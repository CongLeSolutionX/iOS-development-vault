---
created: 2025-03-26 05:31:26
---


----


# Technical Security Concepts and Concerns for iOS Client App

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



## A Diagrammatic Guide 


### 1. Input Validation and Sanitization (iOS)

Validation occurs both client-side in the app (for immediate feedback) and crucially server-side.

```mermaid
---
title: Input Validation & Sanitization Flow (iOS)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph TD
    A["User Enters Data in iOS App<br>(e.g., UITextField)"] --> B{"Client-Side Validation<br>(in App)"}

    subgraph iOS_App["iOS App<br>(Client-Side Checks)"]
        B -- "Format Check<br>(e.g., Email regex, Number format)" --> C{"Valid Format?"}
        C -- "Length Check<br>(e.g., Password min/max length)" --> D{"Within Limits?"}
        D -- "Basic Content Check<br>(e.g., No obvious invalid chars)" --> E{"Passed Basic Checks?"}
    end

    E -- Yes --> F["Send Data to Server API<br>(via URLSession/Alamofire over HTTPS)"]
    F --> G{"Server-Side Validation & Sanitization"}
        subgraph Server_API["Server API<br>(Backend)"]
           G -- "Rigorous Format/Type/Length Checks" --> H{"Valid Data?"}
           H -- Security Checks (Disallowed patterns, injections) --> I{"Safe Content?"}
           I -- Yes --> J["Sanitize Input<br>(e.g., Escape for DB, Encode output)"]
           J --> K["Process Sanitized Input Securely"]
        end

    E -- "No<br>(Client Validation Failed)" --> L["Display Inline Error in App UI"]
    H -- "No<br>(Server Validation Failed)" --> M["API Returns Error Response<br>(e.g., 400 Bad Request)"]
    I -- "No<br>(Server Validation Failed)" --> M
    M --> N["App Displays Error Message to User"]

    %% lightblue
    style A fill:#ADD8E6,stroke:#333,stroke-width:1px
    
    %% cornflowerblue
    style B fill:#6495ED,stroke:#333,stroke-width:1px

    %% lightgreen
    style F fill:#90EE90,stroke:#333,stroke-width:1px

    %% orange
    style G fill:#FFA500,stroke:#333,stroke-width:2px
    
    %% mediumseagreen
    style K fill:#3cb371,stroke:#333,stroke-width:2px

    %% lightpink
    style L fill:#FFB6C1,stroke:#333,stroke-width:1px
    
    %% lightcoral
    style N fill:#F08080,stroke:#333,stroke-width:1px
    
```


**Explanation (iOS Context):** The iOS app performs initial checks for quick user feedback (e.g., is the email format okay?). However, the critical validation and sanitization *must* happen on the server after receiving the data, as the client can be bypassed. The app sends data over HTTPS and handles error responses from the server API.

---

### 2. HTTPS (Secure Communication - iOS)

Illustrates secure API calls from the iOS app.

```mermaid
---
title: Secure API Communication (iOS via HTTPS)
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
      'primaryColor': '#B528',
      'primaryTextColor': '#2cf',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'secondaryColor': '#0610',
      'tertiaryColor': '#fff'
    }
  }
}%%
sequenceDiagram
	autonumber
	
    participant App as iOS Application
    participant NetworkLayer as iOS Networking<br>(URLSession/Alamofire)
    participant Server as Backend API Server

    Note over App, Server: Communication via TLS/SSL (HTTPS)<br>Enforced by App Transport Security (ATS) by default.

    App->>+NetworkLayer: Initiate API Request (e.g., Login)
    NetworkLayer->>+Server: Send Request over HTTPS
    Server-->>-NetworkLayer: Send Response over HTTPS
    NetworkLayer-->>-App: Deliver Response (Data or Error)

    Note over NetworkLayer, Server: Sensitive data (Tokens, Passwords)<br>encrypted during transit.
```

