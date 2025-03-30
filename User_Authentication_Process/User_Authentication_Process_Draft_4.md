---
created: 2025-03-30 05:31:26
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


Here's an optimized version incorporating further details, clarifications, and current best practices, while aiming to maintain the clarity of the original diagram:

***

## Optimized Documentation of Authentication and Security Concepts

This documentation refines and expands upon the previous version to provide a more comprehensive view of user authentication and security, reflecting current industry standards and addressing potential nuances.

The core login and password reset flows remain central, visualized through the sequence diagram. Enhancements include more precise terminology, added security checks, and expanded explanations referencing both the main diagram and associated security principles.

```mermaid
---
title: "Optimized Documentation: Enhanced Authentication and Security Flows"
author: "Cong Le"
version: "1.1"
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
    'sequenceDiagram': { 'htmlLabels': false, 'messageAlign': 'center' },
    'fontFamily': 'Arial, Helvetica, sans-serif', // Using a more standard font
    'themeVariables': {
      'primaryColor': '#E6F0FA', // Lighter blue background
      'primaryTextColor': '#1A1A1A', // Darker text
      'primaryBorderColor': '#B0C4DE', // Softer border
      'lineColor': '#4682B4', // Steel blue lines
      'secondaryColor': '#F5F5F5', // Light grey for alt blocks
      'tertiaryColor': '#FFF8DC' // Cornsilk for notes
    }
  }
}%%
sequenceDiagram
    autonumber

    Actor User
    participant Browser

    box rgb(230, 240, 250) The App System - Primary Flow
        participant LoginPage as UI / Frontend
        participant RateLimiter as Request Throttling
        participant AuthenticationService as Auth Service
        participant PasswordStorage as Password DB<br>(Hashed + Salted)
        participant SessionManager as Session Store
        participant SecurityService as Security Ops
        participant EmailService as Notification Service
    end

    %% Login Flow %%
    Note over User, LoginPage: User initiates Login via Browser

    User ->> Browser: Navigate to Login Page
    Browser ->> LoginPage: Request Login Page
    LoginPage -->> Browser: Render Login Form
    User ->> Browser: Input Username
    User ->> Browser: Input Password (over HTTPS)
    Browser ->>+ LoginPage: Submit Credentials

    Note over LoginPage, RateLimiter: Input Validation & Sanitization performed by LoginPage/Backend API

    LoginPage ->> RateLimiter: Check Login Attempt Rate<br>(Username/IP/Fingerprint)
    Note right of RateLimiter: CAPTCHA challenge might be triggered here based on risk score or attempt frequency.

    rect rgba(200, 220, 240, 0.8)
        alt Excessive Attempts Detected
            RateLimiter -->> LoginPage: Block Request (HTTP 429)
            LoginPage -->> Browser: Display Error: Account Temporarily Locked<br>or "Too Many Attempts"
            Browser -->> User: Show Error Message
        else Attempts Allowed
            LoginPage ->> AuthenticationService: Authenticate User (Username)
            AuthenticationService ->> PasswordStorage: Retrieve Salt & Hash for User
            PasswordStorage -->> AuthenticationService: User Salt & Stored Password Hash

            AuthenticationService ->> AuthenticationService: Compute Hash(Input Password + Salt)
            AuthenticationService ->> AuthenticationService: Securely Compare Computed Hash vs Stored Hash<br>(Use constant-time comparison)

            alt Authentication Successful
                PasswordStorage -->> AuthenticationService: Result: Success
                AuthenticationService ->> SessionManager: Create New Secure Session
                SessionManager -->> AuthenticationService: Session ID / Token
                note right of SessionManager: Session stored server-side (e.g., Redis, DB)
                AuthenticationService -->> LoginPage: Authentication Success + Session Token
                LoginPage ->> Browser: Set Session Cookie<br>(HTTPOnly, Secure, SameSite=Lax/Strict, Path=/)
                note left of Browser: Browser stores cookie and sends it with subsequent requests.
                LoginPage -->> Browser: Redirect to User Dashboard/Welcome Page
                Browser -->> User: Display Dashboard

                note over Browser, SessionManager: Session active. Future requests authenticated via session cookie. MFA/2FA check might occur here if enabled for the user.

            else Authentication Failed (Invalid Credentials or User Not Found)
                PasswordStorage -->> AuthenticationService: Result: Failure
                AuthenticationService ->> RateLimiter: Increment Failed Attempt Count<br>(Username/IP/Fingerprint)
                AuthenticationService -->> LoginPage: Authentication Failed
                LoginPage -->> Browser: Display Error: Invalid Username or Password
                Browser -->> User: Show Error Message
            end
        end
    end

    %% Password Reset Flow %%
    Note over User, LoginPage: User initiates Password Reset

    User ->> Browser: Click "Forgot Password" Link
    Browser ->> LoginPage: Request Password Reset Form
    LoginPage -->> Browser: Render Email Input Form
    User ->> Browser: Input Email Address
    Browser ->>+ LoginPage: Submit Email for Reset

    LoginPage ->> SecurityService: Initiate Password Reset (Email)
    note right of SecurityService: Validate email format and check if user exists.
    SecurityService ->> SecurityService: Generate Cryptographically Secure,<br>Unique, Short-Lived Reset Token
    SecurityService ->> SecurityService: Store Token Hash + Expiry + User ID<br>(Associate securely, prevent reuse)
    SecurityService ->> EmailService: Request Password Reset Email Send<br>(User ID, Email Addr, Reset Token)
    EmailService -->> SecurityService: Acknowledge Request
    EmailService ->> User: Send Email with Unique Reset Link<br>(e.g., https://app.com/reset?token=TOKEN_VALUE)
    note left of User: User receives email and clicks the link.

    User ->> Browser: Click Reset Link in Email
    Browser ->> LoginPage: Access Password Reset Page via Token Link
    LoginPage ->> SecurityService: Validate Provided Reset Token

    rect rgba(200, 220, 240, 0.8)
        alt Reset Token Valid & Not Expired
            SecurityService -->> LoginPage: Token Valid (Provides User Context)
            LoginPage -->> Browser: Render New Password Form
            User ->> Browser: Input New Password
            User ->> Browser: Confirm New Password
            note right of Browser: Frontend validation for match and basic complexity.
            Browser ->>+ LoginPage: Submit New Password Data<br>(+ Reset Token for verification)
            note right of LoginPage: CSRF Token Check should occur here.

            LoginPage ->> SecurityService: Validate New Password Complexity<br>(Against defined policy: length, chars, etc.)

            alt Password Meets Complexity Requirements
                SecurityService -->> LoginPage: Password Compliant
                LoginPage ->> AuthenticationService: Request Password Update (User ID, New Password)
                AuthenticationService ->> AuthenticationService: Generate **New** Salt for User
                AuthenticationService ->> AuthenticationService: Hash(New Password + **New** Salt)
                AuthenticationService ->> PasswordStorage: Update User Record:<br>Store New Hash + **New** Salt
                PasswordStorage -->> AuthenticationService: Password Update Confirmed
                AuthenticationService ->> SecurityService: Invalidate All Active Sessions for User<br>(Security measure post-reset)
                AuthenticationService -->> LoginPage: Password Update Success
                SecurityService ->> SecurityService: Invalidate Used Reset Token
                LoginPage -->> Browser: Display Success Message: Password Reset Successful
                LoginPage ->> Browser: Redirect to Login Page
                Browser -->> User: Show Success & Login Page
            else Password Does Not Meet Requirements
                SecurityService -->> LoginPage: Password Complexity Failure
                LoginPage -->> Browser: Display Error: Password Requirements Not Met
                Browser -->> User: Show Password Policy Requirements
            end

        else Reset Token Invalid, Expired, or Used
            SecurityService -->> LoginPage: Token Validation Failed
            LoginPage -->> Browser: Display Error: Invalid or Expired Reset Link
            Browser -->> User: Show Error Message
        end
    end

```

