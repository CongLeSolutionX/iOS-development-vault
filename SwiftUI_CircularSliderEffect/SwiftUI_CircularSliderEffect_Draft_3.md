---
created: 2025-02-18 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# SwiftUI - Circular Slider Effect
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---
This doc will explain the Swift code implementation from this branch https://github.com/CongLeSolutionX/MyApp/tree/SwiftUI_Circular_Slider_Effect-SAVE-FOR-REFERENCE.
I will keep the code in GitHub branch as is as reference for content on this article.


---


## 1. Overview and High-Level Structure

First, let's provide a high-level overview of what the code does and its main components.  The `CircularSliderView` is a SwiftUI component that displays a horizontal, circular slider of profile images. The slider has two modes ("Normal" and "Scaled") that affect its visual presentation.

Here's a Mermaid flowchart to illustrate the basic structure:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[CircularSliderView] --> B(Picker - TripPicker);
    A --> C(GeometryReader);
    C --> D(ScrollView);
    D --> E[HStack - Profile Images];
    E --> F[Image - Profile];
    F --> G[Visual Effects: offset, scale];
    F --> H[Scroll Transition];
    D --> I[scrollTargetLayout];
    C --> J(Background Circle - conditional);
    A --> K[offset Function];
    A --> L[scale Function];
    A --> M[progress Function];
    B --> N[TripPicker Enum: Scaled, Normal];
    style A fill:#c3cf,stroke:#333,stroke-width:2px
    style B fill:#f39f,stroke:#333,stroke-width:1px
    style C fill:#f39f,stroke:#333,stroke-width:1px
    style D fill:#f39f,stroke:#333,stroke-width:1px
    style E fill:#c3cf,stroke:#333,stroke-width:1px
    style F fill:#93fc,stroke:#333,stroke-width:1px
```

**Textual Explanation:**

1.  **`CircularSliderView` (Struct):** The main view containing all the UI elements.
2.  **`@State private var pickerType`:** A state variable that controls the slider's appearance (Normal or Scaled).
3.  **`Picker`:** A segmented control (using `pickerStyle(.segmented)`) that allows the user to switch between "Normal" and "Scaled" modes.
4.  **`GeometryReader`:**  Provides the size and position of the view, crucial for calculations related to the circular slider.
5.  **`ScrollView`:** Enables horizontal scrolling of the profile images.
6.  **`HStack`:** Arranges the profile images horizontally within the `ScrollView`.
7.  **`ForEach`:** Dynamically creates an `Image` view for each profile picture (from "Profile 1" to "Profile 15").
8.  **`Image(...).resizable().aspectRatio(...)`:** Loads, resizes, and scales each profile image.
9.  **`.clipShape(.circle)`:** Makes the images circular.
10. **`.shadow(...)`:** Adds a drop shadow.
11. **`.visualEffect { ... }`:**  This is where the core animation logic resides, using the `offset` and `scale` functions.
12. **`.scrollTransition(...)`:** conditionally applies transition.
13. **`.scrollTargetLayout()`:** Specifies that the `HStack` should be used for scroll target alignment.
14. **`.background(content: { ... })`:** conditionally renders the yellow.
15. **`.safeAreaPadding(...)`:** Adds padding.
16. **`.scrollIndicators(.hidden)`:** Hides the scroll indicator.
17. **`.scrollTargetBehavior(.viewAligned)`:** Enables snapping behavior, so images center when scrolling stops.
18. **`.scrollPosition(id: $activeID)`:** Binds the scroll position to the `activeID` state variable, which controls which image is centered.
19. **`offset(_ proxy:)` Function:** Calculates the vertical offset of each image based on its position in the scroll view.
20. **`scale(_ proxy:)` Function:** Calculates the scale factor of each image based on its position.
21. **`progress(_ proxy:)` Function:** Calculates the normalized scroll progress.
22. **`TripPicker` Enum:** Defines the two slider modes: "Scaled" and "Normal".

## 2. The `TripPicker` Enum

This enum is straightforward but essential for controlling the slider's mode.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class TripPicker {
        <<enumeration>>
        Scaled
        Normal
    }
```

**Textual Explanation:**

*   The `TripPicker` enum has two cases: `scaled` and `normal`.
*   It conforms to `String` and `CaseIterable`, which are useful for the `Picker` view, and the `ForEach` in the view.

## 3. The `progress`, `offset`, and `scale` Functions

These functions are the heart of the animation and visual effects. Let's break down each one. They work in unison and depend on the geometry of the scrolling area.

