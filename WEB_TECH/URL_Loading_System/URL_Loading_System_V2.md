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


The diagrams and illustrations below are enhanced versions of those in the previous documentation: [this documentation](/WEB_TECH/URL_Loading_System/URL_Loading_System_V1.md).



---


## Diagram 1: Enhanced Core Components Class Diagram

This class diagram is enhanced to provide even more clarity on the attributes, methods, and relationships between the core classes of the URL Loading System.  We'll add detail to methods and clarify inheritance.

```mermaid
---
title: Enhanced Core Components Class Diagram
config:
  look: handDrawn
  theme: dark
---
classDiagram
    class URLSession {
        +configuration: URLSessionConfiguration
        +delegate: URLSessionDelegate?
        +delegateQueue: OperationQueue
        +sessionDescription: String?
        +isDiscretionary: Bool

        +dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) : URLSessionDataTask
        +downloadTask(with: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) : URLSessionDownloadTask
        +uploadTask(with: URLRequest, from: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) : URLSessionUploadTask
        +invalidateAndCancel()
        +finishTasksAndInvalidate()
        +reset(completionHandler: @escaping () -> Void)
        +... other task creation & control methods
    }
    class URLSessionConfiguration {
        +static default: URLSessionConfiguration
        +static ephemeral: URLSessionConfiguration
        +static background(withIdentifier: String): URLSessionConfiguration

        +identifier: String?
        +requestCachePolicy: URLRequest.CachePolicy
        +timeoutIntervalForRequest: TimeInterval
        +timeoutIntervalForResource: TimeInterval
        +allowsCellularAccess: Bool
        +isDiscretionary: Bool
        +protocolClasses: [AnyClass]?
        +connectionProxyDictionary: [AnyHashable : Any]?
        +httpAdditionalHeaders: [AnyHashable : Any]?
        +urlCache: URLCache?
        +httpCookieStorage: HTTPCookieStorage?
        +urlCredentialStorage: URLCredentialStorage?
        +... extensive configuration properties
    }
    class URLSessionTask {
        <<abstract>>
        +taskIdentifier: Int
        +originalRequest: URLRequest?
        +currentRequest: URLRequest?
        +response: URLResponse?
        +error: Error?
        +state: URLSessionTaskState
        +priority: Float
        +countOfBytesClientExpectedToSend: Int64
        +countOfBytesClientSent: Int64
        +countOfBytesExpectedToReceive: Int64
        +countOfBytesReceived: Int64
        +taskDescription: String?

        +resume()
        +suspend()
        +cancel()
        +progress: Progress
        +... lifecycle and state management
    }
    class URLSessionDataTask {
        <<concrete>>
        +dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    }
    class URLSessionDownloadTask {
        <<concrete>>
        +downloadTask(with: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void)
        +downloadTask(withResumeData: Data, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void)
    }
    class URLSessionUploadTask {
        <<concrete>>
        +uploadTask(with: URLRequest, fromFile: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
        +uploadTask(withStreamedRequest: URLRequest)
    }
    class URLSessionDelegate {
        <<interface>>
        +urlSession(_:dataTasksDidBecomeDownloadTasks:)
        +urlSession(_:downloadTasksDidBecomeDataTasks:)
        +urlSession(_:task:didCompleteWithError:)
        +urlSession(_:task:didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
        +... numerous delegate methods for control and events
    }
    class URLSessionDataDelegate {
        <<interface>>
        %% URLSessionDelegate <|-- URLSessionDataDelegate
        +urlSession(_:dataTask:didReceive:)
        +urlSession(_:dataTask:willCacheResponse:completionHandler:)
        +... data task specific delegate methods
    }
    class URLSessionDownloadDelegate {
        <<interface>>
        %% URLSessionDelegate <|-- URLSessionDownloadDelegate
        +urlSession(_:downloadTask:didFinishDownloadingTo:)
        +urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)
        +urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)
         +... download task specific delegate methods
    }
    class URLSessionTaskDelegate {
        <<interface>>
        %% URLSessionDelegate <|-- URLSessionTaskDelegate
        +urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)
        +urlSession(_:task:needNewBodyStream:)
        +urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)
        +... task lifecycle and control delegate methods
    }


    URLSession "1" *-- "1" URLSessionConfiguration : configuration
    URLSession "1" o-- "0..1" URLSessionDelegate : delegate
    URLSession "1" *-- "*" URLSessionTask : tasks
    URLSessionTask <|-- URLSessionDataTask : <creates>
    URLSessionTask <|-- URLSessionDownloadTask : <creates>
    URLSessionTask <|-- URLSessionUploadTask : <creates>
    URLSessionDelegate <.. URLSession : uses
    URLSessionDelegate <|-- URLSessionDataDelegate : specializes
    URLSessionDelegate <|-- URLSessionDownloadDelegate : specializes
    URLSessionDelegate <|-- URLSessionTaskDelegate : specializes


    note for URLSession "Entry point to the URL Loading System.<br>Manages tasks, configurations, and delegates."
    note for URLSessionConfiguration "Configures session behavior:<br>caching, timeouts, cellular access, proxies, cookies, etc.<br>Types: default, ephemeral, background."
    note for URLSessionTask "Abstract base for network operations.<br>State management, lifecycle control (resume, cancel, suspend).<br>Concrete types: Data, Download, Upload."
    note for URLSessionDelegate "Receives session-level events and task completion.<br>Customizable for detailed control and handling events."
    note for URLSessionDataTask "Task for retrieving data directly into memory.<br>Optimized for small to medium sized responses."
    note for URLSessionDownloadTask "Task to download files to disk.<br>Supports background downloads and resuming downloads."
    note for URLSessionUploadTask "Task for uploading data or files to servers.<br>Supports file and streamed uploads."
    note for URLSessionDataDelegate "Delegate protocol for data tasks, handling data reception and caching."
    note for URLSessionDownloadDelegate "Delegate protocol for download tasks, managing file downloads and progress."
    note for URLSessionTaskDelegate "Delegate protocol for general task-level events and control."
    
```

