# iOS-development-vault

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)  [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY)

Copyright © 2025 Cong Le. All Rights Reserved.

---

> ⚠️🏗️🚧🦺🧱🪵🪨🪚🛠️👷
> 
> This is an ongoing project collecting notes for personal educational purposes and references. 
> 
> ![Loading...](https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2V0dXFocnF0cWZ1MTB5bnFqOGZrbnhqZ2Nyd2Vzd3B4cnh1YnVtNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/CTkWFZ1IDvsfS/giphy.gif)
> 
> gif image is provided by [Giphy](https://giphy.com)
> 
> ⚠️🏗️🚧🦺🧱🪵🪨🪚🛠️👷

----

<details open>
	
<summary>Click to show/hide the full disclaimer.</summary>
 
> <ins>📢 **WARNING** 🚨</ins>
 
> **About This Project**
> - This repository documents my ongoing exploration at the intersection of digital art and artificial intelligence.

> **Purpose**
> - To publicly document academic research.
> - To share findings with the community.
> - To maintain a personal portfolio of creative and technical work.

> **Disclaimer**
> - This is a personal project.
> - Any user who shares, adapts, or builds upon this work is responsible for their own interpretations and applications.

> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for 👨‍🎓 <ins>educational purposes</ins> 👨‍🎓 (<ins>sometimes, entertainment purposes</ins>), 📖 <ins> personal study </ins> 📖, and 🔖 <ins> technical reference </ins> 🔖.

> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.

> ... and I'm still searching for a real job now.

</details>


----

These notes cover a wide array of subjects with varying levels of depth and detail. I aim to present iOS development concepts and practices using visual representations.

## Demo
Below is a sample of note in this repo.


```mermaid
---
title: Design Patterns in Mixed Languages
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
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
    A[Identify the core<br>problem] --> B{Is the<br>problem<br>related to}
    B -- Creating objects --> C(Creational)
    B -- Assembling objects --> D(Structural)
    B -- Object interactions/<br>responsibilities --> E(Behavioral)
    B -- Managing memory/resources --> M(Memory Management)

    subgraph Creational_Patterns["Creational Patterns"]
        direction LR
        C --> CR1[Need single instance<br>per app/module] --> S(Singleton)
        C --> CR2[Decouple object creation<br>from usage] --> FM(Factory Method)
        C --> CR3[Create families of<br>related objects] --> AF(Abstract Factory)
        C --> CR4[Create duplicate objects<br>efficiently] --> P(Prototype)
        C --> CR5[Construct complex objects<br>step by step] --> BLD(Builder)
        C --> CR6[Create objects based on<br> runtime parameters] --> BO(Builder with Options)
    end

    subgraph Structural_Patterns["Structural Patterns"]
        direction LR
        D --> ST1[Simplify complex<br>subsystems] --> F(Facade);
        D --> ST2["Make incompatible interfaces<br>compatible<br>(Swift/ObjC/C++)"] --> AD(Adapter);
        D --> ST3["Represent part-whole<br>hierarchies<br>(Views)"] --> CP(Composite);
        D --> ST4["Control access to objects<br>(Network, Files)"] --> PR(Proxy);
        D --> ST5["Dynamically add/remove<br>behavior<br>(at runtime)"] --> DC(Decorator);
        D --> ST6[Decouple abstraction from<br>implementation] --> BR(Bridge);
        D --> ST7[Efficiently share large numbers<br>of fine-grained objects] --> FW(Flyweight);
        D --> ST8[Combine multiple objects<br>into a single interface] --> AGG(Aggregator);
    end
    
    subgraph Behavioral_Patterns["Behavioral Patterns"]
        direction LR
        E --> BH1["Define a family of<br>algorithms<br>(Networking)"] --> STG(Strategy)
        E --> BH2[Define algorithm skeleton,<br> defer steps to subclasses] --> TM(Template Method)
        E --> BH3["Encapsulate requests as objects<br>(Undo/Redo)"] --> CMD(Command)
        E --> BH4[Separate operations from<br>objects they operate on] --> V(Visitor)
        E --> BH5["Encapsulate state-specific<br>behavior<br>(Game States)"] --> STE(State)
        E --> BH6["Maintain a consistent state by<br>being notified of changes<br>(KVO, Combine, Delegates)"] --> O(Observer)
        E --> BH7[Traverse collections without<br>exposing internals] --> I(Iterator)
        E --> BH8[Reduce coupling between<br>communicating objects] --> MED(Mediator)
        E --> BH9[Capture and restore an<br>object's internal state] --> MEM(Memento)
        E --> BH10[Provide a way to access elements<br>of an aggregate object sequentially] --> CHN(Chain of Responsibility)
        E --> BH11[Convert the interface of a class<br>into another interface clients expect] --> INT(Interpreter);

    end

    subgraph Memory_Management_Patterns["Memory Management Patterns"]
      direction LR
      M --> MM1[Automatic Reference Counting] --> ARC(ARC)
      M --> MM2[Manual Reference Counting] --> MRC(MRC)
      M --> MM3[Retain Cycles] --> RC(Retain Cycles)
      M --> MM4[Object Pooling] --> OP(Object Pool)
    end


    style CR1 fill:#1f1111,stroke:#fed7aa
    style CR2 fill:#1f1111,stroke:#fed7aa
    style CR3 fill:#1f1111,stroke:#fed7aa
    style CR4 fill:#1f1111,stroke:#fed7aa
    style CR5 fill:#1f1111,stroke:#fed7aa
    style CR6 fill:#1f1111,stroke:#fed7aa


    style ST1 fill:#1f1111,stroke:#fed7aa
    style ST2 fill:#1f1111,stroke:#fed7aa
    style ST3 fill:#1f1111,stroke:#fed7aa
    style ST4 fill:#1f1111,stroke:#fed7aa
    style ST5 fill:#1f1111,stroke:#fed7aa
    style ST6 fill:#1f1111,stroke:#fed7aa
    style ST7 fill:#1f1111,stroke:#fed7aa
    style ST8 fill:#1f1111,stroke:#fed7aa



    style BH1 fill:#121f91,stroke:#82b366
    style BH2 fill:#121f91,stroke:#82b366
    style BH3 fill:#121f91,stroke:#82b366
    style BH4 fill:#121f91,stroke:#82b366
    style BH5 fill:#121f91,stroke:#82b366
    style BH6 fill:#121f91,stroke:#82b366
    style BH7 fill:#121f91,stroke:#82b366
    style BH8 fill:#121f91,stroke:#82b366
    style BH9 fill:#121f91,stroke:#82b366
    style BH10 fill:#121f91,stroke:#82b366
    style BH11 fill:#121f91,stroke:#82b366



    style MM1 fill:#1f1111,stroke:#feda11
    style MM2 fill:#1f1111,stroke:#feda11
    style MM3 fill:#1f1111,stroke:#feda11
    style MM4 fill:#1f1111,stroke:#feda11


    style S fill:#e1d5,stroke:#1a73a6
    style FM fill:#e1d5,stroke:#1a73a6
    style AF fill:#e1d5,stroke:#1a73a6
    style P fill:#e1d5,stroke:#1a73a6
    style BLD fill:#e1d5,stroke:#1a73a6
    style BO fill:#e1d5,stroke:#1a73a6

    
    style F fill:#818129,stroke:#9673a6
    style AD fill:#818129,stroke:#9673a6
    style CP fill:#818129,stroke:#9673a6
    style PR fill:#818129,stroke:#9673a6
    style DC fill:#818129,stroke:#9673a6
    style BR fill:#818129,stroke:#9673a6
    style FW fill:#818129,stroke:#9673a6
    style AGG fill:#818129,stroke:#9673a6


    style STG fill:#d51114,stroke:#82b366
    style TM fill:#d51114,stroke:#82b366
    style CMD fill:#d51114,stroke:#82b366
    style V fill:#d51114,stroke:#82b366
    style STE fill:#d51114,stroke:#82b366
    style O fill:#d51114,stroke:#82b366
    style I fill:#d51114,stroke:#82b366
    style MED fill:#d51114,stroke:#82b366
    style MEM fill:#d51114,stroke:#82b366
    style CHN fill:#d51114,stroke:#82b366
    style INT fill:#d51114,stroke:#82b366

    style ARC fill:#c511f3,stroke:#824c68
    style MRC fill:#c511f3,stroke:#824c68
    style RC fill:#c511f3,stroke:#824c68
    style OP fill:#c511f3,stroke:#824c68

    style C fill:#c111f3,stroke:#824c68
    style D fill:#623ddd,stroke:#fbbd20
    style E fill:#911297,stroke:#4d884d
    style M fill:#f199,stroke:#4d884d
    style B fill:#e91f11,stroke:#b85450
    style A fill:#4e899f,stroke:#6c8ebf

    S -.-> SI1(Single instance<br>'static let shared = ...')
    FM -.-> SI2(Single instance<br>of concrete factory)
    FM -.-> IM("Implement<br>using:<br>'protocol Product { ... }'<br>'protocol Factory { ... }'")
    FM -.-> CFD(Configure factory<br>dynamically)
    CFD -.-> SI3(Single instance<br>of factory manager)
    AF -.-> IM2(Implement using:<br>Multiple factories<br>conforming to a protocol)
    P -.-> IM3("Implement using:<br>'NSCopying' (ObjC)<br>Custom 'clone()' (Swift)")
    BLD -.-> IM4(Implement using:<br>Separate 'Builder' class<br>with fluent interface)
    BO -.-> IM4
    BO -.-> USO(Use for:<br>Complex object creation<br>with many options)

    F -.-> USF(Use for:<br>Networking, Database access)
    AD -.-> IM5("Implement using:<br>Protocol extensions (Swift)<br>Category (ObjC)<br>Wrapper class")
    AD -.-> USO2(Use for:<br>Bridging Swift/ObjC/C++)
    CP -.-> CC(Creating composites<br>of 'UIView's)
    CP -.-> IM6(Implement using:<br>Recursive data structure)
    PR -.-> USPR(Use for:<br>Lazy loading, access control)
    DC -.-> AR(Add responsibility<br>to objects dynamically)
    DC -.-> OU(Often uses)
    CP -.-> CU(Composed using)
    CP -.-> CSSVG(Chaining skin versus guts<br>Good for 'UITableViewCell')
    FW -.-> USFW(Use for:<br>Drawing large numbers<br>of similar objects)
    AGG -.-> IMAG(Implement Using<br>Multiple Services and Combine)
    AGG -.-> USAG(Use for<br>Microservices, Data Aggregation)


    STG -.-> DAS(Define algorithm<br>steps as protocols)
    STG -.-> IM7("Implement using:<br>'protocol Algorithm { ... }'")
    STG -.-> USSTG(Use for:<br>Networking protocols,<br>Data processing)
    TM -.-> IM8(Implement using:<br>'open' and 'final' methods)
    TM -.-> USTM(Use for:<br>Customizable 'UIViewController's)
    CMD -.-> IM9("Implement using:<br>'protocol Command { ... }'<br>Invoker, Receiver")
    CMD -.-> USCMD(Use for:<br>Undo/Redo, Operations)
    V -.-> IM10(Implement using:<br>Double dispatch)
    V -.-> USV(Use for:<br>Operating on a hierarchy<br>of objects)
    STE -.-> IM11("Implement using:<br>'enum State { ... }'<br>Context class")
    STE -.-> USSTE(Use for:<br>Game states, UI states)
    O -.-> IMO(Implement using:<br>Delegates, Notifications,<br>Combine, KVO)
    O -.-> USO3(Use for:<br>Reacting to model changes)
    I -.-> IMI("Implement using:<br>'IteratorProtocol' (Swift)")
    I -.-> USI(Use for:<br>Custom collection types)
    MED -.-> IMMED(Implement using:<br>Centralized communication object)
    MED -.-> USMED(Use for:<br>Complex UI interactions)
    MEM -.-> IMMEM(Implement using:<br>Originator, Caretaker, Memento)
    MEM -.-> USMEM(Use for:<br>Saving and restoring game state)
    CHN -.-> IMCHN(Implement using:<br>Chain of handlers)
    CHN -.-> USCHN(Use for:<br>Event handling, Error handling)
    INT -.-> IMINT("Implement using:<br>Abstract Syntax Tree<br>(AST)")
    INT -.-> USINT(Use for:<br>Parsing, DSLs)


    ARC -.-> IMARC(Swift's primary memory management)
    MRC -.-> IMMRC(Objective-C, manual retain/release)
    RC -.-> IMARC
    RC -.-> IMRC
    RC -.-> UMRC(Use Weak/Unowned References)
    OP -.-> IMOP(Reusable objects to avoid allocation)
    OP -.-> USOP(UITableViewCells, UICollectionReusableView)

```

---

## 🚀 Project Current Activities

<div align="center">
	<img alt="Project Current Activities Top" src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExM2dtMXUweTRlOXVqOXU5and5ajloeDdycHVsOW1hbG0xazh6ejNpZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/yE72eDy7lj3JS/giphy.gif"/>
	<br/>
	<em>gif image is provided by <a href="https://giphy.com">Giphy</a></em>
</div>


<div align="left"><a name="project-current-activities"></a>

<details open>
<summary>Click to show/hide more on recent activities of this project </summary>

> powered by [OSS Insight](https://ossinsight.io)
<!-- All the diagrams below are made with [OSS Insight](https://ossinsight.io/) -->

| :bar_chart: Widget & Description | :art: Snapshot (Light Mode) |
|---|---|
| Active Contributors :technologist: of iOS-development-vault - Last 28 days | ![Active Contributors of iOS-development-vault - Last 28 days](https://next.ossinsight.io/widgets/official/compose-recent-active-contributors/thumbnail.png?repo_id=902093760&limit=30&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/compose-recent-active-contributors?repo_id=902093760&limit=30) |
| Pushes :arrow_up: and Commits :writing_hand: of iOS-development-vault | ![Pushes and Commits of iOS-development-vault](https://next.ossinsight.io/widgets/official/analyze-repo-pushes-and-commits-per-month/thumbnail.png?repo_id=902093760&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/analyze-repo-pushes-and-commits-per-month?repo_id=902093760) |
| Pull Request Size :straight_ruler: of iOS-development-vault | ![Pull Request Size of iOS-development-vault](https://next.ossinsight.io/widgets/official/analyze-repo-pull-requests-size-per-month/thumbnail.png?repo_id=902093760&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/analyze-repo-pull-requests-size-per-month?repo_id=902093760) |
| Pull Request Lifecycle :arrows_counterclockwise: of iOS-development-vault | ![Pull Request Lifecycle of iOS-development-vault](https://next.ossinsight.io/widgets/official/analyze-repo-pull-request-open-to-merged/thumbnail.png?repo_id=902093760&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/analyze-repo-pull-request-open-to-merged?repo_id=902093760) |
| Lines of Code Changes :computer::scroll: of iOS-development-vault | ![Lines of Code Changes of iOS-development-vault](https://next.ossinsight.io/widgets/official/analyze-repo-loc-per-month/thumbnail.png?repo_id=902093760&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/analyze-repo-loc-per-month?repo_id=902093760) |
| Commits Time Distribution :alarm_clock::date: of iOS-development-vault | ![Commits Time Distribution of iOS-development-vault](https://next.ossinsight.io/widgets/official/analyze-repo-commits-time-distribution/thumbnail.png?repo_id=902093760&period=last_1_year&zone=0&image_size=auto&color_scheme=light) <br/> :link: [View Full Report :mag:](https://next.ossinsight.io/widgets/official/analyze-repo-commits-time-distribution?repo_id=902093760&period=last_1_year&zone=0) | 

</details>

</div>


<div align="center">
	<img alt="Project Current Activities Bottom" src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXduZDR2b2d4bTF3Mjc5OGhlZWU3Mnl3Y2ozbmk3eHIza2EzdGo3aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/aNkKabft4Rs5y/giphy.gif"/>
	<br/>
	<em>gif image is provided by <a href="https://giphy.com">Giphy</a></em>
</div>


---

## License

This project is licensed under the [MIT License](LICENSE), which allows you to use, modify, and distribute the software as long as you provide proper credit to the original authors.

### Software License
This software is licensed under the [MIT License](LICENSE). You may use, copy, modify, merge, publish, distribute, and sublicense it, provided that you include the original license in all copies or substantial portions of the software.

### Documentation License
The documentation and other creative materials for this project are licensed under the [Creative Commons Attribution 4.0 International License](LICENSE-CC-BY). You are free to share, adapt, and use the documentation, as long as you give appropriate credit to the original authors.



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
    
   Closing_quote ~~~ My_Meme
    
  Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

  Closing_quote ~~~ My_Meme
  My_Meme animatingEdge@--> Link_to_my_profile
  
  animatingEdge@{ animate: true }

```

---

