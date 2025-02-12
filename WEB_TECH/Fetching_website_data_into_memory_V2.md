---
created: 2025-02-11 05:48:19
original source: https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
author: Cong Le
version: "2.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Fetching website data into memory
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----

The diagrams and illustrations below are enhanced versions of those in the previous documentation: [this documentation](/WEB_TECH/Fetching_website_data_into_memory_V1.md).



## 1. Diagram: Task Type Choice - Enhanced

*   **Purpose:** To clearly differentiate between `URLSessionDataTask` and `URLSessionDownloadTask` by highlighting their primary use cases and data handling methods.
*   **Type:** Flowchart (Enhanced with more descriptive labels)

```mermaid
---
title: Enhanced Task Type Choice
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Start Data Task"];
    B{"Nature of Data Task?"};
    C{"Primarily for Small Server Interactions?"};
    D["URLSessionDataTask"]:::dataTask;
    E["URLSessionDownloadTask"]:::downloadTask;
    F["Other URLSession Task Types"]:::otherTasks;
    G("Receive Data Directly into Memory"):::dataTaskDetail;
    H("Store Data Directly to File System"):::downloadTaskDetail;
    I("Explore other task types (e.g., Upload)"):::otherTasksDetail;
    J("Ideal for Web Service API calls"):::dataTaskUseCase;
    K("Ideal for Large File Downloads"):::downloadTaskUseCase;

    A --> B
    B -- Data Transfer Task? --> C
    C -- Yes, Small Interaction --> D
    C -- No, Likely Large Data --> E
    B -- Not Data Transfer --> F

    D --> G
    D --> J
    E --> H
    E --> K
    F --> I

    classDef dataTask fill:#c3cf,stroke:#333,stroke-width:1.5px
    classDef downloadTask fill:#c3ff,stroke:#333,stroke-width:1.5px
    classDef otherTasks fill:#e329,stroke:#333,stroke-width:1.5px
    classDef dataTaskDetail font-style:italic
    classDef downloadTaskDetail font-style:italic
    classDef otherTasksDetail font-style:italic
    classDef dataTaskUseCase font-style:bold, color:#555
    classDef downloadTaskUseCase font-style:bold, color:#555
```

---

## 2. Diagram: Session Configuration Options - Enhanced

*   **Purpose:** To clearly illustrate the decision points when choosing between a `shared` session for simplicity or a custom session for delegate-based control.
*   **Type:** Flowchart (Enhanced to emphasize benefits of each path)

```mermaid
---
title: Enhanced Session Configuration Options
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["Start Session Setup"];
    B{"Requirement Complexity?"};
    C{"Simple, Basic Data Fetching?"};
    D["Use URLSession.shared"]:::sharedSession;
    E{"Need Delegate for Advanced Control?"};
    F["Create Custom URLSession"]:::customSession;
    G["Configure URLSessionConfiguration"]:::customConfig;
    H["Implement URLSessionDelegate Protocols"]:::customDelegate;
    I("Quick & Easy for simple tasks"):::sharedBenefit;
    J("Customize session behavior<br>(timeouts, caching, etc.)"):::customBenefitConfig;
    K("Fine-grained control & Event-driven handling<br>(progress, auth, redirects)"):::customBenefitDelegate;

    A --> B
    B -- Simple Requirements? --> C
    C -- Yes, Keep it Simple --> D
    C -- No, Need More Control --> E
    E -- Yes, Delegate Needed --> F
    E -- No, Still Simple --> D

    F --> G
    F --> H
    D --> I
    G --> J
    H --> K

    classDef sharedSession fill:#c3fc,stroke:#333,stroke-width:1.5px
    classDef customSession fill:#f3fc,stroke:#333,stroke-width:1.5px
    classDef customConfig fill:#e229,stroke:#333,stroke-width:1px,  stroke-dasharray: 5 5
    classDef customDelegate fill:#e299,stroke:#333,stroke-width:1px,  stroke-dasharray: 5 5
    classDef sharedBenefit font-style:italic, color:#555
    classDef customBenefitConfig font-style:italic, color:#555
    classDef customBenefitDelegate font-style:italic, color:#555
```

---

## 3. Diagram: Completion Handler Flow - Enhanced (Recreation of Figure 1)