### 3.1. `progress(_ proxy:)`

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A["progress Function"] --> B("Get viewWidth from proxy.size.width");
    B --> C("Get minX from proxy.bounds(of: .scrollView).minX");
    C --> D("Return minX / viewWidth");
    
    style A fill:#c3cf,stroke:#333,stroke-width:2px
```

**Textual Explanation and Math:**

*   **Purpose:**  Calculates how far the scroll view has been scrolled, normalized to the width of the view.  This value represents the scrolling "progress."

*   **`viewWidth = proxy.size.width`:**  Gets the total width of the `GeometryReader`.

*   **`minX = (proxy.bounds(of: .scrollView)?.minX ?? 0)`:** This is the key.  `proxy.bounds(of: .scrollView)` gives us the bounds of the *scrolling content* within the `GeometryReader`'s coordinate space.  `minX` represents the x-coordinate of the left edge of the visible portion of the scrollable content.  As you scroll right, `minX` becomes increasingly *negative*.  The `?? 0` handles the case where `bounds(of:)` might return `nil`.

*   **`return minX / viewWidth`:**  Dividing `minX` (which is negative) by `viewWidth` (positive) gives us a normalized progress value.
    *   When the first image is fully visible, `minX` is close to 0, so the progress is near 0.
    *   As you scroll to the right, `minX` becomes more negative, and the progress becomes a negative number.

### 3.2. `offset(_ proxy:)`

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A["offset Function"] --> B("Call progress(proxy)");
    B --> C{"progress < 0?"};
    C -- Yes --> D("Return progress * -30");
    C -- No --> E("Return progress * 30");
    
     style A fill:#c3cf,stroke:#333,stroke-width:2px
```

**Textual Explanation and Math:**

*   **Purpose:**  Calculates the vertical (y) offset to apply to each image.  This creates the up-and-down movement as the images scroll.

*   **`progress = progress(proxy)`:**  Gets the normalized scroll progress.

*   **`progress < 0 ? progress * -30 : progress * 30`:** This is a ternary operator that determines the offset.
    *   If `progress` is negative (scrolling to the right), the offset is `progress * -30`.  This moves the images *up* (negative y direction).  The further you scroll, the more negative `progress` becomes, and therefore the larger the upward offset.
    *   If `progress` is positive (scrolling to the left, which is less common in this setup), the offset is `progress * 30`.  This would move the images *down*.
    *   The `30` is a constant that controls the *magnitude* of the vertical movement.  You can adjust this to make the movement more or less pronounced.

### 3.3. `scale(_ proxy:)`

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A["scale Function"] --> B("Call progress(proxy)");
    B --> C("Clamp progress between -1 and 1");
    C --> D{"progress < 0?"};
    D -- Yes --> E("Return 1 + progress");
    D -- No --> F("Return 1 - progress");
    
    style A fill:#c3cf,stroke:#333,stroke-width:2px
```

**Textual Explanation and Math:**

*   **Purpose:**  Calculates the scale factor to apply to each image. When combined with the offset, this creates the effect of the images moving in a circular path.

*   **`progress = progress(proxy)`:**  Gets the normalized scroll progress.

*   **`progress = min(max(progress, -1), 1)`:** This is crucial.  It *clamps* the progress value between -1 and 1.  This prevents extreme scaling and ensures a smooth animation.  Without clamping, the scale could become very large or very small, distorting the images.

*   **`progress < 0 ? 1 + progress : 1 - progress`:**  Another ternary operator.
    *   If `progress` is negative (scrolling right), the scale is `1 + progress`.  Since `progress` is negative and clamped to -1, the scale will be between 0 and 1 (shrinking the image).
    *   If `progress` is positive (scrolling left), the scale is `1 - progress`.  Since `progress` is positive and clamped to 1, the scale will again be between 0 and 1.

*   **In Essence:** The further an image is from the center (either left or right), the smaller it becomes.  The image at the center (where `progress` is closest to 0) will have a scale closest to 1 (its original size).

## 4. Visual Effects and Scroll Transition

The `.visualEffect` and `.scrollTransition` modifiers are used to apply the calculated offset and scale, as well as manage the appearance of the centered image.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph VisualEffect["visualEffect Modifier"]
        A["Image View"] --> B["offset(y: offset(proxy))"];
        B --> C["scaleEffect(1 + (pickerType == .normal ? 0 : (scale(proxy) / 2)))"];
        C --> D["offset(y: scale(proxy) * 15)"];
    end

    subgraph ScrollTransition["scrollTransition Modifier"]
        A --> E["Conditional Effects based on phase.isIdentity and activeID"];
    end
    
    style VisualEffect fill:#c3cf,stroke:#333,stroke-width:1px
    style ScrollTransition fill:#c3cf,stroke:#333,stroke-width:1px
```

