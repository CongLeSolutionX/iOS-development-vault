---
created: 2025-02-11 05:48:19
original source: https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Fetching website data into memory
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----

# 1. Diagram: Task Type Choice


*   **Purpose:** To clearly differentiate between `URLSessionDataTask` and `URLSessionDownloadTask` based on their use cases, as introduced in the overview.
*   **Type:** Flowchart

```mermaid
---
title: Task Type Choice
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Start"];
    B{"Data Transfer Task?"};
    C{"Small Interaction with Server?"};
    D["URLSessionDataTask"];
    E["URLSessionDownloadTask"];
    F["Other URLSession Tasks"];
    G("Receive data in Memory");
    H("Store data in File System");
    I("Explore other task types");
    
    A --> B
    B -- Yes --> C
    C -- Yes --> D
    C -- No --> E
    B -- No --> F
    D --> G
    E --> H
    F --> I
    
    style D fill:#c3cf,stroke:#333,stroke-width:1.5px
    style E fill:#c3ff,stroke:#333,stroke-width:1.5px
    
```





---

# 2. Diagram: Session Configuration Options



*   **Purpose:** To illustrate the choice between using the `shared` session and creating a custom session with a delegate.
*   **Type:** Flowchart

```mermaid
---
title: Session Configuration Options
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Start"];
    B{"Simple Needs?"};
    C["Use URLSession.shared"];
    D{"Delegate Interaction Needed?"};
    E["Create Custom URLSession"];
    F["Configure URLSessionConfiguration"];
    G["Implement URLSessionDelegate Protocols"];
    H("Simple data fetching");
    I("Customize session behavior");
    J("Advanced control & event handling");
    
    A --> B
    B -- Yes --> C
    B -- No --> D
    D -- Yes --> E
    D -- No --> C
    E --> F
    E --> G
    C --> H
    F --> I
    G --> J
    
    style C fill:#c3fc,stroke:#333,stroke-width:1.5px
    style E fill:#f3fc,stroke:#333,stroke-width:1.5px
    
```

---

# 3. Diagram: Completion Handler Flow (Recreation of Figure 1)



*   **Purpose:** To visualize the process of using a completion handler with `URLSessionDataTask`.
*   **Type:** Sequence Diagram

```mermaid
---
title: Completion Handler Flow (Recreation of Figure 1)
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant App
    participant URLSession
    participant URLSessionDataTask
    participant Server
    participant CompletionHandler

    App->>URLSession: Create dataTask(with:completionHandler:)
    URLSession->>URLSessionDataTask: Create Task
    App->>URLSessionDataTask: resume()
    URLSessionDataTask->>Server: Send Request
    Server-->>URLSessionDataTask: Response, Data
    URLSessionDataTask-->>CompletionHandler: Deliver: data, response, error
    CompletionHandler->>App: Handle results (data, response, error)
    
```


----

# 4. Diagram: Delegate Flow (Recreation of Figure 2)


*   **Purpose:** To illustrate the process of using a delegate to receive transfer details and results with `URLSessionDataTask`.
*   **Type:** Sequence Diagram

```mermaid
---
title: Delegate Flow (Recreation of Figure 2)
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
    participant URLSessionDataTask
    participant Server

    App->>URLSession: Create URLSession(configuration:delegate:delegateQueue:)
    App->>URLSession: Create dataTask(with:)
    URLSession->>URLSessionDataTask: Create Task
    App->>URLSessionDataTask: resume()
    URLSessionDataTask->>Server: Send Request
    Server-->>URLSessionDataTask: Response Data Chunks
    loop Data Received
        URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive:) with Data Chunk
        URLSessionDelegate->>App: Process Data Chunk
    end
    Server-->>URLSessionDataTask: Complete or Error
    URLSession-->>URLSessionDelegate: urlSession(_:task:didCompleteWithError:)
    URLSessionDelegate->>App: Handle Completion or Error
    
```

---

# 5. Diagram: Delegate Protocol Hierarchy




*   **Purpose:** To showcase the hierarchy and relationships of the important delegate protocols mentioned in the document.
*   **Type:** Class Diagram