*   **Purpose:** To visualize the detailed process of using a completion handler with `URLSessionDataTask`, including error and response handling as per Listing 1.
*   **Type:** Sequence Diagram (Enhanced with error and response checks)

```mermaid
---
title: Enhanced Completion Handler Flow (Recreation of Figure 1)
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

    App->>URLSession: Create dataTask(with:url) { ... completionHandler ... }
    URLSession->>URLSessionDataTask: Instantiate Task with Handler
    App->>URLSessionDataTask: task.resume()
    URLSessionDataTask->>Server: Send HTTP Request
    Server-->>URLSessionDataTask: HTTP Response, Data Payload
    URLSessionDataTask-->>CompletionHandler: Deliver: data, response, error

    activate CompletionHandler
    CompletionHandler->>CompletionHandler: Check for `error` parameter
    alt Error Present
        CompletionHandler-->>App: Handle Client Error
    else No Error
        CompletionHandler->>CompletionHandler: Cast `response` to HTTPURLResponse
        alt Cast Fails or Status Code Not 200-299
            CompletionHandler-->>App: Handle Server Error<br>(non-successful HTTP Response)
        else Valid HTTPURLResponse and Success Code
            CompletionHandler->>CompletionHandler: Check MIME Type<br>(e.g., "text/html")
            alt Invalid MIME Type
                CompletionHandler->>CompletionHandler: Ignore Data<br>(Unexpected format)
            else Valid MIME Type
                CompletionHandler->>CompletionHandler: Convert `data` to String<br>(e.g., UTF8)
                CompletionHandler-->>App: Process Data<br>(e.g., load in WKWebView)
            end
        end
    end
    deactivate CompletionHandler
    
```


---

## 4. Diagram: Delegate Flow - Enhanced (Recreation of Figure 2)

*   **Purpose:** To detail the delegate-based data task process, highlighting key delegate methods and the event-driven nature of the interaction.
*   **Type:** Sequence Diagram (Enhanced with specific delegate methods and event loop)


```mermaid
---
title: Enhanced Delegate Flow (Recreation of Figure 2)
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

    App->>URLSession: Create URLSession(config, delegate, queue)
    App->>URLSession: Create dataTask(with:url)
    URLSession->>URLSessionDataTask: Instantiate Task & Assign Delegate
    App->>URLSessionDataTask: task.resume()
    URLSessionDataTask->>Server: Send HTTP Request
    Server-->>URLSessionDataTask: HTTP Response Headers

    activate URLSessionDelegate
    URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive:response:completionHandler:)
    URLSessionDelegate->>URLSessionDelegate: Validate Response<br>(Status, MIME Type)
    alt Response Valid
        URLSessionDelegate-->>URLSession: completionHandler(.allow)
    else Response Invalid
        URLSessionDelegate-->>URLSession: completionHandler(.cancel)
        Server-->>URLSessionDataTask: [Transfer Cancelled]
        URLSession-->>URLSessionDelegate: urlSession(_:task:didCompleteWithError:)
        URLSessionDelegate-->>App: Handle Error<br>(if any from cancellation)
        Note over App, Server: Transfer Terminated
    end
    deactivate URLSessionDelegate

    Server-->>URLSessionDataTask: Data Chunk 1
    activate URLSessionDelegate
    URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive:) with Data Chunk 1
    URLSessionDelegate->>App: Append Data Chunk to Buffer
    deactivate URLSessionDelegate

    Server-->>URLSessionDataTask: Data Chunk 2
    activate URLSessionDelegate
    URLSession-->>URLSessionDelegate: urlSession(_:dataTask:didReceive:) with Data Chunk 2
    URLSessionDelegate->>App: Append Data Chunk to Buffer
    deactivate URLSessionDelegate
    Note over URLSessionDataTask, Server: ... More Data Chunks may follow ...

    Server-->>URLSessionDataTask: [Transfer Complete/Error]
    activate URLSessionDelegate
    URLSession-->>URLSessionDelegate: urlSession(_:task:didCompleteWithError:)
    URLSessionDelegate->>URLSessionDelegate: Check for `error` parameter
    alt No Error
        URLSessionDelegate->>App: Process Received Data Buffer
    else Error Present
        URLSessionDelegate-->>App: Handle Client/Server Error
    end
    deactivate URLSessionDelegate
    
```


