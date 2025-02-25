---
created: 2025-02-25 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/PresentingaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW1"
---



# Presenting a View Controller - A Diagrammatical Summary
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---


## Overall Structure and Key Concepts

This document explains how to display new view controllers on top of existing ones in iOS, primarily focusing on _presentation_. It covers:

1. **Presentation Styles:** How the new view controller appears (full-screen, popover, etc.).
2. **Transition Styles:** The animation used to bring the new view controller on screen.
3. **Presentation Methods:** Using segues (Interface Builder) or programmatic methods (`showViewController:sender:`, `presentViewController:animated:completion:`).
4. **Dismissal:** How to remove the presented view controller.
5. **Data Passing:** Using delegation to pass data back to the presenting view controller.
6. **Multiple Storyboards:** When and why to use them.

I'll now create visualizations to represent these concepts.

----


## 1. Core Presentation Concepts

```mermaid
---
title: Core Presentation Concepts
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
    A[Presenting View Controller] --> B(Presents)
    B --> C[Presented View Controller]
    C --> D(Dismisses)
    D --> A
  
    B -- "Relationship" --> E[View Controller Hierarchy]
    
    subgraph Concepts["Key Concepts"]
    direction TB
        F[Presentation Style] --> FA["How it looks:<br>Full Screen, Popover, etc."]
        F --> FB[UIModalPresentationStyle]
        G[Transition Style] --> GA["Animation:<br>Slide, Fade, etc."]
        G --> GB[UIModalTransitionStyle]
        H[Presentation Context] --> HA[Which VC is covered]
        H --> HB[definesPresentationContext]
    end

style A fill:#ccf5,stroke:#333,stroke-width:2px
style C fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

- This diagram establishes the fundamental relationship between the _presenting_ and _presented_ view controllers.
- It highlights that presentation creates a hierarchy.
- The "Concepts" subgraph introduces key terms like `Presentation Style`, `Transition Style`, and `Presentation Context`. It links these to the relevant UIKit properties.

---

## 2. Presentation Styles (Visual Representation)

Since Mermaid isn't ideal for representing visual layouts directly, I'll use a combination of a table and conceptual drawings (which you could replace with actual screenshots in a real document).

**Table: Presentation Styles**

|Style|Description|Horizontally Regular|Horizontally Compact|
|---|---|---|---|
|`UIModalPresentationFullScreen`|Covers the entire screen.|Covers fully|Covers fully|
|`UIModalPresentationPageSheet`|(Regular) Leaves part of the underlying view visible at the top.|Partial cover|Covers fully|
|`UIModalPresentationFormSheet`|(Regular) Smaller, centered view. Allows some of the underlying content to show.|Partial cover|Covers fully|
|`UIModalPresentationPopover`|Displays content in a popover.|Popover|Full Screen|
|`UIModalPresentationCurrentContext`|Covers a specific view controller (defined by `definesPresentationContext`).|Covers defined VC|Covers fully|
|`UIModalPresentationOverFullScreen`|Covers the entire screen. The content below is visible if the presented view controller has transparency.|Covers fully|Cover fully.|
|`UIModalPresentationCustom`|Allows for completely custom presentations using a `UIPresentationController`.|Custom|Custom|

**Conceptual Drawings (Illustrative - Replace with Images):**



```txt
// UIModalPresentationFullScreen
+---------------------+     +---------------------+
|                     |     |                     |
|  Presenting VC      |  -> |  Presented VC       |
|                     |     |                     |
+---------------------+     +---------------------+

// UIModalPresentationPageSheet (Regular)
+---------------------+     +---------------------+
|                     |     |                     |
|  Presenting VC      |  -> |  Presented VC       |
| (Partially Visible) |     |                     |
+---------------------+     +---------------------+
      (Dimming)

// UIModalPresentationFormSheet (Regular)
+---------------------+     +---------------------+
|                     |     |   +-----------+     |
|  Presenting VC      |  -> |   | Presented |     |
| (Partially Visible) |     |   |    VC     |     |
+---------------------+     +---------------------+
      (Dimming)

