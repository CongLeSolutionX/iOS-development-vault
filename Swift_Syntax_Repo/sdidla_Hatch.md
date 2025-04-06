---
created: 2025-04-06 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Sdidla - Hatch
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



```mermaid
---
title: "sdidla - Hatch"
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
    'flowchart': {'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'lineColor': '#F8B229'
    }
  }
}%%
flowchart TB
    %% Input & Client Layer
    A["Swift Source Input"]:::runtime
    B["HatchExample (Example Usage)"]:::runtime
    A -->|"provides_source"| B

    %% Core Library: Hatch
    subgraph "Core Library: Hatch"
        C1["SymbolParser"]:::runtime
        C2["Symbol"]:::runtime
        C3["Symbol+Flattened"]:::runtime
        C4["Scope"]:::runtime
        C5["StringBuilder"]:::runtime
        C1 -->|"builds"| C2
        C2 -->|"flattens_to"| C3
        C1 -->|"uses"| C4
        C1 -->|"utilizes"| C5
    end
    B -->|"invokes"| C1

    %% External Dependency
    D["SwiftSyntax (External)"]:::external
    D -->|"parses_code"| C1

    %% Testing Layer
    E["Unit Tests (HatchTests)"]:::test
    E -->|"validates"| C1

    %% CI/CD and Configuration
    subgraph "CI/CD & Configurations"
        F["CircleCI"]:::ci
        G["GitHub Actions"]:::ci
        H["Package.swift"]:::config
        I["Package.resolved"]:::config
        F -->|"runs_tests"| E
        G -->|"runs_tests"| E
        H --- I
    end

    %% Click Events
    click C1 "https://github.com/sdidla/hatch/blob/main/Sources/Hatch/SymbolParser.swift"
    click C2 "https://github.com/sdidla/hatch/blob/main/Sources/Hatch/Symbol.swift"
    click C3 "https://github.com/sdidla/hatch/blob/main/Sources/Hatch/Symbol+Flattened.swift"
    click C4 "https://github.com/sdidla/hatch/blob/main/Sources/Hatch/Scope.swift"
    click C5 "https://github.com/sdidla/hatch/blob/main/Sources/Hatch/StringBuilder.swift"
    click B "https://github.com/sdidla/hatch/blob/main/Sources/HatchExample/HatchExample.swift"
    click E "https://github.com/sdidla/hatch/blob/main/Tests/HatchTests/SymbolVisitorTests.swift"
    click F "https://github.com/sdidla/hatch/blob/main/.circleci/disabled.config.yml"
    click G "https://github.com/sdidla/hatch/blob/main/.github/workflows/unit-tests.yml"
    click H "https://github.com/sdidla/hatch/blob/main/Package.swift"
    click I "https://github.com/sdidla/hatch/blob/main/Package.resolved"

    %% Styles
    classDef runtime fill:#cc42,stroke:#4085,stroke-width:2px;
    classDef test fill:#d4da,stroke:#155724,stroke-width:2px;
    classDef ci fill:#f3cd,stroke:#856404,stroke-width:2px;
    classDef config fill:#f8da,stroke:#721c24,stroke-width:2px;
    classDef external fill:#e3e5,stroke:#6c757d,stroke-width:2px,stroke-dasharray:5 5;
    
    class A,B,C1,C2,C3,C4,C5 runtime;
    class D external;
    class E test;
    class F,G ci;
    class H,I config;
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---