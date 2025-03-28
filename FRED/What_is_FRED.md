---
created: 2025-03-27 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: "https://fredhelp.stlouisfed.org/fred/about/about-fred/what-is-fred/"
---



# What is FRED - A Diagrammatic Guide 
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


### 1. FRED: Core Concept

This mind map provides a high-level overview of what FRED is, encompassing its data, tools, and purpose.

```mermaid
---
title: "FRED: Core Concept"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
mindmap
  root((FRED - Federal Reserve Economic Data))
    **Definition**
      Online Database
      Economic Data Time Series (100,000s)
      Multiple Sources (National, Intl, Public, Private)
      Maintained by St. Louis Fed Research
    **Core Purpose**
      Provide Data Access
       Powerful Tools
        Understand Data
        Interact with Data
        Display Data
        Disseminate Data
      Help Users Tell Data Stories
    **Key Components**
      Data Repository
      Analysis & Visualization Tools
      Access Interfaces (Web, API, etc.)
      Archival Data (ALFRED)
```

---

### 2. FRED History & Evolution

This Gantt chart illustrates the key milestones in FRED's development history.

```mermaid
---
title: "FRED History & Evolution"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
gantt
    dateFormat  YYYY
    title FRED Development Timeline
    axisFormat %Y

    section Early Days & Foundation
    Electronic Bulletin Board :crit, eb1, 1991, 2y
    Goes Online (WWW)       :crit, ol1, 1995, 1y
    Organic Growth          :grow, 1996, 10y

    section Major Feature Releases
    ALFRED live             :milestone, done, alf1, 2006, 0d
    FRED Graph              :milestone, done, fg1, 2006, 0d
    Excel Download          :milestone, done, ed1, 2006, 0d
    Unit Transformations    :milestone, done, ut1, 2006, 0d
    Published Data Lists    :milestone, done, pdl1, 2007, 0d
    FRED API Released       :crit, done, api1, 2009, 0d
    Frequency Aggregation   :milestone, done, fa1, 2010, 0d
    Excel Add-in            :milestone, done, exa1, 2011, 0d
    iPhone App              :milestone, done, ios1, 2011, 0d
    Android App             :milestone, done, and1, 2012, 0d
    Growth to 2M+ Users     :grow, 2013, 10y
```

---

### 3. Data Ecosystem: FRED & ALFRED

This flowchart explains the relationship between current data (FRED) and historical revisions (ALFRED).

```mermaid
---
title: "Data Ecosystem: FRED & ALFRED"
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
    subgraph DataLifecycle["Data Lifecycle & Storage"]
        A["Economic Event Occurs"] --> B("Data Producer Reports Initial Value")
        B --> C{"Data Revision Issued?"}
        C -- No --> D["Data Remains in FRED as Latest Vintage"]
        C -- Yes --> E["Previous Vintage Archived in ALFRED"]
        E --> F["New Value Becomes Latest Vintage in FRED"]
        D --> G(("FRED Database - Current Vintage"))
        F --> G
        E --> H(("ALFRED Database - All Vintages"))
    end

    subgraph UserAccess["User Access"]
        I["User / Researcher"] --> G
        I --> H
        G --> J{"Use Case: Current Analysis"}
        H --> K{"Use Cases: <br>- Replicate Past Research<br>- Train Models<br>- Access Point-in-Time Data"}
    end
```

---

### 4. Data Access Methods

This mind map shows the various ways users can access FRED data.

```mermaid
---
title: "Data Access Methods"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
mindmap
  root((FRED Data Access))
    **Primary Access**
      FRED Website
        Search (Keywords)
        Browse
          By Source
          By Release
          By Category (Traditional)
          By Tags (Evolving, Flexible)
          By Latest Update
    **Programmatic & Tools**
      FRED API
        Foundation for other tools
        Developer Access
      Microsoft Excel Add-in
        Search, Download, Update
        Graphing, Transformations
        Inside Excel
      Mobile Apps
        iOS (iPhone)
        Android
      Mobile Website
        Alternative for other devices
    **Third-Party Integrations**
      Statistical Software Wrappers
        R
        STATA
        MatLAB
        RATS
        EViews
      Educational Platforms
        Pearson MyEconLab
```

----

### 5. FRED Website: Browsing Structure

This flowchart details the different ways a user can browse data on the FRED website.

```mermaid
---
title: "FRED Website: Browsing Structure"
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
    A["Visit FRED Website"] --> B{"Choose Access Method"}
    B -- Search --> C["Enter Search Terms"]
    B -- Browse --> D{"Select Browse Method"}
    D --> E["By Source<br>(Producer)"]
    D --> F["By Release<br>(Publication)"]
    D --> G["By Category<br>(Topic - Less Scalable)"]
    D --> H["By Tags<br>(Metadata - Flexible)"]
    D --> I["By Latest Update"]

    C --> Z["View Search Results / Data Series"]
    E --> Z
    F --> Z
    G --> Z
    H --> Z
    I --> Z
    
```

---

### 6. FRED Tools for Data Interaction

This mind map outlines the key tools available within FRED for working with the data.

```mermaid
---
title: "FRED Tools for Data Interaction"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
mindmap
  root((FRED Tools))
    **Visualization**
      Charting
        Line Chart (Trends)
          Customizable (Fonts, Colors, etc.)
        Bar Chart (Comparisons)
        Pie Chart (Proportions)
        Scatter Plot (Relationships)
      Geographic Mapping (GeoFRED)
        State Level
        MSA Level
        County Level
    **Data Manipulation**
      Formulas / Calculations
        Combine Multiple Series
        Create Custom Series (e.g., Yield Spread, Taylor Rule)
        Mathematical Operations (+, -, *, /)
      Unit Transformations
        Level (Original)
        Change
        Percent Change
        Percent Change from Year Ago
        Compounded Annual Rate of Change
        Index (Value=100 for chosen date)
        _...and others_
      Frequency Aggregation
        Convert High Frequency to Low Frequency
          e.g., Monthly to Quarterly
          e.g., Daily to Monthly
        Methods: Average, Sum, End of Period
    **Export & Download**
        Excel Format
        CSV Format
        Image (PNG, etc.)
        PDF
```

----

### 7. Example Data Workflow: Creating a Spread

This flowchart illustrates a typical workflow for creating a custom series like a yield spread using FRED tools.

```mermaid
---
title: "Example Data Workflow: Creating a Spread"
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
    A["Start on FRED Website/App"] --> B["Search & Select Series 1<br>(e.g., 10-Year Treasury Rate)"]
    B --> C["Add Series 2 to Chart<br>(e.g., AAA Corporate Bond Rate)"]
    C --> D["Apply Formula:<br>'Series 2 - Series 1'"]
    D --> E["Customize Chart Appearance<br>(Optional: Title, Colors, Axis)"]
    E --> F{"View or Use the Result"}
    F --> G["View Spread on Chart"]
    F --> H["Download Chart Image"]
    F --> I["Download Spread Data<br>(Excel/CSV)"]
    
```

---

### 8. User Assistance

A simple flowchart showing the help resources available.

```mermaid
---
title: "User Assistance"
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
    A[User Encounters Difficulty/Question] --> B{Check Series Notes}
    B -- Found Answer --> C[Understanding Gained]
    B -- Need More Help --> D[Contact FRED Support Staff]
    D --> C
    A --> D
    
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---