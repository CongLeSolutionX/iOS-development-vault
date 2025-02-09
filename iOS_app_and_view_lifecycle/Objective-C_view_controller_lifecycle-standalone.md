---
created: 2024-12-01 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

# The Objective-C View Controller - The standalone view controller

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

```mermaid
---
title: The Objective-C View Controller - The View Lifecycle Steps
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    A[initWithNibName:bundle:] --> B[loadView]
    B --> C[viewDidLoad]
    C --> D[viewWillAppear:]
    D --> E[viewWillLayoutSubviews]
    E --> F[viewDidLayoutSubviews]
    F --> G[viewDidAppear:]
    G --> H[User Interaction]
    H --> I[viewWillDisappear:]
    I --> J[viewDidDisappear:]
    J --> K[dealloc]

```

### Explanation of the View Lifecycle Steps:

1. **`initWithNibName:bundle:`**
    - Initializes the view controller with a nib file and bundle.
2. **`loadView`**
    - Loads or creates a view hierarchy programmatically.
3. **`viewDidLoad`**
    - Called after the view has been loaded. Suitable for additional setup after loading the view.
4. **`viewWillAppear:`**
    - Invoked just before the view is added to the app’s view hierarchy.
5. **`viewWillLayoutSubviews`**
    - Called before the view lays out its subviews. Ideal for making changes before layout.
6. **`viewDidLayoutSubviews`**
    - Called after the view lays out its subviews. Suitable for additional layout adjustments.
7. **`viewDidAppear:`**
    - Invoked after the view has been added to the view hierarchy. Good for starting animations or tracking view appearance.
8. **`User Interaction`**
    - Represents the period where the user interacts with the view.
9. **`viewWillDisappear:`**
    - Called just before the view is removed from the view hierarchy.
10. **`viewDidDisappear:`**
    - Invoked after the view has been removed from the view hierarchy. Suitable for stopping services that don’t need to run when the view isn’t visible.
11. **`dealloc`**
    - Called when the view controller is about to be deallocated. Used for cleanup tasks.

### Additional Tips:

- **Debugging Lifecycle Issues:**
    - Understanding the lifecycle is crucial for debugging issues related to view loading, memory management, and resource handling.
- **Best Practices:**
    - **`viewDidLoad`:** Ideal for initializing data structures, setting up observers, and preparing the UI.
    - **`viewWillAppear:` and `viewDidAppear:`:** Useful for starting animations, network requests, or tracking analytics.
    - **`viewWillDisappear:` and `viewDidDisappear:`:** Good for saving state, stopping services, or cleaning up resources.
- **Memory Management:**
    - Ensure that you manage memory effectively in `dealloc` to prevent memory leaks, especially when dealing with observers or notifications.

This diagram serves as a quick reference to understand the sequence and purpose of each method in the Objective-C view controller lifecycle, aiding in better application architecture and maintenance.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
