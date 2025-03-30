---
created: 2025-03-29 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: "https://github.com/swiftlang/swift-evolution/blob/main/visions/using-c%2B%2B-from-swift.md"
---



# Using C++ from Swift 
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


These diagrams aim to capture the core concepts, challenges, and proposed solutions outlined in the Swift C++ interoperability vision document.



### 1. Overall Vision and Goals

This mindmap outlines the central theme, primary goals, and key motivations behind the C++ interoperability vision.

```mermaid
---
title: "Overall Vision and Goals"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
  root((Swift <- C++ Interop Vision))
    Primary Goals
      **Safety**
        Avoid inheriting C++ unsafety
        Make C++ APIs *safer* in Swift
        Statically derive safety where possible
        Require annotations otherwise
        Make unsafety clear / Decline unsafe imports
      **Idiomatic Usage**
        Map C++ patterns to Swift idioms (Collections, value/ref types)
        Feel natural for Swift developers
        Avoid boilerplate/bridging layers
      **Enable Swift Adoption**
        Viable C++ successor language
        Incremental adoption (file-by-file)
        Remove barriers to writing Swift
    Target Use Cases
      Swift developers using C++ libraries
      C++ developers migrating to Swift
    Key Challenges
      C++ Unsafety (pointers, lifetimes)
      C++ Idiom Variety vs. Swift Conventions
      Performance Overhead Avoidance
      Diagnosability
    Approach Pillars
      Pattern Recognition (Iterators, Containers, etc.)
      Semantic Mapping (Value/Reference, Mutability)
      Annotations for Guidance
      Prioritize Safety & Idiomaticity
    Non-Goals (Initially/Explicitly)
      Perfect C++ Template -> Swift Generic mapping
      Importing *every* C++ API without thought/annotation
      Reverse_Interop["Reverse Interop (Swift -> C++) (Covered separately)"]
      
```

---


### 2. Core Interoperability Approach: Pattern Recognition & Mapping

This flowchart illustrates the general decision-making process the Swift compiler aims to follow when importing a C++ API.

```mermaid
---
title: "Core Interoperability Approach: Pattern Recognition & Mapping"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    A["C++ API Encountered"] --> B{"Recognize Idiomatic C++ Pattern?"}
    B -- Yes --> C{"Can Map Safely & Idiomatically?"}
    B -- No --> D{"Annotation Provided?"}

    C -- Yes --> E["Map to Corresponding Swift Construct<br>(e.g., Collection, struct, class)"]
    C -- No --> F["Require Annotation / User Guidance"]

    D -- Yes --> G{"Annotation Defines Safe/Idiomatic Mapping?"}
    D -- No --> H["API Unavailable in Swift - Needs Annotation or Wrapper"]
    G -- Yes --> I["Map to Swift Construct based on Annotation"]
    G -- No --> H

    F --> H
    E --> J["API Usable in Swift"]
    I --> J

    subgraph Constraints
        K["Maintain Swift Safety Guarantees"]
        L["Promote Swift Idioms"]
        M["Ensure Good Performance"]
        N["Provide Clear Diagnostics"]
    end

    E --> K
    E --> L
    E --> M
    E --> N
    I --> K
    I --> L
    I --> M
    I --> N
    H --> N

```


---


### 3. Type Import Strategy: Value vs. Reference Semantics

This diagram outlines the high-level strategy for deciding whether to import a C++ class/struct as a Swift struct (value semantics) or class (reference semantics).

