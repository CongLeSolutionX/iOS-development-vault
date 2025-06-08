---
created: 2025-02-18 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/BuildinganAdaptiveInterface.html#//apple_ref/doc/uid/TP40007457-CH32-SW1"
---



# Building an Adaptive Interface - A Diagrammatical Summary
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift, Mermaid, and any other programming languages provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



## 1. Core Concept: Trait and Size Changes

The fundamental idea is that an adaptive interface should gracefully handle changes in both *traits* and *size*.  This is crucial for supporting different devices (iPhone, iPad), orientations (portrait, landscape), and multitasking scenarios (split view, slide over).

```mermaid
---
title: Core Concept - Trait and Size Changes
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
    A[Adaptive Interface] --> B(Trait Changes)
    A --> C(Size Changes)

    B --> B1[Size Classes]
    B --> B2[Display Scale]
    B --> B3[User Interface Style]

    C --> C1[Window Dimensions]
    C --> C2[Parent View Controller Resize]
    C --> C3[Presentation Controller Resize]
    
style A fill:#a2fa,stroke:#333,stroke-width:1px

```


**Explanation:**

*   **Adaptive Interface (A):**  The overarching goal.  The interface should adapt to different contexts.
*   **Trait Changes (B):**  Coarse-grained changes affecting the overall environment.  Examples include:
    *   **Size Classes (B1):**  Horizontal (Regular/Compact) and Vertical (Regular/Compact).  These define the *amount* of available space.
    *   **Display Scale (B2):**  The pixel density (Retina vs. non-Retina).
    *    **User Interface Style (B3):** Dark Mode or Light Mode.
*   **Size Changes (C):**  Fine-grained adjustments to the layout *within* a given trait environment. Examples:
    *   **Window Dimensions (C1):**  Changes due to device rotation.
    *   **Parent View Controller Resize (C2):** A container view controller adjusting the size of its children.
    *   **Presentation Controller Resize (C3):**  A presented view controller (like a popover) being resized.

---

## 2. Adapting to Trait Changes: Storyboards and Code

There are two primary ways to handle trait changes:

*   **Interface Builder (Storyboards):** The preferred method for many adjustments.
*   **Programmatically (Swift/Objective-C):**  For more dynamic or complex scenarios.

### 2.1 Storyboard Adaptations

Interface Builder provides built-in tools to configure your UI for different size classes.

```mermaid
---
title: Storyboard Adaptations to Trait Changes
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
    A[Interface Builder] --> B(Size Class Viewing Control)
    A --> C(Installation Control)
    A --> D(Layout Constraints)
    A --> E(Image Assets)
    
    B --> B1[Preview different size classes]
     
    C --> C1["Add/Remove views for specific size classes"]
    C --> C2["(+) button to add configurations"]
    
    D --> D1[Configure constraints for different size classes]
     
    E --> E1["Multiple image versions<br>(size class & resolution)"]
    E --> E2["UIImageView automatically selects correct image"]
     

style A fill:#a2fa,stroke:#333,stroke-width:1px
style B fill:#c4fa,stroke:#333,stroke-width:1px
style C fill:#c4fa,stroke:#333,stroke-width:1px
style D fill:#c4fa,stroke:#333,stroke-width:1px
style E fill:#c4fa,stroke:#333,stroke-width:1px

```

**Explanation:**

* **Size Class Viewing Control:** Allows you to preview your layout in different size class combinations (e.g., Regular width, Compact height) *within* Interface Builder.
*   **Installation Control:**  Lets you conditionally install/uninstall views for specific size classes.  A view might be present in a Regular width environment but removed in a Compact width environment.
*   **Layout Constraints:**  You can create different constraints for different size classes.  This is the core of Auto Layout's adaptivity.
*   **Image Assets:**  The best way to manage images.  An image asset can contain multiple versions of an image, each tailored to a specific size class and resolution.  A `UIImageView` will automatically pick the right one.

**Visual Representation (Conceptual Image Asset):**

```
Image Asset: "MyButtonImage"

+-------------------------------------------------+
|  Size Class       |  Resolution  |  Image File     |
|-------------------|--------------|-----------------|
| Regular x Regular |  @1x         |  button_rr_1x.png|
| Regular x Regular |  @2x         |  button_rr_2x.png|
| Regular x Regular |  @3x         |  button_rr_3x.png|
| Compact x Regular |  @1x         |  button_cr_1x.png|
| Compact x Regular |  @2x         |  button_cr_2x.png|
| ...               |  ...          |  ...             |
+-------------------------------------------------+
```

