---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/ClassesAndStructures.md"
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


Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/ClassesAndStructures.md):

---




Here's a plan:
1. **Diagram comparing Structures and Classes:** Highlight the common features and the exclusive features of classes.
2. **Diagram illustrating Definition Syntax:** Show the basic syntax for defining structures and classes.
3. **Diagram illustrating Structure and Class Instances:** Depict the creation of instances.
4. **Diagram illustrating Accessing Properties (Dot Syntax):** Show how to access properties using dot notation.
5. **Diagram illustrating Memberwise Initializers:** Demonstrate the automatic initializer for structures.
6. **Diagram illustrating Value Types (Copying):** Visually represent how structures and enumerations are copied on assignment.
7. **Diagram illustrating Reference Types (Sharing):** Visually represent how classes share the same instance on assignment.
8. **Diagram illustrating Identity Operators:** Show how `===` checks for the same instance in memory.



----


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Structures and Classes] --> B{"Common Features"};
    A --> C{"Class-Specific Features"};
    B --> D[Properties];
    B --> E[Methods];
    B --> F[Subscripts];
    B --> G[Initializers];
    B --> H[Extensions];
    B --> I[Protocol Conformance];
    C --> J[Inheritance];
    C --> K[Type Casting];
    C --> L[Deinitializers];
    C --> M[Reference Counting];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;
style C fill:#d5df,stroke:#333,stroke-width:1px;

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
    A[Definition Syntax] --> B{Structure};
    A --> C{Class};
    B --> D["struct SomeStructure { <br> // structure definition <br> }"];
    C --> E["class SomeClass { <br> // class definition <br> }"];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;
style C fill:#d5df,stroke:#333,stroke-width:1px;

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
    A["Creating Instances"] --> B{"Structure Instance"};
    A --> C{"Class Instance"};
    B --> D["let someResolution = Resolution()"];
    C --> E["let someVideoMode = VideoMode()"];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;
style C fill:#d5df,stroke:#333,stroke-width:1px;

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
    A[Accessing Properties] --> B{Dot Syntax};
    B --> C[instanceName.propertyName];
    B --> D["print(someResolution.width)"];
    B --> E["someVideoMode.resolution.width = 1280"];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;

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
    A["Memberwise Initializer (Structures)"] --> B["let vga = Resolution(width: 640, height: 480)"];

style A fill:#c59f,stroke:#333,stroke-width:2px;

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
    subgraph Value_Types["Value Types <br> (Structures & Enums)"]
        direction LR
        A[hd: Resolution <br> width = 1920, height = 1080] -->|Copy| B[cinema: Resolution <br> width = 1920, height = 1080]
        B --> C[cinema.width = 2048]
        C --> D[cinema: Resolution <br> width = 2048, height = 1080]
        A --- E
        E[hd: Resolution <br> width = 1920, height = 1080]
    end

style A fill:#a5af,stroke:#333,stroke-width:1px;
style B fill:#a5af,stroke:#333,stroke-width:1px;
style D fill:#a5af,stroke:#333,stroke-width:1px;
style E fill:#a5af,stroke:#333,stroke-width:1px;

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
    subgraph Reference_Types["Reference Types <br> (Classes)"]
        direction LR
        A[tenEighty: VideoMode <br> frameRate = 25.0] -- Same Instance --> B[alsoTenEighty: VideoMode <br> frameRate = 25.0]
        B --> C[alsoTenEighty.frameRate = 30.0]
        C -- Same Instance --> D[tenEighty: VideoMode <br> frameRate = 30.0]
    end

style A fill:#f5fa,stroke:#333,stroke-width:1px;
style B fill:#f5fa,stroke:#333,stroke-width:1px;
style D fill:#f5fa,stroke:#333,stroke-width:1px;

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
    A[Identity Operators] --> B{"Identical To (===)"};
    A --> C{"Not Identical To (!==)"};
    B --> D["if tenEighty === alsoTenEighty { <br> print(...) <br> }"];

style A fill:#c5cf,stroke:#333,stroke-width:2px;
style B fill:#d5df,stroke:#333,stroke-width:1px;
style C fill:#d5df,stroke:#333,stroke-width:1px;

```

---


**Illustration for Comparing Structures and Classes:**

```markdown
          Common Ground                       |             Class Extras
----------------------------------------------|--------------------------------------------
| Properties, Methods, Subscripts, Initializers | Inheritance, Type Casting, Deinitializers |
| Extensions, Protocol Conformance            | Reference Counting                         |
----------------------------------------------|--------------------------------------------
              Structures                        |               Classes
```

**Illustration for Value Types vs. Reference Types:**

```markdown
  Value Type (Copy)                      Reference Type (Reference)

+--------+     Copy     +--------+      +--------+
|  Var A |----------->|  Var B |------->| Instance |
+--------+             +--------+      +--------+

(Changes to Var B do     (Both Var A and Var B
 NOT affect Var A)      point to the SAME instance)
```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---