---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/Closures.md"
created: 2025-01-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/Closures.md):

---


Here's a plan:

1. **Basic Closure Structure:** A simple graph or flowchart illustrating the basic syntax of a closure expression.
2. **Closure Types:** A mindmap or tree diagram showing the three forms of closures (global, nested, closure expressions).
3. **`sorted(by:)` Example:** A sequence diagram or flowchart demonstrating how the `sorted(by:)` method works with different closure syntaxes. This could involve expanding steps from verbose to shorthand syntax.
4. **Trailing Closures:** A diagram illustrating the syntax difference between a regular closure argument and a trailing closure.
5. **Capturing Values:** A diagram showing how a nested function captures values from its enclosing function's scope.
6. **Reference Types:** A depiction of how multiple variables can refer to the same closure (reference type behavior).
7. **Escaping Closures:** A diagram showcasing the concept of a closure escaping a function's scope and being called later.
8. **Autoclosures:** A flowchart explaining how an autoclosure delays evaluation of an expression.

Let's start creating the diagrams based on these points.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Closure Expression] --> B{Parameters};
    B --> C(Optional);
    C --> D[inout Parameters];
    C --> E[Variadic Parameters];
    B --> F(Type Inference);
    A --> G[Return Type];
    G --> H(Optional);
    A --> I{in Keyword};
    I --> J[Statements];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;
style G fill:#d5df,stroke:#333,stroke-width:1px;
style I fill:#d5df,stroke:#333,stroke-width:1px;
style J fill:#e5ef,stroke:#333,stroke-width:1px;

```


---

```mermaid
mindmap
  root((Closures))
    named[Named Closures]
      global(Global Functions)
        no_capture[Doesn't capture values]
      nested(Nested Functions)
        can_capture[Can capture values from enclosing function]
    unnamed[Unnamed Closures]
      expressions(Closure Expressions)
        lightweight[Lightweight syntax]
        capture[Can capture values from surrounding context]
        
```

---


```mermaid
sequenceDiagram
    autonumber
    participant Names_Array as Names Array
    participant sorted_method as sorted(by:) Method
    participant Closure as Closure: (String, String) -> Bool
    participant Reversed_Names_Array as Reversed Names Array

    Names_Array ->> sorted_method: sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
    activate sorted_method
    sorted_method ->>Closure: Compare elements
    Closure-->>sorted_method: Bool (Comparison result)
    loop For each element
        sorted_method->>Closure: Compare elements
        Closure-->>sorted_method: Bool
    end
    sorted_method-->>Reversed_Names_Array: New sorted array
    deactivate sorted_method
    
```



---



```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Regular Closure Argument
        A[Function Call] --> B("functionName(argumentLabel: { // closure body })");
    end

    subgraph Trailing Closure
        C[Function Call] --> D("functionName() { // trailing closure body }");
        E[Function Call with Single Trailing Closure] --> F("functionName { // trailing closure body }");
    end

style A fill:#e5e9,stroke:#333,stroke-width:1px
style B fill:#e5e9,stroke:#333,stroke-width:1px
style C fill:#e5e9,stroke:#333,stroke-width:1px
style D fill:#e5e9,stroke:#333,stroke-width:1px
style E fill:#e5e9,stroke:#333,stroke-width:1px
style F fill:#e5e9,stroke:#333,stroke-width:1px

```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Outer Function: makeIncrementer"] --> B{"runningTotal = 0"};
    A --> C{amount Parameter};
    B --> D["Nested Function: incrementer"];
    C --> D;
    D --> E{"runningTotal += amount"};
    D --> F{"return runningTotal"};
    A -- Returns --> D;

style A fill:#f5ec,stroke:#333,stroke-width:2px;
style D fill:#c5fc,stroke:#333,stroke-width:2px;

```


---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Closure Instance];
    B["Constant/Variable 1"] -- Reference --> A;
    C["Constant/Variable 2"] -- Reference --> A;

style A fill:#c5ce,stroke:#333,stroke-width:2px;

```


---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant Function with Escaping Closure
    participant Closure
    participant Outer Scope Variable

    Function with Escaping Closure->>Closure: Closure passed as argument
    Function with Escaping Closure->>Outer Scope Variable: Store closure reference
    Function with Escaping Closure-->>Function with Escaping Closure: Function returns
    note over Closure: Closure continues to exist in outer scope
    Outer Scope Variable->>Closure: Call the closure later
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Expression to be evaluated] --> B{Autoclosure Creation};
    B -- On Function Call --> C[Evaluate Expression];
    C --> D[Return Value];
    B -- If Never Called --> E[Expression Not Evaluated];

style A fill:#f5fc,stroke:#333,stroke-width:2px;
style B fill:#f5dd,stroke:#333,stroke-width:2px;

```



---

