---
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/proposals/0306-actors.md"
created: 2024-12-31 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a breakdown of the diagrams I will create, aligning with [the original proposal documentation's structure of Actors in Swift](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0306-actors.md):

1.  **Actor Basics:** Illustrating the fundamental structure of an actor, its properties, and methods.
2.  **Actor Isolation:** Explaining how actors protect their state, including scenarios with cross-actor references and asynchronous calls.
3.  **`Sendable` Protocol and Cross-Actor Communication:** Visualizing the role of `Sendable` in ensuring type safety when crossing actor boundaries.
4.  **Closures and Actor Isolation:** Detailing how closures interact with actor isolation, including the distinction between `@Sendable` closures.
5.  **Actor Reentrancy**: explaining reentrancy, interleaving and the problems this approach solves.
6. **Protocol Conformances**: explaining how Actors conform to protocols.
7. **Partial applications:** How partial applications can be used with Actors.
8. **Key paths:** Restrictions with key paths. 
9. **`inout` parameters:** Restrictions with `inout` parameters
10. **Objective-C Interoperability:** Show how Actors interact with Objective-C.
11. **Future Directions**: Explaining non-reentrancy and task-chain reentrancy.

Let's start with the first diagram:

# 1. Actor Basics

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class Actor {
        <<actor>>
        -accountNumber: Int
        -balance: Double
        --
        +init(accountNumber: Int, initialDeposit: Double)
       
    }
    class BankAccount {
       <<actor>>
        -accountNumber: Int
        -balance: Double
        --
        +init(accountNumber: Int, initialDeposit: Double)
        +transfer(amount: Double, to other: BankAccount) async throws
        +deposit(amount: Double) 
        +passGo()
    }    
    Actor <|-- BankAccount
   
  %% Note left of Actor: Keyword 'actor'\nReference type\nProtects its own state
  %% Note right of BankAccount: Has properties, initializers\nand methods\nthat are actor-isolated.
  
```

**Explanation:**

*   This diagram introduces the `Actor` base concept and `BankAccount` as a concrete example.
*   It highlights the use of the `actor` keyword to define an actor.
*   It shows that our example `BankAccount` actor has properties (`accountNumber`, `balance`), an initializer (`init`), and methods (`transfer`, `deposit`, `passGo`).
*   The `<<actor>>` stereotype is used to depict the actor type. The dash (-) represent a private field/property and (+) represents a public field/method/function.
*  The note highlights that actors are reference types and protect their state, also this shows that actors are declared through the use of keyword `actor`.

# 2. Actor Isolation

```mermaid
sequenceDiagram
    participant Client
    participant BankAccountActor as BankAccount
    participant OtherAccountActor as OtherAccount

    Client->>BankAccount: transfer(amount, otherAccount) async
    activate BankAccount
    BankAccount->>BankAccount:  check balance <br/> `if amount > balance`
    BankAccount->>BankAccount: `balance -= amount`
    BankAccount->>OtherAccount: await deposit(amount)
    activate OtherAccount
    OtherAccount->>OtherAccount: `balance += amount`
    deactivate OtherAccount
    BankAccount-->>Client: Transfer complete
    deactivate BankAccount
  
  note over Client, OtherAccount: Cross actors calls need to use `await`.
   note over Client,BankAccount:  `balance` can only be referenced directly on `self`.
   
```

**Explanation:**

*   This sequence diagram illustrates how actor isolation works. In this example, we start with a `Client`, who will be using a `BankAccount` actor and `otherAccount` actor which they want to transfer money to.
*   The `Client` requests a `transfer` to the `BankAccount`.
*   The `BankAccount` then checks if there are sufficient funds by accessing `balance`.
*   The `BankAccount` then transfers money by deducting the `amount` from it's balance. This operation is safe since it is on the actor's `self`.
*   In order to send money to the `OtherAccount`, `BankAccount` executes an asynchronous call via an `await`. When an `await` is executed by an actor, the actor saves the current task and is moved into the actor's mailbox, before exiting the current task. Then another task from the actor's mailbox may be picked up to execute. Once our suspended task is picked up from the actor's mailbox will it then resume execution. The caller `Client` may have been suspended during this entire process.
*   Finally, the `transfer` operation is completed, completing the Client's async request.
*   The notes highlights that `await` must be used for cross-actor calls and that an actor-isolated property (such as `balance`) can only be accessed directly on self.

# 3. `Sendable` Protocol and Cross-Actor Communication

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Actor A] -->|"async func(arg: Sendable)"| B;
    B[Actor B] -->|"async func()-> Sendable"| A;
    C[Non-Sendable Type]
    A --x|"async func(arg: Non-Sendable)"|C;
    
    style A fill:#f19f,stroke:#333,stroke-width:2px
    style B fill:#c1cf,stroke:#333,stroke-width:2px
    
     
    classDef actor fill:#f19f,stroke:#333,stroke-width:2px
    classDef error fill:#f1bb,stroke:#333,stroke-width:2px
    class A actor
    class B actor
    class C error

    %% note top of A: Actors are `Sendable`
	%% note top of B: Actors are `Sendable`
    %% note top of C: Cannot participate in cross-actor calls.
```

**Explanation:**

*   This graph illustrates the role of the `Sendable` protocol in cross-actor communication.
*   Actors `A` and `B` can safely exchange messages (using asynchronous functions/methods) because they use types that conform to  `Sendable`
*   If an Attempt is made to use a type that is not `Sendable`, for example, a custom `Non-Sendable Type` C, then a compiler error will be produced. Types that conform to `Sendable` are value types or other types that provide thread safety internally.
*   The notes highlights that actors always conform to `Sendable`, and if a type cannot conform to `Sendable`, then it cannot be used in cross-actor calls/messages.

# 4. Closures and Actor Isolation

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Actor Context] -->|"Task.detached { <br/> @Sendable closure<br/> non-isolated }"| B(Non-Isolated Context);
    A -->|"forEach { <br/> non-@Sendable closure<br/> actor-isolated }"| C(Actor-Isolated Context);
   
    style B fill:#c1cf,stroke:#333,stroke-width:2px
    style C fill:#f19f,stroke:#333,stroke-width:2px
   
    classDef isolated fill:#f19f,stroke:#333,stroke-width:2px
    classDef nonIsolated fill:#c1cf,stroke:#333,stroke-width:2px
    class C isolated
    class B nonIsolated
    
     %% Note top of A: Actor Context
     %% Note top of B: Non-Isolated context: Needs to use await when accessing actor-isolated parts
     %% Note  top of C: Isolated to `self` actor: Synchronous calls are ok.
     
