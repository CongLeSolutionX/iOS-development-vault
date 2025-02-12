---
created: 2025-02-11 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: Here
---



# A Diagrammatic Guide to URL Loading System and Data Fetching in iOS
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----
## Note: These diagrams needed to be rendered on a macOS machine to properly reflect the color system and Mermaid syntax code as intended to convey.
----
This document provides a collection of diagrams and illustrations, created using Mermaid syntax, to comprehensively explain the technical concepts of Apple's URL Loading System and fetching website data into memory. It is based on the official Apple documentations provided and enhances the existing diagrams to offer a more detailed and integrated understanding.

You can check out the sub-version of this comprehensive diagrammatic guide at these documentation: 
- [Fetching Website data into memory](/WEB_TECH/Fetching_website_data_into_memory/Fetching_website_data_into_memory_V1.md)
- [URL Loading System](/WEB_TECH/URL_Loading_System/URL_Loading_System_V1.md)

---

## 1. Integrated Class Diagram: URL Loading System Core Components

This enhanced class diagram integrates and expands upon the previous diagrams to depict the core components of the URL Loading System, their attributes, methods, and relationships in greater detail.

```mermaid
---
title: Integrated Core Components Class Diagram - URL Loading System
config:
  look: handDrawn
  theme: dark
---
classDiagram
    direction BT
    class URLSession {
        +configuration: URLSessionConfiguration
        +delegate: URLSessionDelegate?
        +delegateQueue: OperationQueue
        +sessionDescription: String?
        +isDiscretionary: Bool
        --
        +shared: URLSession (static)
        --
        +dataTask(with: URLRequest, completionHandler) : URLSessionDataTask
        +downloadTask(with: URL, completionHandler) : URLSessionDownloadTask
        +uploadTask(with: URLRequest, from: Data?, completionHandler) : URLSessionUploadTask
        +streamTask(with: Host, port) : URLSessionStreamTask
        +webSocketTask(with: URL) : URLSessionWebSocketTask
        +invalidateAndCancel()
        +finishTasksAndInvalidate()
        +reset(completionHandler)
        +getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void)
        +... task creation & management methods
    }
    class URLSessionConfiguration {
        +identifier: String?
        +requestCachePolicy: URLRequest.CachePolicy
        +timeoutIntervalForRequest: TimeInterval
        +timeoutIntervalForResource: TimeInterval
        +allowsCellularAccess: Bool
        +waitsForConnectivity: Bool
        +isDiscretionary: Bool
        +protocolClasses: [AnyClass]?
        +connectionProxyDictionary: [AnyHashable : Any]?
        +httpAdditionalHeaders: [AnyHashable : Any]?
        +urlCache: URLCache?
        +httpCookieStorage: HTTPCookieStorage?
        +urlCredentialStorage: URLCredentialStorage?
        +networkServiceType: NetworkServiceType
        +multipathServiceType: MultipathServiceType
        +allowsExpensiveNetworkAccess: Bool
        +allowsConstrainedNetworkAccess: Bool
        +shouldUseExtendedBackgroundIdleMode: Bool
        +sessionSendsLaunchEvents: Bool
        +isSharedContainerIdentifierGroupIdentifier: String?

        --
        +static default: URLSessionConfiguration
        +static ephemeral: URLSessionConfiguration
        +static background(withIdentifier: String): URLSessionConfiguration
        --
    }
    class URLSessionTask {
        <<abstract>>
        +taskIdentifier: Int
        +taskDescription: String?
        +originalRequest: URLRequest?
        +currentRequest: URLRequest?
        +response: URLResponse?
        +error: Error?
        +state: URLSessionTaskState
        +priority: Float
        +progress: Progress

        --Metrics--
        +countOfBytesClientExpectedToSend: Int64
        +countOfBytesClientSent: Int64
        +countOfBytesExpectedToReceive: Int64
        +countOfBytesReceived: Int64
        --
        +resume()
        +suspend()
        +cancel()
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
    class URLSessionStreamTask {
        <<concrete>>
    }
    class URLSessionWebSocketTask {
        <<concrete>>
    }
    class URLSessionDelegate {
        <<interface>>
        +urlSession(_:didBecomeInvalidWithError:)
        +urlSessionDidFinishEvents(forBackgroundURLSession:)
        +urlSession(_:configuration:did становятсяInvalidWithError:)
        +... session-level events
    }
    class URLSessionTaskDelegate {
        <<interface>>
        +urlSession(_:task:willPerformHTTPRedirection:...)
        +urlSession(_:task:didReceive:challenge:...)
        +urlSession(_:task:needNewBodyStream:)
        +urlSession(_:task:didSendBodyData:...)
        +urlSession(_:task:didFinishCollectingMetrics:)
        +urlSession(_:task:countOfBytesClientExpectedToSendDidChange:)
        +urlSession(_:task:countOfBytesClientSentDidChange:)
        +urlSession(_:task:countOfBytesExpectedToReceiveDidChange:)
        +urlSession(_:task:countOfBytesReceivedDidChange:)
        +urlSession(_:task:didCompleteWithError:)
        +... task lifecycle & control events
    }
    class URLSessionDataDelegate {
        <<interface>>
        +urlSession(_:dataTask:didReceive:response:completionHandler:)
        +urlSession(_:dataTask:didBecomeStreamTask:)
        +urlSession(_:dataTask:didReceive:)
        +urlSession(_:dataTask:willCacheResponse:completionHandler:)
        +... data delivery & response events
    }
    class URLSessionDownloadDelegate {
        <<interface>>
        +urlSession(_:downloadTask:didFinishDownloadingTo:)
        +urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)
        +urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)
        +urlSession(_:downloadTask:didCreateSandboxFolder:)
        +... download task specific events
    }

    URLSession "1" *-- "1" URLSessionConfiguration : configuration
    URLSession "1" o-- "0..1" URLSessionDelegate : delegate
    URLSession "1" *-- "*" URLSessionTask : tasks
    URLSessionTask <|-- URLSessionDataTask : <creates>
    URLSessionTask <|-- URLSessionDownloadTask : <creates>
    URLSessionTask <|-- URLSessionUploadTask : <creates>
    URLSessionTask <|-- URLSessionStreamTask : <creates>
    URLSessionTask <|-- URLSessionWebSocketTask : <creates>

    URLSessionDelegate <.. URLSession : uses
    URLSessionDelegate <|-- URLSessionTaskDelegate : specializes
    URLSessionDelegate <|-- URLSessionDataDelegate : specializes
    URLSessionDelegate <|-- URLSessionDownloadDelegate : specializes
    URLSessionTaskDelegate <|-- URLSessionDataDelegate : specializes
    URLSessionTaskDelegate <|-- URLSessionDownloadDelegate : specializes


    note for URLSession "Entry point to the URL Loading System.<br>Manages tasks, configurations, and delegates. Supports various task types."
    note for URLSessionConfiguration "Configures session behavior comprehensively: caching, timeouts, network access, security policies, proxies, cookies, and more.<br>Key Types: default, ephemeral, background.<br>Essential for customizing session behavior."
    note for URLSessionTask "Abstract base class for all network operations.<br>Manages task lifecycle (resume, suspend, cancel), state, priority, progress monitoring, and request/response data.<br>Foundation for Data, Download, Upload, Stream, and WebSocket Tasks."
    note for URLSessionDelegate "Interface to receive session-level events and task completion callbacks.<br>Enables custom handling of authentication challenges, redirections, and session invalidation.<br>Basis for more specialized delegates."
    note for URLSessionDataTask "Specialized task for retrieving data directly into memory.<br>Efficient for API calls and handling small to medium-sized data responses.<br>Uses completion handlers or delegates for result delivery."
    note for URLSessionDownloadTask "Task designed for downloading files to the local file system.<br>Supports background downloads and resuming interrupted downloads.<br>Optimized for large file transfers and background operations."
    note for URLSessionUploadTask "Handles uploading data or files to servers.<br>Supports various upload methods including file-based and streamed requests.<br>Crucial for applications requiring content upload."
    note for URLSessionStreamTask "Enables bidirectional communication over TCP/IP connections.<br>For custom protocols or real-time data streams.<br>Provides fine-grained control over data flow."
    note for URLSessionWebSocketTask "Implements WebSocket protocol for full-duplex communication.<br>For real-time, persistent connections with servers.<br>Supports message-based data exchange."
    note for URLSessionDataDelegate "Delegate protocol specialized for data tasks.<br>Extends URLSessionTaskDelegate to include methods for handling received data and caching policies.<br>Key for delegate-based data task management."
    note for URLSessionDownloadDelegate "Delegate protocol specialized for download tasks.<br>Extends URLSessionTaskDelegate to manage file downloads, track progress, and handle download completion and resumption."
    note for URLSessionTaskDelegate "Delegate protocol extending URLSessionDelegate for task-level events.<br>Manages task-specific actions like redirection, authentication, and data sending progress.<br>Base for Data and Download Delegates."
    
```

