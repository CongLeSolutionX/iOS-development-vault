---
created: 2025-03-20 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Best Practices for Hardened Runtime
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


The diagrams below provide a practical guide for developers to incorporate Hardened Runtime into their workflow, from planning and development to testing, debugging, and deployment.  They cover key considerations and best practices for building secure and robust macOS applications.


Here's a breakdown of the diagrams:

1.  **Hardened Runtime Development Workflow:** A high-level overview of the steps involved in incorporating Hardened Runtime.
2.  **Entitlement Selection Process:** A decision-making flowchart for choosing the right entitlements.
3.  **Testing with Hardened Runtime:**  A diagram outlining different testing strategies.
4.  **Debugging Hardened Runtime Issues:** A flowchart for troubleshooting common problems.
5.  **Continuous Integration and Hardened Runtime:** Integrating Hardened Runtime checks into a CI/CD pipeline.
6.  **App Review and Hardened Runtime:** Considerations for preparing for App Review or notarization.

---

## 1. Hardened Runtime Development Workflow

```mermaid
---
title: "Hardened Runtime Development Workflow"
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
    A[Start] --> B[Plan Application Features]
    B --> C{Identify Required Resources}
    C -- Audio, Camera, Location, etc. --> D[Determine Necessary Entitlements]
    D --> E[Enable Hardened Runtime in Xcode]
    E --> F[Configure Entitlements]
    F --> G["Write Usage Descriptions<br>(Info.plist)"]
    G --> H[Develop and Test Locally]
    H --> I{Test with Hardened Runtime Enabled}
    I -- Issues Found --> J[Debug and Refactor]
    J --> F
    I -- No Issues --> K[Prepare for Distribution]
    K --> L["Code Sign and Notarize<br>(macOS)"]
    L --> M["Submit to App Store<br>(if applicable)"]
    M --> N[App Review]
    N -- Approved --> O[Release]
    N -- Rejected --> P[Address Feedback]
    P --> F
    
```


**Explanation:**

*   This diagram outlines the overall workflow, from initial planning to app release.
*   It highlights key steps: identifying required resources, determining entitlements, enabling Hardened Runtime, configuring settings, writing usage descriptions, testing, debugging, and preparing for distribution (including notarization for macOS).
*   It shows the iterative nature of development, with feedback loops for debugging and addressing App Review issues.

---

## 2. Entitlement Selection Process

```mermaid
---
title: "Entitlement Selection Process"
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
graph TD
    A[Start] --> B{Does the app need X?}
    B -- Yes --> C[Identify Entitlement for X]
    B -- No --> D{Is there a less privileged alternative?}
    D -- Yes --> E[Use Alternative]
    D -- No --> F[Justify Entitlement]
    C --> F
    F --> G{Is the entitlement absolutely necessary?}
    G -- Yes --> H[Add Entitlement to Project]
    G -- No --> B
    H --> I[Document Rationale]
    I --> J[End]
    E --> J

    B -- "X = Resource Access<br>(e.g., Camera)" --> C
    B -- "X = Runtime Exception<br>(e.g., JIT)" --> C
    
```


**Explanation:**

*   This flowchart helps developers make informed decisions about which entitlements to include.
*   It emphasizes the principle of least privilege: only request the entitlements that are absolutely necessary.
*   It encourages considering less privileged alternatives before requesting a potentially risky entitlement.
*   It highlights the importance of documenting the rationale for each entitlement.

---

## 3. Testing with Hardened Runtime

```mermaid
---
title: "Testing with Hardened Runtime"
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
    'graph':{'htmlLabels': true, 'curve': 'natural'},
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
    A[Development Build] --> B[Enable Hardened Runtime]
    B --> C[Unit Tests]
    C --> D[UI Tests]
    D --> E[Integration Tests]
    E --> F[Manual Testing]
    F --> G[Test on Different Devices/OS Versions]
    G --> H[Specific Hardened Runtime Tests]
    H --> I[Check Resource Access]
    H --> J[Verify Entitlement Behavior]
    H --> K[Test with/without Entitlements]
    I --> L[User Permission Prompts]
    J --> M[Expected Restrictions]
    K --> N[Identify Issues]
    N --> O[Debug and Fix]
    O --> B
    
```


