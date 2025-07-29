---
created: 2025-03-26 05:31:26
---


---


# Technical Security Concepts and Concerns for Web Browser


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


### 1. Input Validation and Sanitization

This flowchart shows the basic process of handling user input securely before processing it on the server.

```mermaid
---
title: Input Validation & Sanitization Flow
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
    A["Receive User Input<br>(e.g., Username, Password, Email)"] --> B{Validate Input?}

    subgraph Validation_Checks["Validation Checks"]
        B -- "Format Check<br>(e.g., Email syntax)" --> C{"Valid Format?"}
        C -- "Type Check<br>(e.g., Number vs String)" --> D{"Correct Type?"}
        D -- "Length Check<br>(e.g., Min/Max length)" --> E{"Within Length Limits?"}
        E -- "Content Check<br>(e.g., Disallowed characters/patterns)" --> F{"Allowed Content?"}
    end

    F -- Yes --> G["Sanitize Input<br>(e.g., Escape special chars, Remove harmful tags)"]
    G --> H["Process Sanitized Input"]

    C -- No --> I["Reject Input<br>Error: Invalid Format"]
    D -- No --> I["Reject Input<br>Error: Incorrect Type"]
    E -- No --> I["Reject Input<br>Error: Invalid Length"]
    F -- No --> I["Reject Input<br>Error: Disallowed Content"]

    I --> J["Return Error to User"]

    style A fill:#ADD8E6,stroke:#333,stroke-width:2px
    style H fill:#90EE90,stroke:#333,stroke-width:2px
    style I fill:#F08080,stroke:#333,stroke-width:2px
    style G fill:#FFFFE0,stroke:#333,stroke-width:1px
    
```


**Explanation:** Validates input against expected format, type, length, and content rules. If valid, it's sanitized (cleaned) to prevent injection attacks (like XSS or SQL Injection) before being processed. Invalid input is rejected with an appropriate error.

---

### 2. HTTPS (Secure Communication)

This sequence diagram illustrates that communication between the client (Browser) and server occurs over an encrypted channel.

```mermaid
---
title: HTTPS Communication
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
    participant Browser as Client Browser
    participant Server as Web Server

    Note over Browser, Server: Communication established over TLS/SSL<br>(HTTPS)

    Browser->>+Server: Request Resource<br>(over HTTPS)
    Server-->>-Browser: Send Resource<br>(over HTTPS)

    Note over Browser, Server: Data (like passwords) is encrypted during transit
```

**Explanation:** The key point is that all requests and responses, especially those containing sensitive data like passwords, travel over an encrypted HTTPS connection, protecting them from eavesdropping (Man-in-the-Middle attacks).

---

### 3. Secure Comparison (Constant-Time)

This flowchart contrasts a naive (potentially vulnerable) string comparison with a secure, constant-time comparison for password hashes.

```mermaid
---
title: Password Hash Comparison
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
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
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
    A["Receive Input Password & Stored Hash"] --> B{"Comparison Method?"}

    subgraph Naive_Comparison["Naive Comparison<br>(Vulnerable)"]
        B -- Naive String Compare --> C[Compare character by character]
        C --> D{Mismatch found?}
        D -- Yes --> E["Return False Immediately<br>(Execution time varies based on mismatch position)"]
        D -- No --> F["All chars match? Return True<br>(Longer execution time)"]
        %% note right of E : Susceptible to Timing Attacks!
    end

    subgraph Secure_Comparison["Secure Comparison<br>(Constant-Time)"]
        B -- Constant-Time Compare --> G["Compare entire hashesbitwise"]
        G --> H["Iterate through *all* bits/bytes,<br>regardless of when mismatch occurs"]
        H --> I["Track if any mismatch occurred"]
        I --> J{"Any mismatch found during full comparison?"}
        J -- Yes --> K["Return False<br>(Execution time is consistent)"]
        J -- No --> L["Return True<br>(Execution time is consistent)"]
        %%  note right of K : Resistant to Timing Attacks
    end

    %% lightcoral
    style E fill:#F08080
    %% lightgreen
    style K fill:#90EE90
    
```


