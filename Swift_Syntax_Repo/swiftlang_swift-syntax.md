---
created: 2025-04-06 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Swiftlang - Swift Syntax


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
title: "Swiftlang - Swift Syntax"
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
graph TB
    %% Styles
    classDef core fill:#3498db,stroke:#2980b9,color:white
    classDef macro fill:#2ecc71,stroke:#27ae60,color:white
    classDef util fill:#f1c40f,stroke:#f39c12,color:black
    classDef diag fill:#e74c3c,stroke:#c0392b,color:white
    classDef ide fill:#9b59b6,stroke:#8e44ad,color:white
    classDef test fill:#95a5a6,stroke:#7f8c8d,color:white

    %% Top Layer
    subgraph ClientLayer
        SyntaxBuilder["SwiftSyntaxBuilder"]:::macro
        SyntaxMacros["SwiftSyntaxMacros"]:::macro
        MacroExpansion["Macro Expansion System"]:::macro
    end

    %% Middle Layer
    subgraph ProcessingLayer
        Parser["SwiftParser"]:::core
        SyntaxCore["SwiftSyntax Core"]:::core
        Operators["SwiftOperators"]:::core
        LexicalLookup["Lexical Lookup"]:::core
    end

    %% Bottom Layer
    subgraph InfrastructureLayer
        Diagnostics["SwiftDiagnostics"]:::diag
        BasicFormat["SwiftBasicFormat"]:::util
        CompilerPlugin["SwiftCompilerPlugin"]:::util
        ParserDiag["Parser Diagnostics"]:::diag
    end

    %% Support Layer
    subgraph SupportLayer
        IDEUtils["SwiftIDEUtils"]:::ide
        CodeGen["Code Generation"]:::util
        Testing["Testing Infrastructure"]:::test
        IDEIntegration["IDE Integration"]:::ide
    end

    %% Relationships
    SyntaxBuilder <--> SyntaxMacros
    SyntaxMacros <--> MacroExpansion
    MacroExpansion --> CompilerPlugin
    
    Parser --> SyntaxCore
    SyntaxCore <--> Operators
    SyntaxCore --> LexicalLookup
    
    Parser --> ParserDiag
    ParserDiag --> Diagnostics
    
    SyntaxCore --> BasicFormat
    BasicFormat --> CompilerPlugin
    
    IDEUtils --> SyntaxCore
    IDEUtils --> IDEIntegration
    
    Testing -.-> SyntaxCore
    Testing -.-> Parser
    Testing -.-> Operators
    
    CodeGen --> SyntaxCore

    %% Click Events
    click SyntaxBuilder "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftSyntaxBuilder"
    click SyntaxMacros "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftSyntaxMacros"
    click MacroExpansion "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftSyntaxMacroExpansion"
    click Parser "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftParser"
    click SyntaxCore "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftSyntax"
    click Operators "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftOperators"
    click LexicalLookup "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftLexicalLookup"
    click Diagnostics "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftDiagnostics"
    click BasicFormat "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftBasicFormat"
    click CompilerPlugin "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftCompilerPlugin"
    click ParserDiag "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftParserDiagnostics"
    click IDEUtils "https://github.com/swiftlang/swift-syntax/tree/main/Sources/SwiftIDEUtils"
    click CodeGen "https://github.com/swiftlang/swift-syntax/tree/main/CodeGeneration/Sources/SyntaxSupport"
    click Testing "https://github.com/swiftlang/swift-syntax/tree/main/Tests/SwiftSyntaxTest"
    click IDEIntegration "https://github.com/swiftlang/swift-syntax/tree/main/EditorExtension/SwiftRefactorExtension"

    %% Legend
    subgraph Legend
        L1["Core Components"]:::core
        L2["Macro Components"]:::macro
        L3["Utility Components"]:::util
        L4["Diagnostic Components"]:::diag
        L5["IDE Components"]:::ide
        L6["Testing Components"]:::test
    end

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---