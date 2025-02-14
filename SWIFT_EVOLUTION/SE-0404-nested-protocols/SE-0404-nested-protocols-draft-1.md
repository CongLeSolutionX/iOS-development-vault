---
created: 2025-02-11 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/proposals/0404-nested-protocols.md"
---



# A Diagrammatic Guide to SE-0404: Allow Protocols to be Nested in Non-Generic Contexts
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---




---


## Overview: SE-0404 - Nested Protocols

This proposal enhances Swift by allowing protocols to be nested within non-generic types (structs, classes, enums, actors) and functions.  This improves code organization and readability by clearly scoping protocols to their related types.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Before_SE0404["Before SE-0404<br>(Swift < 5.10)"]
    style Before_SE0404 fill:#f394,stroke:#333,stroke-width:2px
        A[Global Scope] --> B(Protocol: TableViewDelegate);
        A --> C(Class: TableView);
        B -- "Workaround:<br>Naming Convention" --> C;
    end

    subgraph After_SE0404["After SE-0404<br>(Swift >= 5.10)"]
    style After_SE0404 fill:#92f9,stroke:#333,stroke-width:2px
        D[Global Scope] --> E(Class: TableView);
        E --> F(Protocol: Delegate);
        style F fill:#c2c6,stroke:#333,stroke-width:1px
    end

    Before_SE0404 -- "Improves Code Organization" --> After_SE0404;
```

**Explanation:**

*   **Before SE-0404:** Protocols had to be declared at the global scope.  Developers used naming conventions (like `TableViewDelegate`) to indicate relationships.
*   **After SE-0404:** Protocols can be nested within the types they relate to, making the relationship explicit and improving code clarity.

---

## Motivation:  Why Nest Protocols?

The core idea is *natural scoping*. Just like `String.UTF8View` clearly belongs to `String`, a `TableView.Delegate` protocol clearly defines the delegate interface for a `TableView`.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Problem:<br>Lack of Natural Scoping] --> B(Solution:<br>Nested Protocols);
    B --> C[Benefit:<br>Improved Code Organization];
    B --> D[Benefit:<br>Clearer Relationships];
    B --> E[Benefit:<br>Shorter Names within Context];

    A -- "e.g., TableViewDelegate" --> A1[Global Scope, Compound Names];
    B -- "e.g., TableView.Delegate" --> B1[Nested, Concise];

    style A fill:#f397,stroke:#333,stroke-width:1px
    style B fill:#9339,stroke:#333,stroke-width:1px
```

**Key Benefits:**

*   **Improved Code Organization:**  Protocols are grouped with the types they logically belong to.
*   **Clearer Relationships:**  The nesting visually and structurally emphasizes the relationship between the protocol and its enclosing type.
*   **Shorter Names:** Within the enclosing type, you can refer to the nested protocol by its short name (`Delegate` instead of `TableView.Delegate`).

---

## Proposed Solution: Where Can Protocols Be Nested?

Protocols can be nested in:

1.  Non-generic `struct`, `class`, `enum`, `actor` types.
2.  Non-generic functions and closures.

```mermaid
---
config:
  theme: dark
---
graph LR
    A[Allowed Nesting Locations] --> B(Non-Generic Struct);
    A --> C(Non-Generic Class);
    A --> D(Non-Generic Enum);
    A --> E(Non-Generic Actor);
    A --> F(Non-Generic Function);
    A --> G(Non-Generic Closure);

    style A fill:#93f9,stroke:#333,stroke-width:2px
```

**Example (Class):**

```swift
class TableView {
  protocol Delegate: AnyObject { // Nested protocol
    func tableView(_: TableView, didSelectRowAtIndex: Int)
  }

  weak var delegate: Delegate?  // Use short name
}
```

**Example (Function):**

```swift
func processData() {
  protocol DataHandler { // Nested protocol
    func handle(_ data: Data)
  }

  struct MyHandler: DataHandler {
    func handle(_ data: Data) { /* ... */ }
  }

  // ... use MyHandler ...
}
```

---

## Restrictions:  No Nesting in Generic Contexts

Crucially, protocols *cannot* be nested within generic types or functions. This is a key limitation of SE-0404.

```mermaid
---
config:
  theme: dark
---
graph LR
    A[Disallowed Nesting Locations] --> B(Generic Struct);
    A --> C(Generic Class);
    A --> D(Generic Enum);
    A --> E(Generic Actor);
    A --> F(Generic Function);
    A --> G("Function Inside Generic Context");

      style A fill:#f399,stroke:#333,stroke-width:2px
```

**Example (Incorrect - Generic Class):**

```swift
class GenericTableView<Element> {
  // ERROR: Cannot nest protocol in generic context
  protocol Delegate {
    func didSelect(_: Element)
  }
}
```

