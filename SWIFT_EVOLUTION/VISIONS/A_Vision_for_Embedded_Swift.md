---
created: 2025-03-29 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: "https://github.com/swiftlang/swift-evolution/blob/main/visions/embedded-swift.md"
---



# A Vision for Embedded Swift
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---




## Embedded Swift: Visualizing the Vision

This document uses Mermaid diagrams to illustrate the key aspects of the proposed Embedded Swift initiative, breaking down the problem, goals, technical approach, and anticipated outcomes.

---

### 1. The Problem: Bridging the Gap

This diagram contrasts the characteristics of current Swift deployments with the constraints of embedded environments, highlighting the motivation for Embedded Swift.

```mermaid
---
title: "The Problem: Bridging the Gap"
author: "Cong Le"
version: "1.1"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Retro Groove Palette Theme
%%%%%%%% Available curve styles include: basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': "'Arial', sans-serif", /* Standard font for better base readability */
    'themeVariables': {
      'primaryColor': '#FDF6E3',                   /* Creamy Beige (Node Background) */
      'primaryTextColor': '#654321',               /* Dark Brown (Text Color) */
      'primaryBorderColor': '#D69E2E',             /* Mustard Yellow (Border Color) */
      'lineColor': '#B7791F',                       /* Darker Mustard/Brown (Arrow/Line Color) */
      'secondaryColor': '#FBD38D',                 /* Lighter Mustard (Alt Node Background) */
      'tertiaryColor': '#825718'                   /* Darkest Brown (Special Node Background) */
      /* Other Palette Colors (Use with 'style'):
         Avocado Green: #8FBC8F
         Burnt Orange: #CC5500
         Light Blue Gray: #A0AEC0
         White: #FFFFFF */
    }
  }
}%%
graph LR
    subgraph Current_Swift["Current Swift Environment<br>(Large OS)"]
        direction LR
        A["General Purpose Language"] --> B("Targets:<br>macOS, iOS, Linux, Windows")
        B --> C{"Characteristics"}
        C --> C1["Plentiful Memory/Storage"]
        C --> C2["Dynamic Linking Common"]
        C --> C3["Rich System Libraries<br>(libc, etc.)"]
        C --> C4["Runtime/Stdlib Size ~5MB"]
        C --> C5["Supports Dynamic Features<br>(Reflection, Existentials, ABI Stability)"]
    end

    subgraph Embedded_Constraints["Embedded/Low-Level Constraints"]
        direction LR
        D{"Challenges"}
        D --> D1["Very Limited Memory<br>(10s/100s kB)"]
        D --> D2["Limited Storage<br>(ROM/SRAM)"]
        D --> D3["No OS / Minimal OS"]
        D --> D4["Restricted Runtime Dependencies"]
        D --> D5["Heap Allocation Restricted/Unavailable"]
        D --> D6["Need for Minimal Binary Size"]
    end

    Current_Swift -- Impractical Due To --> Embedded_Constraints
    Embedded_Constraints -- Motivates --> E[Vision: Embedded Swift]

    style Current_Swift fill:#e6f2ff,stroke:#333
    style Embedded_Constraints fill:#ffe6e6,stroke:#333
    style E fill:#e6ffe6,stroke:#333
    
```

-----


### 2. Core Goals of Embedded Swift

This mind map outlines the primary objectives driving the development of the Embedded Swift compilation mode.