**Explanation (iOS Context):** The iOS app uses networking frameworks like `URLSession` (or libraries like Alamofire) to communicate with the backend API. App Transport Security (ATS) is an iOS feature that enforces secure HTTPS connections by default, preventing accidental insecure communication.

---

### 3. Secure Comparison (Constant-Time) - Server Side

This concept is identical to the web version because it happens on the server. The diagram remains the same, emphasizing it's a backend process.

```mermaid
---
title: Password Hash Comparison (Server-Side)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#ffff',
      'primaryTextColor': '#55ff',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph TD
    A["Server Receives Credentials from iOS App"] --> B["Retrieve Stored Hash & Salt for User"]
    B --> C{"Comparison Method?"}

    subgraph Naive_Comparison["Naive Comparison<br>(Vulnerable)"]
        C -- Naive String Compare --> D["Compare char by char"]
        D --> E{"Mismatch found?"}
        E -- Yes --> F["Return Auth Failure Immediately<br>(Execution time varies)"]
        E -- No --> G["All chars match? Return Auth Success<br>(Longer execution time)"]
        %% note right of F : Susceptible to Timing Attacks!
    end

    subgraph Secure_Comparison["Secure Comparison<br>(Constant-Time)"]
        C -- Constant-Time Compare --> H[Compare entire hashes bitwise];
        H --> I["Iterate through *all* bits/bytes,<br>regardless of when mismatch occurs"]
        I --> J["Track if any mismatch occurred"]
        J --> K{"Any mismatch found during full comparison?"}
        K -- Yes --> L["Return Auth Failure<br>(Execution time is consistent)"]
        K -- No --> M["Return Auth Success<br>(Execution time is consistent)"]
        %%  note right of L : Resistant to Timing Attacks
    end

    %% lightcoral
    style F fill:#F08080
    style L fill:#F08080

    %% lightgreen
    style M fill:#90EE90
```

**Explanation (iOS Context):** The iOS app sends the user's password attempt over HTTPS. The *server* performs the secure, constant-time comparison against the stored hash. This is not an operation performed within the iOS app itself.

---

### 4. Secure Token Handling (iOS)

Focuses on storing and using authentication tokens (like JWT Bearer tokens) securely on the device.

```mermaid
---
title: Secure Token Handling & Storage (iOS)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
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
  root((Authentication Token Handling))
    ::icon(fa fa-key)
    Token Acquisition
      Server_sends_Token["Server sends Token (e.g., JWT) after successful login"]
      Transmitted over HTTPS
    Secure Storage
      **Keychain** ::icon(fa fa-lock)
        iOS secure enclave for sensitive data
        Encrypted on disk
        App-sandboxed (usually)
        Recommended for Auth Tokens, Refresh Tokens
      *Avoid*: UserDefaults (unencrypted plist)
      *Avoid*: Storing directly in variables long-term
    Token Usage
      Include in `Authorization` header for API calls
      (e.g., `Authorization: Bearer <token>`)
      Use via Networking Layer (URLSession/Alamofire)
    Token Expiration
      Tokens should have short lifespans (e.g., 15-60 mins)
      App checks expiry *before* using token (optional pre-check)
      Server *always* validates expiry on API requests
    Refresh Tokens
      Longer-lived token stored securely (Keychain)
      Used to obtain *new* access tokens without re-login
      Requires separate, secure endpoint on server
      Must handle refresh token revocation/rotation
    Security Considerations
      Protect against jailbreak detection bypass (if storing sensitive data based on jailbreak status)
      Minimize token exposure in logs or analytics
      
```


**Explanation (iOS Context):** Instead of relying heavily on cookies, iOS apps typically use bearer tokens received from the server. The **Keychain** is the standard secure storage location for these tokens on iOS. The app includes the token in the Authorization header of API requests and must handle token expiration, often using refresh tokens for a smoother user experience.

---