```


**Explanation:**

*   This graph illustrates how closures interact with actor isolation.
*   A closure that is passed in a `Task.detached { }` block is non-isolated because it is an `@Sendable` closure. It needs to use `await` to access any actor-isolated state of any actor.
*   A closure that is passed into `forEach` in our example is actor-isolated because `forEach` takes a non-`@Sendable` closure, and it is called from within the actor's context. This code can therefore also access other parts of the same actor. 
*   The notes highlights these differences and the context of how that influences closure isolation.

# 5. Actor Reentrancy

```mermaid
%%---
%%config:
%%  layout: elk
%%  look: handDrawn
%%  theme: dark
%%---
stateDiagram-v2
    state InitialState
    state "Actor-Isolated Function" as ActorIsolatedFunction {
       state FirstPartCompleted
       state SuspendPoint <<choice>>
       state SecondPartCompleted
       state Resume
       
      
       FirstPartCompleted --> SuspendPoint
       SuspendPoint --> SecondPartCompleted : Other actor work,
       SuspendPoint --> Resume : No other actor work
        Resume --> SecondPartCompleted
    }
    InitialState --> ActorIsolatedFunction : function call
    ActorIsolatedFunction --> InitialState : completion
    
    %% Note top of ActorIsolatedFunction: Reentrancy allows the actor to be used <br/> while waiting on a suspended call.
            