**Explanation:** A naive comparison might return faster if a mismatch occurs early. Attackers can exploit this timing difference to guess the hash character by character. A constant-time comparison takes the same amount of time regardless of where the mismatch occurs, preventing timing attacks.

---

### 4. Session Cookie Attributes

This mind map outlines the important security attributes of a session cookie.

```mermaid
---
title: Secure Session Cookie Attributes
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
  root((Session Cookie))
    ::icon(fa fa-cookie-bite)
    Attribute: HTTPOnly
      ::icon(fa fa-shield-alt)
      Prevents_access_via_client-side_scripts["Prevents access via client-side scripts (JavaScript)"]
      Mitigates_Cross-Site_Scripting["Mitigates Cross-Site Scripting (XSS) stealing the cookie"]
    Attribute: Secure
      ::icon(fa fa-lock)
      Cookie only sent over HTTPS connections
      Prevents sending over unencrypted HTTP
    Attribute: SameSite
      ::icon(fa fa-exchange-alt)
      Controls when cookie is sent with cross-site requests
      Mitigates Cross-Site Request Forgery (CSRF)
      Values:
         Strict (Only sent for same-site requests)
         Lax (Sent on top-level navigation GET requests)
         None (Sent on all requests - **Requires `Secure` flag**)
    Attribute: Path
      ::icon(fa fa-folder-open)
      Specifies URL path for which the cookie is valid
      Limits scope, e.g., `/app` vs `/`
    Attribute: Expires / Max-Age
      ::icon(fa fa-clock)
      Defines cookie lifetime
      `Expires`: Specific date/time
      `Max-Age`: Duration in seconds
      Helps manage session duration and cleanup
      
```


**Explanation:** These attributes instruct the browser on how to handle the cookie, significantly enhancing security by restricting access (`HTTPOnly`), ensuring encrypted transmission (`Secure`), controlling cross-site behavior (`SameSite`), limiting scope (`Path`), and managing lifetime (`Expires`/`Max-Age`).

---

### 5. Session Storage (Server-Side)

This diagram contrasts storing session data on the server versus embedding it entirely in the client (less secure).

```mermaid
---
title: Session Storage Approaches
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
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
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
    subgraph Server_Side_Session_Storage["Server-Side Session Storage<br>(Recommended)"]
        A["User Logs In"] --> B["Server Generates Session ID"]
        B --> C["Server Stores Session Data<br>(User ID, Role, Prefs, etc.)<br>in Server Memory/DB/Cache (e.g., Redis)"]
        C --> D["Server Sends *Only* Session ID to Client<br>(in Secure Cookie)"]
        D --> E["Client Sends Session ID Cookie with Subsequent Requests"]
        E --> F["Server Looks Up Session Data using Session ID"]
        F --> G["Server Processes Request based on Session Data"]
    end

    subgraph Client_Side_Session_Storage["Client-Side Session Storage<br>(e.g., JWT - *Simplified View*)"]
        H["User Logs In"] --> I["Server Generates Signed Token (e.g., JWT)<br>containing Session Data"]
        I --> J["Server Sends Full Token to Client"]
        J --> K["Client Stores Token (e.g., Local Storage - **Beware XSS!**)"]
        K --> L["Client Sends Token with Subsequent Requests"]
        L --> M["Server Verifies Token Signature & Extracts Data"]
        M --> N["Server Processes Request based on Token Data"]
        note_right_of_K["note_right_of_K: Vulnerable if not handled carefully (XSS, storage choice). JWT often used for stateless auth"]
    end

    %% lightblue
    style C fill:#ADD8E6
    style F fill:#ADD8E6

    %% lightgreen
    style D fill:#90EE90

    %% lightyellow
    style M fill:#FFFFC5
```

