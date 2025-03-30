---
created: 2025-03-29 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Improving the approachability of data-race safety
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


## Overview of Swift Concurrency Goals and Vision

This diagram provides a high-level overview of the core goals driving Swift's concurrency model and the main focus areas of this vision document.

```mermaid
---
title: "CHANGE_ME_DADDY"
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
    subgraph SwiftConcurrencyGoals["Swift Concurrency Goals"]
        direction LR
        G1["Goal 1:<br>Memory Safety for Data Races"]
        G2["Goal 2:<br>Progressive Disclosure & Simplicity"]
        G3["Goal 3:<br>Advanced Performance Uses"]
    end

    subgraph VisionFocus["Vision Document Focus"]
        direction LR
        V1["Improve Usability of Swift 6 Safety"]
        V2["Address User Experience Feedback"]
        V3["Reduce Annotation Burden"]
    end

    subgraph TargetUseCases["Target Use Cases for Improvement"]
        direction LR
        UC1["Simple Sequential Code<br>(No explicit concurrency needed)"]
        UC2["Adapting Existing Codebases<br>(Pre-Swift Concurrency libs)"]
    end

    SwiftConcurrencyGoals --> VisionFocus
    VisionFocus --> TargetUseCases
    G2 --> V3
    G1 --> V1

    style SwiftConcurrencyGoals fill:#f9f3,stroke:#333,stroke-width:2px
    style VisionFocus fill:#ccf3,stroke:#333,stroke-width:2px
    style TargetUseCases fill:#cfc3,stroke:#333,stroke-width:2px
    
```


**Explanation:**
*   Swift's concurrency aims for safety, ease of use through progressive disclosure, and enabling performant advanced use cases.
*   This vision document focuses specifically on improving the usability of the safety features introduced in Swift 6, driven by community feedback, aiming to reduce how often explicit annotations like `@MainActor` are required.
*   The primary targets for improvement are developers writing simple, effectively single-threaded code and those migrating existing projects that used older concurrency mechanisms.

---

## Progressive Disclosure Path for Concurrency

This illustrates the intended ideal path for learning and adopting concurrency features, contrasting it with the challenges currently faced in Swift 6.

```mermaid
---
title: "Progressive Disclosure Path for Concurrency"
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
    subgraph IdealPath["Ideal Progressive Disclosure Path"]
        P1["Step 1:<br>Write Sequential Code"] --> P2["Step 2:<br>Introduce Async/Await<br>(No data-race errors yet)"]
        P2 --> P3["Step 3:<br>Introduce Parallelism<br>(Compiler helps prevent data races)"]
        P1 -- No concurrency needed --> P1_Detail("No data-race errors surfaced")
        P2 -- Async APIs without shared mutable state --> P2_Detail("No data-race safety confrontation")
        P3 -- Explicit offloading for performance --> P3_Detail("Rely on compiler safety")
    end

    subgraph Swift6Challenges["Current Swift 6 Challenges<br>(Breaks Ideal Path)"]
        Challenge1("Presumption of Concurrency") --> Challenge2{"False Positives in Sequential Code"}
        Challenge2 --> Challenge3("Confronts beginners with data-race concepts too early")
        Challenge2 --> Challenge4("Annotation burden '@MainActor'")
        Challenge3 --> Discouragement("Hinders approachability")
    end

    IdealPath -.-> Swift6Challenges

    style IdealPath fill:#90EE,stroke:#333
    style Swift6Challenges fill:#F088,stroke:#333
    
```



**Explanation:**
*   The **Ideal Path** shows a smooth progression: start sequential, add basic `async/await` without immediate data-race issues (if not using shared mutable state concurrently), and only confront data-race safety when *intentionally* introducing parallelism.
*   The **Swift 6 Challenges** diagram highlights how the current default presumption of concurrency disrupts this ideal path, leading to false positive errors in sequential code, forcing premature learning about data races, and requiring excessive annotations.

----

## The "False Positive" Problem in Sequential Code

