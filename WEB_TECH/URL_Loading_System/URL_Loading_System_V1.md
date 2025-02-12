---
created: 2025-02-11 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: https://developer.apple.com/documentation/foundation/url_loading_system
---



# URL Loading System
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----


Below is a collection of diagrams and illustrations on explaining how the URL Loading System works accordingly to the original Apple documentation article at [here](https://developer.apple.com/documentation/foundation/url_loading_system).



## Diagram 1: Core Components Class Diagram


This diagram will illustrate the main classes and their relationships within the URL Loading System. It’s crucial to visualize how `URLSession`, `URLSessionConfiguration`, and `URLSessionTask` interact.

```mermaid
---
title: Core Components Class Diagram
config:
  look: handDrawn
  theme: dark
---
classDiagram
    class URLSession {
        +URLSessionConfiguration configuration
        +URLSessionDelegate? delegate
        +URLSessionTask dataTask(with request: URLRequest)
        +URLSessionTask downloadTask(with url: URL)
        +URLSessionTask uploadTask(with request: URLRequest, from bodyData: Data)
        +... other task creation methods
    }
    class URLSessionConfiguration {
        +URLSessionConfiguration default
        +URLSessionConfiguration ephemeral
        +URLSessionConfiguration background(withIdentifier: String)
        +URLCache? urlCache
        +URLCredentialStorage? credentialStorage
        +HTTPCookieStorage? cookieStorage
        +Bool allowsCellularAccess
        +... many configuration options
    }
    class URLSessionTask {
        <<abstract>>
        +URLRequest originalRequest
        +URLRequest currentRequest
        +URLSessionTaskState state
        +func resume()
        +func cancel()
        +... task lifecycle methods
    }
    class URLSessionDataTask {
        <<concrete>>
    }
    class URLSessionDownloadTask {
        <<concrete>>
    }
    class URLSessionUploadTask {
        <<concrete>>
    }
    class URLSessionDelegate {
        <<interface>>
        +urlSession(_:dataTasksDidBecomeDownloadTasks:)
        +urlSession(_:task:didCompleteWithError:)
        +... many delegate methods
    }

    URLSession "1" *-- "1" URLSessionConfiguration : configuration
    URLSession "1" o-- "0..1" URLSessionDelegate : delegate
    URLSession "1" *-- "*" URLSessionTask : tasks
    URLSessionTask <|-- URLSessionDataTask : <creates>
    URLSessionTask <|-- URLSessionDownloadTask : <creates>
    URLSessionTask <|-- URLSessionUploadTask : <creates>
    URLSessionDelegate <.. URLSession : uses

    note for URLSession "Entry point to the URL Loading System.<br>Manages tasks and configurations"
    note for URLSessionConfiguration "Configures the behavior of a URLSession (caching, cookies, etc.).<br>Different types (default, ephemeral, background)"
    note for URLSessionTask "Represents an asynchronous operation.<br>Abstract class with concrete subclasses for data, download, and upload tasks"
    note for URLSessionDelegate "Optional delegate to receive session events and customize behavior"
    note for URLSessionDataTask "Task to retrieve data in memory"
    note for URLSessionDownloadTask "Task to download a file to disk"
    note for URLSessionUploadTask "Task to upload data or a file"
    
```

----


## Diagram 2:  Session & Task Creation Flowchart



This flowchart will depict the process of creating a `URLSession` and then generating different types of `URLSessionTask` instances from it, as highlighted in Figure 1 of the documentation.

```mermaid
---
title: Session & Task Creation Flowchart
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    subgraph "App"
    A[Start] --> B{Choose Session Configuration};
    B -- Default Configuration --> C[Create URLSession with Default Configuration];
    B -- Ephemeral Configuration --> D[Create URLSession with Ephemeral Configuration];
    B -- Background Configuration --> E[Create URLSession with Background Configuration];

    C --> F{"Create URLSessionTask(s)"};
    D --> F;
    E --> F;

    F -- Data Task --> G[Create URLSessionDataTask];
    F -- Download Task --> H[Create URLSessionDownloadTask];
    F -- Upload Task --> I[Create URLSessionUploadTask];
    F -- ...Other Task Types... --> J[Create Other Task Types];

    G --> K["Task Ready to Run<br>(Suspended State)"];
    H --> K;
    I --> K;
    J --> K;

    K --> L{Start Task};
    L --> M["Call task.resume()"];
    M --> N[Task Begins Asynchronous Operation];
    end

    subgraph "URL Loading System"
    N --> O{Task Completion or Error};
    O -- Success<br>(Data) --> P[Data Received];
    O -- Success<br>(File Download) --> Q[File Downloaded to Disk];
    O -- Error --> R[Error Occurred];

    P --> S{"Handle Data<br>(Delegate or Completion Handler)"};
    Q --> T{"Handle File<br>(Delegate or Completion Handler)"};
    R --> U{"Handle Error<br>(Delegate or Completion Handler)"};

    S --> V[Task Finished];
    T --> V;
    U --> V;
    end

    V --> W[End];

    style B fill:#c3cf,stroke:#333,stroke-width:1px
    style C fill:#c3cf,stroke:#333,stroke-width:1px
    style D fill:#c3cf,stroke:#333,stroke-width:1px
    style E fill:#c3cf,stroke:#333,stroke-width:1px
    style F fill:#c3cf,stroke:#333,stroke-width:1px
    style G fill:#c3cf,stroke:#333,stroke-width:1px
    style H fill:#c3cf,stroke:#333,stroke-width:1px
    style I fill:#c3cf,stroke:#333,stroke-width:1px
    style J fill:#c3cf,stroke:#333,stroke-width:1px
    style K fill:#c3cf,stroke:#333,stroke-width:1px
    style L fill:#c3cf,stroke:#333,stroke-width:1px
    style M fill:#c3cf,stroke:#333,stroke-width:1px
    style N fill:#f3cc,stroke:#333,stroke-width:1px
    style O fill:#f3cc,stroke:#333,stroke-width:1px
    style P fill:#f3cc,stroke:#333,stroke-width:1px
    style Q fill:#f3cc,stroke:#333,stroke-width:1px
    style R fill:#f3cc,stroke:#333,stroke-width:1px
    style S fill:#f3cc,stroke:#333,stroke-width:1px
    style T fill:#f3cc,stroke:#333,stroke-width:1px
    style U fill:#f3cc,stroke:#333,stroke-width:1px
    style V fill:#f3cc,stroke:#333,stroke-width:1px

    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 stroke-width:2px,stroke:#333,fill:none
    
```

---


## Diagram 3: Delegate vs. Completion Handler Sequence Diagram



This sequence diagram will illustrate the two ways to handle the result of a `URLSessionTask`: using a delegate or using a completion handler.

```mermaid
---
title: Delegate vs. Completion Handler Sequence Diagram
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant App
    participant URLSession
    participant URLSessionDelegate
    participant CompletionHandler

    App->>URLSession: Create URLSessionTask
    App->>URLSession: task.resume()
    activate URLSession

    URLSession-->>URLSession: Perform Network Request<br>(Asynchronous)

    alt Using Delegate
        URLSession-->>URLSessionDelegate: urlSession(_:task:didCompleteWithError:) <br> (For Events & Results)
        activate URLSessionDelegate
        URLSessionDelegate-->>App: Delegate Methods Called <br> (Data, Download, Completion etc.)
        deactivate URLSessionDelegate
    else Using Completion Handler
        URLSession-->>CompletionHandler: Completion Handler Block Called <br> (Data, Response, Error)
        activate CompletionHandler
        CompletionHandler-->>App: Handle Results in Block
        deactivate CompletionHandler
    end

    deactivate URLSession
    App-->>App: Process Results<br>(Data, File, or Error)
    
```

---

## Diagram 4: Background Session Mind Map



This mind map will focus specifically on background sessions, highlighting their purpose, configuration, and key considerations.

```mermaid
---
title: Background URLSession
config:
  theme: dark
---
mindmap
  root(("Background URLSession"))
    Purpose
      Allows_Downloads_Uploads_in_Background["Allows Downloads/Uploads in Background"]
      App_Suspended_or_Terminated["App Suspended or Terminated"]
      Long_Running_Tasks["Long-Running Tasks"]
      Improved_User_Experience["Improved User Experience"]
    Configuration
      Background_Configuration["Background Configuration"]
      Identifier_String["Identifier (String)"]
      System_Manages_Lifecycle["System Manages Lifecycle"]
    Delegate
      Required
      Handle_Events_in_Background["Handle Events in Background"]
      App_Launch_if_Suspended_Terminated["App Launch if Suspended/Terminated"]
      URLSession_task_didCompleteWithError["URLSession(_:task:didCompleteWithError:)"]
      URLSessionDidFinishEvents_forBackgroundURLSession["URLSessionDidFinishEvents(forBackgroundURLSession:)"]
    Use_Cases["Use Cases"]
      Downloading_Large_Files["Downloading Large Files"]
      Uploading_Media["Uploading Media"]
      Syncing_Data["Syncing Data"]
    Key_Considerations["Key Considerations"]
      Requires_Specific_Configuration["Requires Specific Configuration"]
      Delegate_Implementation_Crucial["Delegate Implementation_ rucial"]
      Handle_App_Launch_from_Background["Handle App Launch from Background"]
      Resource_Limits_System_Managed["Resource Limits<br>(System Managed)"]
      User_Privacy_and_Data_Usage["User Privacy and Data Usage"]
    Benefits
      Offload_Tasks_from_Foreground["Offload Tasks from Foreground"]
      Non_Blocking_UI["Non-Blocking UI"]
      Resilient_to_App_State_Changes["Resilient to App State Changes"]
    Limitations
      System_Controlled_Execution["System Controlled Execution"]
      Not_for_Real_time_Tasks["Not for Real-time Tasks"]
      Limited_Control_Over_Timing["Limited Control Over Timing"]
      
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---