```mermaid
---
title: "Core Goals of Embedded Swift"
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
  root((Embedded Swift Goals))
    G1(Eliminate Large Codesize Cost)
      ::icon(fa fa-compress-arrows-alt)
      G1A(Supporting libraries should not dominate size)
    G2(Simplify Generated Code)
      ::icon(fa fa-cogs)
      G2A(Easier reasoning about performance/cost)
      G2B(Avoid complex runtime mechanisms like generic instantiation)
    G3(Effective Dead-Code Stripping)
      ::icon(fa fa-cut)
      G3A(Intuitive removal of unused code - App, Libs, Stdlib)
    G4(Support Heap Variations)
      ::icon(fa fa-memory)
      G4A(With heap: "Allocating" Embedded Swift - allows classes, etc.)
      G4B(Without heap: "Non-allocating" Embedded Swift - more restricted)
    G5(Reduce/Remove Implicit Runtime Calls)
      ::icon(fa fa-phone-slash)
      G5A("Eliminate heavyweight calls (metadata lookup, generics)")
      G5B("Permit lightweight calls only when needed (e.g., refcounting)")
    G6(Minimal Statically-Linked Binaries)
      ::icon(fa fa-link)
      G6A("No external dependencies (large Swift runtime/stdlib)")
      G6B(No full libc/libc++ linkage needed)
      G6C(Standard Library is dead-strippable)
    G7(Define a Subset, Not a Dialect)
      ::icon(fa fa-code-branch)
      G7A(Embedded Swift code compiles in regular Swift)
      G7B(Behavior remains consistent)
      G7C(Minimal porting effort, stay close to "Full" Swift)
      
```

---


### 3. Embedded Swift Language Subset Hierarchy

This diagram details the features restricted in Embedded Swift, showing the base restrictions and the additional limitations introduced in the "non-allocating" mode.

```mermaid
---
title: "Embedded Swift Language Subset Hierarchy"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Data Clarity Palette Theme
%%%%%%%% Toggle theme value to `dark` or other built-in themes to disable this customized theme.
%%%%%%%% Available curve styles include: basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Verdana, Arial, sans-serif',
    'themeVariables': {
      'primaryColor': '#F0F0F0',                   /* Neutral Light Gray (Node Background) */
      'primaryTextColor': '#2D3748',               /* Neutral Dark Gray (Text Color) */
      'primaryBorderColor': '#A6CEE3',             /* Category 1 Blue (Border Color) */
      'lineColor': '#718096',                       /* Mid Gray (Arrow/Line Color - not from palette but needed) */
      'secondaryColor': '#B2DF8A',                 /* Category 2 Green (Alt Node Background) */
      'tertiaryColor': '#FB9A99'                   /* Category 3 Red (Special Node Background) */
      /* Other Palette Colors (Use with 'style'):
         Cat 4 Orange: #FDBF6F
         Cat 5 Purple: #CAB2D6
         Cat 6 Yellow: #FFFF99 (Needs dark text!)
         Cat 7 Brown: #B15928
         White: #FFFFFF */
    }
  }
}%%
graph TD
    A[Full Swift Language] --> B{Embedded Swift Subset}

    subgraph Embedded_Restrictions["Base Embedded Swift Restrictions"]
        B --> B1(Limited Library Evolution / No ABI Stability)
        B --> B2(No Objective-C Interop)
        B --> B3(No Reflection / Mirrors API)
        B --> B4("Restricted 'print()', Alternative Provided")
        B --> B5(Restricted Metatypes - Runtime use disallowed)
        B --> B6(No Existentials - 'Any', 'any Protocol', Dynamic Downcasts)
        B --> B7(Restricted Thrown Error Types - related to 'any Error')
        B --> B8(Class Restrictions - e.g., no non-final generic methods)
        B --> B9(Restricted KeyPaths - Limited to specific use cases)
        B --> B10(Opt-in Unicode String APIs - E.g., Iteration, Comparison)
    end

    B --> C{Non-allocating Mode Adds Further Restrictions}

    subgraph NonAllocating_Restrictions["Non-allocating Specific Restrictions"]
       C --> C1(Cannot Instantiate Classes)
       C --> C2(Cannot Construct Indirect Enums)
       C --> C3(No Escaping Closures)
       C --> C4(Restricted Standard Library Features - e.g., No dynamic Arrays/Dicts/Strings)
    end

    style Embedded_Restrictions fill:#fff0b3,stroke:#333
    style NonAllocating_Restrictions fill:#ffcccc,stroke:#333
    
```



-----


### 4. Embedded Swift Compilation Model

This flowchart explains the core compiler techniques used to achieve the goals of Embedded Swift.