// UIModalPresentationPopover (Regular)
+---------------------+     +---------------------+
|                     |     |   +-------+         |
|  Presenting VC      |  -> |   | Popover |         |
|                     |     |   +-------+         |
+---------------------+     +---------------------+
```

**Explanation:**

- The table provides a concise summary of each presentation style and its behavior in different size classes.
- The conceptual drawings give a basic visual idea of how each style appears. In a real document, you would replace these with actual screenshots from an iOS device or simulator.

----

## 3. Transition Styles (Conceptual Animation)

Again, Mermaid isn't built for animation, so I'll describe the animations conceptually, and you could use GIFs or videos in a real document.

**Table: Transition Styles**

|Style|Description|
|---|---|
|`UIModalTransitionStyleCoverVertical`|The presented view controller slides up from the bottom. (Default)|
|`UIModalTransitionStyleFlipHorizontal`|The presenting view controller flips horizontally to reveal the presented view controller.|
|`UIModalTransitionStyleCrossDissolve`|The presented view controller fades in while the presenting view controller fades out.|
|`UIModalTransitionStylePartialCurl`|The presenting view controller's bottom edge curls up to reveal the presented view controller.|
|_Custom_ (using animator object and delegate)|Allows for completely custom transition animations.|

**Conceptual Animation Descriptions (Illustrative):**

- **`UIModalTransitionStyleCoverVertical`:** Imagine a sheet of paper sliding up from the bottom of the screen to cover the existing content.
- **`UIModalTransitionStyleFlipHorizontal`:** Imagine a card flipping over to show its back.
- **`UIModalTransitionStyleCrossDissolve`:** A smooth fade-in/fade-out transition.
- **`UIModalTransitionStylePartialCurl`:** Imagine the bottom corner of a page being peeled up.

----

## 4. Presentation Methods: Segues vs. Programmatic


```mermaid
---
title: Presentation Methods - Segues vs Programmatic
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
    A[Presentation Methods] --> B(Segues)
    A --> C(Programmatic)

    B --> B1[Interface Builder]
    B --> B2[Automatic Presentation]
    B --> B3["Good for static navigation"]

    C --> C1[showViewController:sender:]
    C --> C2[showDetailViewController:sender:]
    C --> C3[presentViewController:animated:completion:]
    C --> C4["More flexible"]
    C --> C5["Good for dynamic navigation"]
    C --> C6["Handles adaptation"]

    C1 -- "Adaptive" --> D[Presenting VC decides]
    C2 -- "Adaptive" --> D
    C3 -- "Modal" --> E[Always modal presentation]
    
```


**Explanation:**

- This diagram differentiates between using segues (defined in Interface Builder) and programmatic presentation.
- It highlights the key advantages of each approach.
- It clarifies the difference between the adaptive `show...` methods and the always-modal `presentViewController...` method.

-----

## 5. Presentation Process (Step-by-Step)

```mermaid
---
title: Presentation Process (Step-by-Step)
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
graph TD
    A[Start] --> B{Create Presented VC}
    B --> C{Set modalPresentationStyle}
    C --> D{Set modalTransitionStyle}
    D --> E{Call Presentation Method}
    E --> F{UIKit Handles Presentation}
    F --> G[Presented VC Onscreen]

    E -- "showViewController:sender:" --> E1[Presenting VC decides how]
    E -- "presentViewController:animated:completion:" --> E2[Modal presentation]

    B -- "Initialize with data" --> B1
    style B1 fill:#eee5,stroke:#333,stroke-width:1px

    C -- "e.g., UIModalPresentationFullScreen" --> C1
    style C1 fill:#eee5,stroke:#333,stroke-width:1px

    D -- "e.g., UIModalTransitionStyleCoverVertical" --> D1
    style D1 fill:#eee5,stroke:#333,stroke-width:1px

