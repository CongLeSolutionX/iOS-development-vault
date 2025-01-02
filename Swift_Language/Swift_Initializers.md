---
source_url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/"
created: 2025-1-1 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


The mermaid diagram below is my attempt to translate and to explain the initialization process from the official original documentation on [Swift Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization). This is still a work in progress.


In essence, below is a comprehensive Mermaid diagram provides a visual walkthrough of the different paths and processes involved in creating and destroying objects in Swift, with a focus on the various types of initializers and their specific roles.


```mermaid
%% ---
%% config:
%%   layout: elk
%%   look: handDrawn
%%   theme: dark
%% ---
graph TD
    subgraph Object_Creation_Lifecycle["Object Creation Lifecycle"]
        direction TB
        A[Request to Create Instance] --> B{Which Initializer is Called?};
    end

    subgraph Designated_Initializer_Path["Designated Initializer Path"]
        direction TB
        B -- Designated Init --> C[Start Designated Initializer];
        C --> D{Initialize All Own Stored Properties};
        D -- All Initialized --> E{Is This a Subclass?};
        E -- Yes --> F[Call Superclass Designated Initializer];
        F --> G[Superclass Initializes Properties];
        G --> H[Return to Subclass];
        H --> I["Phase 2: Further Customization (Optional)"];
        I --> J[Initialization Complete];
        E -- No --> K["Phase 2: Further Customization (Optional)"];
        K --> J;
        style C fill:#c5cf,stroke:#333,stroke-width:2px
        style D fill:#c5cf,stroke:#333,stroke-width:2px
        style F fill:#c5cf,stroke:#333,stroke-width:2px
        style G fill:#a5af,stroke:#333,stroke-width:2px
        style I fill:#a5af,stroke:#333,stroke-width:2px
        style K fill:#a5af,stroke:#333,stroke-width:2px
        linkStyle 0,1,2,3,4,5 stroke:#333,stroke-width:2px
    end

    subgraph Convenience_Initializer_Path["Convenience Initializer Path"]
        direction TB
        B -- Convenience Init --> L[Start Convenience Initializer];
        L --> M["Must Delegate to Designated Initializer (Self or Super)"];
        M -- Calls Designated Init --> C;
        M -- Calls Another Convenience Init --> L;
        style L fill:#d5df,stroke:#333,stroke-width:2px
        style M fill:#d5df,stroke:#333,stroke-width:2px
        linkStyle 6,7 stroke:#333,stroke-width:2px, dasharray: 5 5
    end

    subgraph Failable_Initializer_Path["Failable Initializer Path (init?)"]
        direction TB
        B -- Failable Init (init?) --> N[Start Failable Initializer];
        N --> O{Can Initialization Succeed?};
        O -- Yes --> P[Initialize Instance];
        P --> J;
        O -- No --> Q[Return nil];
        style N fill:#f5cc,stroke:#333,stroke-width:2px
        style O fill:#f5cc,stroke:#333,stroke-width:2px
        style P fill:#f5aa,stroke:#333,stroke-width:2px
        style Q fill:#f5aa,stroke:#333,stroke-width:2px
        linkStyle 8,9,10 stroke:#333,stroke-width:2px
    end

    subgraph Implicitly_Unwrapped_Failable_Init_Path["Implicitly Unwrapped Failable Init Path (init!)"]
        direction TB
        B -- Failable Init (init!) --> R[Start Implicitly Unwrapped Failable Init];
        R --> S{Can Initialization Succeed?};
        S -- Yes --> T["Initialize Instance (Implicitly Unwrapped Optional)"];
        T --> J;
        S -- No --> U[Return nil];
        style R fill:#f5dd,stroke:#333,stroke-width:2px
        style S fill:#f5dd,stroke:#333,stroke-width:2px
        style T fill:#f5bb,stroke:#333,stroke-width:2px
        style U fill:#f5bb,stroke:#333,stroke-width:2px
        linkStyle 11,12,13 stroke:#333,stroke-width:2px, dasharray: 3 3
    end

    subgraph Required_Initializer_Constraint["Required Initializer Constraint"]
        direction LR
        V[Class Defines 'required init'] -- Enforces --> W[Subclasses Must Implement];
        style V fill:#c5ce,stroke:#333,stroke-width:2px
        style W fill:#a5aa,stroke:#333,stroke-width:2px
        linkStyle 14 stroke:#333,stroke-width:2px
    end

    subgraph Deinitialization_Process["Deinitialization Process"]
        direction TB
        X[Instance No Longer Referenced] --> Y[deinit Called Automatically];
        Y --> Z[Perform Cleanup Actions];
        Z --> AA[Memory is Reclaimed];
        style X fill:#e5ec,stroke:#333,stroke-width:2px
        style Y fill:#e5ec,stroke:#333,stroke-width:2px
        style Z fill:#b5bc,stroke:#333,stroke-width:2px
        style AA fill:#a5ac,stroke:#333,stroke-width:2px
        linkStyle 15,16,17 stroke:#333,stroke-width:2px
    end

    %% Connections between Subgraphs (Implicit)
    B --> C
    B --> L
    B --> N
    B --> R
    J --> X
    linkStyle 18,19,20,21,22 stroke:#666,stroke-width:1px

    style Object_Creation_Lifecycle fill:#eee5,stroke:#333,stroke-width:1px
    style Designated_Initializer_Path fill:#ffe5,stroke:#333,stroke-width:1px
    style Convenience_Initializer_Path fill:#eef5,stroke:#333,stroke-width:1px
    style Failable_Initializer_Path fill:#fee5,stroke:#333,stroke-width:1px
    style Implicitly_Unwrapped_Failable_Init_Path fill:#eee5,stroke:#333,stroke-width:1px
    style Required_Initializer_Constraint fill:#eee5,stroke:#333,stroke-width:1px
    style Deinitialization_Process fill:#eee5,stroke:#333,stroke-width:1px

```