```mermaid
---
title: "Embedded Swift Compilation Model"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Synthwave Night Palette Theme (Dark Mode)
%%%%%%%% Toggle theme value to default `dark` theme to disable this customized theme.
%%%%%%%% This theme IS a dark theme by design.
%%%%%%%% Available curve styles include: basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace, Arial, sans-serif',
    'themeVariables': {
      'background' : '#1A202C',                    /* SETTING OVERALL BACKGROUND */
      'primaryColor': '#2D3748',                   /* Dark Slate (Default Node Background) */
      'primaryTextColor': '#E2E8F0',               /* Light Gray/Off-White (Text Color) */
      'primaryBorderColor': '#EC4899',             /* Primary Neon Pink (Border Color) */
      'lineColor': '#4A5568',                       /* Medium Gray-Blue (Arrow/Line Color) */
      'secondaryColor': '#22D3EE',                 /* Secondary Neon Cyan (Alt Node Background) */
      'tertiaryColor': '#A78BFA'                   /* Accent Neon Purple (Special Node Background) */
      /* Other Palette Colors (Use with 'style'):
         Accent Neon Yellow: #FACC15 (Needs dark border/text if fill)
         Secondary Text: #A0AEC0 */
    }
  }
}%%
flowchart TD
    Start["Start: Swift Source Code (App + Libraries)"] --> Step1{Compile-Time Specialization};
    Step1 -- Requires --> Step1a[Known Type Parameters at Call Site];
    Step1 -- Leads to --> Step1b["Specialized (Monomorphized) Functions/Types"]
    Step1 -- Disallows --> Step1c["Separate Compilation of Generics"]

    Step1 --> Step2{Library Code Compilation};
    Step2 -- Built As --> Step2a["emitIntoClient" / Always Inlinable];
    Step2a -- Applies To --> Step2b[Standard Library Too];
    Step2a -- Provides --> Step2c["Serialized SIL (like source) to Client"]

    Step2 --> Step3{Eliminate Runtime Metadata Need};
    Step3 -- How --> Step3a[Ignore ABI Stability / Disable Resilience];
    Step3a --> Step3b[Disable Reflection/Mirrors]
    Step3b --> Step3c["Use Simple V-Tables (or none for final classes)"]
    Step3c --> Step3d[Witness Tables only at Compile-Time];

    Step3 --> Step4[No Type Metadata Emitted in Binary];
    Step4 --> Step5[Remove Runtime Metadata Processing];
    Step5 -- Facilities Removed --> Step5a[Runtime Generic Instantiation];
    Step5a --> Step5b[Runtime Protocol Conformance Lookup];

    Step5 --> Result[Outcome];
    subgraph ResultGraph ["Resulting Binary Characteristics"]
        direction LR
        Result --> R1[Significantly Smaller Size];
        Result --> R2[Intuitive Dead-Code Stripping];
        Result --> R3[Reduced Implicit Runtime Calls];
    end

    style ResultGraph fill:#FACC15,stroke:#333
    
```


### 5. Enabling Embedded Mode and Conditional Code

This diagram shows how developers might enable Embedded Swift and write code compatible with both modes.

