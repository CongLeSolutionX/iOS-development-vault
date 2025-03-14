---
created: 2025-03-13 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# iOS Widget Design Workflow
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


## iOS Widget Design Workflow - A Diagrammatic Guide 



```mermaid
---
title: "iOS Widget Design Workflow"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    subgraph Overall_Flow["Overall Widget Experience"]
        style Overall_Flow fill:#E2F7,stroke:#7BFF,stroke-width:2px
        A[Home Screen] --> B(Long Press App Icon/Widget);
        B -- "App Icon" --> C1{App Context Menu};
        B -- "Widget" --> C2{Widget Context Menu};

        C1 --> C1A[Remove App];
        C1 --> C1B[Require Face ID/Touch ID];
        C1 --> C1C[Share App];
        C1 --> C1D[Edit Home Screen];
        C1 --> C1E["App-Specific Options<br>(Inbox, Saved, Search, Lens)"];
        C1 --> C1F[App Settings];

        C2 --> C2A[Edit Widget];
        C2 --> C2B[Edit Home Screen];
        C2 --> C2C[Remove Widget];
        C2 --> C2D[Widget Help/Tutorial];

        C1D --> D{"Widget Edit Mode (Jiggle Mode)"}
        C2B --> D;
        D --> E["'+' Button (Add Widget)"];
        E --> F[Widget Gallery];
        F --> G(Select Pinterest Widget);
        G --> H["Widget Size Options (Small, Medium, Large, Extra Large)"]
        H --> I(Choose Size & Add);
        I --> J[Widget on Home Screen];

        C2A --> K[Widget Configuration Screen];
        K --> L(Choose Board/Topic/Interest);
        L --> M[Widget Displays Selected Content];

        J --> N[Widget Interaction];
        N --> O[Deep Link to App Content];
        style N fill:#FFD7,stroke:#333,stroke-width:1px;

        J --> P[Refresh Widget Content];
        style P fill:#98FB,stroke:#333,stroke-width:1px;
        
        J --> Q[Error State Handling];
        Q --> QA[No Network Connection];
        QA --> QAD["Display 'No Network' Message"]
        QA --> QAU[Retry Button]
        Q --> QB[Content Unavailable];
        QB --> QBD["Display 'Content Unavailable' Message"]
    end

    subgraph Widget_Configuration["Detailed Widget Configuration"]
        style Widget_Configuration fill:#E2F7,stroke:#007BFF,stroke-width:2px
        J --> K;
        K --> KA["Title: 'Boards/Topics/Interests'"];
        K --> KB["Subtitle: 'Get inspired... (Customizable)'"];
        K --> KC[Carousel of Board/Topic Options];
        KC --> KC1[Preview 1];
        KC --> KC2[Preview 2];
        KC --> KC3[Preview N];
        KC1 --> L;
        KC2 --> L;
        KC3 --> L;
        K --> KD["Frequency of Updates (e.g., Hourly, Daily)"]
        K --> KE["Privacy Options (e.g., Show/Hide Board Names)"]
    end

     subgraph UI_Elements["Widget UI Elements"]
        style UI_Elements fill:#EF27,stroke:#007BFF,stroke-width:2px
        K --> UA["Top Bar (Optional/Configurable)"]
        UA --> UA1[Pinterest Logo/Custom Icon];
        UA --> UA2["Minimize Button (iOS 15+)"]
        UA --> UA3["Close Button (X) - Only in Edit Mode"];
        K --> UB[Main Content Area];
        UB --> KA;
        UB --> KB;
        UB --> KC;
        KC --> UC[Preview Image/Content];
        UC --> UC1[Image/Content Display];
        UC --> UC2["Overlay Text (Optional/Configurable)"];
         UC2 --> UC2A[Board Name]
         UC2 --> UC2B[Custom Text]
        K --> UD["Bottom Bar (Optional/Configurable)"]
        UD --> UD1["'Refresh' Icon/Button"];
        K --> UE["Page Indicator Dots (For Carousel)"]
        K --> UF["Accessibility Labels (VoiceOver Support)"]
    end

    subgraph Best_Practices["Design & Development Best Practices"]
        style Best_Practices fill:#FFE3,stroke:#007BFF,stroke-width:2px
        BP1[Follow Apple's Human Interface Guidelines];
        BP2["Optimize for Performance (Memory, Battery)"]
        BP3[Support Dark Mode];
        BP4[Provide Clear Visual Feedback];
        BP5["Ensure Accessibility (VoiceOver, Dynamic Type)"]
        BP6[Handle Errors Gracefully];
        BP7[Use System Fonts and Colors];
        BP8[Thoroughly Test on Different Devices and iOS Versions];
        BP9[Consider User Privacy];
        BP10["Localize Content (if applicable)"]
        Overall_Flow --> BP1 & BP2 & BP3 & BP4 & BP5 & BP6 & BP7 & BP8 & BP9 & BP10;
        Widget_Configuration --> BP1 & BP2 & BP3 & BP4 & BP5 & BP6 & BP7 & BP8 & BP9 & BP10;
        UI_Elements --> BP1 & BP2 & BP3 & BP4 & BP5 & BP6 & BP7 & BP8 & BP9 & BP10;
    end
  
    subgraph Error_Handling_Diagram["Error Handling Diagram"]
        style Error_Handling_Diagram fill:#f6d3,stroke:#007BFF,stroke-width:2px
        EH[Error Occurs] --> EHA{Network Error?}
        EHA -- Yes --> EHANoNetwork
        EHA -- No --> EHBOtherError
        
        EHANoNetwork[No Network Connection] --> EHADisplay
        EHADisplay["Display 'No Network' Message"]
        EHADisplay --> EHARetry
        EHARetry[Retry Button] --> EHARetryAction
        EHARetryAction{Retry Successful?}
        EHARetryAction -- Yes --> EHResumeNormal
        EHARetryAction -- No --> EHADisplay

        EHBOtherError[Other Error] --> EHBDisplay
        EHBDisplay[Display Generic Error Message]
        EHBDisplay --> EHBLog
        EHBLog[Log Error Details]
        EHBLog --> EHResumeNormal[Attempt to Resume or Provide Alternative Content]
    end

    %% linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87 stroke:#333,stroke-width:1px

```

