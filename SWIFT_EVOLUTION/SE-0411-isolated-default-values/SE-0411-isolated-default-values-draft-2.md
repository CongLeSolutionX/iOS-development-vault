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



## 1. Problem Statement: Data Races and Restrictive Rules (Motivation)

This diagram illustrates the issues with the existing actor isolation rules before SE-0411.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
graph LR
    subgraph Current_Rules["Current Rules:<br>Pre SE-0411"]
        direction TB
        A[Data Races in Stored Properties] --> A1["@MainActor/&#64;AnotherActor properties in nonisolated inits"];
        A1 --> A2[Issue: Concurrent access possible during synchronous init];
        style A fill:#d7d3,stroke:#333,stroke-width:1px

        B[Overly Restrictive Default Arguments] --> B1[&#64;MainActor-isolated fns cannot use &#64;MainActor calls in defaults];
        B1 --> B2[Issue: Unnecessarily prohibits safe, synchronous &#64;MainActor calls];
        style B fill:#ff29,stroke:#333,stroke-width:1px

        C[Inconsistent Rules] --> C1[Stored props & default args have diff isolation rules];
        C1 --> C2[Issue: Model harder to understand];
         style C fill:#e7fa,stroke:#333,stroke-width:1px
    end
    Z[Overall Goal of SE-0411] -->|Unify, Eliminate Races, Improve Expressivity| Current_Rules
    
    style Z fill:#c2ff,stroke:#333,stroke-width:2px
    
```


**Explanation:**

*   **"Current Rules (Pre SE-0411)" subgraph**:  Highlights the problems with the actor isolation rules before the proposal.
*   **Data Races in Stored Properties (Red)**: Emphasizes the most critical issue - the potential for data races when using actor-isolated stored properties within nonisolated initializers due to synchronous, potentially concurrent calls during initialization.
*   **Overly Restrictive Default Arguments (Yellow)**: Shows the unnecessary limitation that prevents safe `@MainActor` calls in default arguments of `@MainActor` functions.
*   **Inconsistent Rules (Blue)**: Points out the lack of uniformity between isolation rules for stored properties and default arguments, leading to a less clear actor isolation model.
*   **"Overall Goal of SE-0411" (Highlighted)**:  Summarizes the main objective of the proposal - to create a more unified and safer system.

---

## 2. Proposed Solution: Unified Isolation (Detailed Design)

This sequence diagram demonstrates how the proposed solution addresses the issues by allowing default value expressions to inherit the isolation of their context.

```mermaid
sequenceDiagram
    participant Context (Enclosing Fn/Property)
    participant Default Value Expression
    participant Callee (Isolated Function)

    Context->>Default Value Expression: Evaluation Request (Synchronous)
    activate Default Value Expression

    Default Value Expression->>Callee: Isolated Call (Synchronous, if same isolation)

    alt Context and Default Value Expression have DIFFERENT isolation
        Default Value Expression-->>Context: Error (Requires 'await')
        Context->>Context:  Must use 'await' for async call
    else Context and Default Value Expression have SAME isolation
        Default Value Expression-->>Context: Okay (Synchronous Call Allowed)
    end

    Default Value Expression-->>Context: Returns Value
    deactivate Default Value Expression
    Note right of Context: Implicit initialization in 'init' only in same isolation domain
```

Note: 
Below is my workaround diagram for now.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
sequenceDiagram
    autonumber
    participant Context_Enclosing_F_Property
    participant Default_Value_Expression
    participant Callee_Isolated_Function

    Context_Enclosing_F_Property->>Default_Value_Expression: Evaluation Request<br>(Synchronous)
    activate Default_Value_Expression

    Default_Value_Expression->>Callee_Isolated_Function: Isolated Call<br>(Synchronous, if same isolation)

    alt Context_Enclosing_F_Property and Default_Value_Expression have DIFFERENT isolation
        Default_Value_Expression-->>Context_Enclosing_F_Property: Error<br>(Requires 'await')
        Context_Enclosing_F_Property->>Context_Enclosing_F_Property:  Must use 'await' for async call
    else Context_Enclosing_F_Property and Default_Value_Expression have SAME isolation
        Default_Value_Expression-->>Context_Enclosing_F_Property: Okay<br>(Synchronous Call Allowed)
    end

    Default_Value_Expression-->>Context_Enclosing_F_Property: Returns Value
    deactivate Default_Value_Expression
    Note right of Context_Enclosing_F_Property: Implicit initialization in 'init' only in same isolation domain
    
```



**Explanation:**

*   **Participants**:  Clearly defines the involved components: the context where the default value is used (function or property), the default value expression itself, and any isolated function it might call.
*   **Synchronous Evaluation**: Highlights that default value expressions are evaluated synchronously.
*   **Isolation Check**: Emphasizes the core of the proposal - the default value expression attempts a synchronous isolated call to the `Callee`.
*   **"Alt" Block**: Illustrates the crucial conditional behavior:
    *   **Different Isolation**: If the context and the default value expression have different isolation domains, synchronous calls are disallowed, resulting in an error (requiring `await`).
    *   **Same Isolation**: If they share the same isolation, synchronous calls are permitted without errors.
*   **Return Value & Note**:  Shows the default value expression returning the calculated value to the context and includes a note about the conditional initialization in initializers, reinforcing the concept of isolation domain matching for implicit initialization.

---

## 3. Inference of Default Value Isolation

This flowchart explains how the isolation of a default value expression is inferred.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
flowchart TD
    A[Start: Default Value Expression Analysis] --> B{Expression contains isolated calls?};
    B -- Yes --> C{Closure Literal?};
    C -- Yes --> D[Infer Closure Isolation: Union of Callee Isolations in Body];
    C -- No --> E[Infer Expression Isolation: Required Isolation of Subexpressions];
    B -- No --> F[Expression Isolation: Nonisolated];
    D --> G[End: Isolation Inferred];
    E --> G;
    F --> G;
    style D fill:#ccebc5,stroke:#333,stroke-width:1px
    style E fill:#ccebc5,stroke:#333,stroke-width:1px
    style F fill:#f9f0c2,stroke:#333,stroke-width:1px

    subgraph Closure_Literal_Path["Closure Literal Path"]
    style Closure_Literal_Path fill:#f0f9ff,stroke:#333,stroke-width:1px
        C -- Yes --> D
    end

    subgraph Non_Closure_Path["Non-Closure Path"]
    style Non_Closure_Path fill:#f0f9ff,stroke:#333,stroke-width:1px
        C -- No --> E
    end

    subgraph No_Isolated_Calls["No Isolated Calls"]
    style No_Isolated_Calls fill:#f0f9ff,stroke:#333,stroke-width:1px
        B -- No --> F
    end
    
```
\

**Explanation:**

*   **Start & Decision (A & B)**:  Begins the process and checks if the default value expression includes any isolated function calls.
*   **Closure Literal Check (C)**: If there are isolated calls, it distinguishes between closure literals and other expressions.
*   **Closure Literal Inference (D - Green)**: For closures, the isolation is inferred as the *union* of the isolations of all synchronously called functions within the closure body. This means if a closure calls both `@MainActor` and `@AnotherActor` isolated functions, the closure itself needs to respect both isolations (though in practice, constraints will limit this combination).
*   **Non-Closure Inference (E - Green)**: For non-closure expressions, the isolation is inferred as the *required* isolation of its constituent parts (sub-expressions). Essentially, the strictest isolation requirement propagates up.
*   **Nonisolated Case (F - Yellow)**: If the expression contains no isolated calls, it's inferred to be `nonisolated`.
*   **End (G)**:  Concludes with the isolation being determined.
*   **Subgraphs (Blue)**:  Visually separates the logic flow for different scenarios (closure vs. non-closure, and presence of isolated calls), improving readability.

---

## 4. Enforcement of Isolation Requirements

This flowchart details how isolation requirements are enforced for default argument values and stored property initial values.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
flowchart TD
    subgraph Default_Argument_Values_Enforcement["Default Argument Values Enforcement"]
        DA[Function Call] --> DB{Callee Isolation?};
        DB -- Yes --> DC{Caller Isolation == Callee Isolation?};
        DC -- Yes --> DD["Evaluate Synchronously (Okay)"];
        DC -- No --> DE{Caller Context == Isolated?};
        DE -- Yes --> DF[Error: Implicit async call, require 'await'];
        DE -- No --> DG["Evaluate Asynchronously with 'await' (Okay)"];
        DB -- No --> DD;

        style Default_Argument_Values_Enforcement fill:#f0f9ff,stroke:#333,stroke-width:1px
        style DD fill:#ccebc5,stroke:#333,stroke-width:1px
        style DG fill:#ccebc5,stroke:#333,stroke-width:1px
        style DF fill:#f8d7da,stroke:#333,stroke-width:1px
    end

    subgraph Stored_Property_Initial_Values_Enforcement["Stored Property Initial Values Enforcement"]
        SA["Initializer (init)"] --> SB{Property Default Value Isolation?};
        SB -- Yes --> SC{Initializer Isolation == Property Default Isolation?};
        SC -- Yes --> SD[Implicit Initialization in 'init' start];
        SC -- No --> SE[No Implicit Init];
        SE --> SF[Must initialize explicitly in 'init' body];
        SB -- No --> SD;

        style Stored_Property_Initial_Values_Enforcement fill:#f0f9ff,stroke:#333,stroke-width:1px
        style SD fill:#ccebc5,stroke:#333,stroke-width:1px
        style SE fill:#ffef99,stroke:#333,stroke-width:1px
        style SF fill:#ffef99,stroke:#333,stroke-width:1px

    end

    direction TB
    Default_Argument_Values_Enforcement --> Stored_Property_Initial_Values_Enforcement
    
```

**Explanation:**

*   **Two Subgraphs**: Separates enforcement for default arguments and stored properties for clarity.
*   **Default Argument Value Enforcement (Top)**:
    *   Checks if the callee function is isolated (DB).
    *   If isolated, it verifies if the caller is in the same isolation domain (DC).
    *   If same isolation, synchronous evaluation is okay (DD - Green).
    *   If different isolation, it checks if the caller context *is* isolated. If so, it's an error because implicit async calls outside the required isolation domain must be marked with `await` (DF - Red). If the caller isn't isolated, async call with `await` is required and okay (DG - Green).
    *   If the callee is not isolated, synchronous evaluation is okay (DD - Green).
*   **Stored Property Initial Value Enforcement (Bottom)**:
    *   In an initializer, it checks if the property has an isolated default value (SB).
    *   If yes, it compares the initializer's isolation to the property's default value isolation (SC).
    *   If they match, implicit initialization happens at the start of `init` (SD - Green).
    *   If they don't match, no implicit initialization occurs (SE - Yellow), and the property *must* be initialized explicitly in the `init` body (SF - Yellow).
    *   If the property's default value is not isolated, implicit initialization happens at the start of `init` (SD - Green).

---

## 5. Argument Evaluation Order

This ordered list clarifies the argument evaluation order in function calls, especially with isolated default arguments.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
graph LR
    subgraph Argument_Evaluation_Order_with_Isolated_Defaults["Argument Evaluation Order with Isolated Defaults"]
        direction TB
        A["Argument 1: Explicit r-value arguments<br>(Left-to-right)"] --> B["Argument 2: Formal access arguments<br>(Left-to-right)"];
        B --> C["Argument 3: *Hop to Callee's Isolation Domain*"];
        C --> D["Argument 4: Default arguments<br>(Left-to-right)"];
        style C fill:#ffe0b2,stroke:#333,stroke-width:1px
    end

    subgraph Argument_Evaluation_Order_No_Isolated_Defaults["Argument Evaluation Order<br>(No Isolated Defaults)"]
        direction TB
        X["Argument 1:<br>Explicit r-value arguments<br>(Left-to-right)"] --> Y["Argument 2:<br>Default arguments & Formal access<br>(Left-to-right)"];
    end

    Z["Key Difference"] -->|Hop to Callee's Isolation for Defaults| Argument_Evaluation_Order_with_Isolated_Defaults
    
    style Z fill:#ccf2ff,stroke:#333,stroke-width:2px
    
```


**Explanation:**

*   **"Argument Evaluation Order with Isolated Defaults" subgraph (Top)**:  Details the modified evaluation order when isolated default arguments are involved:
    1.  Explicit r-value arguments are evaluated first, left-to-right.
    2.  Formal access arguments (like `inout`) are evaluated next, left-to-right.
    3.  **"Hop to Callee's Isolation Domain" (Orange - Key Step)**:  Crucially, the execution context shifts to the callee's isolation domain *before* default arguments are evaluated. This ensures default arguments are evaluated in the correct isolation.
    4.  Default arguments are then evaluated, left-to-right, within the callee's isolation domain.
*   **"Argument Evaluation Order (No Isolated Defaults)" subgraph (Bottom)**: Shows the simpler order for calls without isolated defaults, for comparison:
    1.  Explicit r-value arguments (left-to-right).
    2.  Default arguments and formal access arguments are evaluated together, left-to-right, without a domain hop.
*   **"Key Difference" (Highlighted)**:  Emphasizes the central change: the "hop" to the callee's domain specifically for isolated default argument evaluation. This is the mechanism that allows synchronous isolated calls within default values when called from the appropriate isolation domain.

---

## 6. Stored Property Isolation in Initializers

This diagram illustrates the rules surrounding initializer isolation and how it relates to stored properties, particularly with synthesized initializers.

```mermaid
---
config:
  layout: elk
  look: handDrawn
---
graph LR
    subgraph Initializer_Isolation_Rules["Initializer Isolation Rules"]
        direction TB
        A[Initializing Isolated Prop across Boundary] --> A1[Invalid: Violates Sendable Guarantee];
        A1 --> A2[Requires Initializer to be in SAME Isolation];
        style A fill:#f8d7da,stroke:#333,stroke-width:1px

        B["Synthesized Initializers (structs/classes)"] --> B1{Isolated Stored Prop or Isolated Default?};
        B1 -- Yes --> B2[Synthesized 'init' becomes ISOLATED];
        B1 --> B3{Non-Sendable Isolated Prop?};
        B3 -- Yes --> B2;
        B3 -- No --> B4["Synthesized 'init' can be NONISOLATED (if possible)"];
        B1 -- No --> B4;

        style B fill:#f0f9ff,stroke:#333,stroke-width:1px
        style B2 fill:#ccebc5,stroke:#333,stroke-width:1px
        style B4 fill:#ccebc5,stroke:#333,stroke-width:1px

        C[Two Different Isolated Defaults in Synthesized 'init'] --> C1[Error: Impossible to use defaults together];
        C1 --> C2[Requires Explicit 'async init' with 'await' points];
        style C fill:#f8d7da,stroke:#333,stroke-width:1px

    end
```

**Explanation:**

*   **"Initializer Isolation Rules" subgraph**: Groups rules for clarity.
*   **Initializing Isolated Property Across Boundary (Red)**:  Highlights the error condition of initializing an actor-isolated property from a different isolation domain, emphasizing `Sendable` violations. The initializer *must* also be isolated to the same actor in such cases.
*   **Synthesized Initializers (Blue)**:
    *   Checks if the type has any isolated stored properties or if any default initializer expressions are isolated (B1).
    *   If yes (or if there are non-`Sendable` isolated properties), the synthesized initializer *must* be actor-isolated (B2 - Green).
    *   If no isolated stored properties or default value isolations (and no non-Sendable isolated props), the synthesized initializer *can* be `nonisolated` (B4 - Green - for scenarios where it's safe).
*   **Two Different Isolated Defaults (Red)**:  Points out the error scenario where a synthesized initializer would try to use two default value expressions that require *different* actor isolations; this is an impossible situation, signaling a fundamental design flaw.  The solution is to use an explicit `async init` to handle these different isolations explicitly with `await`.




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---