### 5. Session Storage (Server-Side) - iOS Interaction

Same server-side principle, different client interaction using tokens.

```mermaid
---
title: Server-Side Session (Interacting with iOS App)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
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
    subgraph Server_Side_Session_State["Server-Side Session State<br>(Recommended for Stateful Apps)"]
        A["iOS App User Logs In"] --> B["Server Validates Credentials"]
        B --> C["Server Generates Session ID"]
        C --> D["Server Stores Session Data<br>(User ID, Role, etc.) linked to Session ID<br>in Server Cache/DB<br>(e.g., Redis)"]
        D --> E[Server Sends *Only* Session ID/Token to iOS App]
        subgraph iOS_App_Storage["iOS App Storage & Usage"]
           E --> F["App Stores Session ID/Token Securely<br>(e.g., Keychain)"]
           F --> G["App Includes Session ID/Token<br>in Header ('Authorization' or Custom) of Subsequent API Requests"]
        end
        G --> H["Server Receives Request + Session ID/Token"]
        H --> I["Server Looks Up Session Data using ID/Token"]
        I --> J["Server Processes Request based on Session Data"]
    end

    %% lightblue
    style D fill:#ADD8E6
    style I fill:#ADD8E6

    %% lightgreen
    style E fill:#90EE90
    
    %% cornflowerblue
    style F fill:#6495ED
    
```

**Explanation (iOS Context):** The server maintains the session state. The iOS app receives a session identifier (could be a simple session ID or a structured token like a JWT used *as* a session ID) after login, stores it securely (Keychain), and sends it back to the server with each API request, usually in an `Authorization` header.

---

### 6. MFA/2FA Integration (iOS)

Shows MFA/2FA flow involving native iOS capabilities.

```mermaid
---
title: MFA/2FA Sequence (iOS App)
---
sequenceDiagram
    autonumber

    Actor User

    box rgb(200, 220, 55) The App System
        participant App as iOS App
        participant AuthService as Authentication Service
        participant MFA_Service as MFA/2FA Service
        participant PushService as Push Notification Service<br>(Optional)
        participant Biometric as Face ID / Touch ID<br>(Optional)
    end

    User->>App: Submit Username/Password
    App->>AuthService: Authenticate Primary Credentials
    AuthService-->>App: Primary Auth Success<br>(User identified)

    
    alt User Has MFA/2FA Enabled
        rect rgb(200, 150, 200)
            App->>MFA_Service: Request 2FA Challenge for User
            
            alt Push Notification Based
                rect rgb(20, 150, 200)
                    MFA_Service->>PushService: Send Push Challenge to User's Device
                    PushService->>User: Display Push Notification<br>(Approve/Deny)
                    User->>App: Approve via Push/App
                    App->>MFA_Service: Send Approval Confirmation
                end
            else TOTP<br>(Authenticator App)
                rect rgb(20, 180, 200)
                    MFA_Service-->>App: Indicate TOTP Required
                    App->>User: Prompt for TOTP Code
                    User->>App: Enter TOTP Code
                    App->>MFA_Service: Verify TOTP Code
                end
            else Biometric<br>(If previously setup)
                rect rgb(20, 220, 200)
                    MFA_Service-->>App: Indicate Biometric Allowed
                    App->>Biometric: Request Biometric Scan<br>(Face ID/Touch ID)
                    Biometric-->>App: Scan Success/Failure
                    App->>MFA_Service: Report Biometric Result
                end
            end

            alt Verification Success
                rect rgb(200, 50, 200)
                    MFA_Service-->>App: MFA Verification Success
                    App->>AuthService: Confirm Full Authentication<br>(MFA Passed)
                    AuthService-->>App: Grant Access<br>(Send Session Token/Confirm Session)
                end
            else Verification Failed
                rect rgb(220, 90, 200)
                    MFA_Service-->>App: MFA Verification Failed
                    App->>User: Display Error: Invalid MFA
                end
            end
        end
    else MFA/2FA Not Enabled
        rect rgb(220, 90, 200)
            AuthService-->>App: Grant Access<br>(Send Session Token/Confirm Session)
        end
    end

```



