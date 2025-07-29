---
created: 2025-02-18 05:31:26
author: NA
version: NA
license(s): NA
copyright: NA
---



# SwiftUI - Circular Slider Effect

---

<div align="center">
  <blockquote>
  As a visual learner student, I created these personal study notes from the cited source(s) to aid my understanding.<br/>
  While my firm intention is to provide full credit, the blended format of notes and diagrams may sometimes obscure the original source, for which I apologize.<br/>
  I am committed to making corrections and welcome any feedback.<br/>
  This is a non-commercial project for my humble educational purposes only since the start.<br/>
  My goal is to share my perspective and contribute to the great work already being done.
  <br/>
  <br/>
  I want to extend my genuine apologies to the creators of the original material.<br/>
  Their work was the direct inspiration for this project, and I adapted it without first reaching out.<br/>
  My intent comes from a place of deep respect, and I hope this is received in the spirit of homage.<br/>
  🙏🏼🙏🏼🙏🏼🙏🏼
  </blockquote>
</div>

----



This doc will explain the Swift code implementation from this branch https://github.com/CongLeSolutionX/MyApp/tree/SwiftUI_Circular_Slider_Effect-SAVE-FOR-REFERENCE.
I will keep the code in GitHub branch as is as reference for content on this article.


----


## 1. Code Overview and Structure

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph View Structure
        A[CircularSliderView] --> B{Properties};
        B --> B1["@State pickerType: TripPicker = .normal"];
        B --> B2["@State activeID: Int?"];
        A --> C{Body};
        C --> D[VStack];
        D --> E[Picker];
        E --> F["ForEach(TripPicker.allCases)"];
        F --> G["Text($0.rawValue)"];
        D --> H[Spacer];
        D --> I[GeometryReader];
        I --> J["ScrollView(.horizontal)"];
        J --> K["HStack(spacing: 35)"];
        K --> L["ForEach(1...15)"];
        L --> M["Image('Profile \(index)')"];
        M --> N[Resizing & Shape];
        M --> O[Visual Effect];
        O --> P["Offset(y: offset(proxy))"];
        O --> Q[ScaleEffect];
        J --> R["Offset(y: -30)"];
        I --> S["Background(Circle)"];
    end
    subgraph Helper Functions
      A --> T{"offset(_ proxy: GeometryProxy)"};
      T --> U["Calculates vertical offset based on scroll progress"];
      A --> V{"scale(_ proxy: GeometryProxy)"};
      V --> W["Calculates scaling factor based on scroll progress"];
      A --> X{"progress(_ proxy: GeometryProxy)"};
      X --> Y[Calculates horizontal scroll progress];
    end
    subgraph Data
        A --> Z[Enum TripPicker: String, CaseIterable];
        Z --> ZA[cases: scaled, normal];
    end
    subgraph Preview
        A --> PB[PreviewProvider];
    end
    
```


**Explanation:**

*   **`CircularSliderView`**:  The main `View` struct, representing the circular slider.
*   **Properties**:  The `@State` properties `pickerType` and `activeID` manage the slider's state (mode and selected item, respectively).
*   **`body`**:  The core UI layout using `VStack`, `Picker`, `Spacer`, `GeometryReader`, `ScrollView`, `HStack`, `ForEach`, `Image`, View modifiers and the helper functions.
*   **Helper Functions**:  `offset(_:)`, `scale(_:)`, and `progress(_:)` calculate dynamic view properties based on the scroll position.
*   **`TripPicker` Enum**: Determines the slider's behavior/style through the `scaled` and `normal` options.
*   **`#Preview`**: A useful macro to show sample previews in the Xcode canvas.

## 2. UI Component Breakdown (VStack, Picker, GeometryReader)

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[CircularSliderView.body] --> B[VStack];
    B --> C[Picker];
    C --> D[TripPicker.allCases];
    D --> E["Text('Scaled')"];
    D --> F["Text('Normal')"];
    B --> G[GeometryReader];

    style B fill:#f395,stroke:#333,stroke-width:2px
    style C fill:#c3c5,stroke:#333,stroke-width:2px
    style D fill:#c3c5,stroke:#333,stroke-width:2px;

    style G fill:#c3c5,stroke:#333,stroke-width:2px

