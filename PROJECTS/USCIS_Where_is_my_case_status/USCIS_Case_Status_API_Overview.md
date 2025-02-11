---
created: 2025-02-11 05:48:19
original source: https://developer.uscis.gov/api/case-status
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


# USCIS Case Status API Overview
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

## USCIS Case Status API - Visual Overview

```mermaid
---
title: USCIS Case Status API - Visual Overview
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart LR
    API_Sandbox["Case Status API - Sandbox"];
    AccessToken_Sandbox["Access Token URL - Sandbox"];
    API_Sandbox_URL["api-int.uscis.gov/case-status"];
    AccessToken_Sandbox_URL["api-int.uscis.gov/oauth/accesstoken"];

    API_Production["Case Status API - Production"];
    API_Production_URL["api.uscis.gov/case-status <br> (Production URL - Not in Doc)"];
    Authentication["Authentication <br> OAuth 2.0 Client Credentials"];
    Customer["USCIS Customer/Representative"];

    subgraph Sandbox_Environment
        API_Sandbox
        AccessToken_Sandbox
        API_Sandbox_URL
        AccessToken_Sandbox_URL

        API_Sandbox -->|URL:| API_Sandbox_URL
        AccessToken_Sandbox -->|URL:| AccessToken_Sandbox_URL
    end

    subgraph Production_Environment
        API_Production
        API_Production_URL
        API_Production -->|URL:| API_Production_URL
    end

    Authentication --> AccessToken_Sandbox
    Authentication --> API_Sandbox
    Authentication --> API_Production

    Customer --> API_Sandbox & API_Production

    style API_Sandbox fill:#f399,stroke:#333,stroke-width:2px
    style AccessToken_Sandbox fill:#f399,stroke:#333,stroke-width:2px
    style API_Production fill:#c394,stroke:#333,stroke-width:2px
    style Authentication fill:#c394,stroke:#333,stroke-width:2px
    style Customer fill:#f5f9,stroke:#333,stroke-width:2px
    
```

## Authentication Flow - OAuth 2.0 Client Credentials

```mermaid
---
title: Authentication Flow - OAuth 2.0 Client Credentials
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant ClientApp as Developer App
    participant USCISAuthServer as USCIS <br> Authentication Server
    participant USCISAPI as USCIS <br> Case Status API

    ClientApp->>USCISAuthServer: 1. Request Access Token <br> using Client Credentials
    activate USCISAuthServer
    USCISAuthServer-->>ClientApp: 2. Grant Access Token
    deactivate USCISAuthServer

    ClientApp->>USCISAPI: 3. Access API Endpoint <br> with Access Token in Header
    activate USCISAPI
    USCISAPI-->>ClientApp: 4. Return Case Status Information <br> (if Token Valid)
    deactivate USCISAPI

    Note over ClientApp, USCISAPI: Access Token is validated <br> for each API Request

```

---

## Sandbox Staging Receipt Numbers - Examples


```mermaid
---
title: Sandbox Staging Receipt Numbers - Examples
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart LR
    subgraph With_hist_case_data["With hist case data"]
        direction LR
        hist_data_receipts([
        EAC9999103403 <br>
        EAC9999103404 <br>
        EAC9999103405 <br>
        EAC9999103410 <br>
        EAC9999103411 <br>
        EAC9999103416 <br>
        EAC9999103419 <br>
        LIN9999106498 <br>
        LIN9999106499 <br>
        LIN9999106504 <br>
        LIN9999106505 <br>
        LIN9999106506 <br>
        SRC9999102777 <br>
        SRC9999102778 <br>
        SRC9999102779 <br>
        SRC9999102780 <br>
        SRC9999102781 <br>
        SRC9999102782 <br>
        SRC9999102783 <br>
        SRC9999102784 <br>
        SRC9999102785 <br>
        SRC9999102786 <br>
        SRC9999102787 <br>
        SRC9999132710 <br>
        SRC9999132719
        ])
    end

    subgraph Without_hist_case_data["Without hist case data"]
        direction LR
        no_hist_data_receipts([
        EAC9999103400 <br>
        EAC9999103402 <br>
        EAC9999103406 <br>
        EAC9999103407 <br>
        EAC9999103408 <br>
        EAC9999103409 <br>
        EAC9999103412 <br>
        EAC9999103413 <br>
        EAC9999103414 <br>
        EAC9999103415 <br>
        EAC9999103420 <br>
        EAC9999103421 <br>
        EAC9999103424 <br>
        EAC9999103425 <br>
        EAC9999103426 <br>
        EAC9999103428 <br>
        EAC9999103429 <br>
        EAC9999103431 <br>
        EAC9999103432 <br>
        LIN9999106501 <br>
        LIN9999106507 <br>
        SRC9999132694 <br>
        SRC9999132695 <br>
        SRC9999132706 <br>
        SRC9999132707
        ])
    end
    
    style hist_data_receipts fill:#f399,stroke:#333,stroke-width:2px
    style no_hist_data_receipts fill:#c3c9,stroke:#333,stroke-width:2px
    
    linkStyle default fill:none,stroke:#333,stroke-width:1px

```

