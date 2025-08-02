---
created: 2025-04-06 05:31:26
author: NA
version: NA
license(s): NA
copyright: NA
---



# SwiftFiddle - Swift AST Explorer

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
  I want to extend my genuine apologies to the creators of the original materials.<br/>
  Their work was the direct inspiration for this project, and I adapted it without first reaching out.<br/>
  My intent comes from a place of deep respect, and I hope this is received in the spirit of homage.<br/>
  🙏🏼🙏🏼🙏🏼🙏🏼
  </blockquote>
</div>

----



```mermaid
---
title: "SwiftFiddle - Swift AST Explorer"
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
    %% Frontend Layer
    subgraph "Frontend Layer"
        FE["Frontend (Public Assets)"]:::frontend
    end

    %% Backend Layer
    subgraph "Backend Layer"
        BE["Swift Web Server (Sources/App)"]:::backend
        MW["Middleware & Routes"]:::backend
        BE -->|"delegates to"| MW
    end

    %% Parser Modules Layer
    subgraph "Parser Modules (Resources/parsers)"
        P50800["Parser Module 50800"]:::parser
        P50900["Parser Module 50900"]:::parser
        P51000["Parser Module 51000"]:::parser
        P60000["Parser Module 60000"]:::parser
        Ptrunk["Parser Module trunk"]:::parser
    end

    %% Dev & Build Tools
    subgraph "Dev & Build Tools"
        DEV["Development Tools (dev/)"]:::dev
        WCC["webpack.common.js"]:::dev
        WDEV["webpack.dev.js"]:::dev
        WPROD["webpack.prod.js"]:::dev
        DEV -->|"configures"| WCC
        DEV -->|"configures"| WDEV
        DEV -->|"configures"| WPROD
    end

    %% CI/CD & Deployment
    subgraph "CI/CD & Deployment"
        GHA["GitHub Workflows (.github/workflows)"]:::cicd
        DF["Dockerfile"]:::cicd
        DEPLOYMD["DEPLOYMENT.md"]:::cicd
        DEPLOY["Deployment Scripts (deploy/)"]:::cicd
        GHA --- DF
        DF --- DEPLOYMD
        DEPLOYMD --- DEPLOY
    end

    %% Data Flow Connections
    FE -->|"HTTP requests & static assets"| BE
    MW -->|"calls parser"| P50800
    MW -->|"calls parser"| P50900
    MW -->|"calls parser"| P51000
    MW -->|"calls parser"| P60000
    MW -->|"calls parser"| Ptrunk

    %% Click Events
    click FE "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Public/"
    click BE "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Sources/App"
    click P50800 "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Resources/parsers/50800"
    click P50900 "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Resources/parsers/50900"
    click P51000 "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Resources/parsers/51000"
    click P60000 "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Resources/parsers/60000"
    click Ptrunk "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Resources/parsers/trunk"
    click DEV "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/dev/"
    click WCC "https://github.com/swiftfiddle/swift-ast-explorer/blob/master/webpack.common.js"
    click WDEV "https://github.com/swiftfiddle/swift-ast-explorer/blob/master/webpack.dev.js"
    click WPROD "https://github.com/swiftfiddle/swift-ast-explorer/blob/master/webpack.prod.js"
    click GHA "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/.github/workflows"
    click DF "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/Dockerfile"
    click DEPLOYMD "https://github.com/swiftfiddle/swift-ast-explorer/blob/master/DEPLOYMENT.md"
    click DEPLOY "https://github.com/swiftfiddle/swift-ast-explorer/tree/master/deploy/"

    %% Style Classes
    classDef frontend fill:#f9f,stroke:#333,stroke-width:2px;
    classDef backend fill:#ccf,stroke:#333,stroke-width:2px;
    classDef parser fill:#cfc,stroke:#333,stroke-width:2px;
    classDef dev fill:#fcc,stroke:#333,stroke-width:2px;
    classDef cicd fill:#fc9,stroke:#333,stroke-width:2px;
    
```

---