---

## 5. Diagram: Delegate Protocol Hierarchy - Enhanced

*   **Purpose:** To clearly depict the inheritance hierarchy of `URLSessionDelegate` protocols and specify the core responsibilities of each protocol.
*   **Type:** Class Diagram (Enhanced with protocol responsibilities and clearer relationships)

```mermaid
---
title: Enhanced Delegate Protocol Hierarchy
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    direction BT
    class URLSessionDelegate {
        <<protocol>>
        Handles Session-level events
        ---
        +urlSession(_:didBecomeInvalidWithError:)
        +urlSessionDidFinishEvents(forBackgroundURLSession:)
        +... (Generic Session Events)
    }
    class URLSessionTaskDelegate {
        <<protocol>>
        Handles Task-level events
        ---
        +urlSession(_:task:willPerformHTTPRedirection:...)
        +urlSession(_:task:didReceive:challenge:...)
        +urlSession(_:task:didSendBodyData:...)
        +urlSession(_:task:didCompleteWithError:)
        +... (Task Lifecycle & Control)
    }
    class URLSessionDataDelegate {
        <<protocol>>
        Specializes in Data Tasks
        Handles data-specific events
        ---
        +urlSession(_:dataTask:didReceive:response:completionHandler:)
        +urlSession(_:dataTask:didReceive:)
        +urlSessionDataTaskDidBecomeDownloadTask(_:fromDataTask:)
        +... (Data Delivery & Response Handling)
    }
    class URLSessionDownloadDelegate {
        <<protocol>>
        Specializes in Download Tasks
        Handles download-specific events
        ---
        +urlSession(_:downloadTask:didFinishDownloadingTo:)
        +urlSession(_:downloadTask:didWriteData:...)
        +urlSession(_:downloadTask:didResumeAtOffset:...)
        +... (File Download Management)
    }

    URLSessionDelegate <|-- URLSessionTaskDelegate : Inherits from &<br>extends for tasks
    URLSessionTaskDelegate <|-- URLSessionDataDelegate : Inherits from &<br>extends for data
    URLSessionTaskDelegate <|-- URLSessionDownloadDelegate : Inherits from &<br>extends for downloads

    style URLSessionDelegate fill:#f3cf,stroke:#333,stroke-width:1px
    style URLSessionTaskDelegate fill:#f3cc,stroke:#333,stroke-width:1px
    style URLSessionDataDelegate fill:#c3cf,stroke:#333,stroke-width:1px
    style URLSessionDownloadDelegate fill:#c3fc,stroke:#333,stroke-width:1px
    
```

---

## 6. Table: Comparison of Completion Handler vs Delegate - Enhanced

*   **Purpose:**  To provide a more nuanced comparison emphasizing the scenarios best suited for each approach and highlighting the trade-offs in control, complexity, and features.
*   **Type:** Markdown Table (Enhanced with more specific feature descriptions)

| Feature                   | Completion Handler                                                 | Delegate                                                                 |
|---------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------------|
| **Complexity**            | Simpler to implement, concise for basic operations                  | More complex setup, requires implementing delegate protocol methods      |
| **Control Level**         | Basic: Results at completion, limited interim control               | Fine-grained: Event-driven, continuous updates & control throughout transfer |
| **Event Handling**        | Primarily handles end-of-transfer results (data, response, error)   | Handles numerous events: progress, data chunks, redirects, authentication, errors |
| **Ideal Use Cases**       | One-off, simple data requests; quick API calls where progress is not critical | Background tasks, file downloads, UIs needing progress indicators, advanced network handling |
| **Data Handling**         | Receives all data at once at the end                              | Receives data in chunks as it arrives, better for large data streams      |
| **Error Management**      | Basic error reporting at completion                                  | Comprehensive error and event reporting throughout the task lifecycle     |
| **Code Structure**        | Closure-based, can get nested/complex for error handling          | Delegate methods promote better organization for complex, event-driven logic|
| **Memory Considerations** | Simpler management for single-shot data retrieval                  | Requires more careful buffer management if accumulating received data chunks |
| **Best for:**              | **Simple, fire-and-forget requests**                               | **Complex interactions, requiring detailed transfer insights & control**   |

---


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---