**Explanation:** Storing session data server-side means only a meaningless Session ID is sent to the client (typically in a cookie). This limits the data exposed if the client is compromised. Storing all session data client-side (like in a JWT stored in Local Storage) can be vulnerable to XSS if not implemented with extreme care (e.g., using secure cookies for JWT storage is better). Server-side is generally preferred for traditional stateful sessions.

---

### 6. MFA/2FA (Multi-Factor Authentication) Integration

This sequence diagram shows where 2FA typically fits into the login flow.

```mermaid
---
title: MFA/2FA Sequence in Login
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

    Actor User

    box rgb(200, 220, 55) Sign In Process
        participant Browser
        participant LoginPage
        participant AuthService as Authentication Service
        participant SecondFactorService as 2FA/MFA Service
    end

    User->>Browser: Submit Username/Password
    Browser->>LoginPage: Post Credentials
    LoginPage->>AuthService: Authenticate Primary Credentials
    AuthService-->>LoginPage: Primary Auth Success (User identified)

    
    alt User Has MFA/2FA Enabled
    rect rgb(200, 15, 255)
            LoginPage->>SecondFactorService: Request 2FA Challenge for User
            SecondFactorService-->>LoginPage: Challenge Presented (e.g., Prompt for TOTP)
            LoginPage-->>Browser: Display 2FA Input Form
            User->>Browser: Input 2FA Code (e.g., from Authenticator App)
            Browser->>LoginPage: Post 2FA Code
            LoginPage->>SecondFactorService: Verify 2FA Code
            
            alt Code Valid
                rect rgb(100, 150, 255)
                    SecondFactorService-->>LoginPage: 2FA Verification Success
                    LoginPage->>AuthService: Confirm Full Authentication
                    AuthService->>Browser: Grant Access (e.g., Set Session, Redirect)
                end
            else Code Invalid / Expired
                rect rgb(10, 250, 255)
                    SecondFactorService-->>LoginPage: 2FA Verification Failed
                    LoginPage-->>Browser: Display Error: Invalid 2FA Code
                end
            end
        end
    else MFA/2FA Not Enabled
	     AuthService->>Browser: Grant Access (e.g., Set Session, Redirect)
    end
    
```


**Explanation:** After the primary authentication (username/password) is successful, the system checks if MFA/2FA is enabled for the user. If yes, it initiates a second factor challenge (like requesting a code from an authenticator app). Access is only granted after *both* factors are successfully verified.

---

### 7. Reset Token Security (Generation, Storage, Validation)

This flowchart illustrates the secure lifecycle of a password reset token.

```mermaid
---
title: Secure Password Reset Token Lifecycle
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
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
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
    A["Password Reset Request Received<br>(User Email)"] --> B["Generate Cryptographically Secure<br>Random Token<br>(High Entropy)"]
    B --> C["Get Current Timestamp"]
    C --> D["Calculate Expiration Timestamp<br>(e.g., Now + 15 Minutes)"]
    D --> E["Hash the Generated Token<br>(e.g., using SHA-256)"]
    E --> F["Store **Token Hash**, User ID, and Expiration Timestamp<br>in Secure Storage<br>(e.g., Database)"]
    F --> G["Send the **Original Token** (Not the Hash)<br>to User's Email via Unique Link"]

    subgraph Token_Validation["Token Validation<br>(When User Clicks Link)"]
        H["Receive Token from User Link"] --> I["Hash the Received Token<br>(using the same algorithm, e.g., SHA-256)"]
        I --> J["Look Up **Token Hash** in Storage"]
        J --> K{"Stored Hash Found?"}
        K -- Yes --> L["Retrieve Associated User ID & Expiration Timestamp"]
        L --> M{"Is Current Time < Expiration Timestamp?"}
        M -- Yes --> N["Token is Valid!<br>Proceed with Password Reset Form"]
        N --> O["Mark Token as Used / Delete Record After Successful Reset"]
        M -- No --> P["Reject:<br>Token Expired"]
        K -- No --> P["Reject:<br>Token Invalid / Not Found"]
    end

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
    style O fill:#FFFFC5
    
```