---

## Production Access Requirements Checklist - TODO

```mermaid
---
title: Production Access Requirements Checklist
config:
  layout: elk
  look: handDrawn
  theme: dark
---
requirementDiagram
    requirement ProdAccessReq {
        id: PROD_ACCESS_REQ
        text: "To request Production Access for Case Status API, you must meet the following requirements:"
        type: functionalRequirement
    }

    requirement DevAccount {
        id: DEV_ACCOUNT
        text: "Registered Developer Account on developer.uscis.gov"
        type: functionalRequirement
        parentRelationship: contains
        tags: ["Prerequisite"]
    }

    requirement DevAppSandbox {
        id: DEV_APP_SANDBOX
        text: "Registered Developer App for Case Status API - Sandbox"
        type: functionalRequirement
        parentRelationship: contains
        tags: ["Prerequisite"]
    }

    requirement SandboxTesting {
        id: SANDBOX_TESTING
        text: "Actively implemented and tested API solution in Sandbox"
        type: functionalRequirement
        parentRelationship: contains
    }

    requirement ApiTraffic {
        id: API_TRAFFIC
        text: "Minimum 5 consecutive calendar days of API traffic in Sandbox"
        type: functionalRequirement
        parentRelationship: contains
    }

    requirement HttpResponsesTested {
        id: HTTP_RESPONSES_TESTED
        text: "Success (200) and Error (4xx) HTTPS responses tested in Sandbox"
        type: functionalRequirement
        parentRelationship: contains
    }

    ProdAccessReq -- contains --> DevAccount
    ProdAccessReq -- contains --> DevAppSandbox
    ProdAccessReq -- contains --> SandboxTesting
    ProdAccessReq -- contains --> ApiTraffic
    ProdAccessReq -- contains --> HttpResponsesTested

    style PROD_ACCESS_REQ fill:#f9f,stroke:#333,stroke-width:2px
    style DEV_ACCOUNT fill:#ccf,stroke:#333,stroke-width:1px
    style DEV_APP_SANDBOX fill:#ccf,stroke:#333,stroke-width:1px
    style SANDBOX_TESTING fill:#ccf,stroke:#333,stroke-width:1px
    style API_TRAFFIC fill:#ccf,stroke:#333,stroke-width:1px
    style HTTP_RESPONSES_TESTED fill:#ccf,stroke:#333,stroke-width:1px
    
```

Note: This is new syntax by the bot


---


## Case Status API - Production Features & Limits


```mermaid
---
title: Case Status API - Production Features & Limits
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart LR
    subgraph Features
        direction TB
        QueryLiveReceipts["Query Live Receipt Numbers"]
        NoStagingReceipts["Staging Receipt Numbers <br> NOT Supported"]
    end

    subgraph Limits
        direction TB
        DailyQuota["Daily Quota: 150,000 requests <br> Resets: -04:00 UTC (Midnight EST)"]
        ConcurrencyLimit["API Concurrency: 10 TPS <br> (1 request / 100ms)"]
    end

    ProductionCapabilities[Case Status API - Production <br> Features & Capabilities]
    ProductionCapabilities --> Features
    ProductionCapabilities --> Limits

    style ProductionCapabilities fill:#f399,stroke:#333,stroke-width:2px
    style Features fill:#c3c9,stroke:#333,stroke-width:1px
    style Limits fill:#c3c9,stroke:#333,stroke-width:1px
    
```




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---