**Textual Explanation for `.visualEffect`:**

*   The `visualEffect` modifier is applied to each `Image` view. It takes a closure that receives two parameters:
    *   `view`: The original `Image` view.
    *   `proxy`: A `GeometryProxy` representing the image's geometry within the scroll view.

*   **`view.offset(y: offset(proxy))`:**  Applies the vertical offset calculated by the `offset` function. The `proxy` lets you know about the geometry of an individual profile to move.

*   **`scaleEffect(1 + (pickerType == .normal ? 0 : (scale(proxy) / 2)))`**: It scales views during scrolling, but it only applies scaling if the picker is set to `.scaled` if not it adds 0 to remain at the original size (scale factor of 1):

* **`offset(y: scale(proxy) * 15)`**:  It contributes to the "circular" motion by shifting images vertically based on their scaled size.

**Textual Explanation for `.scrollTransition`:**

*   `.scrollTransition(.interactive, axis: .horizontal)`: Configures a scroll transition that:
    *   Is **interactive:** The transition updates smoothly as the user scrolls.
    *   Applies along the **horizontal axis**.
    *   Receives a `view` (the `Image`) and a `phase` (a `ScrollTransitionPhase`).

## 5. Scroll Target Behavior and Layout

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A["ScrollView"] --> B["scrollTargetLayout"];
    A --> C["scrollTargetBehavior(.viewAligned)"];
    A --> D["scrollPosition(id: $activeID)"];
    
    style A fill:#c3cf,stroke:#333,stroke-width:2px
```
**Textual Explanation for `scrollTargetBehavior` and `scrollPosition`:**

*   `scrollTargetLayout()`:  Uses `HStack` view for scrolling.
*   `.scrollTargetBehavior(.viewAligned)`:  This is what makes the images "snap" to the center.  It tells the scroll view to align its scroll offset so that views are centered.
*   `.scrollPosition(id: $activeID)`: This is how you programmatically control which image is centered.  By updating the `activeID` state variable, you can tell the scroll view to scroll to a specific image.

## 6. Putting It All Together: The Circular Motion

The circular motion effect is a result of the interplay between the `offset`, `scale`, and the snapping behavior (`.scrollTargetBehavior(.viewAligned)`).

1.  **Scrolling:** As the user scrolls, the `progress` function calculates the scroll position.
2.  **Offset:** The `offset` function uses the progress to move the images up or down.
3.  **Scale:** The `scale` function shrinks images that are farther from the center.
4.  **Snapping:** The `scrollTargetBehavior` tries to keep a view centered. Because the images are scaled and offset, the "center" of the scroll view appears to be along a circular path rather than a straight line. The scaled-down images further emphasize the circular appearance.

## 7.  Complete, Cohesive Diagram

This final diagram integrates all the components and their relationships to provide a comprehensive visual representation of the code's functionality and data flow.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph CircularSliderView["CircularSliderView"]
        A["State: pickerType"] --> B("Picker");
        B --> C["TripPicker Enum:<br>Scaled, Normal"];
        A --> D("GeometryReader");
        D --> E("ScrollView");
        E --> F["HStack<br>(spacing: 35)"];
        F --> G["ForEach<br>(1...15)"];
        G --> H["Image"];
        H --> I["resizable, aspectRatio"];
        H --> J["clipShape(circle)"];
        H --> K["shadow"];
        H --> L["visualEffect"];
        L --> M["offset(y: offset(proxy))"];
        L --> N["scaleEffect"];
        L --> O["offset(scaled proxy)"];
        H --> P["scrollTransition"];
        P --> Q["Conditional Effects"];
        E --> R["scrollTargetLayout"];
        D --> S("Background Circle -<br> conditional");

        subgraph Functions
        style Functions fill:#c3212,stroke:#333,stroke-width:1px
            T["offset(proxy)"] --> U("progress(proxy)");
            V["scale(proxy)"] --> U;
            U --> W("minX / viewWidth");
        end
    
    E --> X["scrollIndicators(.hidden)"];
    E --> Y["scrollTargetBehavior(.viewAligned)"];
    E --> Z["scrollPosition(id: $activeID)"];
   
    end
   
    style CircularSliderView fill:#c3c5,stroke:#333,stroke-width:2px
    
```
---





---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---