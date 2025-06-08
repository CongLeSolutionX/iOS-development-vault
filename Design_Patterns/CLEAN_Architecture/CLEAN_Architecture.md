---
created: 2025-02-18 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# CLEAN Architecture
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---

## WIP

```mermaid
---
title: The CLEAN Architecture
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    subgraph Entities [Entities <br> <font size=1>Enterprise Business Rules</font>]
    style Entities fill:#581845,color:#fff
        A[ ]:::empty
    end

    subgraph UseCases [Use Cases <br> <font size=1>Application Business Rules</font>]
    style UseCases fill:#900C3F,color:#fff
        B[ ]:::empty
    end

    subgraph InterfaceAdapters [Interface Adapters]
    style InterfaceAdapters fill:#C70039,color:#fff
        subgraph Controllers [Controllers]
            style Controllers fill:#E37B40,color:#fff
            C[ ]:::empty
        end
        subgraph Presenters [Presenters]
            style Presenters fill:#E37B40,color:#fff
            D[ ]:::empty
        end
        subgraph Gateways [Gateways]
            style Gateways fill:#E37B40,color:#fff
            E[ ]:::empty
        end
    end

    subgraph FrameworksDrivers [Frameworks & Drivers]
    style FrameworksDrivers fill:#1948A,color:#000
        subgraph Devices [Devices]
            style Devices fill:#FDC6F,color:#000
            F[ ]:::empty
        end
        subgraph UI [UI]
            style UI fill:#FDC6F,color:#000
            G[ ]:::empty
        end
        subgraph Web [WEB]
            style Web fill:#FDC6F,color:#000
            H[ ]:::empty
        end
        subgraph DB [DB]
            style DB fill:#FDC6F,color:#000
            I[ ]:::empty
        end
        subgraph ExternalInterfaces [External Interfaces]
            style ExternalInterfaces fill:#FDC6F,color:#000
            J[ ]:::empty
        end
    end

    FrameworksDrivers --> InterfaceAdapters
    InterfaceAdapters --> UseCases
    UseCases --> Entities

    style A fill:#900C3F,stroke:#581845,stroke-width:2px
    style B fill:#C70039,stroke:#900C3F,stroke-width:2px
    style C fill:#F1948A,stroke:#C70039,stroke-width:2px
    style D fill:#F1948A,stroke:#C70039,stroke-width:2px
    style E fill:#F1948A,stroke:#C70039,stroke-width:2px
    style F fill:#F7DC6F,stroke:#F1948A,stroke-width:2px
    style G fill:#F7DC6F,stroke:#F1948A,stroke-width:2px
    style H fill:#F7DC6F,stroke:#F1948A,stroke-width:2px
    style I fill:#F7DC6F,stroke:#F1948A,stroke-width:2px
    style J fill:#F7DC6F,stroke:#F1948A,stroke-width:2px

    classDef empty fill:#FFFFFF,stroke:#FFFFFF,stroke-width:0px;

    subgraph FlowOfControl [Flow of control]
    direction TB
        Controller --> UseCaseInputPort
        UseCaseInputPort --> UseCaseInteractor
        UseCaseInteractor --> UseCaseOutputPort
        UseCaseOutputPort --> Presenter
        Presenter --> Controller
    end

    Controller[Controller]:::box
    UseCaseInputPort[Use Case <br> Input Port]:::box
    UseCaseInteractor[Use Case <br> Interactor]:::box
    UseCaseOutputPort[Use Case <br> Output Port]:::box
    Presenter[Presenter]:::box

    classDef box fill:#E37B40,color:#fff;
    
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
