---
created: 2025-03-20 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Hardened Runtime
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


The diagrams below provide a comprehensive visual overview of the Hardened Runtime concepts, covering its purpose, exceptions, resource access, configuration, and relationship to notarization and security best practices. They should aid in understanding and remembering these important security features.


I'll break this down into several diagrams to cover different aspects:

1.  **Hardened Runtime Overview:** A high-level view of the Hardened Runtime and its purpose.
2.  **Runtime Exceptions:** A diagram showing the different runtime exceptions and their relationships.
3.  **Resource Access:** A diagram illustrating the various resource access options and their associated privacy considerations.
4.  **Entitlements and Info.plist:** A diagram showing how entitlements and `Info.plist` usage descriptions relate to Hardened Runtime.
5.  **Hardened Runtime and Notarization:** Connect Hardened Runtime to the macOS notarization process.
6. **Security Tradeoffs:** Hardened runtime capabilities tradeoffs.

---

## 1. Hardened Runtime Overview

```mermaid
---
title: "Hardened Runtime Overview"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart':{'htmlLabels': false, 'curve': 'basis'},
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
    subgraph Hardened_Runtime["Hardened Runtime"]
        A[Application] --> B(Restricted Capabilities)
        B --> C{Security}
        B --> D{Flexibility}
        C -- Increased --> E[Reduced Attack Surface]
        D -- Reduced --> E
        style Hardened_Runtime fill:#ccf3,stroke:#333,stroke-width:2px
    end

    F[Vulnerability] --> A
    F -- Mitigated by --> Hardened_Runtime
    G[User Data] --> A
    G -- Protected by --> Hardened_Runtime
    H[Malicious Code] -.-> A
    H -- Blocked by --> Hardened_Runtime

```


**Explanation:**

*   This diagram shows the core concept of the Hardened Runtime: it restricts an application's capabilities, increasing security and reducing the attack surface, but at the cost of some flexibility.
*   Vulnerabilities and malicious code attempts are mitigated/blocked by the Hardened Runtime.
*   User data is protected.

---

## 2. Runtime Exceptions

```mermaid
---
title: "Runtime Exceptions"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart':{'htmlLabels': false, 'curve': 'basis'},
    'fontFamily': 'Comic Sans MS',
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
    subgraph Runtime_Exceptions["Runtime Exceptions<br>(Entitlements)"]
    style Runtime_Exceptions fill:#fcf3,stroke:#333,stroke-width:2px
        A[Hardened Runtime] --> B(Default Restrictions)
        B --> C[Allow JIT]:::exception
        B --> D[Allow Unsigned Memory]:::exception
        B --> E[Allow DYLD Vars]:::exception
        B --> F[Disable Library Validation]:::exception
        B --> G[Disable Exec. Mem. Prot.]:::exception
        B --> H[Debugging Tool]:::exception
        C --> C1[JavaScriptCore]
        D --> D1[Legacy Apps]
        E --> E1[Debugging]
        F --> F1[Third-Party Plugins]
        G --> G1[Legacy Apps - High Risk]
        H --> H1[Xcode Debugger]

    end
    classDef exception fill:#fcf2,stroke-width:0.5px
    
```


**Explanation:**

*   The Hardened Runtime starts with default restrictions.
*   Each exception (represented by nodes with the `exception` class) relaxes a specific restriction.
*   The diagram shows the typical use case for each exception.  The red fill indicates higher risk exceptions.

---

## 3. Resource Access

```mermaid
---
title: "Resource Access"
author: "Cong Le"
version: "1.0"
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
    'graph':{'htmlLabels': false, 'curve': 'basis'},
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
    subgraph Resource_Access["Resource Access<br>(Entitlements)"]
    style Resource_Access fill:#cfc2,stroke:#333,stroke-width:2px
        A[Application] --> B(User Permission Prompt)
        B --> C[Audio Input]:::resource
        B --> D[Camera]:::resource
        B --> E[Location]:::resource
        B --> F[Contacts]:::resource
        B --> G[Calendar]:::resource
        B --> H[Photos Library]:::resource
        B --> I[Apple Events]:::resource
        C --> C1[AVFoundation, CoreAudio]
        D --> D1[AVFoundation, Vision]
        E --> E1[CoreLocation]
        F --> F1[Contacts]
        G --> G1[EventKit]
        H --> H1[Photos, PhotosUI]
        I --> I1[NSAppleEventDescriptor]

        J((User Data & Privacy))
        C -- Accesses --> J
        D -- Accesses --> J
        E -- Accesses --> J
        F -- Accesses --> J
        G -- Accesses --> J
        H -- Accesses --> J
        I -- Controls --> K((Other Apps))

    end

    classDef resource fill:#ccf2,stroke:#333,stroke-width:1px
    
```