```mermaid
---
title: "Type Import Strategy: Value vs. Reference Semantics"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    A["C++ 'class' or 'struct' Declaration"] --> B{"Criteria for Reference Type Met?"}

    subgraph ReferenceTypeCriteria["Reference Type Criteria<br>(Often Needs Annotation)"]
        B1[Semantic Object Identity?]
        B2["Polymorphic (virtual methods)?"]
        B3["Predominantly Passed by Pointer/Reference?"]
        B4["Expectation of Stable Address?"]
    end

    B -- "Yes<br>(Often Requires Annotation)" --> C["Attempt to Import as Swift 'class'"]
    B -- No --> D["Import as Swift 'struct'<br>(Default)"]

    C --> E{"Determine Object Management Strategy"}
    D --> F{"Determine Value Type Category"}

    E --> E_Managed["Managed<br>(Unique/Shared)"]
    E --> E_Unmanaged["Unmanaged/Immortal"]

    F --> F_Simple["Simple Data Type"]
    F --> F_SelfContained["Self-Contained Type"]
    F --> F_View["View Type"]

    E_Managed --> G["Usable as Swift Class<br>(Managed)"]
    E_Unmanaged --> H["Usable as Swift Class<br>(Unmanaged)"]
    F_Simple --> I["Usable as Swift Struct<br>(Safe)"]
    F_SelfContained --> J["Usable as Swift Struct<br>(Mostly Safe, Heuristics)"]
    F_View --> K["Imported Struct<br>(Unsafe Elements, Needs Care)"]

    style B fill:#f9f3,stroke:#333,stroke-width:2px
    style C fill:#ccf3,stroke:#333,stroke-width:2px
    style D fill:#cfc3,stroke:#333,stroke-width:2px
    
```

---


### 4. Reference Type Management Strategies

This diagram details the different ways C++ reference types can be managed and how Swift aims to import them.

```mermaid
---
title: "Reference Type Management Strategies"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["C++ Type Identified as Reference Type"] --> B{"Management Pattern"}
    B --> C["Immortal"]
    B --> D["Unique Ownership"]
    B --> E["Shared Ownership"]

    C --> C1["No individual destruction"]
    C1 --> C2["Examples: Arena-allocated, Global Singletons"]
    C2 --> C3["Import as **Unmanaged Swift Class**"]
    C3 --> C4["Safety depends on C++ API guarantees<br>(potential for leaks/use-after-free if not truly immortal)"]

    D --> D1["Single owner responsible for destruction"]
    D1 --> D2["Idioms:<br> Raw pointer + 'delete', 'std::unique_ptr'"]
    D2 --> D3{"Can map ownership semantics?<br>(e.g., via 'unique_ptr' usage)"}
    D3 -- Yes --> D4["Import as **Managed Non-Copyable Swift Class**<br>(Future)"]
    D3 -- No --> D5["Import as **Unmanaged Swift Class** or via 'Unmanaged' wrapper"]

    E --> E1["Reference Counted"]
    E1 --> E2["Idioms:<br>Custom retain/release,<br>'std::shared_ptr' (Intrusive/Non-Intrusive)"]
    E2 --> E3{"Can map RC operations?<br>(e.g., via 'shared_ptr' or annotations)"}
    E3 -- Yes --> E4["Import as **Managed Swift Class<br>(ARC-like)**"]
    E3 -- No --> E5["Import as **Unmanaged Swift Class**"]
    E4 --> E6["Note:<br>Raw pointer usage<br>(e.g., 'this' in methods) is tricky for non-intrusive shared pointers if copy needed"]
    E4 --> E7["Note:<br>Non-atomic RC => Not Sendable"]

    subgraph General_Rule["General Rule"]
        Z["APIs inconsistent with annotated pattern<br>(e.g., 'unique_ptr' param for 'shared_ptr' type) --> Unavailable"]
    end
    
```

----


### 5. Value Type Categories

This diagram categorizes the different kinds of C++ types imported as Swift structs, highlighting safety implications.

