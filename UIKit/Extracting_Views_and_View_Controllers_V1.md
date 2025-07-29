---
created: 2025-02-11 05:48:19
author: NA
version: NA
license(s): NA
copyright: NA
original source: https://github.com/jrasmusson/swift-arcade/tree/master/Extract-Views
---



# Extracting Views & View Controllers

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----


Below is a collection of diagrams and illustrations on explaining how to extract views and view controllers in UIKit.



----

## 1. Architecture Overview

This diagram represents the high-level architecture showing the relationship between `GameView` and `GameTableViewController` within a `ViewController`.

```mermaid
---
title: Architecture Overview
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph ViewController
    style ViewController fill:#f322f,stroke:#333,stroke-width:1px
        A[ViewController] --> B(GameView Container)
        A --> C(GameTableViewController Container)
        style A fill:#c3cf,stroke:#333,stroke-width:1px
        style B fill:#e3ee,stroke:#333,stroke-width:1px
        style C fill:#e3ee,stroke:#333,stroke-width:1px
        B --> D(GameView)
        C --> E(GameTableViewController View)
        style D fill:#b3bf,stroke:#333,stroke-width:1px
        style E fill:#b3bf,stroke:#333,stroke-width:1px
    end
    D --> F{profileImage}
    D --> G{titleLabel}
    D --> H{bodyLabel}
    E --> I[UITableView]

    classDef internal fill:#e3ee,stroke:#ccc,stroke-width:1px;
    classDef component fill:#b3bf,stroke:#333,stroke-width:1px;
    classDef container fill:#e3ee,stroke:#333,stroke-width:1px;
    
    class D,E component
    class B,C container
    class A internal
    
```


**Explanation:**

*   `ViewController` is the parent view controller, containing two main components.
*   `GameView Container` and `GameTableViewController Container` represent the areas within the `ViewController`'s view where the extracted views and view controller's views are placed.
*   `GameView` is an extracted `UIView` subclass, composed of `profileImage`, `titleLabel`, and `bodyLabel`.
*   `GameTableViewController View` is the view managed by the `GameTableViewController`, primarily containing a `UITableView`.

---

## 2. Extracting Views - Constraint Types

This diagram illustrates the two types of constraints involved when extracting a `UIView`: Parent Constraints and Child Constraints.

```mermaid
---
title:  Extracting Views - Constraint Types
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph ParentViewController
    style ParentViewController fill:#f391,stroke:#333,stroke-width:1px
        P[Parent View]
        
        subgraph ExtractedViewContainer
        style ExtractedViewContainer fill:#e3e4,stroke:#333,stroke-width:1px
            EV[Extracted View]
            subgraph InternalView
            style InternalView fill:#b3bf,stroke:#333,stroke-width:1px
                IV[Internal Content]
            end
             EV --- IV:::childConstraint
        end
       
       P --- ExtractedViewContainer:::parentConstraint

    end

    classDef parentConstraint stroke:#orange,stroke-width:2px;
    classDef childConstraint stroke:#blue,stroke-width:2px;

    linkStyle 0 style:parentConstraint
    linkStyle 1 style:childConstraint

    P --> |Parent Constraints| ExtractedViewContainer
    EV --> |Child Constraints| IV

    %% class P fill:#c3cf,stroke:#333,stroke-width:1px;
    %% class EV fill:#aaff,stroke:#333,stroke-width:1px;
    %% class IV fill:#d3df,stroke:#333,stroke-width:1px;

    %% note right of P
    %%     **Parent Constraints:**
    %%     - Define the position and size of the 
    %%       Extracted View Container within the 
    %%       Parent View.
    %%     - Already laid out in the original 
    %%       View Controller.
    %% end

    %% note right of EV
    %%     **Child Constraints:**
    %%     - Define the layout of the Extracted View's 
    %%       internal content within itself.
    %%     - Need to consider padding and spacing, 
    %%       often managed in the parent for flush 
    %%       child views.
    %% end
    
```

**Explanation:**

*   `ParentViewController` represents the view controller from which a view is extracted.
*   `Parent View` is the main view of the parent view controller.
*   `ExtractedViewContainer` represents the area in the parent view where the extracted `Extracted View` is placed.
*   `Extracted View` is the UIView being extracted.
*   `InternalView` and `Internal Content` represent the elements within the extracted view.
*   **Parent Constraints** (orange) are constraints set on the `ExtractedViewContainer` relative to the `Parent View`.
*   **Child Constraints** (blue) are constraints set on the `InternalView` (or internal elements) relative to the `Extracted View`.

---

## 3. Extracting View Controllers - Child View Controller Integration (3 Things)

This flowchart illustrates the three essential steps to properly integrate a child view controller into a parent view controller's lifecycle.

```mermaid
---
title: Extracting View Controllers - Child View Controller Integration (3 Things)
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    A[Start Integration] --> B{Add Child's View to Parent's View Hierarchy};
    B --> C{"Call addChild(_:)"}
    C --> D{"Call child.didMove(toParent: self)"}
    D --> E[Layout Child View in Parent]
    E --> F[End Integration]

    B -- 'view.addSubview(childViewController.view)' --> C
    C -- 'addChild(childViewController)' --> D
    D -- 'childViewController.didMove(toParent: self)' --> E

    style B fill:#c3cf,stroke:#333,stroke-width:1px;
    style C fill:#c3cf,stroke:#333,stroke-width:1px;
    style D fill:#c3cf,stroke:#333,stroke-width:1px;
    style E fill:#a2ff,stroke:#333,stroke-width:1px;


    %% note right of B
    %%     **Step 1: Add View**
    %%     - Makes the child view visible.
    %%     - Part of normal view hierarchy.
    %% end
    %% note right of C
    %%     **Step 2: Add Child View Controller**
    %%     - Establishes parent-child relationship.
    %%     - Integrates into VC lifecycle events 
    %%       (viewDidLoad, viewWillAppear etc.).
    %% end
    %% note right of D
    %%     **Step 3: Notify Child**
    %%     - Informs child VC it has been added.
    %%     - Ensures child VC is aware of its parent 
    %%       for lifecycle management.
    %% end
    %% note right of E
    %%     **Step 4: Layout**
    %%     - Position and size the child's view 
    %%       within the parent's view using 
    %%       frames or Auto Layout.
    %% end
    
```