This diagram explains *why* sequential code often encounters data-race errors in Swift 6 and lists common scenarios.

```mermaid
---
title: "The 'False Positive' Problem in Sequential Code"
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
    A["Program is Effectively Single-Threaded<br>(e.g., UI App, Script)"] --> B{"No Actual Runtime Parallelism"}
    B --> C["No Real Risk of Data Races"]

    D["Swift 6 Default Behavior"] --> E{"Presumes Concurrency"}
    E --> F["Unannotated Code = 'nonisolated'"]
    F --> G["Requires Explicit Isolation for Shared Mutable State"]

    C --> H(("Problem"))
    G --> H
    H --> I["'False Positive' Data-Race Diagnostics"]

    I --> J["Specific Problem Areas"]
    J --> J1["Problem 1:<br>Global/Static Variables"]
    J --> J2["Problem 2:<br>Isolated Type Conformance to nonisolated Protocol"]
    J --> J3["Problem 3:<br>Class Deinitializers"]
    J --> J4["Problem 4:<br>Overrides of nonisolated methods"]
    J --> J5["Problem 5:<br>Calls to SDK<br>('@MainActor') APIs"]
    J --> K["Annotation Burden<br>('@MainActor' propagation)"]

    style H fill:#faa5,stroke:#f00,stroke-width:2px
    
```


**Explanation:**
*   Many programs run sequentially on the `MainActor` without introducing parallelism. In these cases, data races are impossible at runtime.
*   However, Swift 6 defaults to assuming code *could* run concurrently (`nonisolated`).
*   This mismatch forces the compiler to flag potential issues (like using a non-`Sendable` global variable) as errors, even though no concurrent access will actually occur in the single-threaded context.
*   This leads to "false positives" in various common coding patterns and necessitates widespread `@MainActor` annotations.

----

## Proposed Solution: Module-Level Default Isolation

This set of diagrams explains the core proposal: allowing modules to default to `@MainActor` isolation.

**1. Concept:**

```mermaid
---
title: "The Concept of the Module-Level Default Isolation"
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
    subgraph CurrentDefault["Current Swift 6 Default<br>(Per Declaration)"]
        D1[Unannotated Function/Type] --> D2["'nonisolated'<br>(Concurrency Presumed)"]
        D2 --> D3[Requires explicit '@MainActor' for UI code, globals, etc.]
    end

    subgraph ProposedDefault["Proposed Module-Level Default<br>(Optional)"]
        P1["Select Default for Module"] --> P2{Module Defaults to '@MainActor'?}
        P2 -- Yes --> P3["Unannotated Code = '@MainActor'<br>(Sequential Presumed)"]
        P2 -- No --> P4["Unannotated Code = 'nonisolated'<br>(Current Behavior)"]
        P3 --> P5[Use 'nonisolated' explicitly for concurrent code]
    end

    CurrentDefault -.-> ProposedDefault;

    style ProposedDefault fill:#c22c32,stroke:#006400,stroke-width:2px
    
```



**2. Rule by Target Type:**

```mermaid
---
title: "Rule by Target Type"
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
    X["Swift Module"] --> Y{"Target Type?"}
    Y -- Executable<br>(App, Tool, Script) --> Z1["Default:<br> '@MainActor' Isolation"]
    Y -- Library --> Z2["Default:<br> 'nonisolated'<br>(Current Swift 6)"]

    Z1 --> Z1a("Optimized for UI/Sequential code")
    Z1 --> Z1b("Better progressive disclosure")
    Z1 --> Z1c("Reduces annotation burden")

    Z2 --> Z2a("Optimized for generic, reusable code")
    Z2 --> Z2b("Maintains current library expectations")

    Z1 --> Note1(("Can explicitly opt-out"))
    Z2 --> Note2(("Can explicitly opt-in to '@MainActor' default"))

    style Z1 fill:#fcd4, stroke:#333
    style Z2 fill:#d4d4, stroke:#333
    
```



**3. Risks:**