### 2.2 Programmatic Trait Overrides (Child View Controllers)

Sometimes, you need to override the traits inherited by a child view controller. This is common in container view controllers.

```mermaid
---
title: Programmatic Trait Overrides (Child View Controllers)
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
    A["Parent View Controller"] --> B("Child View Controller")
    B --> C["Inherits Traits<br>(Default)"]
    A --> D["setOverrideTraitCollection:forChildViewController:"]
    D --> E["Override Traits"]
    E --> B

style A fill:#c2da,stroke:#333,stroke-width:1px
style B fill:#c2da,stroke:#333,stroke-width:1px
style D fill:#a2da,stroke:#333,stroke-width:1px
style E fill:#c2da,stroke:#333,stroke-width:1px

```

**Explanation:**

*   A parent view controller can explicitly set the traits of its children using `setOverrideTraitCollection:forChildViewController:`.
*   This allows, for example, a child view controller to have a Compact size class even if the parent has a Regular size class.

**Code Example (Objective-C):**

```objc
// Create trait collections for specific size classes
UITraitCollection *horizTrait = [UITraitCollection
                  traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
UITraitCollection *vertTrait = [UITraitCollection
                  traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];

// Combine the trait collections
UITraitCollection *childTraits = [UITraitCollection
                  traitCollectionWithTraitsFromCollections:@[horizTrait, vertTrait]];

// Override the traits of the child view controller
[self setOverrideTraitCollection:childTraits forChildViewController:self.childViewControllers[0]];
```

**Code Example (Swift):**

```swift
// Create trait collections for specific size classes
let horizTrait = UITraitCollection(horizontalSizeClass: .regular)
let vertTrait = UITraitCollection(verticalSizeClass: .compact)

// Combine the trait collections
let childTraits = UITraitCollection(traitsFrom: [horizTrait, vertTrait])

// Override the traits of the child view controller
setOverrideTraitCollection(childTraits, forChild: childViewControllers[0])

```

**Key Point:**  Overridden traits persist until changed again or the child is removed.  Children inherit *un-overridden* traits from their parent.

---

## 3. Adapting Presented View Controllers

Presented view controllers (e.g., popovers, modal sheets) have special adaptation rules.

```mermaid
---
title: Adapting Presented View Controllers
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
    A["Presented View Controller"] --> B{"Horizontal Environment"}
    B -- Regular --> C["Normal Presentation"]
    B -- Compact --> D["UIModalPresentationFullScreen<br>(Default)"]
    D --> E["Customization"]
    E --> F["UIAdaptivePresentationControllerDelegate"]
    F --> G["adaptivePresentationStyleForPresentationController:"]
    F --> H["presentationController:viewControllerForAdaptivePresentationStyle:"]

    style A fill:#a2fa,stroke:#333,stroke-width:1px
    style B fill:#c2da,stroke:#333,stroke-width:1px
    style C fill:#e2ca,stroke:#333,stroke-width:1px
    style D fill:#e2ca,stroke:#333,stroke-width:1px
    style E fill:#a2fa,stroke:#333,stroke-width:1px
    
```


**Explanation:**

*   **Default Behavior:** When transitioning from a horizontally *regular* to a horizontally *compact* environment, UIKit automatically changes the presentation style to `UIModalPresentationFullScreen`.  This makes the presented view controller take up the entire screen.
*   **Customization:** This default behavior can be overridden using a `UIAdaptivePresentationControllerDelegate`.
*   **`adaptivePresentationStyleForPresentationController:`:** This delegate method lets you specify a different presentation style.  Crucially, when transitioning to a compact environment, you can only return:
    *   `UIModalPresentationFullScreen` (or another full-screen style)
    *   `UIModalPresentationNone` (to keep the *original* presentation style, e.g., keep a popover as a popover).
*   **`presentationController:viewControllerForAdaptivePresentationStyle:`:**  This method allows you to *completely replace* the presented view controller with a different one, better suited for the new environment.  This is powerful for significant UI changes.

**Example: Popover Adaptation**