**Explanation:**

*   Accessing resources requires user permission (triggered by the system).
*   The diagram lists the relevant frameworks for each resource.
*   It highlights the privacy implications of accessing user data.
*   Apple Events are slightly different as they control *other* apps.

---

## 4. Entitlements and Info.plist

```mermaid
---
title: "Entitlements and Info.plist"
author: "Cong Le"
version: "1.0"
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
    'graph':{'htmlLabels': false, 'curve': 'basis'},
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
    A[Developer] --> B(Xcode Project)
    B --> C[Hardened Runtime Settings]
    C --> D[Entitlements File]
    D --> E((Runtime Exceptions))
    D --> F((Resource Access))
    B --> G[Info.plist]
    F --> G
    G --> H[Usage Description Strings]
    H --> I[User Permission Prompt]
    E -- Enables --> J[App Capabilities]
    F -- Enables --> J
    
```


**Explanation:**

*   This shows the relationship between the developer's actions (in Xcode), the entitlements file, the `Info.plist`, and how they ultimately lead to the app's capabilities and user permission prompts.
*   The entitlements file specifies which exceptions and resource access the app needs.
*   The `Info.plist` contains the usage description strings that explain *why* the app needs access.
*   These combine to trigger the user permission prompt at runtime.

---

## 5. Hardened Runtime and Notarization

```mermaid
---
title: "Hardened Runtime and Notarization"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart':{'htmlLabels': false, 'curve': 'basis'},
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
    A[Developer] --> B(Builds App)
    B --> C[Code Signing]
    C --> D{Hardened Runtime Enabled?}
    D -- Yes --> E[Entitlements Configured]
    E --> F[Submit for Notarization]
    D -- No --> G[Notarization Required for Distribution]
    F --> H[Apple Notary Service]
    H -- Success --> I[Notarized App]
    H -- Failure --> J[Review Issues]
    I --> K[Distribution]
    J --> E
    G --> K

```


**Explanation:**

*   This diagram shows the workflow for notarizing a macOS app.
*   Hardened Runtime is a *requirement* for notarization.
*   The diagram shows the steps, including code signing, enabling Hardened Runtime, configuring entitlements, submitting to Apple's Notary Service, and handling success/failure.

---

## 6. Security Tradeoffs

```mermaid
---
title: "Security Tradeoffs"
author: "Cong Le"
version: "1.0"
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
    'flowchart':{'htmlLabels': false, 'curve': 'natural'},
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
    subgraph Hardened_Runtime_Tradeoffs["Hardened Runtime Tradeoffs"]
    style Hardened_Runtime_Tradeoffs fill:#ccc3,stroke:#333,stroke-width:2px
        A[Security] <--> B[Flexibility/Compatibility]
        A -- Increased by --> C[Default Restrictions]
        B -- Reduced by --> C
        C -- Relaxed by --> D[Runtime Exceptions]
        A -- Decreased by --> D
        B -- Increased by --> D
        
        E[Principle of Least Privilege] --> F(Minimize Exceptions)
        F -- Leads to --> A
        F -- May Reduce --> B

        G[Legacy Code/Frameworks] --> H(May Require Exceptions)
        H -- May Reduce --> A

    end
    
```


**Explanation:**

* This diagram visually presents the core trade-off between security and flexibility/compatibility when using the Hardened Runtime.
* It emphasizes the "Principle of Least Privilege" - minimizing exceptions to maximize security.
* It also acknowledges that legacy code or frameworks might necessitate exceptions, potentially reducing security.


----



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---