---


Here's the breakdown, organized by the subgraphs in the grand diagram above.

This complete set of diagrams provides a much more granular and digestible view of the iOS widget design workflow. Each diagram focuses on a specific part, making the overall process easier to understand and implement.



---

## 1. Overall Widget Experience

```mermaid
---
title: "Overall Widget Experience"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'themeVariables': {
        'fontFamily': 'Comic Sans MS',
        'fontSize': '20px',
        'primaryColor': '#ffff',
        'primaryTextColor': '#55ff',
        'primaryBorderColor': '#7c2',
        'lineColor': '#F8B229',
        'secondaryColor': '#006100',
        'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A["Home Screen"] --> B("Long Press App Icon/Widget")
    B -- "App Icon" --> C1{"App Context Menu"}
    B -- "Widget" --> C2{"Widget Context Menu"}

    C1 --> C1A["Remove App"]
    C1 --> C1B["Require Face ID/Touch ID"]
    C1 --> C1C["Share App"]
    C1 --> C1D["Edit Home Screen"]
    C1 --> C1E["App-Specific Options<br>(Inbox, Saved, Search, Lens)"]
    C1 --> C1F["App Settings"]

    C2 --> C2A["Edit Widget"]
    C2 --> C2B["Edit Home Screen"]
    C2 --> C2C["Remove Widget"]
    C2 --> C2D["Widget Help/Tutorial"]

    C1D --> D{"Widget Edit Mode<br>(Jiggle Mode)"}
    C2B --> D
    D --> E["'+' Button<br>(Add Widget)"]
    E --> F["Widget Gallery"]
    F --> G("Select Pinterest Widget")
    G --> H["Widget Size Options<br>(Small, Medium, Large, Extra Large)"]
    H --> I("Choose Size & Add")
    I --> J["Widget on Home Screen"]

    C2A --> K["Widget Configuration Screen"]
    K --> L("Choose Board/Topic/Interest")
    L --> M["Widget Displays Selected Content"]

    J --> N["Widget Interaction"]
    N --> O["Deep Link to App Content"]
    style N fill:#FFD7,stroke:#333,stroke-width:1px

    J --> P["Refresh Widget Content"]
    style P fill:#98FB,stroke:#333,stroke-width:1px;

    J --> Q["Error State Handling"]
    Q --> QA["No Network Connection"]
    QA --> QAD["Display 'No Network' Message"]
    QA --> QAU["Retry Button"]
    Q --> QB["Content Unavailable"]
    QB --> QBD["Display 'Content Unavailable' Message"]
    
```


---

## 2. Widget Configuration

```mermaid
---
title: "Detailed Widget Configuration"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    J["Widget on Home Screen"] --> K["Widget Configuration Screen"]
    K --> KA["Title:<br>'Boards/Topics/Interests'"]
    K --> KB["Subtitle:<br>'Get inspired...<br>(Customizable)'"]
    K --> KC["Carousel of Board/Topic Options"]
    KC --> KC1[Preview 1]
    KC --> KC2[Preview 2]
    KC --> KC3[Preview N]
    KC1 --> L("Choose Board/Topic/Interest")
    KC2 --> L
    KC3 --> L
    K --> KD["Frequency of Updates<br>(e.g., Hourly, Daily)"]
    K --> KE["Privacy Options<br>(e.g., Show/Hide Board Names)"]
    L --> M["Widget Displays Selected Content"]

```

---

## 3. Widget UI Elements

