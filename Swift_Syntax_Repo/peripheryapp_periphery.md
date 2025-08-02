---
created: 2025-04-06 05:31:26
author: NA
version: NA
license(s): NA
copyright: NA
---



# Periphery App - Periphery


---

<div align="center">
  <blockquote>
  As a visual learner student, I created these personal study notes from the cited source(s) to aid my understanding.<br/>
  While my firm intention is to provide full credit, the blended format of notes and diagrams may sometimes obscure the original source, for which I apologize.<br/>
  I am committed to making corrections and welcome any feedback.<br/>
  This is a non-commercial project for my humble educational purposes only since the start.<br/>
  My goal is to share my perspective and contribute to the great work already being done.
  <br/>
  <br/>
  I want to extend my genuine apologies to the creators of the original material.<br/>
  Their work was the direct inspiration for this project, and I adapted it without first reaching out.<br/>
  My intent comes from a place of deep respect, and I hope this is received in the spirit of homage.<br/>
  🙏🏼🙏🏼🙏🏼🙏🏼
  </blockquote>
</div>

----



```mermaid
---
title: "Periphery App - Periphery"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright © 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  theme: base
  look: handDrawn
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'American Typewriter, monospace',
    'logLevel': 'fatal',
    'themeVariables': {
      'primaryColor': '#2211',
      'primaryTextColor': '#F8B229',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#2F11',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '20px'
    }
  }
}%%
flowchart TD
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
