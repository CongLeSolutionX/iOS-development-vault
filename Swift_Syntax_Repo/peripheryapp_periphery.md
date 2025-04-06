---
created: 2025-04-06 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Periphery App - Periphery
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
title: "Periphery App - Periphery"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: default
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': {'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'lineColor': '#F8B229'
    }
  }
}%%
graph TD
    CLI("CLI (Sources/Frontend)"):::frontend
    PD("Project Drivers (Sources/ProjectDrivers)"):::integration
    IDX("Indexer (Sources/Indexer)"):::processing
    SG("Source Graph (Sources/SourceGraph)"):::processing
    GM("Graph Mutators (Sources/SourceGraph/Mutators)"):::processing
    SA("Syntax Analysis (Sources/SyntaxAnalysis)"):::analysis
    PK("Output Formatting (PeripheryKit/Results)"):::output
    XS("Xcode Support (Sources/XcodeSupport)"):::integration
    LOG("Logger (Sources/Logger)"):::logger
    EXT("External Build Systems (Bazel, Xcode,SPM)"):::external

    SW("swiftlint.yml"):::config
    BZ(".bazelrc"):::config
    DO(".dockerignore"):::config
    MB("MODULE.bazel"):::config
    MI(".mise/"):::config

    %% Data Flow
    CLI -->|"sends_commands"| PD
    PD -->|"interfaces_with"| EXT
    PD -->|"provides_index_store"| IDX
    IDX -->|"builds_analysis_pipeline"| SG
    SA -->|"enhances_graph"| SG
    SG -->|"applies_mutators"| GM
    GM -->|"outputs_refined_graph"| PK
    PK -->|"returns_results"| CLI
    PD -->|"handles_Xcode_integration"| XS

    %% Logger connections (dashed lines)
    LOG --- CLI
    LOG --- PD
    LOG --- IDX
    LOG --- SG
    LOG --- SA
    LOG --- PK
    LOG --- XS

    %% Configuration files feeding into Project Drivers
    SW --> PD
    BZ --> PD
    DO --> PD
    MB --> PD
    MI --> PD

    %% Click Events
    click CLI "https://github.com/peripheryapp/periphery/tree/master/Sources/Frontend"
    click PD "https://github.com/peripheryapp/periphery/tree/master/Sources/ProjectDrivers"
    click IDX "https://github.com/peripheryapp/periphery/tree/master/Sources/Indexer"
    click SG "https://github.com/peripheryapp/periphery/tree/master/Sources/SourceGraph"
    click GM "https://github.com/peripheryapp/periphery/tree/master/Sources/SourceGraph/Mutators"
    click SA "https://github.com/peripheryapp/periphery/tree/master/Sources/SyntaxAnalysis"
    click PK "https://github.com/peripheryapp/periphery/tree/master/Sources/PeripheryKit/Results"
    click XS "https://github.com/peripheryapp/periphery/tree/master/Sources/XcodeSupport"
    click LOG "https://github.com/peripheryapp/periphery/tree/master/Sources/Logger"
    click SW "https://github.com/peripheryapp/periphery/blob/master/swiftlint.yml"
    click BZ "https://github.com/peripheryapp/periphery/blob/master/.bazelrc"
    click DO "https://github.com/peripheryapp/periphery/blob/master/.dockerignore"
    click MB "https://github.com/peripheryapp/periphery/blob/master/MODULE.bazel"
    click MI "https://github.com/peripheryapp/periphery/tree/master/.mise/"

    %% Styles
    classDef frontend fill:#a8dadc,stroke:#457b9d,stroke-width:2px;
    classDef integration fill:#f4a261,stroke:#e76f51,stroke-width:2px;
    classDef processing fill:#e9c46a,stroke:#f4a261,stroke-width:2px;
    classDef analysis fill:#e76f51,stroke:#2a9d8f,stroke-width:2px;
    classDef output fill:#2a9d8f,stroke:#264653,stroke-width:2px;
    classDef config fill:#f1faee,stroke:#a8dadc,stroke-width:2px;
    classDef logger fill:#d8e2dc,stroke:#99a8b2,stroke-width:2px;
    classDef external fill:#ffb4a2,stroke:#f28482,stroke-width:2px;
    
```

---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---