---

## 2. Enhanced Task Execution Flow Diagram

This flowchart details the lifecycle of a `URLSessionTask` from creation to completion, emphasizing the asynchronous nature of network operations and the different task states.

```mermaid
---
title: Enhanced Task Execution Flow - URLSessionTask Lifecycle
config:
  layout: elk
  look: handDrawn
  theme: forest
---
flowchart TB
    subgraph App_Interaction["App Initiates Task"]
    style App_Interaction fill:#cc2f,stroke:#333,stroke-width:1.3px
    A["Create URLSessionTask <br>(in Suspended State)"] --> B{"Start Task?"};
    B -- Yes --> C["Call task.resume()"];
    B -- No --> B_Suspend["Remain Suspended"];
    end

    subgraph Task_Lifecycle["URLSessionTask Lifecycle"]
    style Task_Lifecycle fill:#c325,stroke:#333,stroke-width:1.3px
    C --> D["Task Enters <br>__Running__ State <br>(Asynchronous Network Request)"];
    D --> E{Network Operation <br>Ongoing};
    E -- Data Arrives<br>(DataTask) --> E1["__Receiving Data__ <br>(URLSessionDataDelegate methods)"];
    E -- Bytes Written<br>(UploadTask) --> E2["__Sending Data__ <br>(URLSessionTaskDelegate methods)"];
    E -- Bytes Written<br>(DownloadTask) --> E3["__Downloading Data__ <br>(URLSessionDownloadDelegate methods)"];
    E --> F{Task Event<br>Interrupt or Completion?};

    F -- Completion Success<br>(DataTask) --> FA[Data Received];
    F -- Completion Success<br>(DownloadTask) --> FB[File Downloaded <br>to Temp Location];
    F -- Error/Cancellation --> FC[Task Enters <br>__Canceling__ -> __Completed__ <br>State with Error];
    F -- Suspension<br>(task.suspend()) --> FD["Task Enters <br>__Suspended__ State <br>(Can Resume)"];
    F -- Expiration of Timeout --> FE[Task Enters __Completed__ <br>State with Timeout Error];
    F -- Server Issues Redirect --> FF["__Will Perform HTTP Redirect__ <br>(Delegate Call)"];
    F -- Auth Challenge from Server --> FG["__Did Receive Challenge__ <br>(Delegate Call)"];
    F -- Requires New Body Stream --> FH["__Need New Body Stream__ <br>(Delegate Call - rare)"];

    FA --> G{"Handle Data<br>(Delegate or <br>Completion Handler)"};
    FB --> H{"Handle Downloaded File <br>(Delegate or <br>Completion Handler)"};
    FC --> I{"Handle Error<br>(Delegate or <br>Completion Handler)"};
    FD --> J[Task in __Suspended__ <br>State];
    FE --> K{Handle Timeout Error};
    FF --> L{"Handle Redirect <br>(Delegate Logic)"};
    FG --> M{"Handle Auth Challenge <br>(Delegate Logic)"};
    FH --> N{"Provide New Body Stream <br>(Delegate Logic)"};


    G --> O[Task Enters <br>__Completed__ State];
    H --> O;
    I --> O;
    K --> O

    %% Redirect restarts network op
    L --> D

    %% Auth success restarts network op
    M --> D

    %% New body stream provided; restart upload
    N --> D
    O --> P["End Task Lifecycle"]
     end

    B_Suspend --> J

    %% Loop to remain suspended or Start Task again
    J --> B_Suspend 

    E1 --> F
    E2 --> F
    E3 --> F


    style C fill:#ccf,stroke:#333,stroke-width:1.3px
    style D fill:#fec,stroke:#333,stroke-width:1.3px,stroke-dasharray: 5 5
    style F fill:#fec,stroke:#333,stroke-width:1.3px,stroke-dasharray: 5 5
    style O fill:#cfc,stroke:#333,stroke-width:1.3px

    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37 stroke-width:1.7px,stroke:#333,fill:none, arrow-head:normal
    
```


---





---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---