---
created: 2024-11-11 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# The Composable Architecture

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a Mermaid diagram that illustrates the architecture of The Composable Architecture (TCA) as discussed in the previous article. This diagram captures the core components of TCA—State, Actions, Reducers, Environment—and their interactions within a SwiftUI application.


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
    'flowchart': { 'htmlLabels': true, 'curve': 'linear' },
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

    %% State
    B --> B1[AppState]
    B --> B2[FeatureState]

    %% Actions
    C --> C1[AppAction]
    C --> C2[FeatureAction]

    %% Reducers
    D --> D1[AppReducer]
    D --> D2[FeatureReducer]

    %% Environment
    E --> E1[AppEnvironment]
    E --> E2[FeatureEnvironment]

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

    %% Additional Components
    subgraph SwiftUI Integration
        F
        G
    end

    subgraph TCA Core
        B
        C
        D
        E
    end

    subgraph Side Effects
        I
        J
        K
        L
    end

```


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