```mermaid
---
title: "Value Type Categories"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["C++ Type Imported as Swift 'struct'"] --> B{"Category"}

    B --> C["**Simple Data Types**"]
    C --> C1["Trivially copyable"]
    C1 --> C2["Does **not** contain pointers/references"]
    C2 --> C3["Examples:<br> 'int', 'float', 'struct Point { int x, y; }'"]
    C3 --> C4["Safety:<br> Generally safe, no lifetime issues"]

    B --> D["**Self-Contained Types**"]
    D --> D1["May have complex copy/destroy ops"]
    D1 --> D2["Contains pointers/references **but manages their lifetime internally**"]
    D2 --> D3["Examples:<br> 'std::string', 'std::vector<int>'"]
    D3 --> D4["Heuristic:<br> User-defined special members + pointers => likely self-contained"]
    D4 --> D5["Safety:<br> Mostly safe, but potential issues with indirect dependencies<br>(e.g., 'vector<T*>')"]
    D5 --> D6["Needs Correction:<br> Annotations to override heuristic"]

    B --> E["**View Types**"]
    E --> E1["Value type **not** self-contained"]
    E1 --> E2["Contains pointers/references to **unowned** memory"]
    E2 --> E3["Examples:<br> 'T*', 'T&', 'std::string_view', 'std::span<T>'"]
    E3 --> E4["Safety:<br> **Unsafe** - value depends on external lifetime. Leads to Projection issues"]

    style E fill:#fcc3,stroke:#333,stroke-width:2px
    
```

---



### 6. Projection Handling Challenge

This diagram illustrates the core problem with "projections" – values (often pointers/references) derived from another value whose lifetime they depend on, especially problematic with value types in Swift.

```mermaid
---
title: "Projection Handling Challenge"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    subgraph CppSide["C++ Example<br>('std::string')"]
        OwnedType["'std::string'<br>(Self-Contained Value Type)"] -- Owns --> OwnedStorage["Internal 'char*' buffer"]
        OwnedType -- "'c_str()' method" --> Projection1["'const char*'<br>(View Type)"]
        Projection1 -- Points to --> OwnedStorage
        OwnedType -- "'begin()/end()' methods" --> Projection2["'char*' Iterators<br>(View Type)"]
        Projection2 -- Points to --> OwnedStorage
    end

    subgraph SwiftSide["Swift Interaction Issue"]
        SwiftCode["Swift Code Using Imported 'std::string'"] --> SwiftVar["'var s: std.string'"]
        SwiftVar -- "Implicit Copy<br>(e.g., function call)" --> TempCopy["Temporary 'std::string' copy"]
        TempCopy -- "'s.c_str()' called on copy" --> DanglingPtr["'UnsafePointer<CChar>'"]
        TempCopy -- Destroyed --> FreedStorage["Underlying buffer of copy freed"]
        DanglingPtr -- Now Points to --> FreedStorage
    end

    Conclusion["Conclusion: Naive import of projections from value types is unsafe due to Swift's copy semantics & lifetime differences. Need strategies like scoped access (generalized accessors) or lifetime association."]

    style DanglingPtr fill:#f00, color:#fff
    style FreedStorage fill:#aaf3
    
```

----


### 7. Iterator and Range Mapping

This flowchart shows the desired mapping for common C++ iterator patterns.

```mermaid
---
title: "Iterator and Range Mapping"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    A["C++ Container<br>(e.g., 'std::vector')"] --> B{"Provides 'begin()' / 'end()' methods?"}
    B -- Yes --> C["Recognize Iterator Pair Pattern"]
    C --> D["Map to Swift 'Sequence'/'Collection' Conformance"]
    D --> E["Provide Safe Swift 'Iterator' Wrapper"]
    E --> F["Automatically works with Swift algorithms<br>('map', 'filter', 'reduce', etc.)"]
    F --> G["Idiomatic & Safe Swift Usage"]

    B -- No / Other Iterator Use --> H{"Complex Use Case?<br>(e.g., multiple iterators)"}
    H -- Yes --> I["Mapping Strategy TBD / Needs Evolution"]
    H -- No --> J["API Not Imported as Collection"]
    
```

----


### 8. Mutability Mapping (`const` vs. Swift Mutability)

This diagram highlights the mapping between C++ `const` and Swift's mutability system.