**Explanation (iOS Context):** After primary login, the app requests an MFA challenge. This could involve prompting for a TOTP code, triggering a Face ID/Touch ID scan (if configured as a factor), or handling an interactive push notification sent via APNS, providing a native and often smoother user experience compared to web forms.

---

### 7. Reset Token Security (Generation, Storage, Validation) - Server Side

This lifecycle is identical to the web version as it's server-side logic. The difference is how the user interacts with the link/token (potentially via deep links).

```mermaid
---
title: Secure Password Reset Token Lifecycle (Server-Side)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
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
    A["Password Reset Request Received<br>(User Email from App/Web)"] --> B["Generate Cryptographically Secure Random Token"]
    B --> C["Get Current Timestamp"]
    C --> D["Calculate Expiration Timestamp"]
    D --> E["Hash the Generated Token"]
    E --> F["Store Token Hash, User ID, Expiration in Secure DB"]
    F --> G["Send Original Token to User's Email via Unique Link"]

    subgraph Token_Validation["Token Validation<br>(Server Side - App/Web Initiated)"]
        H["Receive Token<br>(from Deep Link/Web)"] --> I["Hash Received Token"]
        I --> J["Look Up Token Hash in Storage"]
        J --> K{"Stored Hash Found?"}
        K -- Yes --> L["Retrieve User ID & Expiration"]
        L --> M{"Is Current Time < Expiration?"}
        M -- Yes --> N["Token is Valid!<br>Allow Password Reset UI"]
        N --> O["Mark Token Used/Delete After Reset"]
        M -- No --> P["Reject:<br>Token Expired"]
        K -- No --> P["Reject:<br>Token Invalid"]
    end

    %% note right of G: "Link might be a Universal Link/Deep Link opening the iOS app, or a web link"
    %% note right of H: Request originates from iOS app (via deep link) or browser.

    %% lightblue
    style E fill:#ADD8E6
    style F fill:#ADD8E6
    style I fill:#ADD8E6
    style J fill:#ADD8E6

    %% lightgreen
    style N fill:#90EE90

    %% lightcoral
    style P fill:#F08080

    %% lightyellow
    style O fill:#90EE90
    
```


**Explanation (iOS Context):** The server handles token generation, storage (hash!), and validation. The user might click a link in their email that uses an iOS Universal Link or custom scheme to open the app directly to the password reset screen, passing the token. The app then sends this token to the server for validation.

---

### 8. CSRF Protection (iOS Context)

CSRF is less of a concern for typical native API calls using token authentication but relevant for `WKWebView`.

```mermaid
---
title: CSRF Protection (Primarily for WKWebView in iOS)
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
      'primaryColor': '#B528',
      'primaryTextColor': '#2cf',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'secondaryColor': '#0610',
      'tertiaryColor': '#fff'
    }
  }
}%%
sequenceDiagram
    autonumber

    actor User
    
    box rgb(20, 200, 155) The App System
        participant App as iOS App
        participant WebView as WKWebView Component
        participant Server as Web Server<br>(serving content to WebView)
        participant MaliciousWeb as Malicious Website<br>(loaded in system browser/another app)
    end

    Note over App, WebView: App loads a web page (requiring login/session) into a WKWebView
    User->>App: Interact with WebView content<br>(e.g., click submit on a form)
    WebView->>Server: POST Request (e.g., /update-profile) with Session Cookie
    Server->>Server: Check for CSRF Token<br>(Synchronizer Token Pattern)
    
    rect rgb(20, 150, 255)
        alt Valid CSRF Token Present<br>(Sent by legitimate form in WebView)
            Server->>Server: Process Request
            Server-->>WebView: Success Response
        else Invalid/Missing CSRF Token
            Server->>Server: Reject Request<br>(Potential CSRF)
            Server-->>WebView: Error Response
        end
    end

    Note over MaliciousWeb, App: Standard Token Auth for native APIs is different.
    
    App->>Server: Native API Call (e.g., /api/data) with 'Authorization: Bearer <token>' header
    Server->>Server: Verify Bearer Token<br>(No cookie/CSRF token needed for this auth type)
    Server-->>App: API Response
    
    note right of Server: Bearer tokens aren't automatically sent cross-origin by browsers, mitigating traditional CSRF for APIs

    Note over MaliciousWeb, User: If malicious site *tricks user* into action *within the app's WebView* without proper CSRF protection *on the web content*, CSRF is still possible *within the WebView context*

```




