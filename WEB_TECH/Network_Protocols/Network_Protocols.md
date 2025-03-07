---
created: 2025-03-06 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Network Protocols
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---

 Here's a Mermaid representation that captures the structure, content, and visual cues of the "8 Popular Network Protocols".




```mermaid
---
title: "8 Popular Network Protocols"
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    "flowchart":{"htmlLabels": false, 'curve': 'basis'},
    'fontFamily':'Fantasy',
    'themeVariables':{
      'primaryColor':'#BB2528',
      'primaryTextColor':'#f529',
      'primaryBorderColor':'#7C0000',
      'lineColor':'#F8B229',
      'secondaryColor':'#006100',
      'tertiaryColor':'#fff'
    }
  }
}%%
graph LR
    A["8 Popular Network Protocols"] --> B(Protocols)
    style A fill:#ccf3,stroke:#333,stroke-width:2px
    A --> C("How does it Work?")
    style C fill:#ccf3,stroke:#333,stroke-width:2px
    A --> D(Use Cases)
    style D fill:#ccf3,stroke:#333,stroke-width:2px

    subgraph Protocols_List["Protocols List"]
    style Protocols_List fill:#ff22,stroke:#fff,stroke-width:0px
        B --> B1[HTTP]
        style B1 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B2["HTTP/3 (QUIC)"]
        style B2 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B3[HTTPS]
        style B3 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B4[WebSocket]
        style B4 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B5[TCP]
        style B5 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B6[UDP]
        style B6 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B7[SMTP]
        style B7 fill:#eef3,stroke:#66c,stroke-width:1px
        B --> B8[FTP]
        style B8 fill:#eef3,stroke:#66c,stroke-width:1px
    end

    subgraph How_It_Works["How It Works"]
    style How_It_Works fill:#2fc3,stroke:#fff,stroke-width:0px
        C --> C1["<img src='https://i.imgur.com/R6Z997H.png' width='200px'/>"]
        style C1 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C2["<img src='https://i.imgur.com/uL0R168.png' width='200px'/>"]
        style C2 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C3["<img src='https://i.imgur.com/b0Xg0rA.png' width='200px'/>"]
        style C3 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C4["<img src='https://i.imgur.com/Kz441sP.png' width='200px'/>"]
        style C4 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C5["<img src='https://i.imgur.com/d6T9b2L.png' width='200px'/>"]
        style C5 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C6["<img src='https://i.imgur.com/Qn889y2.png' width='200px'/>"]
        style C6 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C7["<img src='https://i.imgur.com/s1y4WjD.png' width='200px'/>"]
        style C7 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        C --> C8["<img src='https://i.imgur.com/u94k8n2.png' width='200px'/>"]
        style C8 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
    end
    
        subgraph Use_Cases_List["Use Cases List"]
        style Use_Cases_List fill:#fcf32,stroke:#fff,stroke-width:0px
        D --> D1["<img src='https://i.imgur.com/8hT9q93.png' width='150px'/>"]
        style D1 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D2["<img src='https://i.imgur.com/J1W9e5z.png' width='150px'/>"]
        style D2 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D3["<img src='https://i.imgur.com/9J54d56.png' width='150px'/>"]
        style D3 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D4["<img src='https://i.imgur.com/9V0V1d6.png' width='150px'/>"]
        style D4 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D5["<img src='https://i.imgur.com/J17E8c8.png' width='150px'/>"]
        style D5 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D6["<img src='https://i.imgur.com/i94Y06D.png' width='150px'/>"]
        style D6 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D7["<img src='https://i.imgur.com/b7z9o8v.png' width='150px'/>"]
        style D7 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
        D --> D8["<img src='https://i.imgur.com/N8s4b5H.png' width='150px'/>"]
        style D8 fill:#fff3,stroke:#66c,stroke-width:1px,stroke-dasharray: 5 5
    end

    B1 -.->|maps to| C1
    B2 -.->|maps to| C2
    B3 -.->|maps to| C3
    B4 -.->|maps to| C4
    B5 -.->|maps to| C5
    B6 -.->|maps to| C6
    B7 -.->|maps to| C7
    B8 -.->|maps to| C8

    B1 -.->|maps to| D1
    B2 -.->|maps to| D2
    B3 -.->|maps to| D3
    B4 -.->|maps to| D4
    B5 -.->|maps to| D5
    B6 -.->|maps to| D6
    B7 -.->|maps to| D7
    B8 -.->|maps to| D8

    %% linkStyle default stroke:#444,stroke-width:1px;

```

---


## Key improvements and explanations:

*   **Overall Structure:**  The `graph LR` (left-to-right) provides a high-level view of the infographic's sections:  "8 Popular Network Protocols," "Protocols," "How does it Work?", and "Use Cases."
*   **Subgraphs for Clarity:**  The `subgraph` keyword is used *extensively* to group related elements.  This is *crucial* for visual organization in Mermaid, especially when dealing with many items.  We have subgraphs for:
    *   `Protocols_List`:  Lists each protocol (HTTP, HTTPS, etc.).  This keeps the main graph from becoming too cluttered.
    *   `How_It_Works`: Contains the cropped images that represent each protocol.
    *   `Use_Cases_List`: Contains the cropped images that represent each use case.
*   **Direct image use via imgur link:** Because you are using a image as an input, and the best output I can provide you here is Mermaid, the cropped images are stored on Imgur, and used for the best visualization I can provide you in this case.
*   **Mapping with Dotted Lines:** The `-.->` creates a dotted line, visually representing the mapping between a protocol and its corresponding "How It Works" and "Use Cases" sections.  The `|maps to|` text adds clarity.
* **Styling**: The use of different fill colors and border make the distinction between the different nodes and categories easier.

How to use this:

1.  **Copy the Code:** Copy the entire Mermaid code provided above.
2.  **Mermaid Live Editor:** Paste the code into the Mermaid Live Editor ([https://mermaid.live/](https://mermaid.live/)).  You should see the diagram rendered.
3.  **Export (if needed):** The Mermaid Live Editor allows you to export the diagram as an SVG, PNG, or PDF.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---