```mermaid
---
title: Delegate Protocol Hierarchy
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class URLSessionDelegate {
        <<protocol>>
        +urlSession(_:didBecomeInvalidWithError:)
        +urlSessionDidFinishEvents(forBackgroundURLSession:)
        +...
    }
    class URLSessionTaskDelegate {
        <<protocol>>
        +urlSession(_:task:willPerformHTTPRedirection:newRequest:completionHandler:)
        +urlSession(_:task:didReceive:challenge:completionHandler:)
        +urlSession(_:task:needNewBodyStream:)
        +urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)
        +urlSession(_:task:didFinishCollectingMetrics:)
        +urlSession(_:task:countOfBytesClientExpectsToSend:)
        +urlSession(_:task:countOfBytesClientExpectsToReceive:)
        +urlSession(_:task:didCompleteWithError:)
        +...
    }
    class URLSessionDataDelegate {
        <<protocol>>
        +urlSession(_:dataTask:didReceive:response:completionHandler:)
        +urlSession(_:dataTask:didBecomeStreamTask:)
        +urlSession(_:dataTask:didBecomeDownloadTask:)
        +urlSession(_:dataTask:didReceive:)
        +urlSessionDataTaskDidBecomeDownloadTask(_:fromDataTask:)
        +urlSessionDataTaskDidReceiveResponse(_:dataTask:response:completionHandler:)
        +urlSessionDataTask(_:dataTask:didReceive:)
        +urlSessionDataTask(_:dataTask:willCacheResponse:completionHandler:)
        +...
    }
    class URLSessionDownloadDelegate {
        <<protocol>>
        +urlSession(_:downloadTask:didFinishDownloadingTo:)
        +urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)
        +urlSession(_:downloadTask:didResumeAtOffset:expectedTotalBytes:)
        +urlSession(_:downloadTask:willBeginDelayedRequest:request:completionHandler:)
        +urlSession(_:downloadTask:needNewBodyStream:)
        +urlSession(_:downloadTask:didStreamTaskForChallenge:)
        +...
    }

    URLSessionDelegate <|-- URLSessionTaskDelegate
    URLSessionTaskDelegate <|-- URLSessionDataDelegate
    URLSessionTaskDelegate <|-- URLSessionDownloadDelegate
    URLSessionDataDelegate --|> URLSessionDelegate : Inherits from
    URLSessionTaskDelegate --|> URLSessionDelegate : Inherits from
    URLSessionDownloadDelegate --|> URLSessionDelegate : Inherits from
    URLSessionDataDelegate --|> URLSessionTaskDelegate : Inherits from
    URLSessionDownloadDelegate --|> URLSessionTaskDelegate : Inherits from

    style URLSessionDelegate fill:#f3cf,stroke:#333,stroke-width:1px
    style URLSessionTaskDelegate fill:#f3cc,stroke:#333,stroke-width:1px
    style URLSessionDataDelegate fill:#c3cf,stroke:#333,stroke-width:1px
    style URLSessionDownloadDelegate fill:#c3fc,stroke:#333,stroke-width:1px
    
```

----

# 6. Table: Comparison of Completion Handler vs Delegate


*   **Purpose:** To summarize the key differences and trade-offs between using completion handlers and delegates for `URLSessionDataTask`.
*   **Type:** Markdown Table (as Mermaid tables are less versatile for complex comparison)

| Feature               | Completion Handler                                  | Delegate                                             |
|-----------------------|----------------------------------------------------|------------------------------------------------------|
| **Complexity**        | Simpler, easier for basic tasks                    | More complex, requires delegate implementation        |
| **Control**           | Limited control over transfer process             | Fine-grained control, event-driven handling            |
| **Event Handling**    | Receives results only at the end (or error)        | Receives updates throughout the transfer (progress, data chunks, etc.) |
| **Use Cases**         | Simple data fetching, one-off requests            | Background tasks, progress updates, authentication, redirects, advanced handling |
| **Memory Management** | Easier to manage in simple cases                   | Requires careful management when accumulating data chunks |
| **Code Structure**    | Closure-based, can lead to "callback hell" in complex scenarios | Delegate methods, promotes better code organization for complex tasks |


----




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---