```


**Explanation:**

- This flowchart outlines the steps involved in presenting a view controller programmatically.
- It emphasizes the responsibilities of the developer (creating and configuring the view controller) and the role of UIKit in handling the actual presentation.
- It shows the branching paths for `showViewController:` and `presentViewController:`.

----

## 6. Dismissing a View Controller


```mermaid
---
title: Dismissing a View Controller
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
    A[Presented View Controller] --> B(Calls dismissViewControllerAnimated:completion:)
    B --> C[Presenting View Controller]
    C --> D(Handles Dismissal)
    D --> E[Presented VC Removed]
    B -- "UIKit forwards to" --> C

style B fill:#ccf5,stroke:#333,stroke-width:2px
style C fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

- This diagram shows how dismissing a view controller works.
- It clarifies that the call can be made on either the presented _or_ presenting view controller.
- It highlights the role of the presenting view controller in ultimately handling the dismissal.

----

## 7. Data Passing with Delegation


```mermaid
---
title: Data Passing with Delegation
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
    class PresentingViewController {
        - delegate: PresentedViewControllerDelegate
        + dismissViewController(animated:completion:)
        + presentedViewControllerDidFinish(data: Data)
    }
    class PresentedViewController {
        + delegate: PresentingViewControllerDelegate?
        + finishWithData(data: Data)
    }
    class PresentedViewControllerDelegate {
        <<protocol>>
        + presentedViewControllerDidFinish(data: Data)
    }

    PresentingViewController --|> PresentedViewControllerDelegate : implements
    PresentedViewController --> PresentingViewControllerDelegate : has
    PresentingViewController "1" -- "1" PresentedViewController : presents
    PresentedViewController --|> PresentedViewControllerDelegate
    
```


**Explanation:**

- This UML class diagram illustrates the delegation pattern.
- It shows the `PresentingViewController` and `PresentedViewController` classes.
- The `PresentedViewControllerDelegate` protocol defines the method(s) for data transfer (`presentedViewControllerDidFinish` in this example).
- The `PresentingViewController` conforms to the delegate protocol and sets itself as the delegate of the `PresentedViewController`.
- The `PresentedViewController` calls the delegate method to pass data back.

----

## 8. Multiple Storyboards


```mermaid
---
title: Multiple Storyboards
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
    A[App] --> B(Storyboard 1)
    A --> C(Storyboard 2)
    A --> D(Storyboard 3)

    B --> B1[View Controller 1]
    B --> B2[View Controller 2]

    C --> C1[View Controller 3]
    C --> C2[View Controller 4]

    D --> D1[View Controller 5]
    D --> D2[View Controller 6]

    B1 -- "Present from different storyboard" --> C1
    
```

**Explanation:**

- This diagram visualizes the concept of multiple storyboards within an app.
- It shows how view controllers from one storyboard can present view controllers from another.

**Code Example (Illustrative, Swift):**

```swift
// In PresentingViewController.swift
func presentFromOtherStoryboard() {
    let storyboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
    if let myVC = storyboard.instantiateViewController(withIdentifier: "MyViewController") as? MyViewController {
        // Configure myVC
        present(myVC, animated: true, completion: nil)
    }
}
```

This code snippet, combined with the diagram, demonstrates how to instantiate and present a view controller from a different storyboard.

----

## 9. Popover Specifics


```mermaid
---
title: Popover Specifics
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
graph TD
    A[Create Popover VC] --> B{Set modalPresentationStyle = .popover}
    B --> C[Get UIPopoverPresentationController]
    C --> D{Configure Anchor}
    D --> E[Set preferredContentSize]
    D -- "Option 1:<br>barButtonItem" --> D1[Set popoverPresentationController.barButtonItem]
    D -- "Option 2:<br>sourceView/sourceRect" --> D2[Set popoverPresentationController.sourceView & sourceRect]
    C --> F["Optional:<br>Configure Delegate"]
    F --> G["Handle adaptation, dismissal, etc."]

style B fill:#ccf5,stroke:#333,stroke-width:2px
style D fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

- This flowchart outlines the popover presentation configuration.
- It calls out the popover-specific steps, such as:
    - Setting `.popover` style.
    - Getting the `UIPopoverPresentationController`.
    - Setting the anchor point (either `barButtonItem` or `sourceView`/`sourceRect`).
    - Setting the preferred content size.
    - Optionally setting a delegate for handling events.




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---