---


Here's a breakdown of each component in the comprehensive Mermaid diagram:

## Subgraphs (Representing higher-level concepts)

*   **Object Creation Lifecycle:**  This is the starting point, representing the initial request to create an instance of a class.
*   **Designated Initializer Path:**  This outlines the primary and most fundamental way a class is initialized. It ensures all essential properties are set and calls upon superclasses for their initialization.
*   **Convenience Initializer Path:** This describes how convenience initializers act as secondary initializers, simplifying common initialization scenarios by ultimately delegating to a designated initializer.
*   **Failable Initializer Path (init?)**: This illustrates the flow for initializers that can potentially fail during the initialization process and return `nil`.
*   **Implicitly Unwrapped Failable Init Path (init!)**: Similar to the regular failable initializer, but the successfully initialized instance is an implicitly unwrapped optional, carrying a risk of runtime errors if accessed when `nil`.
*   **Required Initializer Constraint:** This highlights the rule that if a class defines a `required` initializer, all its subclasses must also implement it, ensuring consistent initialization across the inheritance hierarchy.
*   **Deinitialization Process:** This depicts what happens when an instance is no longer needed, showing the automatic call to `deinit` for cleanup and the eventual memory reclamation.

## Nodes (Representing specific steps or states)

*   **A (Request to Create Instance):** The very beginning of the process, someone or something asks for a new object.
*   **B (Which Initializer is Called?):**  A decision point determining the type of initializer being invoked.
*   **C (Start Designated Initializer):** The execution of a designated initializer begins.
*   **D (Initialize All Own Stored Properties):**  The core responsibility of a designated initializer – setting the initial values of all non-optional properties declared in the class.
*   **E (Is This a Subclass?):** A check to see if the current class inherits from another class.
*   **F (Call Superclass Designated Initializer):** If it's a subclass, the designated initializer calls the designated initializer of its superclass to ensure the superclass's properties are also initialized.
*   **G (Superclass Initializes Properties):** The superclass performs its property initialization.
*   **H (Return to Subclass):** Control returns to the subclass's initializer after the superclass has finished.
*   **I (Phase 2: Further Customization (Optional)):**  The second phase of initialization where further setup or customization can be performed.
*   **J (Initialization Complete):** The object has been successfully initialized and is ready for use.
*   **K (Phase 2: Further Customization (Optional)):** Similar to 'I', but for base classes that don't have a superclass to initialize.
*   **L (Start Convenience Initializer):** The execution of a convenience initializer begins.
*   **M (Must Delegate to Designated Initializer (Self or Super)):** The key characteristic of a convenience initializer – it must call another initializer (usually designated) to handle the primary initialization.
*   **N (Start Failable Initializer):** The execution of a failable initializer (`init?`) begins.
*   **O (Can Initialization Succeed?):** A conditional check within a failable initializer to determine if the initialization criteria are met.
*   **P (Initialize Instance):** If the conditions are met, the instance is initialized.
*   **Q (Return nil):** If the conditions are not met, the failable initializer returns `nil`, indicating failure.
*   **R (Start Implicitly Unwrapped Failable Init):** The execution of an implicitly unwrapped failable initializer (`init!`) begins.
*   **S (Can Initialization Succeed?):** Similar to 'O', a check for success within an `init!`.
*   **T (Initialize Instance (Implicitly Unwrapped Optional)):** The instance is initialized, but it's an implicitly unwrapped optional.
*   **U (Return nil):** If initialization fails, `nil` is returned. Accessing this `nil` value without checking will cause a runtime error.
*   **V (Class Defines 'required init'):** A base class declares a `required` initializer.
*   **W (Subclasses Must Implement):**  The consequence of a `required` initializer – all subclasses are obligated to provide an implementation.
*   **X (Instance No Longer Referenced):** The point at which an instance is no longer held by any strong references.
*   **Y (deinit Called Automatically):** The system automatically calls the `deinit` method of the instance.
*   **Z (Perform Cleanup Actions):**  The code within the `deinit` method is executed, allowing for resource release or other cleanup tasks.
*   **AA (Memory is Reclaimed):**  The memory occupied by the instance is freed by the system.

---

