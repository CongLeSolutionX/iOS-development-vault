---
created: 2025-02-25 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html#//apple_ref/doc/uid/TP40007457-CH16-SW1"
---



# Customizing the Transition Animations - A Diagrammatical Summary
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



## 1. Core Concepts: Transition Animation Sequence

```mermaid
---
title: Transition Animation Sequence
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
    A[Start] --> B{Transition Type?}
    B -- Presentation --> C[Add View Controller]
    B -- Dismissal --> D[Remove View Controller]
    C --> E[End]
    D --> E

    style A fill:#ccf5,stroke:#333,stroke-width:2px
    style B fill:#f9f5,stroke:#333,stroke-width:2px
    style C fill:#cfc5,stroke:#333,stroke-width:2px
    style D fill:#fcc5,stroke:#333,stroke-width:2px
    style E fill:#ccf5,stroke:#333,stroke-width:2px
    
```


**Explanation:**

*   **Start:**  The transition process begins.
*   **Transition Type?:**  A decision point: Is this a *presentation* (adding a new view controller) or a *dismissal* (removing a view controller)?
*   **Add View Controller:**  If presenting, a new view controller is added to the hierarchy.
*   **Remove View Controller:** If dismissing, a view controller is removed.
*   **End:** The transition process concludes.

This diagram simplifies the top-level concept: transitions either add or remove view controllers.

---

## 2. Key Players: The Transitioning Objects

```mermaid
---
title: Key Players - The Transitioning Objects
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
    subgraph TransitioningDelegate["Transitioning Delegate<br>(UIViewControllerTransitioningDelegate)"]
        TD[Provides Objects] --> A(Animator Object)
        TD --> IA(Interactive Animator Object)
        TD --> PC(Presentation Controller)
    end

    subgraph Animator["Animator Object<br>(UIViewControllerAnimatedTransitioning)"]
        A --> AA[Creates Animations]
        A --> AB[animateTransition: method]
        A --> AC[transitionDuration: method]
    end

    subgraph InteractiveAnimator["Interactive Animator Object<br>(UIViewControllerInteractiveTransitioning)"]
       IA --> IAA[Drives Timing with Events]
       IA --> IAB[UIPercentDrivenInteractiveTransition]
       IA --> IAC[startInteractiveTransition: method]
    end
     subgraph PresentationController["Presentation Controller"]
        PC --> PCA[Manages Presentation Style]
        PC --> PCB[Custom Appearance]
    end

    style TransitioningDelegate fill:#ccf4,stroke:#333,stroke-width:2px
    
```


**Explanation:**

*   **Transitioning Delegate:**  The central coordinator.  It provides the necessary objects to UIKit.  Conforms to `UIViewControllerTransitioningDelegate`.
*   **Animator Object:** Responsible for creating the actual animations (e.g., fading, sliding). Conforms to `UIViewControllerAnimatedTransitioning`.  Key methods: `animateTransition:` (where the animation logic resides) and `transitionDuration:` (specifies animation length).
*   **Interactive Animator Object:**  Controls the *timing* of animations based on user interaction (e.g., swiping). Conforms to `UIViewControllerInteractiveTransitioning`.  Often a subclass of `UIPercentDrivenInteractiveTransition`. Key Method: `startInteractiveTransition:`
*   **Presentation Controller:** Manages the *overall presentation style*, not just the animation itself. Used for custom presentations (`UIModalPresentationCustom`).

This diagram clarifies the roles and relationships of the main objects involved.

---

## 3. The Custom Animation Sequence (Presentation)

```mermaid
---
title: The Custom Animation Sequence (Presentation)
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
sequenceDiagram
    autonumber
    participant UIKit
    
    box rgb(20, 22, 55) The System
        participant TD as TransitioningDelegate
        participant A as Animator
     participant IA as InteractiveAnimator
    end

    UIKit->>TD: animationControllerForPresentedController(...)
    activate TD
    TD-->>UIKit: Animator Object (A)
    deactivate TD

    UIKit->>TD: interactionControllerForPresentation(...)
    activate TD
    TD-->>UIKit: Interactive Animator (IA) or nil
    deactivate TD

    rect rgb(20, 150, 25)
        alt Interactive Transition
            rect rgb(20, 100, 55)
                UIKit->>IA: startInteractiveTransition(...)
                activate IA
                IA-->>UIKit: Updates via updateInteractiveTransition:
                IA-->>UIKit: Completion via finishInteractiveTransition/cancelInteractiveTransition
                IA->>A: completeTransition:
            end
        else Non-Interactive Transition
            rect rgb(200, 100, 95)
                UIKit->>A: transitionDuration(...)
                activate A
                A-->>UIKit: Duration
                deactivate A

                UIKit->>A: animateTransition(...)
                activate A
                A-->>UIKit: Animation Execution
                A->>UIKit: completeTransition:
                deactivate A
            end
        end
    end

    Note over UIKit,A: UIKit waits for completeTransition: call
    
```