```
Regular Environment (iPad):
+---------------------+
|      Popover        |
|  +---------------+  |
|  |  Content      |  |
|  +---------------+  |
|                     |
+---------------------+

Compact Environment (iPhone, default):
+---------------------+
|                     |
|                     |
|  +---------------+  |
|  |  Content      |  |  (Full Screen)
|  +---------------+  |
|                     |
|                     |
+---------------------+

Compact Environment (with UIModalPresentationNone):
+---------------------+
|      Popover        |
|  +---------------+  |
|  |  Content      |  |
|  +---------------+  |
|                     |
+---------------------+
```

**Code Example (Swift):**

```swift
// Delegate method to prevent full-screen adaptation
func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
    return .none // Keep the original presentation style (e.g., popover)
}

// Delegate method to replace the view controller
func presentationController(_ presentationController: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
    // If transitioning to a compact environment, return a navigation controller
    if style == .fullScreen {
        let newVC = MyCustomViewControllerForCompact() // A view controller designed for compact
        let navController = UINavigationController(rootViewController: newVC)
        return navController
    }
    return nil // Use the original view controller
}

```

**Key Takeaways - Presented View Controllers:**

*   Understand the default full-screen adaptation.
*   Use `UIAdaptivePresentationControllerDelegate` to customize this behavior.
*   Consider replacing the view controller entirely for major adaptations.

---

## 4. Responding to Size Changes

Size changes, as opposed to trait changes, are about fine-tuning the layout within a given trait environment.

```mermaid
---
title: Responding to Size Changes
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
    A[Size Change] --> B[Auto Layout Constraints]
    A --> C[viewWillTransitionToSize:withTransitionCoordinator:]

    B --> B1[Automatic Adaptation]
    C --> C1[Manual Layout Adjustments]
    C --> C2[Custom Animations]

style A fill:#a2fa,stroke:#333,stroke-width:1px

```


**Explanation:**

*   **Auto Layout (B):**  If you've set up your Auto Layout constraints correctly, your app will *automatically* adapt to many size changes.  This is the ideal scenario.
*   **`viewWillTransitionToSize:withTransitionCoordinator:` (C):** This view controller method is called when the size of the view controller's view is about to change.  Use this for:
    *   **Manual Layout Adjustments (C1):** If Auto Layout isn't sufficient, you can manually adjust the frames of your views here.
    *   **Custom Animations (C2):**  You can use the provided transition coordinator to create animations that run *alongside* the standard size-change animations.  For example, you could counter-rotate a view during a device rotation.

**Code Example (Swift):**

```swift
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    // 1. Manual Layout Adjustments (example)
    if size.width > size.height { // Landscape
        myLabel.frame = CGRect(x: 20, y: 20, width: size.width - 40, height: 50)
    } else { // Portrait
        myLabel.frame = CGRect(x: 20, y: 20, width: size.width - 40, height: 100)
    }

    // 2. Custom Animations (example - counter-rotation)
    coordinator.animate(alongsideTransition: { context in
        let transform = context.targetTransform
        self.myImageView.transform = transform.inverted()
    }, completion: { context in
        // Reset the transform after the animation
        self.myImageView.transform = .identity
    })
}
```

**Key Point:** Prioritize Auto Layout.  Use `viewWillTransitionToSize:` for cases where Auto Layout alone isn't enough or for custom animations.

---

## 5. Tips for Adaptive Popovers (Recap)

The document specifically highlights popovers because they require special consideration:

*   **Problem:**  The default full-screen adaptation on compact devices removes the usual way to dismiss a popover (tapping outside its bounds).

*   **Solutions:**
    1.  **Push onto Navigation Stack:** If a navigation controller is available, dismiss the popover and push its view controller onto the stack.
    2.  **Add Dismiss Controls:** Add a "Done" button or similar control.  Better yet, *replace* the popover with a navigation controller using the delegate method.
    3.  **Prevent Adaptation:** Use `UIModalPresentationNone` in the delegate to keep the popover presentation style.

```mermaid
---
title: Tips for Adaptive Popovers
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
    A["Adaptive Popovers"] --> B["Problem:<br>Full-Screen on Compact"]
    B --> C["Solutions"]
    C --> C1["Push onto Navigation Stack"]
    C --> C2["Add Dismiss Controls<br>(e.g., Done Button)"]
    C --> C3["Prevent Adaptation<br>(UIModalPresentationNone)"]
    C --> C4["Replace with Navigation Controller<br>(Recommended)"]
    
    style A fill:#a2fa,stroke:#333,stroke-width:1px
    
```


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
