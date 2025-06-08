---
created: 2025-02-25 05:31:26
author: Cong Le
version: "2.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# The Composable Architecture V2 - A Diagrammatical Summary
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---

## Enhanced version - WIP

This is a draft enhanced version from the initial version at [here](./The_Composable_Architecture_V1.md).



```mermaid
---
title: The Composable Architecture in SwiftUI
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Andale Mono, monospace',
    'logLevel': 'fatal',
    'themeVariables': {
      'primaryColor': '#22BB',
      'primaryTextColor': '#F8B229',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#E2F1',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '20px'
    }
  }
}%%
flowchart TD
    %% TCA Core Components
    A[The Composable Architecture - TCA] --> B[State]
    A --> C[Actions]
    A --> D[Reducers]
    A --> E[Environment]
    A --> O[Benefits of TCA]

    %% State
    B --> B1[AppState]
    B --> B2[FeatureState]
    B --> B3[Holds application's data model]
    B --> B4[Single source of truth]

    %% Actions
    C --> C1[AppAction]
    C --> C2[FeatureAction]
    C --> C3[Represents all possible events]
    C --> C4[Unidirectional data flow]

    %% Reducers
    D --> D1[AppReducer]
    D --> D2[FeatureReducer]
    D --> D3[Pure functions]
    D --> D4[State transitions based on actions]

    %% Environment
    E --> E1[AppEnvironment]
    E --> E2[FeatureEnvironment]
    E --> E3[Dependencies and services]
    E --> E4[Testability through controlled dependencies]

    %% Interactions
    B1 -->|Contains| B2
    C1 -->|Includes| C2
    D1 -->|Combines| D2
    E1 -->|Provides| E2

    %% Flow
    F[SwiftUI View] -->|Interacts with| G[ViewStore]
    G -->|Sends Actions to| H[Store]
    H --> D1
    H --> B1
    D1 --> B1
    D1 --> E1
    E1 -->|Handles Side Effects| I[Effects/Services]
    I --> D1

    %% ViewStore and Store
    H[Store] --> B1
    H --> D1
    H --> E1
    G[ViewStore] --> B1
    G --> C1

    %% Side Effects
    I --> J[Network Requests]
    I --> K[Database Operations]
    I --> L[Analytics]
    I --> M[Persistence]
    I --> N[System Notifications]

    %% Benefits of TCA
    O --> O1[Improved Testability]
    O --> O2[Enhanced Maintainability]
    O --> O3[Better Code Organization]
    O --> O4[Predictable State Management]
    O --> O5[Increased Code Reusability]
    O --> O6[Composition]
    O --> O7[Modularity]
    O --> O8[Debugging]

    %% Additional Components
    subgraph SwiftUI_Integration["SwiftUI Integration"]
        F
        G
    end

    subgraph TCA_Core["TCA Core"]
        B
        C
        D
        E
    end

    subgraph Side_Effects["Side Effects"]
        I
        J
        K
        L
        M
        N
    end

    %% Links to Resources
    style O fill:#f399,stroke:#333,stroke-width:2px
    click O "https://github.com/pointfreeco/swift-composable-architecture" "TCA GitHub Repository"
     %% click O "https://pointfree.co/collections/composable-architecture" "Learn more about TCA"
    
```


Key Improvements and Additions:

*   **Expanded Component Descriptions (State, Actions, Reducers, Environment):**  Added nodes (B3, B4, C3, C4, D3, D4, E3, E4) to describe the *purpose* of each core TCA component.  This is crucial for understanding *why* TCA is structured the way it is.
*   **Side Effects Expansion:** Added `Persistence` and `System Notifications` to the `Side Effects` subgraph.  These are common examples of side effects in real-world applications.
*   **Benefits of TCA:** Added a `Benefits of TCA` node that links to multiple nodes (O1-O8).
*   **Links to Resources:** Included links to the Point-Free website (where TCA was introduced) and the TCA GitHub repository to provide a starting point for further exploration.
*   **Styling:** Added some light styling for link nodes.


---

<!-- 
```mermaid
%% Current Mermaid version
info
```  -->


```mermaid
---
title: "CongLeSolutionX"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'flowchart': { 'htmlLabels': false },
    'fontFamily': 'Bradley Hand',
    'themeVariables': {
      'primaryColor': '#fc82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#81c784',
      'secondaryTextColor': '#6C3483',
      'lineColor': '#F8B229',
      'fontSize': '20px'
    }
  }
}%%
flowchart LR
  My_Meme@{ img: "https://raw.githubusercontent.com/CongLeSolutionX/CongLeSolutionX/refs/heads/main/assets/images/My-meme-light-bulb-question-marks.png", label: "Ăn uống gì chưa ngừi đẹp?", pos: "b", w: 200, h: 150, constraint: "off" }

  Closing_quote@{ shape: braces, label: "...searching insights in the process of formulating better questions..." }
    
  My_Meme ~~~ Closing_quote
    
  Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

  Closing_quote ~~~ My_Meme
  My_Meme animatingEdge@--> Link_to_my_profile
  
  animatingEdge@{ animate: true }

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
