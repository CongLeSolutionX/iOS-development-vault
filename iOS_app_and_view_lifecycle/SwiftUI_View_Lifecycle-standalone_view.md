---
created: 2024-11-11 05:31:26
author: Cong Le
version: "1.5"
license(s): MIT, CC BY 4.0
---


# SwiftUI View lifecycle - The standalone view
 
Below is a **Mermaid** diagram that illustrates the **SwiftUI View Lifecycle** along with related functions. This diagram provides a visual representation of the key stages and methods involved in the lifecycle of a SwiftUI view.

```mermaid
flowchart TD
    A[View Initialization] --> B[Body Computation]
    B --> C[Rendering on Screen]
    C --> D{User Interaction or State Change}
    D -->|State Change| B
    D -->|Disappear| E[onDisappear]
    C --> F[onAppear]
    E --> G[View Deinitialization]
    F --> H[Additional Modifiers]
    H --> D

```

### Explanation of the Diagram:

1. **View Initialization (`init`)**
    - The lifecycle begins with the initialization of the SwiftUI view.
2. **Body Computation (`body`)**
    - SwiftUI calls the `body` property to compute the view's layout and contents.
3. **Rendering on Screen**
    - The computed body is rendered on the device's screen.
4. **User Interaction or State Change**
    - The view waits for user interactions or state changes that might trigger updates.
5. **State Change Handling**
    - If there's a state change, SwiftUI recomputes the `body`, leading back to re-rendering.
6. **`onAppear` Modifier**
    - Called when the view appears on the screen. Useful for tasks like fetching data.
7. **`onDisappear` Modifier**
    - Invoked when the view is about to disappear from the screen. Ideal for cleanup tasks.
8. **Additional Modifiers**
    - Other modifiers can be applied to the view, affecting its behavior and appearance.
9. **View Deinitialization (`deinit`)**
    - Finally, when the view is no longer needed, it gets deinitialized.

### Related Functions and Modifiers:

- **`init`**
    - Initializes the view instance.
- **`body`**
    - Computes and returns the view hierarchy.
- **`onAppear`**
    - Executes a closure when the view appears.
- **`onDisappear`**
    - Executes a closure when the view disappears.
- **State Modifiers (`@State`, `@Binding`, etc.)**
    - Manage and react to changes in state data.
- **`viewDidLoad`, `viewWillAppear`, `viewDidDisappear`**
    - While more common in UIKit, understanding their equivalents in SwiftUI helps bridge concepts.

---
