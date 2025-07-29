---
created: 2025-02-11 05:48:19
author: NA
version: NA
license(s): NA
copyright: NA
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/proposals/0411-isolated-default-values.md"
---



# A Diagrammatic Guide to SE-0411 - Isolated default value expressions
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



## 1. Overview of the Proposal

A high-level diagram to summarize the core issue and proposed solution:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Current Swift<br>(before SE-0411)"] --> B{"Problem:<br>Data Races & Restrictions"};
    B --> C["Stored Properties:<br>Data Races Possible"];
    B --> D["Default Arguments:<br>Overly Restrictive, Always `nonisolated`"];
    A --> E{"Proposal:<br>Unified & Safe Rules"};
    E --> F["Default Value Isolation = Enclosing Context"];
    E --> G["Data Races Eliminated"];
    E --> H["Improved Expressivity"];
    
    style A fill:#f394,stroke:#333,stroke-width:2px
    style B fill:#c3c4,stroke:#333,stroke-width:1px
    style E fill:#c3c4,stroke:#333,stroke-width:1px
    
```

Textual summary:

The core problem addressed is the inconsistent and unsafe handling of actor isolation when using default values in stored properties and function arguments.  The proposal aims to create a unified model that is safer (eliminating data races) and more flexible (less restrictive).

## 2. Motivation: Examples of Problems

Diagrams illustrating the code examples and the issues:

**a. Data Race in Stored Properties (Problematic Code - Invalid)**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["@MainActor func requiresMainActor() -> Int"];
    B["@AnotherActor func requiresAnotherActor() -> Int"];
    C["class C"];
    C --> D["@MainActor var x1 = requiresMainActor()"];
    C --> E["@AnotherActor var x2 = requiresAnotherActor()"];
    C --> F["nonisolated init() {}"];
 
    D --> A
    E --> B 

    style A fill:#c3c3,stroke:#333,stroke-width:1px
    style B fill:#c3c3,stroke:#333,stroke-width:1px
    style C fill:#f393,stroke:#333,stroke-width:2px
    style D fill:#c3c3,stroke:#333,stroke-width:1px
    style E fill:#c3c3,stroke:#333,stroke-width:1px
    style F fill:#c3c3,stroke:#333,stroke-width:1px
    
```


Textual summary:

This code creates a data race because the `nonisolated init()` can simultaneously call `@MainActor` and `@AnotherActor` functions, violating actor isolation.

**b. Overly Restrictive Default Arguments (Problematic Code - Invalid)**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph MainActorScope
    A["@MainActor class C {}"];
    B["@MainActor func f(c: C = C()) {}"];
    C["@MainActor func useFromMainActor() { f() }"];
    end
 
    B --> A
    C --> B

    %% style A fill:#ccf,stroke:#333,stroke-width:1px
    %% style B fill:#f9f,stroke:#333,stroke-width:2px
    %% style C fill:#ccf,stroke:#333,stroke-width:1px
    
```


Textual summary:

The compiler prevents this code, which is not technically unsafe since the default value initializer and the function are isolated to the same actor.

## 3. Proposed Solution: Unified Isolation Rules

A diagram representing the solution:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Proposed Solution] --> B{Default Value Isolation};
    B --> C[Default Value Isolation = Enclosing Function/Property Isolation];
    B --> D[If Caller != Callee's Isolation: `await` Required];
    A --> E{Stored Properties};
    E --> F[Implicit Initialization in `init` with Same Isolation];
    style A fill:#c3c7,stroke:#333,stroke-width:1px
    style B fill:#c3c7,stroke:#333,stroke-width:1px
    style E fill:#c3c7,stroke:#333,stroke-width:1px
```

Textual Summary:

The proposal enforces that the isolation of a default value expression matches the isolation of whatever it's part of (function, property).  If a caller is not in the same isolation, using the default value requires `await`.

**a. Solution to the Data Race Example:**

This code is invalid without `await` in the initializer

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["@MainActor func requiresMainActor() -> Int"];
    B["@AnotherActor func requiresAnotherActor() -> Int"];
    C["class C"];
    C --> D["@MainActor var x1 = requiresMainActor()"];
    C --> E["@AnotherActor var x2 = requiresAnotherActor()"];
    C --> F["nonisolated init() async { self.x1 = await requiresMainActor(); self.x2 = await requiresAnotherActor() }"];

    D --> A
    E --> B

    %% style A fill:#ccf,stroke:#333,stroke-width:1px
    %% style B fill:#ccf,stroke:#333,stroke-width:1px
    %% style C fill:#f9f,stroke:#333,stroke-width:2px

    %% style D fill:#ccf,stroke:#333,stroke-width:1px
    %% style E fill:#ccf,stroke:#333,stroke-width:1px
    %% style F fill:#ccf,stroke:#333,stroke-width:1px
    
