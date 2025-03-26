---
created: 2025-03-26 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# User Authentication Process
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


## A Diagrammatic Guide 



```mermaid
---
title: "User Authentication Process"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'sequenceDiagram': { 'htmlLabels': false},
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615'
    }
  }
}%%
sequenceDiagram
    autonumber

    Actor Customer as User
  
    box rgb(20, 22, 55) The App System
        participant LoginPage as Log in page
        participant P1 as Log in details storage
        participant P2 as Security Department
    end

    Customer ->>+ LoginPage: Input: Username
    Customer ->>+ LoginPage: Input: Password
    LoginPage ->> P1: Username and password
    P1 ->> P1: Authenticate

    rect rgb(20, 50, 150)
        alt Successful Authentication
            LoginPage ->> LoginPage: Redirect to welcome page
            LoginPage ->> Customer: Log in successful, stand by
        else Failed Authentication
            P1 ->> LoginPage: If rejected
            Customer ->> Customer: I forgot my password...
            LoginPage ->> Customer: Password Hint
            Customer ->> Customer: I still can't remember...
        end
    end

    LoginPage ->> Customer: Do you wish to reset your password
    
    rect rgb(50, 50, 50)
        opt Password Reset Flow
            Customer ->> LoginPage: Yes
            LoginPage ->> P2: New password request
            P2 ->> P2: Validate email address
            P2 ->> Customer: Email sent with a reset link
            Customer ->> P2: Input new password
            P2 ->> P2: Process new password
            P2 ->> P1: Store new password
            P2 ->> P2: Redirect user to log in page
        end
    end
    
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---