**Explanation:** Securely generate a random token. Store its *hash* (not the original token) along with an expiration time. Send the original token to the user. When the user clicks the link, hash the received token and compare it against the stored hash. Also, check the expiration time. Invalidate the token immediately after successful use.

---

### 8. CSRF Protection (Synchronizer Token Pattern)

This sequence diagram shows how a CSRF token protects against Cross-Site Request Forgery, particularly relevant for state-changing actions like password reset submissions.

```mermaid
---
title: CSRF Protection using Synchronizer Token
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
    participant Browser
    participant Server
    participant AttackerSite

    Note over Browser, Server: User is Logged In<br>(Has Valid Session)

    Browser->>Server: GET /render-password-reset-form
    Server->>Server: Generate Unique, Session-Bound CSRF Token
    Server-->>Browser: Send HTML Form + Hidden Field<br>(csrf_token=GENERATED_TOKEN)

    Note over Browser, Server: User fills and submits the form

    Browser->>Server: POST /submit-new-password<br>(Form Data + csrf_token=GENERATED_TOKEN)
    Server->>Server: Retrieve Expected CSRF Token for User's Session
    Server->>Server: Compare Received Token == Expected Token?

    
    alt Tokens Match
        rect rgb(200, 150, 255)
            Server->>Server: Process Password Reset Request
            Server-->>Browser: Success Response
        end
    else Tokens Do Not Match<br>(or Token Missing)
        rect rgb(200, 150, 55)
            Server->>Server: Reject Request<br>(Potential CSRF Attack)
            Server-->>Browser: Error Response<br>(e.g., 403 Forbidden)
        end
    end

    Note over AttackerSite, Browser: Attacker tries to trick user's browser

    AttackerSite->>Browser: Malicious Request to POST /submit-new-password<br>(No/Invalid CSRF Token)
    Browser->>Server: POST /submit-new-password<br>(No/Invalid CSRF Token - Submitted cross-site)
    Server->>Server: Retrieve Expected CSRF Token for User's Session
    Server->>Server: Compare Received Token == Expected Token? --> **FAIL**
    Server->>Server: Reject Request
    Server-->>Browser: Error Response


```



**Explanation:** The server embeds a unique, hidden token in forms. When the form is legitimately submitted, the browser sends this token back. The server validates that the received token matches the one expected for the user's session. Malicious sites cannot guess this token, so forged requests initiated by them will fail the validation.

---

### 9. New Salt on Password Change/Reset

This flowchart highlights the generation of a *new* salt during the password update process.

```mermaid
---
title: Generating New Salt on Password Update
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
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
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
    A["Receive Request to Update Password<br>(User ID, New Password)"] --> B["Generate **New**, Unique Cryptographic Salt"]
    B --> C["Hash the New Password using the **New** Salt<br>(e.g., Argon2(NewPassword, NewSalt))"]
    C --> D["Store the resulting Hash and the **New** Salt<br>in the User's Record in Database"]
    D --> E["Password Update Complete"]

    %% lightblue
    style B fill:#ADD8E6,stroke:#333,stroke-width:2px 
    %% lightyellow
    style C fill:#FFFFC5 
    lightgreen
    style D fill:#90EE90
    
```


**Explanation:** It's crucial to generate a *new* salt every time a password is set or changed. This ensures that even if a user reuses an old password, the resulting hash will be different, preventing attackers from easily identifying reused passwords using precomputed rainbow tables based on potentially leaked older hashes/salts.

---

### 10. Session Invalidation on Password Reset

This sequence diagram shows the server actively invalidating existing sessions after a successful password reset.

