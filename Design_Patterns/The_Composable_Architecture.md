---
created: 2024-11-11 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---



# The Composable Architecture

Below is a Mermaid diagram that illustrates the architecture of The Composable Architecture (TCA) as discussed in the previous article. This diagram captures the core components of TCA—State, Actions, Reducers, Environment—and their interactions within a SwiftUI application.


```mermaid
graph TD
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