**Example (Incorrect - Generic Function):**

```swift
func genericFunction<T>(value: T) {
  // ERROR: Cannot nest protocol in generic context
  protocol Processor {
    func process(_: T)
  }
}
```

**Reasoning:**  Supporting nested protocols in generic contexts would require more complex features like:

*   Generic protocols
*   Mapping generic type parameters to associated types

These are explicitly *out of scope* for SE-0404, but potential future directions.

---

## Associated Type Matching

Nested protocols *do not* witness associated type requirements of an outer protocol.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Outer Protocol] --> B(Associated Type: Delegate);
    A --> C[Conforming Struct];
    C --> D{Nested Protocol: Delegate};
    B -.- D

    A -- "protocol Widget" --> Empty;
    B -- "associatedtype Delegate" -->Empty2;
    C -- "struct TableWidget: Widget" --> Empty3;
    D -- "protocol Delegate" --> Empty4;

    style A fill:#c3c4,stroke:#333,stroke-width:1px
    style B fill:#c3c4,stroke:#333,stroke-width:1px
    style C fill:#93f4,stroke:#333,stroke-width:1px
    style D fill:#c3c4,stroke:#333,stroke-width:1px
    
```

**Example:**
```swift
    protocol Widget {
        associatedtype Delegate // Associated type in outer protocol
   }

    struct TableWidget: Widget{
    // Nested protocol does NOT satisfy the 'Delegate' requirement
        protocol Delegate{ }
    }
```

**Explanation:**

*   Associated types define a *single* concrete type that fulfills a requirement.
*   Protocols represent *constraints* that multiple types can conform to.  There's no clear way to map a nested protocol to a single associated type.
*   A hypothetical future feature ("associated protocols") might address this.

---

## Source and ABI Compatibility

*   **Source Compatibility:**  SE-0404 is purely additive; existing code will not break.
*   **ABI Compatibility:**  Moving a protocol in/out of a nested context is an *ABI-breaking* change.  This is because the protocol's mangled name includes the enclosing type's name.
*   **Mitigation (Source Breakage):** When moving a protocol, provide a `typealias` to maintain source compatibility:

    ```swift
    // Old code:
    protocol MyProtocol { /* ... */ }

    // New code (nested):
    class MyContainer {
      protocol InnerProtocol { /* ... */ }
    }
    typealias MyProtocol = MyContainer.InnerProtocol // For source compatibility
    ```

---
## Implications on Adoption
This part emphasizes how easily developers can start using the new feature.

**Adoption Illustration**

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Migration_Stages[Migration Stages]
        A[Current Code] --> B{Refactor?};
        B -- "Yes" --> C[Nested Protocol];
        B -- "No" --> D[Legacy Code];
        C --> E[Improved Structure];
        style Migration_Stages fill:#a3a9,stroke:#33,stroke-width:1px
    end
    
    F[Easy Adoption] --> A;
    
    style F fill:#a3fa,stroke:#333,stroke-width:1px
      
```


*   **Easy Adoption**: The feature can be freely adopted without any constraints.
*  **Refactoring**: Developers can easily refactor existing flat code structures to use nested protocols.

---

## Future Directions

1.  **Nesting Non-Protocol Types in Protocols:**  Allowing structs, enums, etc., to be nested within protocols.  This is useful for types that are specific to a protocol (e.g., `FloatingPointRoundingRule` within the `FloatingPoint` protocol).

2.  **Nesting Protocols in Generic Types:** This opens the door to greater expressiveness, but would require addressing how generics and associated types interact with nested protocols.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Future Directions] --> B(Nesting Non-Protocol Types in Protocols);
    A --> C(Nesting Protocols in Generic Types);

      style A fill:#c3c8,stroke:#333,stroke-width:2px
    B -- "e.g., enum inside protocol" --> B1;
    C -- "Requires handling generics/associated types" --> C1;
```

---

## Alternatives Considered

The proposal states that no other alternatives were considered, as this is a straightforward extension of existing nesting capabilities.

---
## Key Takeaways (Table)

| Feature                   | Description                                                                         | Status     |
| :------------------------ | :---------------------------------------------------------------------------------- | :--------- |
| Nested Protocols          | Protocols can be nested within non-generic structs, classes, enums, actors, and functions. | Implemented (Swift 5.10) |
| Generic Contexts          | Nesting protocols in generic contexts is *not* allowed.                               | N/A        |
| Associated Type Witnessing | Nested protocols *do not* witness associated type requirements.                       | N/A        |
| Source Compatibility      | Fully additive; does not break existing code.                                     | Compatible |
| ABI Compatibility         | Moving protocols in/out of nesting is ABI-breaking.                                  | Incompatible |
| Adoption                  | Easy to adopt and un-adopt; use `typealias` for source compatibility during moves.   | Easy       |

---




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
