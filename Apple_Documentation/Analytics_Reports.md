---
created: 2025-02-25 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/documentation/analytics-reports"
---



# Analytics Reports - A Diagrammatical Summary
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



## 1. Overview and Access Control

This diagram illustrates the core purpose of the API and the roles that have access to it.

```mermaid
graph LR
    A[Analytics Reports API] --> B(Analyze App Data);
    B --> B1[App Store Engagement];
    B --> B2[App Store Commerce];
    B --> B3[App Usage];
    B --> B4[Framework Usage];
    B --> B5[Performance];

    A --> C{API Key Roles};
    C --> C1[ADMIN];
    C --> C2[SALES_AND_REPORTS];
    C --> C3[FINANCE];

    style A fill:#a2c4,stroke:#333,stroke-width:2px;
    style C fill:#c5cf,stroke:#333,stroke-width:1px;
```

**Explanation:**

*   The **Analytics Reports API** (A) allows analysis of app data (B) across various categories.
*   Access is controlled through API Key Roles (C), specifically `ADMIN`, `SALES_AND_REPORTS`, and `FINANCE`.

----

## 2. Report Downloading and Processing

This sequence diagram depicts the steps involved in requesting, downloading, and processing reports.

```mermaid
sequenceDiagram
    actor Developer
    participant AppStoreConnectAPI
    participant AnalyticsReportAPI

    Developer->>AppStoreConnectAPI: POST /v1/analyticsReportRequests (Request Reports)
    activate AppStoreConnectAPI
    AppStoreConnectAPI-->>Developer: Request Created
    deactivate AppStoreConnectAPI

    loop Polling for Report Instances
        Developer->>AppStoreConnectAPI: GET /v1/analyticsReportRequests/{id} (Read Report Request)
        activate AppStoreConnectAPI
        AppStoreConnectAPI-->>Developer: Report Request Status (Instances)
        deactivate AppStoreConnectAPI
    end

    Developer->>AnalyticsReportAPI: Download Report Instance (Multiple Segments)
    activate AnalyticsReportAPI
    AnalyticsReportAPI-->>Developer: Report Segment Data
    deactivate AnalyticsReportAPI

    Developer->>Developer: Combine Segments for Complete Data
```

**Explanation:**

1.  The **Developer** initiates a report request via the App Store Connect API (`POST /v1/analyticsReportRequests`).
2.  The developer then *polls* the API (`GET /v1/analyticsReportRequests/{id}`) to check for the availability of report *instances*.  This is a crucial step; reports aren't generated until requested.
3.  Once an instance is available, the **Developer** downloads it from the Analytics Report API.  Crucially, each instance might be split into *segments*, requiring multiple downloads.
4.  The **Developer** combines the segments to get the complete data set for that instance.

----

## 3. Report Granularity and Data Completeness

This diagram shows how report instances are grouped by time.

```mermaid
graph TD
    A[Report Instance] --> B{Granularity};
    B --> B1[Daily];
    B1 --> B1A[Data for one or more days];
    B1 --> B1B["Date" column indicates event day];
    B --> B2[Weekly];
    B2 --> B2A[Monday to Sunday];
    B --> B3[Monthly];
    B3 --> B3A[Full Month Data];

    style A fill:#a2c4,stroke:#333,stroke-width:2px;
```

**Explanation:**

*   Each **Report Instance** (A) has a specific **Granularity** (B):
    *   **Daily** (B1):  May contain data for one *or more* days.  The "Date" column in the report specifies the day of the events.
    *   **Weekly** (B2): Always covers Monday to Sunday.
    *   **Monthly** (B3): Covers a complete calendar month.

----

## 4. Report Structure and Schema Changes

This section uses a simple table and a note to emphasize key points about report structure and future changes.

| Column Name | Description                                        | Data Type    |
| :---------- | :------------------------------------------------- | :----------- |
| Date        | Date of the event                                  | Date         |
| Metric1     | Description of the first metric...                  | Numeric/Text |
| Metric2     | Description of the second metric...                 | Numeric/Text |
| ...         | ...                                                | ...          |

**Important Note:**  The documentation emphasizes relying on *column names* rather than *column positions* because the positions might change in future updates.  Report values are *not* case-sensitive. This is crucial for robust data processing.

----

## 5. Report Categories and Specific Reports

This mind map provides a hierarchical view of the different report categories and some example specific reports.

```mermaid
mindmap
  root((Analytics Reports))
    App_Store_Engagement
      Description(How people find, discover, and share your app)
    App_Store_Commerce
      Description(Downloads, pre-orders, and purchases)
      App_Store_Pre-orders(Pre-order details)
    App_Usage
      Description(How people interact with your apps)
      App_Crashes(Crash reports)
      App_Sessions(Session analysis)
    Framework_Usage
      Description(App and API usage)
      App_Runtime_Usage(Dynamic library symbol execution)
      Audio_Input_Muting(Muting gestures in conferencing apps)
      Home_Screen_Widgets(Widget additions to Smart Stack)
      Browser_Choice_Screen_Selection(Default browser selection)
    Performance
      Description(App performance and user interactions)
      Audio_Overloads(Audio glitches)
```

**Explanation:**

This mind map organizes the reports into five main categories:

*   **App Store Engagement:**  Discovery and sharing.
*   **App Store Commerce:**  Purchases and downloads.
*   **App Usage:**  User interaction (sessions, crashes).
*   **Framework Usage:**  How the app interacts with system APIs and frameworks.
*   **Performance:**  Metrics related to app performance (e.g., audio glitches).

Within each category, specific reports are listed (e.g., "App Crashes" under "App Usage").

----

## 6. Combined Conceptual Diagram

This combines some of the previous concepts into a single, more comprehensive diagram:

```mermaid
graph LR
    A[Developer] --> B[App Store Connect API];
    B --> C[Request Reports];
    C --> D[Analytics Reports API];
    D --> E[Report Instances];
    E --> F{Granularity};
    F --> F1[Daily];
    F --> F2[Weekly];
    F --> F3[Monthly];
    E --> G[Segments];
    G --> H[Combined Data];

    B --> I[Read Report Request];
    I --> E;

    D --> J[Report Categories];
    J --> J1[App Store Engagement];
    J --> J2[App Store Commerce];
    J --> J3[App Usage];
    J --> J4[Framework Usage];
    J --> J5[Performance];

    style A fill:#d2e4,stroke:#333,stroke-width:1px;
    style B fill:#a2c4,stroke:#333,stroke-width:2px;
    style D fill:#a2c4,stroke:#333,stroke-width:2px;
```

This diagram shows the flow from the developer requesting reports, through the APIs, to the final combined data, and also includes the report categories.

---

## 7. Data Flow Visualization

This diagram illustrates the data flow with different granularities in a data pipeline-like visualization:

```mermaid
graph LR
    A[Raw Data] --> B{Daily Aggregation};
    B --> C[Daily Reports];
    C --> D[Data Warehouse];

    A --> E{Weekly Aggregation};
    E --> F[Weekly Reports];
    F --> D;

    A --> G{Monthly Aggregation};
    G --> H[Monthly Reports];
    H --> D;

    style A fill:#a2f4,stroke:#333,stroke-width:1px;
    style B fill:#f2c4,stroke:#333,stroke-width:1px;
    style E fill:#f2c4,stroke:#333,stroke-width:1px;
    style G fill:#f2c4,stroke:#333,stroke-width:1px;
```
**Explanation:**
This diagram visually explains how the API handles different time frames, and uses a conceptual "Data Warehouse" to represent where the aggregated data is stored for further analysis.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---