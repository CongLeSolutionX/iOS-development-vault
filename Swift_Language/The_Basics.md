---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/TheBasics.md"
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

Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/TheBasics.md):

---



Here's a plan for creating the diagrams:

1. **High-Level Structure:** Start with a diagram showing the main topics covered in the "The Basics" section.
2. **Constants and Variables:**  Illustrate the difference between `let` and `var`.
3. **Type Annotations:** Show how type annotations clarify data types.
4. **Type Inference:** Depict how Swift automatically infers types.
5. **Numeric Literals:** Visualize different ways of representing integer literals (decimal, binary, etc.).
6. **Type Conversion:** Illustrate explicit type conversion between different numeric types.
7. **Tuples:**  Show how tuples group multiple values.
8. **Optionals:** Explain the concept of optionals and how they handle the absence of a value (using `nil`). Depict optional binding and force unwrapping.
9. **Error Handling:**  Illustrate the `try`, `catch`, and `throw` mechanism.
10. **Assertions and Preconditions:** Show the difference between assertions (debug only) and preconditions (debug and production).Here are some Mermaid diagrams and illustrations to accompany the Swift documentation you provided:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Swift_Basics["Swift Basics"]
	    style Swift_Basics fill:#c392,stroke:#333,stroke-width:2px;
        direction TB
        A["Data Types: <br> Int, Double, Bool, String"] --> B("Collections: <br> Array, Set, Dictionary")
        A --> C("Variables: var")
        A --> D("Constants: let")
        A --> E(Tuples)
        A --> F(Optionals)
        A --> G(Type Safety)
    end
    
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
    subgraph Constants_and_Variables["Constants and Variables"]
	    style Constants_and_Variables fill:#c391,stroke:#333,stroke-width:2px;
        direction LR
        A[let] --> B{Value Assigned Once}
        A --> C{Immutable}
        D[var] --> E{Value Can Change}
        D --> F{Mutable}
    end
    
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
    subgraph Type_Annotations["Type Annotations"]
        style Type_Annotations fill:#c295,stroke:#333,stroke-width:2px;
        A[Variable/Constant Name] -- ":" --> B[Type]
        B --> C(Clarifies Data Type)
        B --> D(Explicitly Defines Type)
    end
    
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
    subgraph Type_Inference["Type Inference"]
        style Type_Inference fill:#c215,stroke:#333,stroke-width:2px;
        A[Value Provided on Declaration] --> B{Swift Infers Type}
        B --> C(Reduces Explicit Type Declarations)
        D[Example: let age = 25] --> B
    end
    
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
    subgraph Numeric_Literals["Numeric Literals"]
        style Numeric_Literals fill:#c119,stroke:#333,stroke-width:2px;
        direction TB
        A["Integer Literals"] --> B("Decimal: <br> 17")
        A --> C("Binary: <br> 0b10001")
        A --> D("Octal: <br> 0o21")
        A --> E("Hexadecimal: <br> 0x11")
        F["Floating-Point Literals"] --> G("Decimal: <br> 12.1875")
        F --> H(With Exponent: <br> 1.21875e1)
        F --> I("Hexadecimal: <br> 0xC.3p0")
    end
    
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
    subgraph Numeric_Type_Conversion["Numeric Type Conversion"];
        style Numeric_Type_Conversion fill:#c519,stroke:#333,stroke-width:2px;
        A["Numeric Type <br> (e.g., UInt8)"] -- "Initialize with" --> B["Desired Type <br> (e.g., UInt16)"];
        B --> C("Explicit Conversion Required");
        D["Example: <br> UInt16(myUInt8)"] --> C;
    end
    
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
    subgraph Tuples
        style Tuples fill:#c612,stroke:#333,stroke-width:2px;
        A(( )) --> B(Group Multiple Values);
        B --> C(Values Can Be Different Types);
        D["Example: <br> (404, 'Not Found')"] --> B;
        B --> E(Access by Index: <br> .0, .1);
        B --> F(Access by Name: <br> .statusCode, .description);
        B --> G("Decomposition: <br> let (code, message) = tuple");
    end
    
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
    subgraph Optionals
        style Optionals fill:#c613,stroke:#333,stroke-width:2px;
        direction TB
        A["Optional Type <br> (e.g., Int?)"] --> B{"Contains a Value OR nil"};
        B --> C(Handles Absence of Value);
        D[Setting to nil] --> E(Indicates No Value);
        F["Optional Binding <br> (if let)"] --> G("Safely Access Value if Present");
        H["Force Unwrapping <br> (!)"] --> I("Access Value - <br> Potential Runtime Error if nil");
        J["Implicitly Unwrapped Optional <br> (Int!)"] --> K("Assumed to Always Have a Value After Initialization");
    end
    
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
    subgraph Error_Handling["Error Handling"];
        style Error_Handling fill:#c614,stroke:#333,stroke-width:2px;
        A["Function that Can Fail"] -- "throws" --> B("Indicates Potential Error");
        C["Calling a throwing function"] -- "try" --> D("Attempt Execution");
        D -- Error Thrown --> E("catch Clause");
        D -- No Error --> F("Continue Execution");
        E --> G("Handle the Specific Error");
    end
    
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
    subgraph Assertions_and_Preconditions["Assertions and Preconditions"]
        style Assertions_and_Preconditions fill:#c615,stroke:#333,stroke-width:2px;
        direction LR
        A[Assertions] -- "Checked in Debug Builds" --> B{"Verify Assumptions During Development"};
        B --> C("Terminates App if Condition is False");
        D[Preconditions] -- "Checked in Debug & Production" --> E{"Enforce Requirements for Correct Execution"};
        E --> F("Terminates App if Condition is False");
    end
    
```



These diagrams aim to provide visual summaries of the concepts explained in the Swift documentation. You can use them to enhance understanding and make the documentation more engaging. Remember that the level of detail in each diagram can be adjusted based on the specific focus and audience.

---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---