**Explanation:**

*   The flowchart outlines the sequence of actions needed to correctly embed a child view controller.
*   **Step 1: Add Child's View to Parent's View Hierarchy:** `view.addSubview(childViewController.view)` - Adds the child view controller's view as a subview of the parent's view.
*   **Step 2: Call `addChild(_:)`:** `addChild(childViewController)` - Establishes the parent-child view controller relationship, which is crucial for lifecycle management.
*   **Step 3: Call `child.didMove(toParent: self)`:** `childViewController.didMove(toParent: self)` - Notifies the child view controller that it has been added to a parent, completing the integration into the view controller hierarchy.
*   **Step 4: Layout Child View:** After these steps, you can layout the child view using frames or Auto Layout constraints.

---

## 4. `loadView()` vs. Auto Layout for Child View Controllers

This diagram contrasts the two methods for laying out a child view controller's view: using Auto Layout constraints or overriding `loadView()`.

```mermaid
---
title: loadView() vs. Auto Layout for Child View Controllers
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph AutoLayoutMethod
    style AutoLayoutMethod fill:#f333,stroke:#333,stroke-width:1px
        AL[Auto Layout Constraints]
        AL --> ALA["Explicitly set x4 constraints (top, bottom, leading, trailing)"]
        ALA --> ALC[More verbose, requires more code]
        ALA --> ALE[Flexible layout control]
    end

    subgraph LoadViewMethod
    style LoadViewMethod fill:#f3f4,stroke:#333,stroke-width:1px
        LV["Override loadView()"]
        LV --> LVB["'override func loadView() { view = childView }'"]
        LVB --> LVD[Less code, more concise]
        LVB --> LVF[Child view fills entire VC's view]
    end

    AL --> LV[Alternative Approach Comparison]
    LV --> Both[Achieve Full-Screen Child View Layout]

    style Both fill:#a3ff,stroke:#333,stroke-width:1px;

    %% note left of AL
    %%     **Auto Layout Option:**
    %%     - Pin the child view to all four 
    %%       edges of the parent view 
    %%       using constraints.
    %% end
    %% note right of LV
    %%     **loadView() Option:**
    %%     - Override `loadView()` in the 
    %%       child view controller and 
    %%       set `view = childView`.
    %% end
    
```

**Explanation:**

*   **Auto Layout Method:**
    *   Involves setting explicit Auto Layout constraints for the top, bottom, leading, and trailing edges of the child view to pin it to the parent view.
    *   More verbose, requiring more lines of code to set up the constraints.
    *   Offers flexible layout control, allowing for layouts that are not just full-screen.
*   **`loadView()` Method:**
    *   Involves overriding the `loadView()` method in the child view controller.
    *   Sets the `view` property of the view controller directly to the desired view (e.g., `tableView`).
    *   Less code and more concise for achieving a full-screen layout.
    *   The child view automatically fills the entire view of the view controller.
*   Both methods achieve the goal of making the child view fill the entire area of the child view controller's view. `loadView()` is presented as a more elegant and less code-intensive solution for this specific full-screen scenario.

---

## 5. Handling View Interactions via Closures

This sequence diagram demonstrates how to use closures to handle interactions between a `UIView` and its `UIViewController`.

```mermaid
---
title: Handling View Interactions via Closures
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant ViewController
    participant View
    participant TextField

    ViewController->>View: Set searchTextFieldHandler = { fetchWeatherClosure }
    View->>TextField: User interacts with TextField<br>(e.g., ends editing)
    TextField-->>View: textFieldDidEndEditing(_:) Event
    View->>View: Check if searchTextFieldHandler is set
    alt handler is set
        View->>ViewController: Call searchTextFieldHandler(TextField)<br>(Closure execution)
        ViewController->>ViewController: fetchWeatherClosure(TextField)
        ViewController->>TextField: textField.text = ""<br>(Clear TextField)
    else handler is not set
        View-->>View: Return<br>(No action)
    end
```

**Explanation:**

*   **ViewController** sets a closure (`searchTextFieldHandler`) on the **View**. This closure (`fetchWeatherClosure` in this example) will be executed when a specific event occurs in the **View**.
*   **User interacts with TextField** within the **View** (for example, finishes editing).
*   **TextField** triggers the `textFieldDidEndEditing(_:)` event within the **View**.
*   **View** checks if `searchTextFieldHandler` closure has been set.
*   **If handler is set:**
    *   **View** calls the `searchTextFieldHandler` closure, passing the **TextField** as a parameter.
    *   **ViewController** executes the `fetchWeatherClosure`, which processes the text from the **TextField**.
    *   **ViewController** may then clear the **TextField** text.
*   **If handler is not set:** No action is taken.

This illustrates a callback mechanism using closures, allowing the `View` to communicate UI events back to the `ViewController` in a decoupled manner.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---