----

## Diagram 2: Enhanced Session & Task Creation and Execution Flowchart

This flowchart is made more detailed to incorporate the task states and the asynchronous nature more explicitly. It now better reflects the lifecycle of a `URLSessionTask`.

```mermaid
---
title: Enhanced Session & Task Creation and Execution Flowchart
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TB
    subgraph App_Process["App Process"]
    A[Start App] --> B{Configure Session?};
    B -- Yes --> BA["Choose Session Configuration <br>(Default, Ephemeral,<br>Background)"];
    BA --> C[Create URLSession <br>with Configuration];
    B -- No --> CA[Use Default <br>URLSession.shared];
    CA --> C

    C --> D{Create Task?};
    D -- Yes --> DA["Choose Task Type <br>(Data, Download, Upload,<br>Stream, WebSocket)"];
    DA --> E["Create URLSessionTask <br>(in Suspended State)"];
    D -- No --> Z[Idle, Waiting for Tasks];


    E --> F{Start Task Execution?};
    F -- Yes --> FA["Call task.resume()"];
    FA --> G["Task Enters <br>Running State <br> (Asynchronous Operation)"];
    F -- No --> EE[Task Remains Suspended];
    EE --> F
    G --> H{Task Completion <br>or Interruption?};


    H -- Success<br>(DataTask) --> HA[Data Received];
    H -- Success<br>(DownloadTask) --> HB[File Downloaded <br>to Temporary Location];
    H -- Error/Cancel --> HC["Task Enters <br>Canceling/Completed <br>State with Error"];
    H -- Interruption<br>(Suspend) --> HD["Task Enters <br>Suspended State <br> (Can Resume Later)"];


    HA --> I{"Handle Data <br> (Delegate or <br>Completion Handler)"};
    HB --> J{"Handle Downloaded File <br>(Delegate or <br>Completion Handler)"};
    HC --> K{"Handle Error <br> (Delegate or <br>Completion Handler)"};
    I --> L[Task Enters <br>Completed State];
    J --> L;
    K --> L;
    L --> M[End Task Lifecycle];

    end

    subgraph URL_Loading_System_and_Network["URL Loading System & Network"]
    G --> N["Network Request <br>in Progress <br>(Asynchronous)"];
    N --> H;
    HB --> O["File Saved <br>by System <br>(Download Task)"];
    O --> J;
    end

    M --> P[App Continues <br>or Task Ends];


    style BA fill:#c3cf,stroke:#333,stroke-width:1px
    style CA fill:#c3cf,stroke:#333,stroke-width:1px
    style DA fill:#c3cf,stroke:#333,stroke-width:1px
    style EE fill:#c3cf,stroke:#333,stroke-width:1px
    style FA fill:#c3cf,stroke:#333,stroke-width:1px


    style G fill:#f3cc,stroke:#333,stroke-width:1px
    style H fill:#f3cc,stroke:#333,stroke-width:1px
    style HA fill:#f3cc,stroke:#333,stroke-width:1px
    style HB fill:#f3cc,stroke:#333,stroke-width:1px
    style HC fill:#f3cc,stroke:#333,stroke-width:1px
    style HD fill:#f3cc,stroke:#333,stroke-width:1px
    style I fill:#f3cc,stroke:#333,stroke-width:1px
    style J fill:#f3cc,stroke:#333,stroke-width:1px
    style K fill:#f3cc,stroke:#333,stroke-width:1px
    style L fill:#f3cc,stroke:#333,stroke-width:1px
    style N fill:#f3cc,stroke:#333,stroke-width:1px
    style O fill:#f3cc,stroke:#333,stroke-width:1px


    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30 stroke-width:2px,stroke:#333,fill:none

```