```mermaid
---
title: "Risks"
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
    R1["Risk:<br>Language Dialect Creation"] --> R2{Potential Downsides}
    R2 --> R3["Readability<br>(Need context for isolation)"]
    R2 --> R4["Usability<br>(Moving code between dialects)"]
    R2 -- Less Likely --> R5["Tooling Complexity"]
    R2 -- Less Likely --> R6["Portability Issues"]

    R3 --> M1["Mitigation:<br>IDE support for showing isolation"]
    R4 --> M2["Mitigation:<br>IDE tools for migration/annotation"]

    Conclusion(("Conclusion:<br>Costs seem modest & manageable"))
    M1 --> Conclusion
    M2 --> Conclusion
    
```


**Explanation:**
*   The core idea is to flip the default isolation assumption *at the module level*. Instead of defaulting to `nonisolated`, code *within* a specific module can default to `@MainActor`.
*   This would be the standard default for *executable* targets (apps, tools), aligning with their typical main-thread-centric nature and improving the experience for beginners.
*   *Libraries* would retain the current `nonisolated` default, suitable for general-purpose, context-agnostic code. Modules can override the default.
*   Explicit `nonisolated` annotations can be used when concurrency is intended within a module defaulting to `@MainActor`.
*   The main risk is creating a language "dialect," potentially affecting readability and code movement, but these risks are deemed manageable, especially with potential IDE support.

----

## Isolated Conformances

This addresses the difficulty of conforming isolated types (like `@MainActor` classes) to nonisolated protocols.

```mermaid
---
title: "Isolated Conformances"
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
    subgraph Problem["Problem:<br>Isolated Types vs. Nonisolated Protocols"]
        IsoT["@MainActor class/struct"] -- Conforms to --> Proto["Protocol<br>(nonisolated reqs)"]
        Proto --> Req["Requirement 'func doSomething()'<br>(implicitly nonisolated)"]
        IsoT --> Impl["'@MainActor func doSomething()'<br>(implicitly MainActor)"]
        Impl -- X --> Req
        style X fill:#f00,stroke:#f00
        X{"Conflict!"} --> Err["Swift 6 Error: Implementation must be nonisolated"]
        Err --> Pain["Common false positive, often no good solution"]
    end

    subgraph SolutionConcept["Proposed Solution:<br>Isolated Conformances"]
        SC1["Allow 'Isolated Conformances'"] --> SC2{"How it Works"}
        SC2 --> SC3["Compiler recognizes isolated impl. for nonisolated requirements"]
        SC3 --> SC4["Treats the *conformance itself* as isolated<br>(e.g., '@MainActor conformance')"]
        SC4 --> SC5["Use of conformance restricted to the specific actor"]
    end

    subgraph Impact["Impact of Isolated Conformances"]
        IC1["Generic code in '@MainActor'-default modules"] --> IC2["Can naturally use '@MainActor'-isolated conformances"]
        IC3["Generic code in 'nonisolated'-default modules<br>(or existing code)"] --> IC4["Still expects nonisolated conformances by default"]
        IC4 --> IC5["Needs explicit opt-in to accept isolated conformances<br>(e.g., 'where T: ~Sendable P' or similar syntax)"]
        IC5 --> IC6["Allows libraries like StdLib to work with isolated types more easily"]
    end

    Problem --> SolutionConcept --> Impact
    
```


**Explanation:**
*   Currently, if a type is `@MainActor` isolated, its methods are also implicitly `@MainActor`. This conflicts with implementing requirements from protocols that assume `nonisolated` implementations. This is a major source of "false positives" and usability issues.
*   The proposal introduces the concept of an "isolated conformance." If the compiler sees an isolated implementation (like `@MainActor func...`) for a nonisolated requirement, it can treat the entire conformance *as if* it's isolated (e.g., a `@MainActor conformance`).
*   Using such an isolated conformance would then be restricted to the appropriate context (e.g., only callable from the `@MainActor`).
*   Generic code would default to accepting conformances matching the module's isolation default but could explicitly opt-in to accepting isolated conformances when needed, making libraries more flexible.

