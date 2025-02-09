---
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/proposals/0298-asyncsequence.md"
created: 2024-12-31 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



Below is a breakdown of the diagrams I will create, aligning with [the original proposal documentation's structure of Async Sequence in Swift](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0298-asyncsequence.md):

---


# Diagram 1: AsyncSequence and AsyncIteratorProtocol

This diagram illustrates the relationship between the two core protocols:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class AsyncSequence {
        <<protocol>>
        +associatedtype AsyncIterator: AsyncIteratorProtocol
        +associatedtype Element
        +__consuming makeAsyncIterator(): AsyncIterator
    }
    class AsyncIteratorProtocol {
        <<protocol>>
        +associatedtype Element
        +mutating next(): async throws Element?
    }
  
    %% TODO Fix the syntax for this 
    %% AsyncSequence <|--o AsyncIteratorProtocol : Uses
    %% AsyncSequence "1" *-- "1" AsyncIteratorProtocol : creates
  
%% Note left of AsyncSequence: Represents a sequence\nthat produces values asynchronously
%% Note right of AsyncIteratorProtocol: Provides the values of\nan AsyncSequence at each step

```


**Explanation:**

*   `AsyncSequence` is the protocol representing an asynchronous sequence of values.
    *   It has an associated type `Element`, which is the type of the value being produced.
    *   It has an associated type `AsyncIterator` conforming to `AsyncIteratorProtocol`.
    *   `makeAsyncIterator()` is a method that returns a new instance of the iterator.
*   `AsyncIteratorProtocol` defines how to iterate over the sequence.
    *   It also has an associated type `Element`, which is the same as that of the corresponding `AsyncSequence`.
    *   `next()` is a mutating function that asynchronously retrieves the next optional value. Returning `nil` indicates the end of the sequence.

---


# Diagram 2: `for await in` Loop Mechanics

This diagram shows how the compiler transforms a `for await in` loop into lower-level code using protocols:

## FIXME: Fix the diagram syntax for this case

```mermaid
sequenceDiagram
  participant Code as Source Code
  participant A as AsyncSequence
  participant I as AsyncIterator
  participant Loop as Loop Body
    Code->>A: myAsyncSeq()
    activate A
    A->>I: makeAsyncIterator()
    deactivate A
    activate I
    loop
      I->>I: next()
      activate I
      I-->>Loop: Element?
      deactivate I
      Loop->>Loop: Check Element
      alt Element != nil
         Loop->>Loop: Use Element
      else Element == nil
        Loop->>Loop: break
      end
    end
    deactivate I
```

**Explanation:**

1.  The source code calls `myAsyncSeq()`, which returns the AsyncSequence instance.
2.  The compiler calls `makeAsyncIterator()` on the `AsyncSequence` to create an iterator.
3.  The loop begins, repeatedly calling `next()` on the iterator.
4.  The async function `next()` yields a value if available, and null if not, which is processed by the loop body based on the current element or ends the loop.
5.  The loop continues until `next()` returns `nil`.

---


# Diagram 3: Example `Counter` Implementation

This diagram illustrates the basic implementation of the `Counter` example, highlighting the structure of an AsyncSequence and AsyncIterator:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class Counter {
        -howHigh: Int
        +makeAsyncIterator(): AsyncIterator
    }
    class AsyncIterator {
        -howHigh: Int
        -current: Int
        +next(): async -> Int?
    }
    Counter *-- AsyncIterator : Creates
    AsyncIterator --|> AsyncIteratorProtocol : implements
    Counter --|> AsyncSequence : implements
      
%% note left of Counter: An example of\nAsyncSequence
%% note right of AsyncIterator: An example of\nAsyncIteratorProtocol

```


**Explanation:**

*   `Counter` conforms to `AsyncSequence` and holds the limit of the count (`howHigh`).
*   It has an inner struct `AsyncIterator` conforming to `AsyncIteratorProtocol` maintaining `current` and `howHigh`.
    *   The `next()` method increments `current` and returns it until `current` is greater than `howHigh`.

---

# Diagram 4. AsyncSequence Functions - To Single Value

This diagram showcases functions that reduce an AsyncSequence to a single value:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[AsyncSequence] -->|"contains(value: Element)"| B(Bool);
    A -->|"contains(where: (Element) async throws -> Bool)"| C(Bool);
    A -->|"allSatisfy((Element) async throws -> Bool)"| D(Bool);
    A -->|"first(where: (Element) async throws -> Bool)"| E(Element?);
    A -->|"min()"| F(Element?);
    A -->|"min(by: (Element, Element) async throws -> Bool)"| G(Element?);
    A -->|"max()"| H(Element?);
    A -->|"max(by: (Element, Element) async throws -> Bool)"| I(Element?);
    A -->|"reduce<T>(_ initialResult: T, _ nextPartialResult: (T, Element) async throws -> T)"| J(T);
    A -->|"reduce<T>(into initialResult: T, _ updateAccumulatingResult: (inout T, Element) async throws -> ())"| K(T);

style A fill:#f19f,stroke:#333,stroke-width:2px;
style B fill:#c1cf,stroke:#333,stroke-width:2px;
style C fill:#c1cf,stroke:#333,stroke-width:2px;
style D fill:#c1cf,stroke:#333,stroke-width:2px;
style E fill:#c1cf,stroke:#333,stroke-width:2px;
style F fill:#c1cf,stroke:#333,stroke-width:2px;
style G fill:#c1cf,stroke:#333,stroke-width:2px;
style H fill:#c1cf,stroke:#333,stroke-width:2px;
style I fill:#c1cf,stroke:#333,stroke-width:2px;
style J fill:#c1cf,stroke:#333,stroke-width:2px;
style K fill:#c1cf,stroke:#333,stroke-width:2px;

```


**Explanation:**
*   The diagram shows various functions that consume an `AsyncSequence` and return a single value.  Each function is represented with the syntax that it is written in Swift and its corresponding final value that is being returned.
* Each function operates asynchronously, indicated by `async rethrows` (not displayed for simplicity purpose), to perform its task.
* `contains`, `allSatisfy`, `first`, `min`, `max`, `reduce`, and other functions in the list reduce the `AsyncSequence` into a single value with specific conditions such as closure or equatable.

---


# Diagram 5: AsyncSequence Functions - To AsyncSequence

This diagram illustrates functions that transform an `AsyncSequence` into a new `AsyncSequence`:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[AsyncSequence] -->|"map<T>(_ transform: (Element) async throws -> T)"| B(AsyncMapSequence);
    A -->|"compactMap<T>(_ transform: (Element) async throws -> T?)"| C(AsyncCompactMapSequence);
    A -->|"flatMap<SegmentOfResult: AsyncSequence>(_ transform: (Element) async throws -> SegmentOfResult)"| D(AsyncFlatMapSequence);
    A -->|"drop(while: (Element) async throws -> Bool)"| E(AsyncDropWhileSequence);
    A -->|"dropFirst(_ n: Int)"| F(AsyncDropFirstSequence);
    A -->|"prefix(while: (Element) async throws -> Bool)"| G(AsyncPrefixWhileSequence);
    A -->|"prefix(_ n: Int)"| H(AsyncPrefixSequence);
    A -->|"filter(_ predicate: (Element) async throws -> Bool)"| I(AsyncFilterSequence);

style A fill:#f33,stroke:#333,stroke-width:2px;

style B fill:#c1cf,stroke:#333,stroke-width:2px;
style C fill:#c1cf,stroke:#333,stroke-width:2px;
style D fill:#c1cf,stroke:#333,stroke-width:2px;
style E fill:#c1cf,stroke:#333,stroke-width:2px;
style F fill:#c1cf,stroke:#333,stroke-width:2px;
style G fill:#c1cf,stroke:#333,stroke-width:2px;
style H fill:#c1cf,stroke:#333,stroke-width:2px;
style I fill:#c1cf,stroke:#333,stroke-width:2px;

```

**Explanation:**
*   Each function transforms the incoming `AsyncSequence` in some way and returns a new `AsyncSequence`. All these are performed as the elements of the sequences are being requested through iteration so they are not eagerly executed.
*   Types like `AsyncMapSequence`, `AsyncCompactMapSequence`, and `AsyncFilterSequence` are the concrete types for each function.
*  `map` transforms each element of the source sequence using an async closure, `compactMap` provides the same functionality and remove optionals at the same time .
* `filter` selectively yields elements from the source sequence based on a boolean-returning closure.
* `flatMap` flattens async sequences elements into new collection of the elements of the resulted `AsyncSequence`, `drop` returns the remaining elements after the given `n` or condition, `prefix` does the same but from the begining of the sequence.

---


# Diagram 6: Cancellation Handling

This sequence diagram details how cancellation should be handled in an `AsyncIteratorProtocol`:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    participant Iterator as AsyncIterator
    participant Task as Task API
    participant Action as Some Action
    
    loop
        Iterator->>Task: Task.isCancelled
            activate Iterator
        Task-->>Iterator: true/false
        alt Task.isCancelled == true
            Iterator->>Iterator: Perform Cleanup
            Action->>Iterator: return nil or throw cancellationError
        else Task.isCancelled == false
            Iterator->>Iterator: continue to next action
            Action->>Iterator: get next element and perform action
        end
            deactivate Iterator
    end
    
    Iterator->>Iterator: deinit() (if is a class type)
    
```


**Explanation:**

1.  The `AsyncIteratorProtocol`'s `next()` method checks for cancellation using the `Task` API (part of Swift's structured concurrency).
2.  If the task is cancelled, the iterator performs any needed cleanup tasks as part of the existing async/await task management mechanism.
3.  The iterator returns `nil` to indicate the sequence has ended or throws a `CancellationError`.
4. If the task is not cancelled, iterator continues its process as usual.
5. A class-based iterator could also perform additional cleanup in its `deinit`.

**Summary**

These diagrams collectively illustrate how `AsyncSequence` and `AsyncIteratorProtocol` work together, how `for await in` works under the hood, and how the standard library extends these protocols. They help visualize the concepts of asynchronous sequences in Swift, making the complexities easier to understand. The new functions for transforming, reducing, compacting and manipulating `AsyncSequence`s makes the code concise, easy to read, and very familiar to the users with synchronous `Sequence` protocol.

---