```mermaid
---
title: "Enabling Embedded Mode and Conditional Code"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Synthwave Night Palette Theme (Dark Mode)
%%%%%%%% Toggle theme value to default `dark` theme to disable this customized theme.
%%%%%%%% This theme IS a dark theme by design.
%%%%%%%% Available curve styles include: basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace, Arial, sans-serif',
    'themeVariables': {
      'background' : '#1A202C',                    /* SETTING OVERALL BACKGROUND */
      'primaryColor': '#2D3748',                   /* Dark Slate (Default Node Background) */
      'primaryTextColor': '#E2E8F0',               /* Light Gray/Off-White (Text Color) */
      'primaryBorderColor': '#EC4899',             /* Primary Neon Pink (Border Color) */
      'lineColor': '#4A5568',                       /* Medium Gray-Blue (Arrow/Line Color) */
      'secondaryColor': '#22D3EE',                 /* Secondary Neon Cyan (Alt Node Background) */
      'tertiaryColor': '#A78BFA'                   /* Accent Neon Purple (Special Node Background) */
      /* Other Palette Colors (Use with 'style'):
         Accent Neon Yellow: #FACC15 (Needs dark border/text if fill)
         Secondary Text: #A0AEC0 */
    }
  }
}%%
graph TD
    A["Developer Goal"] --> B{"Compile for Embedded Environment"}
    B -- Option 1 --> C1["Top-Level Compiler Flag<br>(e.g., '-embedded')"]
    B -- Option 2 --> C2["Target Triple Implication<br>(e.g., '*-*-none')"]

    subgraph Activation ["Activation Mechanism<br>(Open Question)"]
        C1 & C2
    end

    C1 & C2 --> D["Embedded Swift Mode Active"]

    D --> E{Writing Compatible Code}
    subgraph Compatibility ["Handling Code Differences"]
        direction LR
        E --> E1["Conditional Compilation:<br> '#if !mode(embedded)'"]
        E --> E2["API Availability:<br> '@available(embedded, unavailable, ...)'"]
        E1 & E2 --> F["Allows Single Codebase for Full & Embedded Swift"]
        E --> E3["Similar constructs for 'noAllocations' mode"]
    end

    style Activation fill:#f3e5f5, stroke:#333
    style Compatibility fill:#e3f2fd, stroke:#333
    
```


### 6. Expected Dependency Profile

This illustrates the minimal external dependencies anticipated for binaries compiled in Embedded Swift modes.

```mermaid
---
title: "Expected Dependency Profile"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Forest Trail Palette Theme
%%%%%%%% Toggle theme value to `dark` or other built-in themes to disable this customized theme.
%%%%%%%% Available curve styles include: basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Verdana, Arial, sans-serif',
    'themeVariables': {
      'primaryColor': '#F8F8F8',                   /* Neutral Light (Node Background) */
      'primaryTextColor': '#4A4A4A',               /* Neutral Dark (Text Color) */
      'primaryBorderColor': '#38A169',             /* Primary Green (Border Color) */
      'lineColor': '#B0B0B0',                       /* Neutral Medium Gray (Arrow/Line Color) */
      'secondaryColor': '#9AE6B4',                 /* Secondary Green (Alt Node Background) */
      'tertiaryColor': '#A0522D'                   /* Accent Brown (Special Node Background) */
      /* Other Palette Colors (Use with 'style'):
         Accent Blue: #5A9BD1
         Accent Cream: #F5F5DC (Needs dark text!)
         White: #FFFFFF */
    }
  }
}%%
graph TD
    subgraph NonAllocating["Non-allocating Embedded Swift"]
        NA_Code[Swift Code] --> NA_Compile['swiftc *.swift -target *-*-none -no-allocations ...']
        NA_Compile --> NA_Object["Object File<br>(.o)"]
        NA_Object --> NA_Deps["Minimal Dependencies"]
        NA_Deps --> NA_Dep1['memcpy']
        NA_Deps --> NA_Dep2['memset']
    end

    subgraph Allocating["Allocating Embedded Swift"]
       A_Code[Swift Code] --> A_Compile['swiftc *.swift -target *-*-none ...']
       A_Compile --> A_Object["Object File<br>(.o)"]
       A_Object --> A_Deps[Minimal Dependencies]
       A_Deps --> A_Dep_Runtime["Small Swift Runtime Lib<br>(Static)"]
       A_Dep_Runtime --> RT1['swift_allocObject',<br> '_retain',<br> '_release',<br> etc.]
       A_Deps --> A_Dep_Platform[Platform Memory Functions]
       A_Dep_Platform --> PF1['malloc']
       A_Dep_Platform --> PF2['calloc']
       A_Dep_Platform --> PF3['free']
    end

    style NonAllocating fill:#9AE6B4, stroke:#333
    style Allocating fill:#F8F8F8, stroke:#333
    
```




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---