----

## Isolated Subclasses and Overrides

This deals with restrictions related to class inheritance and isolation.

```mermaid
---
title: "Isolated Subclasses and Overrides"
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
    subgraph Problem["Problem:<br>Class Inheritance & Isolation Rules<br>(Swift 6)"]
        P1["Sendability must match superclass<br>(with exceptions)"]
        P2["Isolated class superclass must be nonisolated or same isolation"]
        P3["Override isolation must match overridden method"]
        P1 & P2 & P3 --> FP["Can cause False Positives in sequential code"]
    end

    subgraph ProposedImprovements["Proposed Improvements"]
        Imp1["Leverage SE-0434 Changes"] --> Imp2["Allow '@MainActor' class to inherit from non-Sendable class<br>(subclass stays non-Sendable)"]
        Imp2 --> Imp3{"Goal:<br>Relax Override Restriction"}
        Imp3 --> Imp4["Allow '@MainActor' override of nonisolated method *if* subclass is non-Sendable & '@MainActor' isolated"]
        Imp4 --> Imp5["Requires revising SE-0434 slightly<br>(initializer restrictions)"]
        Imp5 --> Imp6["Source break potential, but improves usability"]

        Imp7["Challenge:<br>'@MainActor' subclass inheriting from *Sendable* nonisolated superclass"]
        Imp7 --> Imp8["Relaxing override rules here seems hard without breaking safety"]
        Imp8 --> Imp9["Possible Solution:<br>Prevent upcasting?<br>(Likely too restrictive)"]
    end

    Problem --> ProposedImprovements
    
```


**Explanation:**
*   Swift 6 enforces rules about matching sendability and isolation between subclasses and superclasses, and for method overrides. These can cause false positives in sequential code.
*   Building on SE-0434, the vision proposes relaxing the override restriction: specifically, allow a method in a `@MainActor`-isolated, *non-Sendable* subclass to override a nonisolated method from its superclass. This requires minor adjustments to SE-0434.
*   Solving this for `@MainActor` subclasses inheriting from *Sendable* superclasses is harder and might require overly restrictive solutions.

----

## Easing Basic Async Code Introduction (SE-0338 Revision)

This addresses the execution behavior of `nonisolated async` functions.

```mermaid
---
title: "Easing Basic Async Code Introduction (SE-0338 Revision)"
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
    subgraph CurrentBehavior["Current Behavior<br>(SE-0338)"]
        CB1["Call 'nonisolated async func foo()' from Actor<br>(e.g., '@MainActor')"]
        CB1 --> CB2{"Execution"}
        CB2 --> CB3["Switches *OFF* the caller actor"]
        CB3 --> CB4["Runs on cooperative thread pool"]
        CB4 --> CB5["Why?<br>Avoid actor contention/overhang"]
        CB5 --> CB6["Problem:<br>Forces data-race checks on non-Sendable args/results passed from actor"]
        CB6 --> CB7["Problem:<br>Confusing - 'nonisolated' means different things for sync vs. async"]
        CB7 --> CB8["Hinders Progressive Disclosure"]
    end

    subgraph ProposedBehavior["Proposed Behavior"]
        PB1["Call 'nonisolated async func foo()' from Actor<br>(e.g., '@MainActor')"]
        PB1 --> PB2{"Default Execution"}
        PB2 --> PB3["Runs *ON* the caller actor's executor"]
        PB3 --> PB4["Why?<br>Simpler default, easier basic async use"]
        PB4 --> PB5["Aligns 'nonisolated' meaning for sync/async"]
        PB5 --> PB6["Facilitates Progressive Disclosure"]
        PB6 --> PB7["Benefit:<br> Avoids data-race checks for args/results within same isolation"]
        PB3 --> PB8{"Need to run OFF actor?"}
        PB8 -- Yes --> PB9["Use new explicit annotation:<br> '@execution(concurrent)'"]
    end

    CurrentBehavior -- Replaced by --> ProposedBehavior;

    style CurrentBehavior fill:#fbf3, stroke:#800080
    style ProposedBehavior fill:#bde5, stroke:#008000
```