```mermaid
---
title: Session Invalidation After Password Reset
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
    
    box rgb(10, 150, 25) The System
        participant Browser
        participant LoginPage
        participant AuthService
        participant PasswordStorage
        participant SessionManager as Session Store
    end

    User->>Browser: Submits New Password Successfully
    Browser->>LoginPage: POST New Password Data
    LoginPage->>AuthService: Request Password Update
    AuthService->>PasswordStorage: Store New Hashed Password + New Salt
    PasswordStorage-->>AuthService: Confirm Update

    Note over AuthService, SessionManager: Password update successful, now invalidate old sessions.

    AuthService->>SessionManager: Invalidate ALL Active Sessions for User ID
    SessionManager->>SessionManager: Remove/Mark User's Sessions as Invalid in Store
    SessionManager-->>AuthService: Invalidation Complete

    AuthService-->>LoginPage: Password Reset Success
    LoginPage-->>Browser: Success Message & Redirect to Login

    Note over Browser, SessionManager: Any subsequent request using old session cookies<br>will be rejected, forcing re-login.

```

**Explanation:** After a password reset, any active sessions the user might have on other devices become potentially compromised (as the credentials used to create them are now old). Invalidating all sessions forces the user (and any potential attacker who might have hijacked an old session) to re-authenticate with the new password, enhancing security.

---

### 11. CAPTCHA Integration Points

This flowchart shows common scenarios where a CAPTCHA challenge might be triggered.

```mermaid
---
title: CAPTCHA Trigger Points
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
    'graph': { 'htmlLabels': false, 'curve': 'linear' },
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
    A["User Action<br>(e.g., Login Attempt, Registration, Password Reset)"] --> B{"Evaluate Risk / Attempt Frequency"}

    subgraph Risk Factors
        B -- "High Number of Failed Attempts (IP/User)?" --> C{"Threshold Exceeded?"}
        B -- "Suspicious Traffic Pattern (e.g., Bot-like behavior)?" --> D{"Suspicious?"}
        B -- "High-Risk Action (e.g., Password Reset)?" --> E{"Is High-Risk?"}
        B -- "Low User Reputation / New Account?" --> F{"Low Reputation?"}
    end

    C -- Yes --> G["Trigger CAPTCHA Challenge"]
    D -- Yes --> G
    E -- Often Yes --> G
    F -- Sometimes Yes --> G

    C -- No --> H["Proceed without CAPTCHA<br>(for now)"]
    D -- No --> H
    E -- Maybe No --> H
    F -- Often No --> H

    G --> I{"CAPTCHA Solved Successfully?"}
    I -- Yes --> J["Allow Original Action"]
    I -- No --> K["Block Action / Display Error"]

    style G fill:#lightblue
    style I fill:#lightyellow
    style J fill:#lightgreen
    style K fill:#lightcoral
```

**Explanation:** CAPTCHA (Completely Automated Public Turing test to tell Computers and Humans Apart) is used to differentiate humans from bots. It's often triggered during login, registration, or password reset flows, especially if the system detects suspicious activity (like too many failed attempts from one IP) or based on a risk assessment.

---

### 12. Rate Limiter Inputs

This mind map shows the various data points that can be used as input for rate-limiting decisions.

```mermaid
---
title: Inputs for Rate Limiting Decisions
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
  root((Rate Limiter))
    ::icon(fa fa-tachometer-alt)
    Input: IP Address
      ::icon(fa fa-network-wired)
      Track requests per IP
      Can be spoofed / Shared IPs (NAT)
    Input: Username / User ID
      ::icon(fa fa-user)
      Track attempts per specific account
      Effective after user identification
    Input: Session ID / API Key
      ::icon(fa fa-key)
      Track requests per authenticated session/client
    Input: Device Fingerprint
      ::icon(fa fa-fingerprint)
      Identify unique browsers/devices
      More resilient than IP alone
      Privacy considerations
    Input: Specific Action/Endpoint
      ::icon(fa fa-route)
      Apply different limits to different actions
      (e.g., stricter limits on login vs. read operations)
    Input: Global Limits
      ::icon(fa fa-globe)
      Overall system request limits
```

**Explanation:** Rate limiting prevents abuse by restricting the number of requests a user or system can make in a given time window. The effectiveness of rate limiting depends on accurately identifying the source of requests, often using a combination of inputs like IP address, username, session identifiers, or more advanced techniques like device fingerprinting. Different limits can be applied based on the action being performed.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---