```

**Explanation:**

*   **VStack**:  Vertically stacks the UI elements.
*   **Picker**: A control that allows the user to select from a set of mutually exclusive values, which drives slider behaviour.
*   **TripPicker**: `enum` provides types of slider.
*   **GeometryReader**: Provides the size and position of its content.

## 3. Scrollable Content (ScrollView, HStack, ForEach)

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[CircularSliderView.body] --> B[GeometryReader];
    B --> C["ScrollView(.horizontal)"];
    C --> D["HStack(spacing: 35)"];
    D --> E["ForEach(1...15)"];
    E --> F["Image('Profile_index')"];
    
  
    F --> G["clipShape(.circle)"];
    F --> H[shadow];
    G --> I[visualEffect];

    style C fill:#c3c5,stroke:#333,stroke-width:2px
    style D fill:#c3c5,stroke:#333,stroke-width:2px
    style E fill:#c3c5,stroke:#333,stroke-width:2px
    style F fill:#c3c5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

*   **ScrollView**:  Enables horizontal scrolling.
*   **HStack**: Arranges the images horizontally.
*   **ForEach**: Efficiently creates 15 image views from a single code block.
*   **Image**: Displays profile images.
*  **clipShape**: clips the image.
* **shadow**: shadows the image.
*  **visualEffect**: Dynamically alters the appearance of the image, in response to scrolling.

## 4. Visual Effect and Dynamic Properties (offset, scaleEffect)

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Image] --> B[visualEffect];
    B --> C["offset(y: offset(proxy))"];
    B --> D["scaleEffect(1 + (pickerType == .normal ? 0 : (scale(proxy) / 2)))"];
    C --> E[offsetFunc];
    D --> F[scaleFunc];

    E --> G["progress(proxy)"];
    G --> H[minX / viewWidth]
    F --> I["progress(proxy)"];
    I --> H

    style C fill:#c3c5,stroke:#333,stroke-width:2px
    style D fill:#c3c5,stroke:#333,stroke-width:2px
    style E fill:#c3c5,stroke:#333,stroke-width:2px
    style F fill:#c3c5,stroke:#333,stroke-width:2px
    
```


**Explanation:**

*   **`visualEffect`**: Applies changes to the `Image` during scroll.
*   **`offset(y: offset(proxy))`**: The vertical offset of the image and the `offset` function is called to return the offset. The `offset` uses returns calculation based on the `progress(proxy)` function.
*   **`scaleEffect`**: The scale of the image, dynamically calculated via `scale(proxy)`. Uses calculates from from the `progress(proxy)` function.
*   **`offsetFunc`**: Calculates the y-offset to the image, creating a vertical motion effect during scroll.
*   **`scaleFunc`**: Determines the scaling of the image.
*   **`progress(proxy)`**: Calculates the normalized scroll position (0 to 1).

## 5. State Management and Interaction (pickerType, activeID)

```mermaid
---
config:
  look: handDrawn
  theme: dark
---
stateDiagram
    state PickerType {
      [*] --> Normal
      Normal --> Scaled : User selects "Scaled"
      Scaled --> Normal : User selects "Normal"
    }

    state ScrollState {
      [*] --> Idle
      Idle --> Scrolling : User scrolls
      Scrolling --> Idle : Scroll stops
    }
    note right of PickerType : Changes affect view appearance<br>(scale, offset)
    note left of ScrollState : Active ID updates with scroll position
    
```


**Explanation:**

*   **`@State pickerType`**: Controls the slider's mode (e.g., "Scaled", "Normal").  Changes triggers UI updates.
*   **`@State activeID`**: Tracks the currently focused/selected image, potentially used for further animations or interactions.
*   The state diagram describes how `pickerType` changes when the user selects an item, and how scroll events modify the slider's `activeID`.

## 6. Function Dependencies and Data Flow

```mermaid
---
config:
  look: handDrawn
  theme: dark
---
graph LR
    A["progress(proxy)"] --> B[GeometryProxy];
    A --> C["Returns Scroll Progress<br>(0-1)"];
    D["offset(proxy)"] --> A;
    D --> E[Returns Vertical Offset];
    F["scale(proxy)"] --> A;
    F --> G[Returns Scale Factor];
    H{Scroll View} --> A;
    H --> I[HStack];
    I --> J[ForEach];
    J --> K["Image(profile_index)"];
    K --> D;
    K --> F;
    style A fill:#f395,stroke:#333,stroke-width:2px;
    style D fill:#f395,stroke:#333,stroke-width:2px;
    style F fill:#f395,stroke:#333,stroke-width:2px;
    style B fill:#c3c5,stroke:#333,stroke-width:2px;
    style H fill:#a3f5,stroke:#333,stroke-width:2px
    
```


**Explanation**:

*   The dependency graph shows the relationships between functions and components. `progress(proxy)`is the core function to calculate scroll progress.
*   `offset(proxy)` and `scale(proxy)` use the result of`progress(proxy)` to calculate the image's visual properties.

## 7. Advanced Concepts Applied

*   **`GeometryReader`**: Used to get the dimensions of the screen, which are used to make the circular slider more dynamic.
*   **`ScrollView(.horizontal)`**: Enabling the horizontal scroll for the item in the slider.
*   **`visualEffect`**:  Used to make the image in the slider dynamically altered as user scrolls.
*   **`@State`**: Managing the state of a view with properties.
*   **`ForEach`**:  Used to populate item in the slider.
*   **Enum `TripPicker`**:  Used to provide and organize types of slider.
    *   **Custom visual appearance for the slider**: The `offset(_:)` and `scale(_:)` functions and `VisualEffect` are the key that provide the custom visual appearance for the circular slider.
---



**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---