```mermaid
---
title: "Mutability Mapping (`const` vs. Swift Mutability)"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    subgraph CppDefinition["C++ Method Definition"]
        A1["'void mutates() { ... }'<br>(non-const)"]
        A2["'void doesntMutate() const { ... }'"]
        A3["Overloads: 'T& get(int);' & 'const T& get(int) const;'"]
        A4["'const_cast' usage"]
    end

    subgraph SwiftImport["Swift Import & Usage"]
        B1["'mutating func mutates()'"]
        B2["'func doesntMutate()'"]
        B3["Disambiguated via naming/attributes<br>(Details TBD)"]
        B4["Assumed NOT used by imported APIs<br>(Potential Unsafety)"]
        B5["Swift enforces exclusivity<br>(no aliased mutable args) -> Potential safety benefit"]
    end

    A1 --> B1
    A2 --> B2
    A3 --> B3
    A4 -- Assumed Not Used --> B4
    
    CppDefinition -- Translated To --> SwiftImport
    SwiftImport -- Benefits from --> B5

    style A4 fill:#fcc3
    style B4 fill:#fcc3
    
```


### 9. Computed Property Mapping (Getters/Setters)

Illustrates mapping common C++ getter/setter patterns to Swift computed properties.

```mermaid
---
title: "Computed Property Mapping (Getters/Setters)"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["C++ API Pattern"] --> B["Swift Idiomatic Mapping"]

    subgraph CppGetterSetter["C++ Getter/Setter Pair"]
        C1["'T getX() const;'"]
        C2["'void setX(const T& value);'"]
    end

    subgraph SwiftComputedProperty["Swift Computed Property"]
        D1["'var x: T {'"]
        D2["&nbsp;&nbsp;'get { ... }'"]
        D3["&nbsp;&nbsp;'set { ... }'"]
        D4["'}'"]
    end

    CppGetterSetter --> SwiftComputedProperty

    subgraph CppRefGetter["C++ Getter Returning Reference"]
        E1["'T& getY();' <br> 'const T& getY() const;'"]
    end

    subgraph SwiftGeneralizedAccessor["Swift Generalized Accessor<br>(yield)"]
        F1["'var y: T {'"]
        F2["&nbsp;&nbsp;'_read { yield /* reference */ }'"]
        F3["&nbsp;&nbsp;'_modify { yield &/* mutable storage */ }'"]
        F4["'}' <br> (Leverages coroutines for safety/performance)"]
    end

    CppRefGetter --> SwiftGeneralizedAccessor

    style B fill:#ccf3
    
```

---


### 10. C++ Templates / Swift Generics Limitation

Highlights the difficulty in bridging the two generic systems.

```mermaid
---
title: "C++ Templates / Swift Generics Limitation"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["C++ Templates"] --> B("Template<T> { ... }")
    C["Swift Generics"] --> D("Generic<T: Protocol> { ... }")

    B --> E{"Use C++ Template in Swift?"}
    E -- "In Swift Generic Code<br>(e.g., 'func foo<U>(t: Template<U>)')" --> F("**Very Difficult / Likely Not Supported Initially**")
    F --> F1["Requires major language/compiler work"]
    E -- "On Concrete Swift Types<br>(e.g., 'let x: Template<MySwiftStruct>')" --> G("**Theoretically Feasible, but Complex**")
    G --> G1["Major project, ad-hoc constraints"]
    G --> G2["Likely needs annotations/wrappers"]


    H["C++ Type"] --> I("MyCppClass")
    I --> J{"Use C++ Type in Swift Generic Code?"}
    J -- "Unconstrained<br>(e.g., 'func bar<T>(c: T)')" --> K("**Supported**")
    J -- "Constrained<br>(e.g., 'func baz<T: MyProto>(c: T)')" --> L("**Supported via Conformance**")
    L --> L1["Add 'extension MyCppClass: MyProto { ... }'"]

    style F fill:#fcc3
    style G fill:#fec3
    
```

----


### 11. Standard Library Interaction & Overlay

Shows the relationship between Swift code, the Swift standard library, the C++ standard library, and the necessary overlays/utility modules.

```mermaid
---
title: "Standard Library Interaction & Overlay"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["Swift Application Code"] --> B["Swift Standard Library"]
    A --> C["Imported C++ Module"]

    C --> D["**Implicit C++ Interop Swift Utilities**"]
    D --> B
    D -.-> E
    D -.-> F

    C --> E["**C++ Standard Library Overlay<br>(Swift)**"]
    E --> B
    E --> F["C++ Standard Library<br>('<vector>', '<string>', etc.)"]

    A -- Uses --> D
    A -- Uses --> E
    E -- Bridges --> F
    D -- Assists --> C

    style D fill:#ccf3,stroke:#333,stroke-width:2px
    style E fill:#cfc3,stroke:#333,stroke-width:2px
    
```

