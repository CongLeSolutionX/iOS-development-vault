---
created: 2025-02-25 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/documentation/uikit/uiviewcontroller"
---



# UIViewController - A Diagrammatical Summary
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift, Mermaid, and any other programming languages provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

This document aims to visually explain the [`UIViewController`](https://developer.apple.com/documentation/uikit/uiviewcontroller) in iOS development, including its lifecycle, responsibilities, and how to use it effectively.  It leverages Mermaid diagrams and other visual aids for clarity.

---




## 1. Core Concepts and Responsibilities

The `UIViewController` is a fundamental building block in iOS apps.  It manages a view hierarchy and handles user interactions within that view.  It's *not* usually instantiated directly; instead, you create *subclasses* to implement specific app features.

```mermaid
---
title: Core Concepts and Responsibilities of UIViewController
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[UIViewController] --> B(Responsibilities)
    style A fill:#ccf4,stroke:#333,stroke-width:2px

    B --> C[Update View Content]
    C --> C1[Respond to Data Changes]
    C --> C2[Reflect Model Updates]
    B --> D[Respond to User Interaction]
    D --> D1[Handle Taps, Gestures]
    D --> D2[Trigger Actions]
    B --> E[Manage View Layout]
    E --> E1[Resize Views]
    E --> E2[Handle Orientation Changes]
    B --> F[Coordinate with Other Objects]
    F --> F1[Communicate with Other View Controllers]
    F --> F2[Interact with Model Objects]
    F --> F3[Delegate Tasks]

    A --> G(Key Features)
    G --> H[View Hierarchy Management]
    H --> H1["Root View (self.view)"]
    H --> H2[Subviews]
    G --> I[Responder Chain Participation]
    I --> I1[Handles Events]
    I --> I2[Passes Events Up the Chain]
    G --> J[Lifecycle Management]
    G --> K[Memory Management]
    G --> L[State Preservation & Restoration]
    
```

**Key Takeaways from the Diagram:**

*   **Responsibilities:** The core duties of a `UIViewController` are clearly outlined.
*   **Features:**  Highlights the important capabilities provided by the class.
*   **View Hierarchy:** Emphasizes the `view` property as the root of the managed view hierarchy.
*   **Responder Chain:** Shows how the view controller participates in event handling.

---

## 2. View Loading Strategies

A `UIViewController` loads its views lazily (only when needed).  There are three main ways to define these views:

```mermaid
---
title: View Loading Strategies
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[View Loading Strategies] --> B(Storyboard)
    B --> B1[Preferred Method]
    B --> B2[Visual Design]
    B --> B3[Defines Segues]
    B --> B4["Instantiate with 'instantiateViewController(withIdentifier:)'"]
    A --> C("Nib File (.xib)")
    C --> C1[Single View Controller]
    C --> C2[No Segues]
    C --> C3["Initialize with 'init(nibName:bundle:)'"]
    A --> D("Programmatically - 'loadView()' ")
    D --> D1[Full Control]
    D --> D2[Create Views in Code]
    D --> D3["Assign Root View to 'self.view'"]
```

**Explanation:**

*   **Storyboard:** The recommended approach, allowing for visual design and defining transitions (segues) between view controllers.
*   **Nib File (.xib):**  Suitable for single view controllers, but doesn't support segues.
*   **Programmatically (`loadView()`):** Provides maximum control, requiring you to create and manage all views in code.  This is less common but useful in specific scenarios.

---

## 3. View Lifecycle and Notifications

Understanding the view lifecycle is *crucial* for managing your app's state and behavior. The diagram from the Apple documentation is excellent, but let's represent it in text and then augment it with a state diagram:

**Textual Representation of the Lifecycle:**

1.  **View Not Visible (Initial State)**
2.  **View Is Appearing:**
    *   `viewWillAppear(_:)` - Called *before* the view becomes visible.  Good for initial setup.
    *   `viewIsAppearing(_:)`
3.  **View Appeared:**
    *   `viewDidAppear(_:)` - Called *after* the view is visible.  Good for starting animations or tasks that require the view to be onscreen.
4.  **View Is Disappearing:**
    *   `viewWillDisappear(_:)` - Called *before* the view goes offscreen.  Good for saving data or stopping ongoing tasks.
5.  **View Disappeared:**
    *   `viewDidDisappear(_:)` - Called *after* the view is no longer visible.  Good for cleanup.
6. **View Removed**
    *`viewDidDisappear(_:)`

**Mermaid State Diagram:**

```mermaid
---
title: State Diagram of the View Lifecycle
config:
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
stateDiagram-v2
    [*] --> NotVisible
    NotVisible --> Appearing: viewWillAppear, View added, viewIsAppearing
    Appearing --> Appeared: viewDidAppear
    Appeared --> Disappearing: viewWillDisappear
    Disappearing --> Disappeared: viewDidDisappear, View removed
    Disappeared --> Appearing
    Appeared --> Appeared: viewDidLayoutSubviews
```

**Key Improvements and Explanations:**

*   **`[*]`:** Represents the initial state (view controller exists, but views aren't loaded).
*   **`NotVisible`:**  Clearly indicates the starting state.
*   **Transitions:**  The arrows show the flow between states, labeled with the corresponding methods.
*   **`viewDidLayoutSubviews`:** Added this to the `Appeared` state.  This method is called *after* the view's bounds change, making it important for layout adjustments.
*   **Cyclical Nature:** The diagram visually represents the cyclical nature of the view lifecycle.

**Important Note:** The documentation emphasizes that `will` methods might not always have a corresponding `did` method. You must ensure that any process started in a `will` method is also handled in the *opposite* `will` method if necessary, to avoid issues. For example, if you start something in `viewWillAppear`, you might need to stop it in both `viewDidAppear` *and* `viewWillDisappear`.

---

## 4. Handling Rotations (Orientation Changes)

The approach to handling rotations has changed over time in iOS.

```mermaid
---
title: Handling Rotations (Orientation Changes)
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[Handling Rotations] --> B(iOS 8 and Later)
    B --> B1["'viewWillTransition(to:with:)'"]
    B1 --> B2[Handles Size Changes]
    B1 --> B3[Propagated through View Controller Hierarchy]
    A --> C(iOS 6 and 7)
    C --> C1['supportedInterfaceOrientations']
    C1 --> C2[Defines Supported Orientations]
    C --> C3['preferredInterfaceOrientationForPresentation']
    C3 --> C4[For Full-Screen Presentation]
    C --> C5[Deprecated Methods]
    C5 --> C6["'willRotate(to:duration:)'"]
    C5 --> C7["'willAnimateRotation(to:duration:)'"]
    C5 --> C8["'didRotate(from:)'"]
```

**Explanation:**

*   **Modern Approach (iOS 8+):**  `viewWillTransition(to:with:)` is the key method.  It's called whenever the view controller's size changes, which includes orientation changes.
*   **Older Approach (iOS 6/7):**  Relied on methods like `supportedInterfaceOrientations` to control which orientations were allowed.  These methods are now deprecated.
*   **`viewWillLayoutSubviews()`:**  This method is still relevant and is called after the view's bounds change, regardless of the iOS version.


---


## 5. Container View Controllers

Container view controllers are powerful tools for managing complex UI structures.  They host other view controllers (child view controllers).

```mermaid
---
title: Container View Controllers
config:
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
classDiagram
    class UIViewController {
        +addChild(UIViewController)
        +removeFromParent()
        +willMove(toParent: UIViewController?)
        +didMove(toParent: UIViewController?)
    }
    class CustomContainerViewController {
        -children: [UIViewController]
        +addChildViewController(UIViewController)
        +removeChildViewController(UIViewController)
    }

    UIViewController <|-- CustomContainerViewController
    CustomContainerViewController "1" *-- "*" UIViewController : manages

```

**Explanation:**

*   **`CustomContainerViewController`:**  This represents your custom subclass of `UIViewController` that acts as a container.
*   **`children`:**  A private array (represented by `-`) to hold the child view controllers.
*   **`addChildViewController` and `removeChildViewController`:**  These are *your* custom methods for adding and removing children.  They *must* call the appropriate `UIViewController` methods:
    *   **Adding:**
        1.  `addChild(_:)` - Establishes the parent-child relationship.
        2.  `willMove(toParent:)` - Called on the *child* before it's added.
        3.  Add the child's view to the container's view hierarchy.
        4.  `didMove(toParent:)` - Called on the *child* after it's added.
    *   **Removing:**
        1.  `willMove(toParent: nil)` - Called on the *child* before it's removed.
        2.  Remove the child's view from the container's view hierarchy.
        3.  `removeFromParent()` - Removes the parent-child relationship.
        4.  `didMove(toParent: nil)` - Called on the *child* after it's removed.

**Why are these methods important?**  They ensure that UIKit properly routes events and manages the lifecycle of the child view controllers.

---

## 6. Memory Management

iOS has limited memory, and view controllers provide mechanisms to help manage it.

```mermaid
---
title: Memory Management
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
graph LR
    A[Memory Management] --> B["'didReceiveMemoryWarning()'"]
    B --> C[Automatic Handling]
    C --> D[Releases Unneeded Memory]
    B --> E[Override to Release Custom Resources]
```

**Explanation:**

*   **`didReceiveMemoryWarning()`:** This method is called automatically by UIKit when the system is low on memory.
*   **Default Behavior:** The default implementation releases some cached data.
*   **Override:** You can override this method in your subclasses to release any additional memory-intensive resources that you're holding (e.g., large images, cached data).

---

## 7. State Preservation and Restoration

This allows your app to save its UI state when it goes into the background and restore it when it comes back to the foreground, providing a seamless user experience.

```mermaid
---
title: State Preservation and Restoration
config:
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant App

    box rgb(20, 110, 15) The Device System
        participant System
        participant VC as UIViewController
        participant View as UIView
    end

    Note over App,System: App Transitions to Background

    System ->> VC: restorationIdentifier set?
    activate VC
    VC -->> System: Yes
    System ->> VC: encodeRestorableState(with:)
    VC ->> View: encodeRestorableState(with:) if restorationIdentifier set
    activate View
    View -->> VC: State encoded
    deactivate View
    VC -->> System: State encoded
    deactivate VC

    Note over App,System: App Returns to Foreground

    System ->> VC: restoreState(with:)
    activate VC
    VC ->> View: restoreState(with:)
    activate View
    View -->> VC: State restored
    deactivate View
    VC -->> System: State restored
    deactivate VC
    
```
**Explanation:**
* **restorationIdentifier:** The sequence diagram shows that the value of the property needs to be set to trigger the state saving and restoration process.
* **Encoding/Decoding:** The view controller and its views (if they have restoration identifiers) are asked to encode their state.
* **Custom Container Controllers:** If you have a custom container view controller, *you* are responsible for encoding the state of your child view controllers.  Each child must have a *unique* `restorationIdentifier`.
* **App Programming Guide:** The documentation refers to the "App Programming Guide for iOS" for more details on the overall process.
* **Restoring your app’s state:** provides a dedicated guide on this specific functionality.

---

## 8. Mixed Programming Languages: Swift, Objective-C, and UIViewController

While the documentation focuses on Swift, `UIViewController` is fully compatible with Objective-C.  Here's how they relate:

```mermaid
---
title: Mixed Programming Languages - Swift, Objective-C, and UIViewController
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%{
  init: {
    'fontFamily': 'verdana',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
classDiagram
    class UIViewController {
        // Swift
        +view: UIView!
        +init(nibName: String?, bundle: Bundle?)
        +viewDidLoad()
        +viewWillAppear(Bool)
        // ... other Swift methods ...
    }

    class UIViewController_ObjC {
        // Objective-C
        @property (nonatomic, strong) UIView *view;
        -(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
        -(void)viewDidLoad;
        -(void)viewWillAppear:(BOOL)animated;
        // ... other Objective-C methods ...
    }

    UIViewController <|-- MySwiftViewController : Swift Subclass
    UIViewController <|-- MyObjCViewController : Objective-C Subclass

    class MySwiftViewController {
        +override func viewDidLoad()
    }

    class MyObjCViewController {
        -(void)viewDidLoad;
    }
    
```

**Explanation:**

*   **`UIViewController` (Swift):** Shows the Swift syntax for properties and methods.
*   **`UIViewController_ObjC` (Objective-C):**  Shows the equivalent Objective-C syntax (using `@property` for properties and `-` for methods).
*   **Subclassing:**  You can subclass `UIViewController` in either Swift (`MySwiftViewController`) or Objective-C (`MyObjCViewController`).
*   **Method Overriding:**  The diagram demonstrates how to override `viewDidLoad` in both languages.

**Key Considerations for Mixed-Language Projects:**

*   **Bridging Headers:**  If you have a mixed Swift and Objective-C project, you'll need a bridging header to expose Objective-C code to Swift.
*   **`@objc` and `@IBAction`:**  In Swift, you use the `@objc` attribute to make methods and properties accessible to Objective-C.  `@IBAction` is used for methods connected to Interface Builder actions.
*   **Nullability:** Pay close attention to nullability annotations in Objective-C headers (`nullable`, `nonnull`, `_Nullable`, `_Nonnull`) to ensure proper Swift interoperability.




---

<!-- 
```mermaid
%% Current Mermaid version
info
```  -->


```mermaid
---
title: "CongLeSolutionX"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'flowchart': { 'htmlLabels': false },
    'fontFamily': 'Bradley Hand',
    'themeVariables': {
      'primaryColor': '#fc82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#81c784',
      'secondaryTextColor': '#6C3483',
      'lineColor': '#F8B229',
      'fontSize': '20px'
    }
  }
}%%
flowchart LR
  My_Meme@{ img: "https://raw.githubusercontent.com/CongLeSolutionX/CongLeSolutionX/refs/heads/main/assets/images/My-meme-light-bulb-question-marks.png", label: "Ăn uống gì chưa ngừi đẹp?", pos: "b", w: 200, h: 150, constraint: "off" }

  Closing_quote@{ shape: braces, label: "...searching insights in the process of formulating better questions..." }
    
  My_Meme ~~~ Closing_quote
    
  Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

  Closing_quote ~~~ My_Meme
  My_Meme animatingEdge@--> Link_to_my_profile
  
  animatingEdge@{ animate: true }

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
