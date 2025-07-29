---
created: 2025-02-18 05:31:26
author: N/A
version: N/A
license(s): N/A
copyright: N/A
---



# CLEAN Architecture

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