----


### 12. Evolution Strategy

Outlines the proposed staged approach for developing and stabilizing C++ interoperability.

```mermaid
---
title: "Evolution Strategy"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    A["Start:<br>Experimental C++ Interop Support"] --> B["Import many APIs<br>(Potentially Unstable/Unreviewed)"]
    B --> C["Introduce Versioning Scheme"]
    C --> D("Independent of Swift Compiler Version")
    D --> E["Allows Adoption & Source Stability during Evolution"]

    subgraph Evolution_Process["Swift Evolution Process<br>(Incremental)"]
        F["Identify Specific Feature/Pattern<br>(e.g., Iterators, unique_ptr)"]
        F --> G["Create Focused SE Proposal"]
        G --> H["Community Review & Revision"]
        H --> I["Formalize & Stabilize Feature in Interop"]
    end

    B -- Fed Into --> F
    I -- Gradually Leads To --> J["Stable C++ Interoperability Feature Set"]
    E --> J
    
```

---


### 13. Tooling and Build Process Requirements

Summarizes the necessary tooling support for a good user experience.

```mermaid
---
title: "Tooling and Build Process Requirements"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
graph TD
    A["C++ Interoperability Feature"] --> B("Needs Supporting Ecosystem")

    subgraph Tooling["Developer Tools"]
        C["SourceKit Integration"] --> C1["Code Completion<br>(C++ types/funcs)"]
        C1 --> C2["Jump-to-Definition<br>(to C++ headers)"]
        C2 --> C3["Other IDE features"]
        D["Debugger<br>(LLDB)"] --> D1["Inspect C++ types in Swift frames"]
        D1 --> D2["Step through interop calls"]
    end

    subgraph BuildSystem["Build System"]
        E["Swift Package Manager<br>(SPM)"] --> E1["Support C++ dependencies"]
        E1 --> E2["Handle C++ build settings"]
        E2 --> E3["Cross-platform compatibility"]
    end

    subgraph Annotations["Annotation Mechanism"]
        F["Provide Semantic Information to Compiler"] --> F1["Inline C++ Annotations<br>('[[swift::...]]'?)"]
        F1 --> F2["Sidecar File<br>(APINotes update or new format)"]
        F2 --> F3["Support for annotating unmodifiable library headers"]
    end

    B --> Tooling
    B --> BuildSystem
    B --> Annotations
    
```

---


### 14. Appendix 2: Lifetime Issue with Projections from Value Types

This flowchart specifically illustrates the dangling pointer problem described in Appendix 2 when naively importing projections from self-contained C++ value types.

```mermaid
---
title: "Appendix 2: Lifetime Issue with Projections from Value Types"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
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
    A["Swift Code"] --> B["'var v = vector(1)'"]
    B --> C["'let start = v.begin()'"]

    subgraph CompilerBehavior["Swift Compiler Behavior<br>(Simplified)"]
        B --> C_Copy["Implicitly creates temporary 'copy = v'"]
        C_Copy --> C_Call["Calls 'start = copy.begin()'"]
        C_Call --> C_Destroy["Destroys 'copy' (buffer potentially freed)"]
    end

    C --> D["'doSomething(start)'"]
    D --> E["'fixLifetime(v)'<br>(Irrelevant for 'start')"]

    subgraph Result["Result"]
        F["'start' now holds a pointer (projection) into the memory of the **destroyed** 'copy'"]
        F --> G["**Dangling Pointer!** --> Undefined Behavior"]
    end

    C_Destroy --> F

    H["Lesson:<br>Naive import is unsafe. Projection lifetime is tied to the specific C++ object instance it came from. Swift needs mechanisms (e.g., ownership, generalized accessors) to manage this."]

    style G fill:#f00, color:white, stroke:#333, stroke-width:2px
    
```




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---