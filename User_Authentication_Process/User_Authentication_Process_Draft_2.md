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


This document now includes a more detailed look at user authentication and security.



### 1. Enhanced Login Process with Security Considerations

The following sequence diagram expands on the initial login flow by incorporating some of the security measures discussed earlier.

```mermaid
---
title: "Enhanced Login Process with Security Considerations"
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
    'fontFamily': 'Fantasy',
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
    
    Actor User
    
    box rgb(20, 22, 55) The App System
        participant LoginPage
        participant AuthenticationService
        participant PasswordDatabase
        participant RateLimiter
        participant SessionStore
    end

    participant Browser

    User ->> LoginPage: Input: Username
    User ->> LoginPage: Input: Password
    LoginPage ->> RateLimiter: Check Login Attempts<br>(Username/IP)
    
    rect rgb(20, 50, 150)
        alt Exceeds Rate Limit
            rect rgb(100, 50, 150)
                RateLimiter -->> LoginPage: Blocked
                LoginPage ->> User: Too many failed attempts, try again later
            end
        else Within Limit
            rect rgb(220, 50, 150)
                LoginPage ->> AuthenticationService: Authenticate<br>(Username, Password)
                AuthenticationService ->> PasswordDatabase: Get Salt and Password Hash
                PasswordDatabase -->> AuthenticationService: Salt and Hash
                AuthenticationService ->> AuthenticationService: Compare Hash(Password + Salt)
                rect rgb(120, 50, 150)
                    alt Successful Authentication
                        rect rgb(20, 50, 150)
                            AuthenticationService ->> SessionStore: Create Session
                            SessionStore -->> AuthenticationService: Session ID
                            AuthenticationService -->> LoginPage: Authentication Success, Session ID
                            LoginPage ->> Browser: Set Session Cookie
                            LoginPage ->> User: Redirect to welcome page
                        end
                    else Failed Authentication
                        rect rgb(20, 50, 150)
                            AuthenticationService -->> LoginPage: Authentication Failure
                            LoginPage ->> RateLimiter: Increment Failed Attempts<br>(Username/IP)
                            LoginPage ->> User: Invalid username or password
                        end
                    end
                end
            end
        end
    end
  
```

**Explanation:** This updated login process now explicitly includes a `RateLimiter` to prevent brute-force attacks. It also clarifies that the `AuthenticationService` retrieves the salt and hashed password from the `PasswordDatabase` to perform a secure comparison. Upon successful authentication, a session is created and a session ID is managed via a `SessionStore`.

---

### 2. Two-Factor Authentication (2FA) Integration

This sequence diagram shows how 2FA can be integrated into the login process for enhanced security.

```mermaid
---
title: "Two-Factor Authentication (2FA) Integration"
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
    'fontFamily': 'Fantasy',
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

    Actor User
    
    box rgb(20, 22, 55) The App System
        participant LoginPage
        participant AuthenticationService
        participant PasswordDatabase
        participant SecondFactorService
        participant SessionStore
    end

    participant Browser

    User ->> LoginPage: Input: Username
    User ->> LoginPage: Input: Password
    LoginPage ->> AuthenticationService: Authenticate<br>(Username, Password)
    AuthenticationService ->> PasswordDatabase: Get Salt and Password Hash
    PasswordDatabase -->> AuthenticationService: Salt and Hash
    AuthenticationService ->> AuthenticationService: Compare Hash(Password + Salt)
    
    rect rgb(20, 50, 150)
        alt Successful Password Authentication
            rect rgb(100, 50, 150)
            AuthenticationService ->> SecondFactorService: Initiate 2FA for User
            SecondFactorService ->> User: Send Verification Code<br>(e.g., OTP)
            User ->> LoginPage: Input: Verification Code
            LoginPage ->> SecondFactorService: Validate Verification Code
            rect rgb(120, 50, 150)
                    alt Valid Code
                        rect rgb(50, 50, 150)
                            SecondFactorService -->> LoginPage: Code Valid
                            LoginPage ->> AuthenticationService: Create Session
                            SessionStore -->> AuthenticationService: Session ID
                            AuthenticationService -->> LoginPage: Authentication Success, Session ID
                            LoginPage ->> Browser: Set Session Cookie
                            LoginPage ->> User: Redirect to welcome page
                        end
                    else Invalid Code
                        rect rgb(50, 50, 150)
                            SecondFactorService -->> LoginPage: Code Invalid
                            LoginPage ->> User: Incorrect verification code
                        end
                    end
                end
            end
        else Failed Password Authentication
            rect rgb(150, 100, 250)
                AuthenticationService -->> LoginPage: Authentication Failure
                LoginPage ->> User: Invalid username or password
            end
        end
    end
    
```




**Explanation:** After the initial password authentication is successful, the user is prompted for a second factor of authentication, managed by the `SecondFactorService`. Only after the successful validation of this second factor is a session created.

---

### 3. Password Reset Flow with Email Verification

The password reset flow now includes a clearer step for email verification.

```mermaid
---
title: "Password Reset Flow with Email Verification"
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
    'fontFamily': 'Fantasy',
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

    Actor User
    
    box rgb(20, 22, 55) The App System
        participant LoginPage
        participant PasswordResetService
        participant UserDatabase
        participant EmailService
    end

    participant EmailClient


    User ->> LoginPage: Click "Forgot Password"
    LoginPage ->> User: Input Email Address
    User ->> LoginPage: Submit Email Address
    LoginPage ->> PasswordResetService: Initiate Password Reset<br>(Email)
    PasswordResetService ->> UserDatabase: Retrieve User by Email
    
    rect rgb(20, 50, 150)
        alt Email Found
            rect rgb(100, 50, 150)
                PasswordResetService ->> PasswordResetService: Generate Unique Reset Token
                PasswordResetService ->> UserDatabase: Store Reset Token and Timestamp
                PasswordResetService ->> EmailService: Send Password Reset Email<br>(with Link)
                EmailService ->> User: Email Sent
                User ->> EmailClient: Click Reset Link
                EmailClient ->> PasswordResetService: Validate Reset Token<br>(via Link)
                rect rgb(120, 50, 150)
                    alt Valid Token and Not Expired
                        PasswordResetService ->> LoginPage: Display New Password Form
                        User ->> LoginPage: Input New Password
                        User ->> LoginPage: Confirm New Password
                        LoginPage ->> PasswordResetService: Update Password<br>(User ID, New Password)
                        PasswordResetService ->> UserDatabase: Update Password Hash and Salt
                        PasswordResetService -->> LoginPage: Password Reset Successful, Redirect to Login
                        LoginPage ->> User: Password reset successful, please log in
                    else Invalid or Expired Token
                        PasswordResetService -->> LoginPage: Display Error Message
                        LoginPage ->> User: Invalid or expired password reset link
                    end
                end
            end
        else Email Not Found
            rect rgb(150, 50, 150)
                PasswordResetService -->> LoginPage: Display Error Message<br>(Generic)
                LoginPage ->> User: If email exists, a reset link will be sent
            end
        end
    end
  
```


**Explanation:** This refined password reset flow ensures that a unique, time-sensitive token is generated and sent to the user's email address for verification before they can set a new password.


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---