---
created: 2024-12-11 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


# Objective-C and UIKit Integration

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


## High-Level Application Lifecycle Diagram

This diagram captures the overarching states of an iOS application managed primarily by UIKit, with explicit inclusion of **Objective-C delegate methods** and the **bridging between Objective-C and Swift**.

```mermaid
---
title: High-Level Application Lifecycle Diagram
config:
  layout: elk
  look: handDrawn
  theme: dark
---
stateDiagram-v2
    %% Define styles
    classDef lifecycleStarts fill:#6c8ebf,stroke:#333,stroke-width:2px,roundedCorners
    classDef lifecycleEnds fill:#bf6c6c,stroke:#333,stroke-width:2px,roundedCorners
    classDef lifecycleActive fill:#6bbf6c,stroke:#333,stroke-width:2px,roundedCorners
    classDef UIKitProcess fill:#f5a623,stroke:#333,stroke-width:2px,roundedCorners, fontColor:#000
    classDef ObjCProcess fill:#8e44ad,stroke:#333,stroke-width:2px,roundedCorners, fontColor:#fff

    %% Application Lifecycle States
    [*] --> NotRunning : Launch
    
    NotRunning --> Inactive : application didFinishLaunchingWithOptions<br>(Objective-C)
    Inactive --> Active : applicationDidBecomeActive<br>(Objective-C)
    
    Active --> Inactive : applicationWillResignActive<br>(Objective-C)<br>(e.g., Incoming Call, User Presses Home/Lock)
    Inactive --> Active : applicationDidBecomeActive<br>(Objective-C)
    
    Active --> Background : applicationDidEnterBackground<br>(Objective-C)<br>(Home Button Pressed / App Switch)
    Inactive --> Background : applicationDidEnterBackground<br>(Objective-C)<br>(Move to Background)
    
    Background --> Suspended : No Active Tasks
    Background --> NotRunning : System Terminates App
    Suspended --> NotRunning : System Terminates App
    
    Suspended --> Inactive : Relaunch App<br>(State Restoration)
    
    %% Objective-C Methods Node
    %% ObjCMethods["Objective-C UIApplicationDelegate Methods"]:::ObjCProcess
    
    %% Transitions to Objective-C Methods
    Inactive --> ObjCMethods : Handles State Transitions
    Active --> ObjCMethods : Handles State Transitions
    Background --> ObjCMethods : Handles State Transitions
    Suspended --> ObjCMethods : Handles State Transitions
    NotRunning --> ObjCMethods : Handles Launch
    
    %% Styling
    class NotRunning,ObjCMethods lifecycleStarts
    class NotRunning,ObjCMethods --> lifecycleEnds

```

### Key Enhancements

1. **Objective-C Delegate Methods:**
    - **`application:didFinishLaunchingWithOptions:`** : Called when the app has finished launching. Typically used for initial setup.
    - **`applicationDidBecomeActive:`** : Invoked when the app moves from inactive to active state.
    - **`applicationWillResignActive:`** : Called when the app is about to move from active to inactive state.
    - **`applicationDidEnterBackground:`** : Triggered when the app enters the background.
    - **`applicationWillTerminate:`** : Optional method called when the app is about to terminate.
2. **Bridging Objective-C and Swift:**
    - **`@UIApplicationMain`** attribute in Swift bridges to the Objective-C `UIApplicationDelegate` methods.
    - When using SwiftUI with UIKit lifecycle methods, Objective-C bridge methods handle the application states.

### Explanation of Enhancements

- **Objective-C Methods Integration:** The diagram now explicitly shows how Objective-C `UIApplicationDelegate` methods correspond to state transitions. This is crucial for applications that still leverage UIKit’s delegate pattern alongside SwiftUI.
- **Bridging Mechanism:** The `ObjCMethods` node represents the collection of Objective-C delegate methods that manage state transitions. This bridge ensures that even in a SwiftUI environment, the traditional Objective-C lifecycle methods are recognized and handled appropriately.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---