```
**Explanation:**
* The state diagram shows the lifecycle of an actor-isolated function within a reentrant actor.
*   The function initially starts in the `InitialState`, and it transitions to the `ActorIsolatedFunction` state. 
*   The `ActorIsolatedFunction` state starts the function execution and reaches a `FirstPartCompleted` point. At that point we execute until we reach a `SuspendPoint`.
*   When hitting a `SuspendPoint`, the reentrancy of an actor allows the actor to switch to another task in its mailbox, until it is ready to `Resume` the original suspended task. If there isn't any other task, we skip through to the `Resume` state.
*   Once the function resumes, it continues execution in the `SecondPartCompleted` section. After which it will complete and transition to the `InitialState`, completing the actor-isolated function's execution. 
*   The notes highlights the importance of reentrancy, in that it allows other work to be done on the actor while waiting on a suspended task.

# 6. Protocol conformances


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class Actor {
        <<protocol>>
        <<Sendable>>
    } 
    class DataProcessible{
        <<protocol>>
        <<Actor>>
        +data: Data get
        +compressData(): Data
    }

    class MyProcessor {
        <<actor>>
        +data: Data
        +doSomething()
    }
    
     class Server{
        <<protocol>>
        +send<Message: MessageType>(message: Message) async throws -> Message.Reply
    }
     class MyActor{
        <<actor>>
         +send<Message: MessageType>(message: Message) async throws -> Message.Reply
    }
    Actor <|-- DataProcessible
    DataProcessible <|-- MyProcessor
    Server <|-- MyActor
    
    %% Note left of Actor: All actors implicitly conform to <br/> the `Actor` protocol
    %% Note left of DataProcessible: Only actors can conform <br/> to this protocol
    
```


**Explanation:**

*   This diagram illustrates how actors conform to protocols.
*   All actor types implicitly conform to the `Actor` protocol, which indicates that it is `Sendable`.
*   The `DataProcessible` protocol, which extends the `Actor` protocol can only be adopted by actors. This is because it has an actor-isolated requirement `data`. The diagram also shows the `MyProcessor` actor conforming to the `DataProcessible` protocol. This indicates that an actor may conform to multiple protocols, so long as it conforms to the `Actor` protocol and the associated constrains. 
*   The diagram also displays a `Server` protocol that has async requirements. `MyActor` is shown to be conforming to that protocol.
*   The notes highlight the rules around `Actor` protocol conformance and how actors satisfy protocols with asynchronous requirements.


# 7. Partial applications

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Actor A] -->|"array.map(self.f)"| B(Partial application OK);
    A --> |"Task.detached(operation: self.g)"| C("Partial application error: <br/> cannot convert \n non-Sendable type");
    A -->|"runLater(self.g)"|C;
    
    style C fill:#f1bb,stroke:#333,stroke-width:2px
    
    classDef error fill:#f1bb,stroke:#333,stroke-width:2px
    class C error
    
    %% note top of A: Actor with `f` , `g` functions
    %% note left of B: Expression is a direct argument \n whose parameter is non-Sendable.
    %% note right of C:  self.g has non-sendable type <br/> that cannot be converted \n to Sendable function type
  