**Explanation (iOS Context):** Standard iOS app API calls using `Authorization: Bearer` tokens are generally not vulnerable to traditional web-based CSRF because the token isn't sent automatically like cookies. However, if the iOS app embeds web content using `WKWebView` that relies on cookie-based sessions for state-changing actions, that *web content* must implement CSRF protection (like the synchronizer token pattern) just like a regular website.

---

### 9. New Salt on Password Change/Reset - Server Side

Identical to the web version, as it's a server-side operation.

```mermaid
---
title: Generating New Salt on Password Update (Server-Side)
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Toggle theme value to `base` to activate the initilization below for the customized theme version.
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
    'fontFamily': 'Monospace',
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
    A["Server Receives Request to Update Password<br>(User ID, New Password from iOS App)"] --> B["Generate **New**, Unique Cryptographic Salt"]
    B --> C["Hash the New Password using the **New** Salt"]
    C --> D["Store resulting Hash and **New** Salt in DB"]
    D --> E["Password Update Complete - Send Success to App"]

    %% lightblue
    style B fill:#ADD8E6,stroke:#333,stroke-width:2px
    
    %% lightyellow
    style C fill:#FFFFED

    %% lightgreen
    style D fill:#90EE90
    
```



**Explanation (iOS Context):** The app sends the new password; the server is responsible for generating a new salt and hashing before storing.

---

### 10. Session Invalidation on Password Reset (iOS Impact)

Shows how the app experiences server-side session invalidation.

```mermaid
---
title: App Experience of Session Invalidation After Password Reset
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
      'primaryColor': '#B528',
      'primaryTextColor': '#2cf',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'secondaryColor': '#0610',
      'tertiaryColor': '#fff'
    }
  }
}%%
sequenceDiagram
    autonumber

    actor User
    
    box rgb(20, 200, 155) The App System
        participant App as iOS App
        participant ServerAuth as Authentication Service
        participant ServerSession as Session/Token Store
        participant ServerAPI as Resource API
    end

    Note over User, App: Password reset completed successfully earlier.<br>App still holds old session token.

    App->>ServerAPI: Make API Request using OLD Session Token
    ServerAPI->>ServerSession: Validate Token
    ServerSession-->>ServerAPI: Token Invalid / Revoked

    ServerAPI-->>App: Send Error Response<br>(e.g., HTTP 401 Unauthorized)

    App->>App: Handle 401 Error
    App->>App: Clear Stored (Old) Session Token<br>(from Keychain)
    App->>User: Redirect to Login Screen / Prompt Re-Authentication

```

**Explanation (iOS Context):** After the server invalidates sessions/tokens post-password reset, the next time the iOS app tries to use its stored (now old) token to access a protected API endpoint, the server rejects it (e.g., with a 401 Unauthorized status). The app must handle this error gracefully, clear the invalid token from storage (Keychain), and typically force the user to log in again with their new credentials.

---

### 11. CAPTCHA Integration (iOS)

Shows how CAPTCHA might be presented within an iOS app.