**Explanation:**

*   This diagram outlines a comprehensive testing strategy for Hardened Runtime.
*   It includes standard testing practices (unit, UI, integration, manual) as well as tests specifically focused on Hardened Runtime behavior.
*   It emphasizes testing resource access, verifying entitlement behavior, and testing with and without certain entitlements to identify potential issues.

---

## 4. Debugging Hardened Runtime Issues

```mermaid
---
title: "Debugging Hardened Runtime Issues"
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
    'graph':{'htmlLabels': false, 'curve': 'natural'},
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
graph TD
    A[App Crash/Unexpected Behavior] --> B{Is Hardened Runtime enabled?}
    B -- No --> C[Debug as usual]
    B -- Yes --> D[Check Console Logs]
    D --> E[Look for Entitlement Errors]
    E -- Error Found --> F{Missing or Incorrect Entitlement?}
    F -- Yes --> G[Add/Correct Entitlement]
    F -- No --> H[Review Code for Issues]
    E -- No Error --> H
    G --> I[Retest]
    H --> J["Use Debugger<br>(with Debugging Tool entitlement)"]
    J --> K[Step Through Code]
    K --> L[Identify Root Cause]
    L --> M[Implement Fix]
    M --> I
    I --> N{Problem Solved?}
    N -- Yes --> O[End]
    N -- No --> J
    C --> N
    
```



**Explanation:**

*   This flowchart provides a structured approach to debugging issues that may be related to Hardened Runtime.
*   It starts by checking console logs for entitlement errors.
*   It guides the developer through checking for missing or incorrect entitlements, reviewing code, and using the debugger.
*   It emphasizes the iterative nature of debugging, with retesting after each fix.

---

## 5. Continuous Integration and Hardened Runtime

```mermaid
---
title: "Continuous Integration and Hardened Runtime"
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
    'graph':{'htmlLabels': false, 'curve': 'natural'},
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
    A[Code Commit] --> B[Trigger CI Pipeline]
    B --> C[Build Application]
    C --> D[Enable Hardened Runtime]
    D --> E[Run Automated Tests]
    E --> F[Unit Tests]
    E --> G[UI Tests]
    E --> H[Integration Tests]
    E --> I[Hardened Runtime Specific Tests]
    F --> J{Test Results}
    G --> J
    H --> J
    I --> J
    J -- Pass --> K[Code Signing]
    K --> L["Notarization<br>(macOS)"]
    L --> M[Deploy to Test Environment]
    J -- Fail --> N[Notify Developers]
    N --> O[Fix Issues]
    O --> A
    
```


**Explanation:**

*   This diagram shows how to integrate Hardened Runtime checks into a Continuous Integration/Continuous Delivery (CI/CD) pipeline.
*   It ensures that Hardened Runtime is enabled during the build process and that automated tests (including Hardened Runtime-specific tests) are run.
*   It automates code signing and notarization (for macOS).
*   It includes a feedback loop for notifying developers of test failures.

---

## 6. App Review and Hardened Runtime

```mermaid
---
title: "App Review and Hardened Runtime"
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
    A[Prepare for Submission] --> B[Verify Entitlements]
    B --> C{Are all entitlements justified?}
    C -- Yes --> D[Review Usage Descriptions]
    C -- No --> E[Remove Unnecessary Entitlements]
    E --> B
    D --> F{Are descriptions clear and accurate?}
    F -- Yes --> G[Test Thoroughly]
    F -- No --> H[Update Descriptions]
    H --> D
    G --> I[Submit to App Store]
    I --> J[App Review]
    J -- Approved --> K[Release]
    J -- Rejected --> L{Reason for Rejection?}
    L -- Hardened Runtime Issue --> M[Address Entitlement/Description Issue]
    M --> B
    L -- Other Issue --> N[Address Other Issue]
    N --> I

```

**Explanation:**

*   This diagram outlines the steps to take when preparing an app for App Review (or notarization) with Hardened Runtime enabled.
*   It emphasizes verifying that all entitlements are justified and that usage descriptions are clear and accurate.
*   It shows how to handle potential rejections related to Hardened Runtime issues.



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
