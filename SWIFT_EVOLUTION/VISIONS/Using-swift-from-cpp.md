---
created: 2025-03-29 05:31:26
author: NA
version: NA
license(s): NA
copyright: NA
original source: "https://github.com/swiftlang/swift-evolution/blob/main/visions/using-swift-from-c%2B%2B.md"
---



# Using Swift from C++
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


## A Diagrammatic Guide 

Here is a collection of Mermaid diagrams illustrating the concepts and complexities described in the "Using Swift from C++" vision document.


### 1. Overview: The Problem and Proposed Solution

This flowchart illustrates the core motivation and the high-level solution proposed for Swift-to-C++ interoperability.

```mermaid
---
title: "Overview: The Problem and Proposed Solution"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
flowchart TD
    A["Existing C++ Codebase"] --> B{"Desire to Use Swift"}
    B --> B1["Adopt Swift Gradually"]
    B --> B2["Use Swift-Only Libraries"]
    B --> C{"CurrentChallenge"}
    C --> C1["No Direct Swift -> C++ Interop"]
    C --> C2["Objective-C Wrappers are Cumbersome<br/>(performance/expressivity issues, '@objc' needed)"]
    C --> D["Proposed Solution: Swift-to-C++ Interoperability"]
    D --> E["Swift Compiler Generates C++ Header<br>(.h)"]
    E --> F["Header Exposes Swift APIs using C++ Constructs"]
    F --> G["Utilizes Native Swift Calling Convention"]
    G --> H["C++ Code Can Directly Call Swift APIs"]
    H --> I["Lowers Adoption Barrier"]
    H --> J["Enables Access to Swift Libraries"]

    style C fill:#f9f3,stroke:#333,stroke-width:2px
    style D fill:#ccf3,stroke:#333,stroke-width:2px
    
```


------


### 2. Comparison: Reverse Interoperability Mechanisms

This diagram contrasts the proposed C++ reverse interoperability mechanism with the existing Objective-C mechanism.

```mermaid
---
title: "Comparison: Reverse Interoperability Mechanisms"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
flowchart TD
    subgraph Swift_Code["Swift Code"]
        S["Swift Module Code<br>(.swift)"]
    end

    S --> SC[Swift Compiler]

    subgraph Objective_C_Interop_Reverse["Objective-C Interop<br>(Reverse)"]
    direction LR
        SC --> O1{"Requires '@objc' Annotation"}
        O1 --> O2["Generates Objective-C Header<br>('-Swift.h')"]
        O2 --> O3["Relies on Obj-C Runtime & ABI"]
        O3 --> O4["Usable by Objective-C / Objective-C++ Code"]
    end

    subgraph CPP_Interop_Reverse_Proposed["C++ Interop<br>(Reverse - Proposed)"]
    direction LR
        SC --> C1{"No '@objc' Needed<br>(By Default)"}
        C1 -- Optional --> C1a["Annotation ('@expose') for Fine Control"]
        C1 --> C2["Generates C++ Header<br>(.h)"]
        C2 --> C3["Uses Native Swift Calling Convention & ABI"]
        C3 --> C4["Usable by C++ Code<br>(Clang initially)"]
    end

    style O1 fill:#f9f2,stroke:#333,stroke-width:1px
    style C1 fill:#cbc2,stroke:#333,stroke-width:1px
    
```

---


### 3. Core Goals of Swift-to-C++ Interoperability

This mind map outlines the primary objectives guiding the design of the feature.

```mermaid
---
title: "Core Goals of Swift-to-C++ Interoperability"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Monospace'
    }
  }
}%%
mindmap
  root((Swift -> C++ Interop Goals))
    Lower Adoption Barrier
      ::icon(fa fa-door-open)
      Gradual Swift adoption in C++ projects
      Use Swift libraries from C++
    Safety First
      ::icon(fa fa-shield-alt)
      Enforce Swift Type Rules
      Enforce Swift Memory Model (incl. lifetime management)
      Enforce Exclusivity Rules (compile/runtime checks)
      Prioritize Safety over Performance (by default)
    High Performance
      ::icon(fa fa-tachometer-alt)
      Minimize Bridging Overhead
      No unnecessary type conversions (e.g., String != std::string)
      Zero-cost for primitive types (Float == float)
      Minimize overhead for complex features (e.g., resilience)
    Ergonomics
      ::icon(fa fa-thumbs-up)
      Map to corresponding C++ features where possible
      Provide reasonable C++ approximations otherwise (e.g., Swift Enum -> C++ Class)
      Enhance C++ types for idiomatic use (e.g., range-based for)
      Consistent experience (Library Evolution shouldn't break C++ use)
    Clear Language Mapping
      ::icon(fa fa-map)
      Well-defined rules for Swift -> C++ construct mapping
      Document unbridged features
      Clear compiler diagnostics for exposure issues
      Map common Swift API patterns (e.g., namespace-enum -> C++ namespace)
      Preserve Swift Semantics (Value vs. Ref, COW)
    Unaffected Swift Evolution
      ::icon(fa fa-rocket)
      Swift language/API design driven by Swift goals, not C++ interop needs
      New Swift features don't *need* C++ exposure
      Avoid incentivizing "worse" Swift code for "better" C++ interface
    Objective-C Compatibility
      ::icon(fa fa-link)
      Existing Swift -> Obj-C bridge remains supported
      Generated C++ uses Obj-C++ constructs where appropriate
      
```