**Summary of Key Optimizations and Enhancements:**

1.  **Clearer Participants & Roles**:
    *   `LoginPage` explicitly labeled as `UI / Frontend`.
    *   `RateLimiter` labeled as `Request Throttling` for clarity.
    *   `SecurityDepartment` (unused) removed. `SecurityService` clearly labeled `Security Ops`.
    *   `EmailService` labeled `Notification Service`.
    *   `Browser` is now explicitly shown interacting with the user and the `LoginPage`.

2.  **Enhanced Security Details in Diagram:**
    *   **Input Validation**: Added a note emphasizing validation/sanitization (though detailed steps aren't shown to keep the diagram concise).
    *   **HTTPS**: Explicitly mentioned password submission occurs over HTTPS.
    *   **Secure Comparison**: Noted the use of constant-time comparison for password hashes to prevent timing attacks.
    *   **Session Cookie Attributes**: Detailed the recommended attributes (`HTTPOnly`, `Secure`, `SameSite`, `Path`).
    *   **Session Storage**: Added a note indicating sessions are stored server-side.
    *   **MFA/2FA**: Added a note indicating where Multi-Factor Authentication would typically fit in (post-successful primary authentication).
    *   **Reset Token Security**: Emphasized generating cryptographically secure, unique, short-lived tokens and storing their *hash*, not the raw token.
    *   **CSRF Protection**: Added a note indicating the need for CSRF token validation during password reset submission.
    *   **New Salt on Reset**: Explicitly highlighted that a **new** salt is generated when the password is changed/reset.
    *   **Session Invalidation on Reset**: Added a crucial step to invalidate all existing user sessions after a password reset for security.
    *   **CAPTCHA**: Added a note indicating potential CAPTCHA integration points.
    *   **Rate Limiter Inputs**: Specified that rate limiting can use Username, IP, and potentially device fingerprinting.

3.  **Improved Flow and Clarity:**
    *   More explicit interaction steps involving the `Browser`.
    *   Clearer distinction between authentication failure reasons (handled generically in the message for security, but the process accounts for different internal causes).
    *   More descriptive messages on activation/deactivation arrows.
    *   Refined `alt` block structure and coloring for readability.
    *   Used standard fonts and adjusted colors for better visual appeal based on Mermaid theme variables.

4.  **Refined Explanations (To accompany the diagram):**
    *   **Input Validation/Sanitization**: Emphasize this as a first line of defense (handled by Frontend/Backend API before hitting core services).
    *   **Rate Limiting Strategies**: Mention different techniques (token bucket, leaky bucket) and inputs (IP, username, device fingerprint). Discuss CAPTCHA as a common companion.
    *   **Password Hashing**: Explain the importance of strong, adaptive hashing algorithms (e.g., Argon2, bcrypt, scrypt) and unique salts per user. Reiterate constant-time comparison.
    *   **Session Management**: Discuss session timeouts (idle and absolute), session rotation, secure cookie flags, and server-side session storage benefits.
    *   **CSRF Protection**: Explain the use of synchronizer tokens (CSRF tokens) for state-changing requests like password reset.
    *   **Password Reset Token Best Practices**: Cover secure generation (CSPRNG), short expiry times, single-use enforcement, storing hashes, and delivering via a secure channel (email link over HTTPS).
    *   **Password Policies**: Detail common complexity rules (length, character types, disallowing common passwords/user info).
    *   **MFA/2FA**: Reiterate its importance as an additional layer, often prompted after successful primary login or for sensitive actions.
    *   **Logging & Monitoring**: Stress the importance of logging all significant authentication and security events for auditing and incident response.
    *   **Secure Communication (HTTPS)**: Reiterate that all communication must happen over TLS/HTTPS.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---