---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/Subscripts.md"
created: 2025-01-07 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/Subscripts.md).

Overall, the key concepts are:

*   **Definition of Subscripts:** A shortcut to access elements in collections, lists, or sequences.
*   **Subscript Syntax:** `subscript(parameters) -> ReturnType { get/set }`
*   **Read-Only Subscripts:**  Omitting the `set` block.
*   **Subscript Usage:**  Accessing elements using square brackets (e.g., `array[index]`, `dictionary[key]`).
*   **Subscript Options:**
    *   Multiple parameters.
    *   Varying number of parameters (variadic).
    *   Default parameter values.
    *   Subscript overloading.
*   **Type Subscripts:** Subscripts called on the type itself, denoted by `static` or `class`.


---



**Diagram Creation Strategy:**

I will use different types of Mermaid diagrams to illustrate the concepts:

*   **Mindmap:** To provide a high-level overview of the different aspects of subscripts.
*   **Class Diagram:** To demonstrate the structure of a type with a subscript.
*   **Sequence Diagram:** Potentially to show the flow of accessing a subscript.
*   **Flowchart:**  To explain the logic of choosing the correct subscript overload.

Let's start with the mindmap to structure the information.



## Mindmap - TBD 

---

# Class Diagram

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class SubscriptUser {
        +accessElement()
    }
    class MyCollection {
        <<interface>>
        +subscript(index: Int): Element
    }
    class MyArray {
        -elements: [Element]
        +subscript(index: Int): Element
    }
    class MyDictionary {
        -data: [Key: Value]
        +subscript(key: Key): Value?
    }
    class TimesTable {
        -multiplier: Int
        +subscript(index: Int): Int
    }
    class Matrix {
        -rows: Int
        -columns: Int
        -grid: [Double]
        +subscript(row: Int, column: Int): Double
        +indexIsValid(row: Int, column: Int): Bool
    }
    class Planet {
        <<enumeration>>
        +mercury
        +venus
        +earth
        +mars
        +jupiter
        +saturn
        +uranus
        +neptune
        +subscript(n: Int): Planet
    }

    SubscriptUser --|> MyCollection : Uses
    MyArray --|> MyCollection : Implements
    MyDictionary --|> MyCollection : Implements
    SubscriptUser --|> MyArray : Uses
    SubscriptUser --|> MyDictionary : Uses
    SubscriptUser --|> TimesTable : Uses
    SubscriptUser --|> Matrix : Uses
    SubscriptUser --|> Planet : Uses
    
```

---
# Sequence Diagram 

```mermaid
%% ---
%% config:
%%   layout: elk
%%   look: handDrawn
%%   theme: dark
%% ---
sequenceDiagram
    actor User
    participant CollectionInstance
    participant SubscriptImplementation

    User->>CollectionInstance: Access element using subscript: <br> collection[index]
    activate CollectionInstance
    CollectionInstance->>SubscriptImplementation: Call subscript's getter with index
    activate SubscriptImplementation
    SubscriptImplementation-->>CollectionInstance: Return element value
    deactivate SubscriptImplementation
    CollectionInstance-->>User: Return element value

    User->>CollectionInstance: Set element using subscript: <br> collection[index] = newValue
    activate CollectionInstance
    CollectionInstance->>SubscriptImplementation: Call subscript's setter with index and newValue
    activate SubscriptImplementation
    SubscriptImplementation->>CollectionInstance: Update internal state
    deactivate SubscriptImplementation
    CollectionInstance-->>User: Confirmation <br> (implicit)
    deactivate CollectionInstance
    
```

---

# Flowchart 

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    A[Start: Subscript Access] --> B{Is it a Type Subscript?};
    B -- Yes --> C{Call Type's Subscript Implementation};
    B -- No --> D{Determine Instance Type};
    D --> E{Find Matching Subscript Overload};
    E -- Found --> F{Execute Subscript Implementation};
    E -- Not Found --> G[Error: No Matching Subscript];
    F --> H[Return Value or Perform Set];
    C --> H;
    H --> I[End];
    
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
    subgraph ReadWriteSubscript
        direction TB
        A1["subscript(index: Int) -> Int"]
        B1{get} -- Returns Value --> E1[Return Value]
        C1{"set(newValue)"} -- Performs Setting Action --> E1
    end

    subgraph ReadOnlySubscript
        direction TB
        A2["subscript(index: Int) -> Int"]
        B2 -- Returns Value --> D2[Return Value]
    end

    A1 -- Implements --> ParentClass
    A2 -- Implements --> ParentClass

    style ReadWriteSubscript fill:#5cc1,stroke:#99f,stroke-width:2px
    style ReadOnlySubscript fill:#f5c1,stroke:#ff9,stroke-width:2px
    
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
    subgraph MultipleParameterSubscript
        direction TB
        A["subscript(row: Int, column: Int) -> Double"]
        B{get} -- Validate Indices --> C{Access Grid}
        C -- Returns Value --> E[Return Value]
        D{"set(newValue)"} -- Validate Indices --> F{Update Grid}
        F --> E
    end

    subgraph IndexValidation
        direction LR
        G["indexIsValid(row: Int, column: Int) -> Bool"]
        H{row >= 0 AND row < rows} -- Yes --> I{column >= 0 AND column < columns}
        H -- No --> J[Return False]
        I -- Yes --> K[Return True]
        I -- No --> J
    end

    A -- Uses --> G
    D -- Uses --> G

    style MultipleParameterSubscript fill:#f5cc,stroke:#f99,stroke-width:2px
    style IndexValidation fill:#c5ff,stroke:#9ff,stroke-width:2px
    
```


---