---


### 4. Technical Approach: Header Generation and Usage

This diagram illustrates the flow of generating and using the C++ header file.

```mermaid
---
title: "Technical Approach: Header Generation and Usage"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    subgraph Input
        A["Swift Module Source (.swift)<br/><i>or</i><br/>Swift Interface (.swiftinterface)"]
    end

    subgraph Generation Process
        A --> B("Swift Compiler / Tooling")
        B -- Generates --> C{"Generated C++ Header<br>(.h)"}
        C --> C1[Contains C++ Wrapper Types/Functions]
        C --> C2[Relies on Native Swift Calling Convention]
        C --> C3["Depends on Clang Features<br>(initially)"]
        C --> C4["Requires C++14+ (C++20 Recommended)"]
        C --> C5["Can Include C/Obj-C Decls"]
        C --> C6["Client-Generated (Typical)<br/><i>or</i> Library-Distributed"]
        C --> C7["Respects ABI Stability<br>(where applicable)"]
    end

    subgraph Usage["Usage"]
        D["C++ Source Code<br>(.cpp)"] -- Includes --> C
        D --> E{"C++ Compiler<br>(Clang)"}
        E -- Compiles --> F["Executable / Library"]
    end

    subgraph Runtime_Interaction["Runtime Interaction"]
        F -- Calls --> G["C++ Wrapper Code in Header"]
        G -- Calls --> H["Native Swift Code<br>(Functions/Methods)"]
    end

    style B fill:#add3,stroke:#333,stroke-width:2px
    style C fill:#dda3,stroke:#333,stroke-width:2px
    style E fill:#add3,stroke:#333,stroke-width:2px
    
```

---


### 5. Bridging Key Swift Constructs to C++

This mind map summarizes how major Swift language features are expected to be represented in C++.

```mermaid
---
title: "Bridging Key Swift Constructs to C++"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Monospace'
    }
  }
}%%
mindmap
  root((Bridging Swift Constructs to C++))
    Types (Struct, Enum, Class)
      Mapped to C++ `class` types
      Preserve Swift semantics (Value vs. Reference, Copying/Destruction)
      Support C++ Move Semantics (Mapped to Swift `consume`)
      Expose Methods, Properties, Members
      Handle Swift Enums idiomatically (e.g., map to C++ class for members/methods)
    Protocols
      Exposed as C++ types
      Access to protocol interface
      Support for Protocol Composition
    Generics
      Mapped to C++ Templates (`template <...> class/func`)
      Type-checking["Type-checking via `requires` (C++20) or `enable_if` (C++17-)"]
      Instantiates type-checked Swift generic interface
      Specialized storage for bounded generics (performance)
    Standard Library Types
      Bridged (e.g., `String`, `Array`, `Optional`)
      Enhanced C++ interface for idiomatic usage
        (`Array` -> range-based for support)
        (`Optional` -> C++ optional-like API)
    Non-Copyable Types
      Supported via C++ Move Semantics mapping to `consume`
    Functions / Methods / Initializers / Accessors
      Exposed as C++ functions / member functions
      Argument labels integrated into function names
      Initializers potentially mapped to static `init` methods (esp. failable)
    Specific Patterns
      Namespace-like enums -> C++ `namespace`

```


----


### 6. Evolution Process for the Feature

This flowchart outlines how the specific bridging details will be designed and approved.

```mermaid
---
title: "Evolution Process for the Feature"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'natural' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
flowchart TD
    A[Identify Swift Language Construct / API Pattern for Bridging] --> B(Draft Detailed Swift Evolution Proposal)
    B --> C["Proposal References Vision Document"]
    C --> D{Swift Evolution Review Process}
    D -- Community Feedback --> D
    D --> E{Decision}
    E -- Accepted --> F[Bridging Design Ratified & Documented]
    E -- Rejected/Revised --> B

    style D fill:#ffc3,stroke:#333,stroke-width:1px
    
```


---



### 7. Ecosystem Integration

This mind map details the planned support within the broader Swift ecosystem tools.

```mermaid
---
title: "Ecosystem Integration"
author: NA
version: NA
license(s): NA
copyright: NA
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Monospace'
    }
  }
}%%
mindmap
  root((Ecosystem Tooling Integration))
    Build Tool Support
      Swift Package Manager (SwiftPM)
        ::icon(fa fa-box-open)
        Automatic header generation for C++ targets
        Header discovery/include path setup
        Reuse existing Obj-C header generation logic
      CMake
        ::icon(fa fa-cogs)
        Provide good support for mixed Swift/C++ targets
        Example project showing interop setup
    Debugging Support (LLDB)
      ::icon(fa fa-bug)
      Understand C++ wrappers -> Show underlying Swift value
      Step-in/Step-out skips C++ wrapper thunks
    IDE Support (SourceKit-LSP)
      ::icon(fa fa-laptop-code)
      Wrap/redirect queries to `clangd`
      Mixed-language queries (Jump-to-Definition Swift <-> C++)
      Extend Clang Indexing
        Represent C++ wrapper references as underlying Swift references
        
```





---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---