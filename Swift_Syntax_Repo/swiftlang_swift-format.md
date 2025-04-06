---
created: 2025-04-06 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Swiftlang - Swift Format
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
title: "Swiftlang - Swift Format"
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
    'flowchart': {'htmlLabels': true, 'curve': 'basis' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'lineColor': '#F8B229'
    }
  }
}%%
flowchart TD
    subgraph "User Interaction Layer"
        CLI_Interface["Command-Line Interface (CLI)"]:::user
        API_Layer["API Layer"]:::user
    end

    ConfigLoader["Configuration Loader"]:::config

    CLI_Interface -->|"loads_configuration"| ConfigLoader
    API_Layer -->|"invokes_API"| ConfigLoader

    subgraph "Formatting and Linting Engine"
        subgraph "Formatting Pipeline"
            CoreProcessing["Core Processing"]:::engine
            RulesEngine["Rules Engine"]:::engine
            PrettyPrint["Pretty Print Module"]:::engine
            CoreProcessing -->|"applies_rules"| RulesEngine
            RulesEngine -->|"formats_output"| PrettyPrint
        end
        subgraph "Linting Pipeline"
            SwiftLinter["Swift Linter"]:::engine
            LintPipeline["Lint Pipeline"]:::engine
            SwiftLinter -->|"generates_diagnostics"| LintPipeline
        end
    end

    ConfigLoader -->|"provides_settings"| CoreProcessing
    API_Layer -->|"calls_formatting"| CoreProcessing

    PluginSupport["Plugin Support"]:::plugin
    PluginSupport -->|"extends_engine"| CoreProcessing

    BuildInfra["Build & Test Infrastructure"]:::infra
    BuildInfra -->|"builds_and_tests"| CoreProcessing

    ExternalDeps["External Dependencies"]:::ext
    ExternalDeps -->|"supports_engine"| CoreProcessing

    PrettyPrint -->|"outputs"| Output["Formatted Code / Diagnostics"]
    LintPipeline -->|"outputs"| Output

    %% Click Events
    click CLI_Interface "https://github.com/swiftlang/swift-format/tree/main/Sources/swift-format/Frontend"
    click CLI_Interface "https://github.com/swiftlang/swift-format/tree/main/Sources/swift-format/Subcommands"
    click API_Layer "https://github.com/swiftlang/swift-format/tree/main/Sources/SwiftFormat/API"
    click ConfigLoader "https://github.com/swiftlang/swift-format/blob/main/Sources/swift-format/Frontend/ConfigurationLoader.swift"
    click CoreProcessing "https://github.com/swiftlang/swift-format/tree/main/Sources/SwiftFormat/Core"
    click PrettyPrint "https://github.com/swiftlang/swift-format/tree/main/Sources/SwiftFormat/PrettyPrint"
    click RulesEngine "https://github.com/swiftlang/swift-format/tree/main/Sources/SwiftFormat/Rules"
    click SwiftLinter "https://github.com/swiftlang/swift-format/blob/main/Sources/SwiftFormat/API/SwiftLinter.swift"
    click LintPipeline "https://github.com/swiftlang/swift-format/blob/main/Sources/SwiftFormat/Core/LintPipeline.swift"
    click PluginSupport "https://github.com/swiftlang/swift-format/tree/main/Plugins/FormatPlugin"
    click PluginSupport "https://github.com/swiftlang/swift-format/tree/main/Plugins/LintPlugin"
    click BuildInfra "https://github.com/swiftlang/swift-format/blob/main/CMakeLists.txt"
    click BuildInfra "https://github.com/swiftlang/swift-format/blob/main/Sources/CMakeLists.txt"
    click BuildInfra "https://github.com/swiftlang/swift-format/tree/main/Tests/"

    %% Styles
    classDef user fill:#f9e79f,stroke:#d35400,stroke-width:2px;
    classDef config fill:#fad7a0,stroke:#e67e22,stroke-width:2px;
    classDef engine fill:#aed6f1,stroke:#2471a3,stroke-width:2px;
    classDef plugin fill:#d7bde2,stroke:#8e44ad,stroke-width:2px;
    classDef infra fill:#d5f5e3,stroke:#1e8449,stroke-width:2px;
    classDef ext fill:#f5b7b1,stroke:#c0392b,stroke-width:2px;


```




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---