**Explanation (Presentation):**

1.  **Get Animator:** UIKit asks the `TransitioningDelegate` for the animator object (`animationControllerForPresentedController:`).
2.  **Get Interactive Animator (Optional):**  UIKit checks for an interactive animator (`interactionControllerForPresentation:`).
3.  **Get Duration:**  If non-interactive, UIKit gets the animation duration from the animator (`transitionDuration:`).
4.  **Start Animation:**
    *   **Non-Interactive:** UIKit calls `animateTransition:` on the animator.
    *   **Interactive:** UIKit calls `startInteractiveTransition:` on the interactive animator.
5.  **Animation Execution:**  The animator performs the animation (in `animateTransition:` for non-interactive, or driven by events for interactive).
6.  **Completion:** The animator (or interactive animator) calls `completeTransition:` on the *transition context object* to signal the end of the transition.
7. **UIKit waits:** The most important point, showing the sequence, interaction, and conditions.

The sequence for dismissal is very similar, using `animationControllerForDismissedController:` and `interactionControllerForDismissal:` instead.

---

## 4. The Transitioning Context Object

```mermaid
---
title: The Transitioning Context Object
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
    A[Animator Object] -->|animateTransition:| B(Transitioning Context Object)
    B --> C[Container View]
    B --> D[From View Controller]
    B --> E[To View Controller]
    B --> F[From View]
    B --> G[To View]
    B --> H[Final Frame]
    B --> I{Interactive?}

    style B fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

*   **Transitioning Context Object (`UIViewControllerContextTransitioning`):**  Provides *all* the necessary information for the animator.  It's passed to the `animateTransition:` method.
*   **Container View:**  The view where the animation takes place.  Crucially, new views are added to this container.
*   **From/To View Controllers:** The view controllers involved in the transition.
*   **From/To Views:**  The root views of the view controllers (may include additional views from a presentation controller).
*   **Final Frame:**  The final frame rectangle for the view being added/removed.
*   **Interactive?:**  Indicates whether the transition is interactive.

This emphasizes the importance of the context object as the *single source of truth* for animation parameters.

----

## 5. The Transition Coordinator

```mermaid
---
title: The Transition Coordinator
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
    A[View Controller] -->|transitionCoordinator| B(Transition Coordinator)
    B --> C[Animate Alongside]
    B --> D[Animation Context]
    B --> E[Timing Information]
    B --> F[Transition State]

    style B fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

*   **Transition Coordinator (`UIViewControllerTransitionCoordinator`):**  Allows for *additional* animations to run *concurrently* with the main transition. Accessed via the `transitionCoordinator` property of a view controller.
*   **Animate Alongside:**  Methods like `animateAlongsideTransition:completion:` allow you to add your own animation blocks.
*   **Animation Context (`UIViewControllerTransitionCoordinatorContext`):**  Provides information similar to the transitioning context object, but for the alongside animations.
*   **Timing Information:**  Provides details about the transition's timing.
*   **Transition State:**  Indicates the current state of the transition.

This highlights the coordinator's role in synchronizing extra animations.

----

## 6. Implementing the Animator Object (Simplified)

```mermaid
---
title: Implementing the Animator Object (Simplified)
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
    A[animateTransition: Method] --> B[Get Animation Parameters]
    B --> C[Create Animations]
    C --> D[Cleanup and Complete]

    B --> B1[viewControllerForKey:]
    B --> B2[containerView]
    B --> B3[viewForKey:]
    B --> B4[finalFrameForViewController:]

    C --> C1[UIView.animateWithDuration:...]
    C --> C2[Core Animation]

    D --> D1[completeTransition:]
    D --> D2[animationEnded:]
    D --> D3{transitionWasCancelled?}

    style A fill:#ccf5,stroke:#333,stroke-width:2px
    style B fill:#f9f5,stroke:#333,stroke-width:1px
    style C fill:#cfc5,stroke:#333,stroke-width:1px
    style D fill:#fcc5,stroke:#333,stroke-width:1px
    
```

**Explanation:**

1.  **`animateTransition:` Method:**  The core of the animator object.
2.  **Get Animation Parameters:**  Use the transitioning context object (passed to `animateTransition:`) to get:
    *   `viewControllerForKey:` (get the "from" and "to" view controllers)
    *   `containerView` (the superview for animations)
    *   `viewForKey:` (get the views to be added/removed)
    *   `finalFrameForViewController:` (get the final frame)
3.  **Create Animations:**  Use either:
    *   `UIView.animateWithDuration:...` (block-based animations)
    *   Core Animation (for more complex animations)