```

**Explanation:**

* This diagram illustrates partial applications in the context of Actors.
*  In the provided code, there are two methods f(Int) -> Double and g() -> Double.
* Partial application is ok when using `array.map(self.f)` because the closure parameter for map is non-`Sendable`. If the input function parameter were set to `@Sendable`, then this would become a compile error since it would be required that the return value is also `Sendable`. In this case, `() -> Double` is not `Sendable`.
*  Partial application will result in an error  when using `Task.detached( operation: self.g)` or `runLater(self.g)` because both of these API's are requiring `@Sendable` types as the input.
* The notes highlights these differences and the constraints around using them.

# 8. Key paths

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Actor A] -->|❌  key path  | B(Error: Cannot reference actor-isolated declarations);
    
    
    style B fill:#f1bb,stroke:#333,stroke-width:2px
        
    classDef error fill:#f1bb,stroke:#333,stroke-width:2px
    class B error
     
      %% note top of A: Actor with storage property.
      %% note bottom of B:  A key path cannot involve <br/> a reference to an actor-isolated property.

```
**Explanation:**
* The Diagram shows that if a keypath is created that references an actor-isolated property on the Actor, a compiler error will be thrown.
*  This diagram shows that attempting to create a keypath on an actor-isolated property will fail.
*  The notes explain why and the restriction around that. 

# 9. `inout` parameters

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
   A[Actor] -->|❌  inout parameter to async| B(Error: Cannot pass actor-isolated property);
    A -->|✅  inout parameter to sync| C(Okay);
    
        style B fill:#f1bb,stroke:#333,stroke-width:2px
       
    classDef error fill:#f1bb,stroke:#333,stroke-width:2px
    class B error
    
     %% note top of A: Actor with a balance property.
     %% note top of B: Passing actor-isolated property `inout` to async functions is not allowed.
    %% note top of C: Passing actor-isolated property `inout`  to sync functions is OK.

```

**Explanation:**

*   This graph illustrates the restrictions with `inout` parameters in actors.
*  If an `inout` parameter is passed to async function that is using an actor-isolated property, then a compiler error will be generated.
*  If an `inout` parameter is passed to synchronous function that is using an actor-isolated property, then the operation is ok.
* The notes explain the restrictions around passing an `inout` parameter to async vs sync functions.

# 10. Objective-C Interoperability

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[@objc Actor] -->|❌ @objc sync func | B(Error: part of actor's isolation domain);
    A-->|✅ @objc async func | C(Okay: Exposed as a completion handler method);
    A-->|✅ @objc nonisolated func | D(Okay: Not part of actor's isolation);
    
        style B fill:#f1bb,stroke:#333,stroke-width:2px
       
    classDef error fill:#f1bb,stroke:#333,stroke-width:2px
    class B error
    
    %% note top of A: @objc Actor 
    %% note top of B:  Synchronous members must not be marked as `@objc`.
    %% note top of C: Async members are okay since they can be exposed to Obj-C using the completion handler patterns.
    %% note top of D: nonisolated members are ok.
```
**Explanation:**

* This diagram shows the rules for using `@objc` members of an actor.
* Synchronous functions that are part of the actor's isolation domain cannot be exposed to Objective-C and a compiler error will be thrown for any attempt.
* Async members are okay, since they can be exposed as a method that accepts a completion handler. 
*  `nonisolated` members are okay, since they are not part of the actor's isolation domain.
* The notes show the specific rules and the reasoning.

# 11. Future Directions

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Future Directions] --> B(Non-Reentrancy);
    A --> C(Task-Chain Reentrancy);
     
    B --> D["@reentrant(never) <br/> attribute"];
    C --> E[Reentrant calls on behalf of the same task hierachy]
    
     %%Note top of B: Non-reentrant attribute can be used <br/> on actor-isolated functions to stop <br/> interleaving on suspension points.
    %% Note top of C: This could be used if each async call <br/> was made from the same task hierarchy.

```

**Explanation:**
* This diagram shows future directions for actors. 
* Non-reentrancy is shown to be available through the use of the `@reentrant(never)` attribute, that prevents other async calls from running on the Actor while it is suspended.
* Task-chain reentrancy would allow reentrant calls so long as they were from the same task hierachy. Since it is common to perform a series of calls between a small group of actors as part of a task. 
* The notes explain each of the approaches.

---