```mermaid
---
title: "Widget UI Elements"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    K["Widget Configuration Screen"] --> UA["Top Bar <br>(Optional/Configurable)"]
    UA --> UA1["Pinterest Logo/Custom Icon"]
    UA --> UA2["Minimize Button<br>(iOS 15+)"]
    UA --> UA3["Close Button (X) - Only in Edit Mode"]
    K --> UB["Main Content Area"]
    UB --> KA["Title:<br>'Boards/Topics/Interests'"]
    UB --> KB["Subtitle:<br>'Get inspired... (Customizable)'"]
    UB --> KC["Carousel of Board/Topic Options"]
    KC --> UC["Preview Image/Content"]
    UC --> UC1["Image/Content Display"]
    UC --> UC2["Overlay Text<br>(Optional/Configurable)"]
    UC2 --> UC2A["Board Name"]
    UC2 --> UC2B["Custom Text"]
    K --> UD["Bottom Bar<br>(Optional/Configurable)"]
    UD --> UD1["'Refresh' Icon/Button"]
    K --> UE["Page Indicator Dots<br>(For Carousel)"]
    K --> UF["Accessibility Labels<br>(VoiceOver Support)"]

```


---

## 4. Design & Development Best Practices

```mermaid
---
title: "Design & Development Best Practices"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph TB
    BP1["Follow Apple's Human Interface Guidelines"]
    BP2["Optimize for Performance<br>(Memory, Battery)"]
    BP3["Support Dark Mode"]
    BP4["Provide Clear Visual Feedback"]
    BP5["Ensure Accessibility<br>(VoiceOver, Dynamic Type)"]
    BP6["Handle Errors Gracefully"]
    BP7["Use System Fonts and Colors"]
    BP8["Thoroughly Test on Different Devices and iOS Versions"]
    BP9["Consider User Privacy"]
    BP10["Localize Content<br>(if applicable)"]

```

---

## 5. Error Handling

```mermaid
---
title: "Error Handling Diagram"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    EH["Error Occurs"] --> EHA{"Network Error?"}
    EHA -- Yes --> EHANoNetwork
    EHA -- No --> EHBOtherError
    
    EHANoNetwork["No Network Connection"] --> EHADisplay
    EHADisplay["Display 'No Network' Message"]
    EHADisplay --> EHARetry
    EHARetry["Retry Button"] --> EHARetryAction
    EHARetryAction{"Retry Successful?"}
    EHARetryAction -- Yes --> EHResumeNormal
    EHARetryAction -- No --> EHADisplay

    EHBOtherError["Other Error"] --> EHBDisplay
    EHBDisplay["Display Generic Error Message"]
    EHBDisplay --> EHBLog
    EHBLog["Log Error Details"]
    EHBLog --> EHResumeNormal["Attempt to Resume or Provide Alternative Content"]
    
```

---
## 6. App and Widget Context Menus

This diagram shows the options available in the context menus for both the app icon and the widget.

```mermaid
---
title: "App and Widget Context Menus"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    subgraph AppContextMenu["App Context Menu<br>(Long Press App Icon)"]
        style AppContextMenu fill:#f9c4,stroke:#333,stroke-width:1px
        C1{"App Context Menu"} --> C1A["Remove App"]
        C1 --> C1B["Require Face ID/Touch ID"]
        C1 --> C1C["Share App"]
        C1 --> C1D["Edit Home Screen"]
        C1 --> C1E["App-Specific Options<br>(Inbox, Saved, Search, Lens)"]
        C1 --> C1F["App Settings"]
    end

    subgraph WidgetContextMenu["Widget Context Menu<br>(Long Press Widget)"]
        style WidgetContextMenu fill:#f9f9,stroke:#333,stroke-width:1px
        C2{"Widget Context Menu"} --> C2A["Edit Widget"]
        C2 --> C2B["Edit Home Screen"]
        C2 --> C2C["Remove Widget"]
        C2 --> C2D["Widget Help/Tutorial"]
    end
    
```


---

## 7. Widget Adding and Editing Flow

This diagram focuses specifically on the flow of adding a widget and entering the edit mode.

```mermaid
---
title: "Widget Adding and Editing Flow"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    D{"Widget Edit Mode<br>(Jiggle Mode)"} --> E["'+' Button<br>(Add Widget)"]
    E --> F["Widget Gallery"]
    F --> G("Select Pinterest Widget")
    G --> H["Widget Size Options<br>(Small, Medium, Large, Extra Large)"]
    H --> I("Choose Size & Add")
    I --> J["Widget on Home Screen"]
    J --> K["Widget Configuration Screen"]
    K --> L["Choose Content"]

```

---

## 8. Widget Interaction and Refresh

```mermaid
---
title: "Widget Interaction and Refresh"
author: "Cong Le"
version: "1.1"
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
    "graph": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    J["Widget on Home Screen"] --> N["Widget Interaction"]
    N --> O["Deep Link to App Content"]
    style N fill:#FFD700,stroke:#333,stroke-width:1px;

    J --> P["Refresh Widget Content"]
    style P fill:#98FB98,stroke:#333,stroke-width:1px;

```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---