4.  **Cleanup and Complete:**
    *   Call `completeTransition:` on the context object to signal completion.
    *   Handle cancellation using `transitionWasCancelled`.
    *   Optionally implement `animationEnded:` for additional cleanup.

----

## 7.  "From" and "To" View Controllers

```mermaid
---
title: From and To View Controllers
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
    subgraph Presentation
        A[Initial State] --> B[Transition]
        B --> C[Final State]
        A -- "From: Presenting VC" --> A
        A -- "To: Presented VC" --> A
        C -- "From: Presenting VC" --> C
        C -- "To: Presented VC" --> C
    end

    subgraph Dismissal
        D[Initial State] --> E[Transition]
        E --> F[Final State]
        D -- "From: Presented VC" --> D
        D -- "To: Presenting VC" --> D
        F -- "From: Presented VC" --> F
        F -- "To: Presenting VC" --> F
    end
    
```

**Explanation:**

*   This diagram illustrates how the "from" and "to" view controllers change roles during presentation and dismissal.
*   **Presentation:**
    *   **Initial:** "From" is the presenting view controller, "To" is the presented view controller.
    *   **Final:**  Roles remain the same.
*   **Dismissal:**
    *   **Initial:** "From" is the presented view controller (being dismissed), "To" is the presenting view controller.
    *   **Final:** Roles remain the same.

This clarifies the swapping roles, which simplifies animator logic.

-----

## 8. Interactive Transitions with `UIPercentDrivenInteractiveTransition`

```mermaid
---
title: Interactive Transitions with `UIPercentDrivenInteractiveTransition`
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
    A[User Interaction] --> B[Event Handling Code]
    B --> C[Calculate Completion Percentage]
    C --> D[updateInteractiveTransition:]
    D --> E{Gesture Ended?}
    E -- Yes --> F[finishInteractiveTransition]
    E -- No --> B
    F --> G[completeTransition:]

    style A fill:#ccf5,stroke:#333,stroke-width:2px
    style B fill:#f9f5,stroke:#333,stroke-width:1px
    style C fill:#cfc5,stroke:#333,stroke-width:1px
    style D fill:#fcc5,stroke:#333,stroke-width:1px
    style E fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

1.  **User Interaction:**  A gesture (e.g., swipe) begins.
2.  **Event Handling Code:**  Your code (e.g., a gesture recognizer's action method) receives events.
3.  **Calculate Completion Percentage:**  Based on the gesture's progress, calculate a percentage (0.0 to 1.0).
4.  **`updateInteractiveTransition:`:**  Call this method on the `UIPercentDrivenInteractiveTransition` object with the calculated percentage.  This updates the animation's progress.
5.  **Gesture Ended?:**  Check if the gesture has finished.
6.  **`finishInteractiveTransition`:** If the gesture ended, call this method to complete the transition.
7.  **`completeTransition:`:** The interactive transition calls complete transition.

This shows the flow of control for interactive transitions.


----

## 9. Code Snippets (Illustrative - Not Complete)

**9.1 Transitioning Delegate (Swift):**

```swift
class MyTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MyAnimator()
        animator.isPresenting = true // Set a custom property
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = MyAnimator()
        animator.isPresenting = false
        return animator
    }
    
    //optionally provide interactive animator
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return myInteractiveAnimator
    }
}

```

**9.2 Animator Object (Swift - Simplified):**

```swift
class MyAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = true // Custom property

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 // Duration in seconds
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!

        if isPresenting {
            containerView.addSubview(toView)
            toView.frame = //... Calculate initial frame (offscreen)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.frame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
             //add the toView to the container
            containerView.addSubview(toView)
            // Dismissal animation...
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                           fromView.frame = //... Calculate final frame (offscreen)
                       }, completion: { finished in
                           fromView.removeFromSuperview()
                           transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                       })
        }
    }
}
```

**9.3 Interactive Animator (Swift - Conceptual):**

```swift
class MyInteractiveAnimator: UIPercentDrivenInteractiveTransition {
    var contextData: UIViewControllerContextTransitioning?
    var panGesture: UIPanGestureRecognizer!

    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
        self.contextData = transitionContext

        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeUpdate(_:)))
        transitionContext.containerView.addGestureRecognizer(panGesture)
    }

    @objc func handleSwipeUpdate(_ gestureRecognizer: UIGestureRecognizer) {
        let container = contextData!.containerView
        // ... Calculate percentage based on gesture ...
        let percentage: CGFloat = //calculate the percentage

        switch gestureRecognizer.state {
            case .began:
                panGesture.setTranslation(.zero, in: container)
            case .changed:
                update(percentage)
            case .ended, .cancelled:
                if percentage > 0.5 {
                    finish()
                } else{
                    cancel()
                }
                container.removeGestureRecognizer(panGesture)
                
            default: break;
        }
    }
}
```



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---