```


Textual summary:  The `nonisolated init` now correctly uses `await` before initializing the properties, addressing the violation.

**b. Solution to the Default Argument Example:**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph MainActorScope
    A["@MainActor class C {}"]
    B["@MainActor func f(c: C = C()) {}"];
    C["@MainActor func useFromMainActor() { f() }"];
    end
 
    B --> A
    C --> B

    %% style A fill:#ccf,stroke:#333,stroke-width:1px
    %% style B fill:#f9f,stroke:#333,stroke-width:2px
    %% style C fill:#ccf,stroke:#333,stroke-width:1px
    
```


Textual summary:  The original code is now valid.  The default value expression and the enclosing function share the same actor isolation (`@MainActor`).

## 4. Detailed Design

### **a. Isolation Inference Rules**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Default Value Expression] --> B{Inferred Isolation};
    B --> C[Required Isolation of Subexpressions];
    B --> D{"Closure Literals"};
    D --> E["Closure Isolation = Union of Callee Isolations in Body (for synchronous calls)"];
    B --> F["if Closure has no isolation annotation, It Inhertis Isolation from callees"];
    
    style A fill:#f39f,stroke:#333,stroke-width:2px
    style B fill:#c3cf,stroke:#333,stroke-width:1px
    style D fill:#c3cf,stroke:#333,stroke-width:1px
    
```


Textual Summary: The isolation of a default value is determined by the isolation of any functions/properties called within the expression.

Special note about closures: The Isolation of a closure in a default value can not be determined by the actor instance of the closure.

**Restrictions:**

*   If function or type has actor isolation, default value expressions must share it.
*   `nonisolated` function/type implies `nonisolated` default value expressions.

### **b. Enforcing Isolation Requirements**

**Diagram (Default Arguments):**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["@MainActor func requiresMainActor() -> Int"];
    B["@MainActor func useDefault(value: Int = requiresMainActor())"];
    C["@MainActor func mainActorCaller() { useDefault() }"];
    D["func nonisolatedCaller() async { await useDefault() }"];
    E["useDefault() -> Error: Implicitly async needs await"];
    
    C --> B
    D --> B

    %% style A fill:#ccf,stroke:#333,stroke-width:1px
    %% style B fill:#ccf,stroke:#333,stroke-width:1px
    %% style C fill:#ccf,stroke:#333,stroke-width:1px
    %% style D fill:#ccf,stroke:#333,stroke-width:1px
    
```


Textual Summary for the diagram: Isolation is enforced at the caller, including `await` when needed.

**a. Argument Evalutation**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Argument Evaluation Order"] --> B{"Explicit r-value Arguments (left-to-right)"};
    B --> C{Explicit formal access Arguments}
    C --> D{"Access the Callee's Isolation Domain"};
    D --> E{"Default Arguments (left-to-right)"};
    
    %% style A fill:#a4a,stroke:#333,stroke-width:1px

```

Textual Summary: The evaluation process includes evaluating explicit arguments, formal-access arguments, transitioning to the callee’s isolation if necessary and then evaluating the default arguments

### **c. Stored Property Initial Values**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Stored Property Initial Values] --> B{Isolation Enforcement};
    B --> C["Initialization in init (matching isolation)"];
    B --> D[If Isolation Mismatch: Explicit Initialization Required in init Body];
    
    %% style A fill:#f9f,stroke:#333,stroke-width:2px
    %% style B fill:#aed,stroke:#333,stroke-width:1px
    
```


Textual summary: The stored properties are initialized within the init’s body if there is an isolation mismatch.

### **d. Stored property isolation in initializers**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Init isolated property across boundaries] --> B{Violation};
    B --> C[Init must be made in the same isolation domain];

    A["Synthesized initializers"] --> D{Compiler Generated};
    D --> E{If Non-sendable and isolated properties are detected, the initializer inherits isolation};
    D --> F{Otherwise, the initializer is nonisolated}
    
    %% style A fill:#f9f,stroke:#333,stroke-width:2px
    %% style B fill:#ccf,stroke:#333,stroke-width:1px
    
```


Textual summary: Synthesized init's are only isolated if non-sendable properties require actor isolation

## 5. Source, ABI Compatibility, and Adoption

Text summary

*   **Source Compatibility**: Stricter rules, staged under a feature flag.
*   **ABI Compatibility**: No changes to the Application Binary Interface.
*   **Adoption**: Can be adopted freely without deployment or compatibility problems.

## 6. Alternatives Considered

Text summary:

This section summarizes an alternative considered during the proposal's development.

*   Original Proposal (SE-0327): all default initializer expressions were `nonisolated`.  But this was causing a large number of problems/inconveniences since often the stored properties are of `@MainActor` types.

----



## 7. Acknowledgments
Text summary:
Recognition of the people who helped move the proposal forward, and the issues that it uncovered.

## 8. Revision History

Text Summary:
Changes Made on the First Pitch, with the key change, is for isolated default values to have the same isolation as the enclosing function or types






---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---