```mermaid
---
title: CAPTCHA Presentation and Verification (iOS)
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
      'primaryColor': '#B528',
      'primaryTextColor': '#2cf',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'secondaryColor': '#0610',
      'tertiaryColor': '#fff'
    }
  }
}%%
sequenceDiagram
    autonumber

    actor User

    box rgb(20, 200, 155) The App System
        participant App as iOS App
        participant CAPTCHA_Provider as CAPTCHA Service<br>(e.g., Google reCAPTCHA)
        participant Server as Backend Server
    end

    App->>Server: Initiate Risky Action<br>(e.g., Login Attempt after failures)
    Server-->>App: Respond: CAPTCHA Required

    rect rgb(20, 150, 255)
    alt Native SDK Integration
        rect rgb(200, 150, 255)
            App->>CAPTCHA_Provider: Request CAPTCHA Challenge (using SDK)
            CAPTCHA_Provider-->>App: Present Native CAPTCHA UI / Interaction
            User->>App: Solve CAPTCHA
            App->>CAPTCHA_Provider: Get Verification Token from SDK
            App->>Server: Resubmit Original Action + CAPTCHA Token
        end
    else WebView Integration
        rect rgb(200, 150, 255)
            App->>App: Load CAPTCHA Web Page in WKWebView
            User->>App: Solve CAPTCHA in WebView
            App->>App: Extract Verification Token<br>(e.g., via JavaScript bridge)
            App->>Server: Resubmit Original Action + CAPTCHA Token
        end
    end
    end

    Server->>CAPTCHA_Provider: Verify CAPTCHA Token<br>(Server-Side)

    rect rgb(20, 150, 255)
    alt Token Valid
        rect rgb(200, 150, 255)
            CAPTCHA_Provider-->>Server: Verification Success
            Server->>Server: Process Original Action
            Server-->>App: Success Response
        end
    else Token Invalid
        rect rgb(200, 150, 255)
            CAPTCHA_Provider-->>Server: Verification Failed
            Server-->>App: Error Response<br>(CAPTCHA Failed)
        end
    end
    end

```

**Explanation (iOS Context):** When the server determines a CAPTCHA is needed, the iOS app can either load the CAPTCHA challenge in a `WKWebView` or use a provider's native iOS SDK (if available). After the user solves the challenge, the app gets a verification token and sends it back to the *backend server* along with the original request. The backend server *must* verify this token with the CAPTCHA provider before proceeding.

---

### 12. Rate Limiter Inputs (iOS Context)

Mind map including iOS-specific identifiers.

```mermaid
---
title: Inputs for Rate Limiting Decisions (iOS Context)
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
  root((Rate Limiter - Server Side))
    ::icon(fa fa-tachometer-alt)
    Input: IP Address (of request origin)
      ::icon(fa fa-network-wired)
      Server sees gateway/device IP
      Less reliable identifier alone
    Input: Account ID / User ID
      ::icon(fa fa-user-circle)
      Track attempts per specific account (after login/identification)
      Very important input
    Input: Device Identifier (IDFV)
      ::icon(fa fa-mobile-alt)
      IdentifierForVendor: Semi-unique per app vendor per device
      More stable than IP for identifying a device
    Input: Session Token / API Key
      ::icon(fa fa-key)
      Track requests per authenticated session
    Input: Specific Action/Endpoint
      ::icon(fa fa-route)
      Apply different limits based on API endpoint called
    Input: Global Limits
      ::icon(fa fa-globe)
      Overall system health limits
    *Client-Side Hinting*
      App *can* do preliminary rate limiting (e.g., disable login button briefly)
      *Not* a security measure, purely UX. Server-side is mandatory.
```

**Explanation (iOS Context):** The server-side rate limiter uses inputs like the user's account ID (most reliable when known), the request's source IP, and potentially device identifiers like `IdentifierForVendor` (IDFV) passed up from the app. While the app can implement *UX-based* rate limiting (like temporarily disabling a button), true security rate limiting must be enforced on the server.

----