---

## Diagram 3: Refined Delegate vs. Completion Handler Sequence Diagram

This sequence diagram is refined to more clearly distinguish the flow and timing of delegate calls versus completion handler execution, enhancing clarity on asynchronous handling.

```mermaid
---
title: Refined Delegate vs. Completion Handler - Handling Task Results
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

    App->>URLSession: Create URLSessionTask <br> (e.g., dataTask)
    App->>URLSession: task.resume()
    activate URLSession

    URLSession-->>URLSession: Initiate Network Request<br>(Asynchronous)

    par Delegate Handling Path
        URLSession-->>URLSessionDelegate: ... Delegate Calls Begin ...
        activate URLSessionDelegate
        URLSession-->>URLSessionDelegate: urlSession(_:task:willPerformHTTPRedirection:...)
        URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive response:...)
        URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive data:) <br> (Multiple calls as data arrives)
        URLSession-->>URLSessionDelegate: urlSession(_:task:didCompleteWithError:) <br> (Final Completion)
        URLSessionDelegate-->>App: Delegate Methods Handle <br> Events & Data Progressively
        deactivate URLSessionDelegate
    and Completion Handler Path
        opt Completion Handler is Used (No Delegate Set)
            URLSession-->>CompletionHandler: ... Completion Handler Invoked ONCE ...
            activate CompletionHandler
            CompletionHandler-->>App: Completion Handler Block <br> Executes ONCE after Task Completion<br> Provides: Data, Response, Error (All at once)
            deactivate CompletionHandler
        end
    end

    deactivate URLSession
    App->>App: Process Final Results <br> (Data Aggregated by Delegate, <br> or from Completion Handler)
    Note over App,CompletionHandler: Task lifecycle events can be handled <br> either by Delegate methods (progressive, detailed) <br> or a single Completion Handler (result summary)
    
```

---

## Diagram 4: Expanded Background URLSession Mind Map

The mind map is expanded with more detail and reorganized for better logical flow, offering a deeper dive into background sessions.