**Explanation:**
*   Currently (SE-0338), calling a `nonisolated async` function from an actor *always* switches off that actor to execute the function. This was done for performance reasons but complicates basic usage by forcing data-race checks when passing data from the actor.
*   The proposal changes the *default* behavior: a `nonisolated async` function will run *on* the caller's executor if called from one (like a synchronous `nonisolated` function does).
*   This makes simple `async` calls easier and avoids unnecessary data-race checks when no concurrency boundary is actually needed.
*   If the old "switch off" behavior is desired (e.g., for performance-critical code that shouldn't block the actor), it can be explicitly requested with a new `@execution(concurrent)` (or similar) annotation.

---

## Easing Incremental Migration

This covers proposals to help migrate existing codebases.

```mermaid
---
title: "Easing Incremental Migration"
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
    subgraph MigrationChallenges["Challenges Migrating Existing Code"]
        MC1["Introducing async/await incrementally is hard"]
        MC2["Cannot always propagate 'async'<br>(external deps)"]
        MC3["Using Actors forces 'await' even from MainActor"]
        MC4["SE-0423 Dynamic Checks cause runtime crashes<br> (sometimes false positives)"]
    end

    subgraph ProposedAids["Proposed Migration Aids"]
        PA1["Bridge Sync/Async Code"] --> PA1a("Provide language tools similar to 'DispatchQueue.asyncAndWait'")
        PA1a --> PA1b("Carefully designed to mitigate deadlock risks")

        PA2["Mitigate SE-0423 Crashes"] --> PA2a("Elide checks via static analysis where possible<br>(true false positives)")
        PA2 --> PA2b{"Handle True Positives<br>(Accessing actor state wrongly)"}
        PA2b -- Option 1 --> PA2c("Enqueue job on actor instead of direct call<br>(if no return value)")
        PA2b -- Option 2 --> PA2d("Improve 'import async' heuristics (SE-0297) for completion handlers")

        PA3["Automatic Migration Tooling"] --> PA3a("Compiler offers automatic source changes for new features/modes")
        PA3a --> PA3b("Preserves existing semantics during migration")
    end

    MigrationChallenges --> ProposedAids
    
```




**Explanation:**
*   Migrating existing, often synchronous, codebases to use Swift Concurrency presents challenges like the inability to easily call `async` code from sync code and runtime crashes due to new dynamic isolation checks (SE-0423).
*   The vision proposes aids:
    *   Language-level tools to bridge sync and async code (akin to `Dispatch.sync`, but safer).
    *   Reducing SE-0423 crashes by eliminating true false positives via analysis and providing mechanisms (like auto-enqueuing or better import heuristics) to handle real data races revealed by the checks.
    *   Strong compiler tooling to automatically migrate code to adopt these new features while preserving behavior.

---

## Scope Exclusions

```mermaid
---
title: "Scope Exclusions"
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
    A[Vision Document Focus] --> B(Improving Approachability of Data-Race Safety)
    B --> C("Primarily:<br>Sequential Code & Migration")

    D["What's NOT Covered in *This* Vision"] --> E["Task Ordering Guarantees"]
    D --> F[Actor Re-entrancy Issues]
    D --> G[Detailed Diagnostics Improvements]
    D --> H[Documentation Enhancements]

    E & F --> I(Important, but separate concerns - likely future work)
    G & H --> J(Important, but outside formal evolution process)

    style D fill:#eee3, stroke:#555, stroke-dasharray: 5 5
    
```


**Explanation:**
*   This diagram clarifies that while important, issues related to specific task execution order, actor re-entrancy behaviors, and general improvements to compiler error messages and documentation are outside the scope of *this specific* vision document, which is focused on the core usability of the static safety model.




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---