```mermaid
---
title: Expanded Background URLSession Mind Map
config:
  theme: dark
---
mindmap
  root(("Background URLSession"))
    Purpose
      Essential_for_Background_Tasks["Essential for Background Tasks"]
        Allows_Downloads_Uploads_InBackground["Enables Downloads/Uploads <br>in Background"]
        Independent_of_App_State["Operates Independently of <br>App Foreground/Background State"]
        Supports_App_Suspension_Termination["Functionality when App is <br>Suspended or Terminated"]
      For_Long_Running_Network_Ops["Ideal for Long-Running <br>Network Operations"]
        Downloading_Large_Files["Efficient Downloading <br>of Large Files"]
        Uploading_Large_Media["Uploading Large Media Files <br>(Photos, Videos)"]
        Data_Synchronization["Background Data Sync <br>with Servers"]
      Enhances_User_Experience["Enhances User Experience"]
        Non_Blocking_UI_in_Foreground["Maintains Non-Blocking UI <br>in Foreground App"]
        Task_Completion_Guaranteed["Increased Likelihood of <br>Task Completion"]

    Configuration_Details["Configuration Details"]
      Special_Configuration["Requires Specific <br>Background Configuration"]
        URLSessionConfiguration_backgroundWithIdentifier["Use .background(withIdentifier:) <br>Configuration Factory"]
        Unique_Identifier_Required["Unique Identifier String <br>(for System Persistence)"]
      System_Managed_Lifecycle["System Managed Lifecycle & Resources"]
        System_Controls_Task_Execution["System Decides When to <br>Execute Tasks in Background"]
        Resource_Prioritization["Lower Priority Resources <br>Compared to Foreground"]
        Opportunistic_Execution["Execution During System Idle Time<br>& Optimal Network Conditions"]

    Delegate_is_Crucial["Delegate is Crucial"]
      Delegate_Required_for_Background_Sessions["Delegate MUST be set for <br>Background Sessions"]
      Event_Handling_in_Background["Delegate Handles ALL Events <br>in Background"]
        Task_Completion_DelegateMethod["URLSession(_:task:didCompleteWithError:) <br>Essential for Handling Task End"]
        Background_Session_Completion_Method["urlSessionDidFinishEvents(forBackgroundURLSession:) <br>Called when all background tasks complete"]
      App_Reactivation["App Reactivation"]
        System_Launches_App_if_Terminated["System Automatically Launches App <br>in Background if Terminated"]
        Delegate_Handles_Post_Launch_Events["Delegate Responsible for Handling <br>Events After Background App Launch"]

    Practical_Considerations["Practical Considerations"]
      Resource_Limits["System Resource Limits Apply"]
        Background_Tasks_Have_Limits["Background Tasks are Subject <br>to System Limits"]
        Avoid_Excessive_Background_Activity["Avoid Overloading Background <br>Tasks to Prevent System Issues"]
      User_Privacy_and_Data["User Privacy & Data Usage"]
        Respect_User_Data_Settings["Adhere to User Preferences <br>(Cellular Data, Background App Refresh)"]
        Minimize_Data_Transfer["Optimize Data Transfer <br>to Minimize Usage"]
      Error_Handling_is_Key["Robust Error Handling is Key"]
        Background_Tasks_Less_Visible_to_User["Errors in Background May Be <br>Less Immediately Noticeable to User"]
        Comprehensive_Delegate_Error_Handling["Implement Comprehensive Error Handling <br>in Delegate Methods"]

    Benefits_Summary["Benefits Summary"]
      Improved_App_Responsiveness["Improved App Responsiveness"]
        Offloads_Network_Tasks["Offloads Long Network Tasks <br>from Foreground UI Thread"]
        Maintains_Smooth_UI["Maintains Smooth & Responsive <br>User Interface"]
      Resilience_to_App_State_Changes["Resilience to App State Changes"]
        Tasks_Continue_Across_Suspension["Tasks Continue Even if App is Suspended <br>or Terminated by User/System"]
        Enhanced_Reliability["Enhanced Reliability for <br>Critical Network Operations"]


    Limitations_and_Caveats["Limitations & Caveats"]
      System_Controlled_Timing["System Controlled Timing"]
        Less_Predictable_Execution_Timing["Execution Timing Less Predictable <br>than Foreground Tasks"]
        Not_Suitable_for_RealTime["Not Suitable for Real-Time <br>or Immediate Response Tasks"]
      Limited_Control["Limited Control After Task Start"]
        Less_Direct_Control_Over_Task_Pacing["Less Direct Control Over Task <br>Pacing and Scheduling"]
        Delegate_Driven_Management["Management Largely Delegate-Driven <br>after Task Initiation"]
        
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---