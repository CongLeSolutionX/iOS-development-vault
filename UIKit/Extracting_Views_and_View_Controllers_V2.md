---
created: 2025-02-11 05:48:19
author: Cong Le
version: "2.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
original source: https://github.com/jrasmusson/swift-arcade/tree/master/Extract-Views
---



# Extracting Views & View Controllers - NEED RENDERED ON A MACBOOK TO SEE THE BEAUTY OF THE DIAGRAMS

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

----


Below is is the 2nd version from [this documentation](Extracting_Views_and_View_Controllers_V1.md)


---

## 1. Enhanced Architecture Overview: Component Relationships

This diagram is refined to explicitly show the component hierarchy and relationships within the `ViewController`, making the architecture clearer.

```mermaid
---
title: Enhanced Architecture Overview - Component Relationships
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
    subgraph ViewController["UIViewController"]
    style ViewController fill:#f0f2,stroke:#333,stroke-width:1.2px
        A["ViewController Instance"];
        B("GameView Container");
        D("GameView<br>[UIView]");

        C("GameTableViewController Container");
        E("GameTableViewController View<br>[UITableView]");

        F{"profileImage<br>[UIImageView]"};
        G{"titleLabel<br>[UILabel]"};
        H{"bodyLabel<br>[UILabel]"};
        I["UITableView Instance"];
        
        direction TB
        
        
        A:::internal --> B:::container  --- D:::component
        A --> C:::container  --- E:::component
    end
   
    D --> F:::internalComponent
    D --> G:::internalComponent
    D --> H:::internalComponent
    E --> I:::internalComponent

    classDef internal fill:#e399,stroke:#ccc,stroke-width:1px,stroke-dasharray: 5 5;
    classDef component fill:#d0ef,stroke:#333,stroke-width:1.1px;
    classDef container fill:#e844,stroke:#333,stroke-width:1px;
    classDef internalComponent fill:#f8f5,stroke:#ccc,stroke-width:1px,stroke-dasharray: 3 3;

    class A internal
    class B,C container
    class D,E component
    class F,G,H,I internalComponent

    linkStyle 0,1,2,3 stroke-width:1.5px;
    
```


**Explanation of Enhancements:**

*   **Clearer Labels:**  Nodes are labeled with their class names (`UIViewController`, `UIView`, `UITableView`, `UILabel`, `UIImageView`) and roles (e.g., `ViewController Instance`, `GameView Container`).
*   **Explicit Hierarchy:** The `subgraph` structure within `ViewController` clearly delineates the containment relationships ("Container" nodes visually group the views they hold). Arrows indicate a direct hierarchical association.
*   **Styling for Roles:** CSS classes (`internal`, `component`, `container`, `internalComponent`) are used with distinct fill colors and border styles to differentiate the roles of each element (e.g., Containers lighter, Components in blue tones, internals in grey dashes).
*   **Component Breakdown:** Inside `GameView` and `GameTableViewController View`, internal components (`profileImage`, `titleLabel`, `bodyLabel`, `UITableView`) are shown as direct children, illustrating their composition.
*   **Improved Connectors:** Solid arrows with increased `stroke-width` enhance visual flow representing the parent-child relationship more definitively.


---

## 2. Enhanced Extracting Views - Constraint Types: Visual Emphasis

This diagram visually distinguishes between Parent and Child constraints using color and annotations directly within the diagram, making the concept more intuitive.

```mermaid
---
title: Enhanced Extracting Views - Constraint Types
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph ParentViewController["Parent UIViewController"]
    style ParentViewController fill:#f0f2f5,stroke:#333,stroke-width:1.2px
        P["Parent View<br>[UIView]"]:::parentView

        subgraph ExtractedViewContainer["Container View in Parent"]
        style ExtractedViewContainer fill:#e8f0fe,stroke:#333,stroke-width:1px
            EV["Extracted View<br>[UIView]"]:::extractedView
            subgraph InternalView["Content within Extracted View"]
            style InternalView fill:#d0e8ff,stroke:#333,stroke-width:1.1px
                IV["Internal Content"]
            end
             EV --- IV:::childConstraintLink
            %%  note right of EV
            %%     **Child Constraints (Blue)**
            %%     Define layout of content *within* the 
            %%     Extracted View.
            %%     Spacing/padding often managed by Parent.
            %%  end
        end
        P --- ExtractedViewContainer:::parentConstraintLink
        %% note right of P
        %%     **Parent Constraints (Orange)**
        %%     Position & size of Container 
        %%     *in* Parent View.
        %%     Already set up in original VC.
        %% end


    end

    classDef parentView fill:#e3eef9,stroke:#ccc,stroke-width:1px,stroke-dasharray: 5 5;
    classDef extractedView fill:#e3e4f9,stroke:#333,stroke-width:1px;
    classDef parentConstraintLink stroke:#orange,stroke-width:2.5px;
    classDef childConstraintLink stroke:#blue,stroke-width:2.5px;


    linkStyle 0 style:parentConstraintLink
    linkStyle 1 style:childConstraintLink


```

**Explanation of Enhancements:**

*   **Visual Constraint Differentiation:**  `parentConstraintLink` is styled with orange and `childConstraintLink` with blue, directly corresponding to the original text's color coding for immediate visual distinction. Increased `stroke-width` to emphasize the constraints.
*   **In Diagram Notes:** Key details about Parent and Child Constraints are added directly as `note right of` elements within the diagram itself, making the explanations immediately accessible and linked to the visual components.
*   **Descriptive Labels Enhanced:** Node labels now include class names (`[UIView]`, `[UIViewController]`) to improve technical context. Container and content roles are also clarified in labels (e.g., `Container View in Parent`, `Content within Extracted View`).
*   **Consistent Styling Theme:** Maintained a hand-drawn look with default theme but refined color palettes for better contrast and readability.
*   **Structure Maintained:**  Kept the nested subgraph structure to represent containment clearly, but enhanced visual cues direct attention to the constraint types.


---

## 3. Enhanced Extracting View Controllers - Child View Controller Integration (3+1 Steps) with Code Snippets

This flowchart is significantly enhanced by integrating code snippets directly into each step and clarifying the layout step as a subsequent action, making it a 4-step process for clearer instruction.

```mermaid
---
title: Enhanced Extracting View Controllers - Child VC Integration (4 Steps) with Code
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    A[Start Integration] --> B{Add Child's View to Parent's Hierarchy};
    B -- "// view.addSubview(childView)" --> C{"Call addChild(_:)"};
    C -- "// addChild(childVC)" --> D{"Call child.didMove(toParent: self)"};
    D -- "// childVC.didMove(toParent: self)" --> E[Layout Child View in Parent];
    E --> F[End Integration];

    style B fill:#e8f0fe,stroke:#333,stroke-width:1px;
    style C fill:#e8f0fe,stroke:#333,stroke-width:1px;
    style D fill:#e8f0fe,stroke:#333,stroke-width:1px;
    style E fill:#d0e8ff,stroke:#333,stroke-width:1.1px;
    style F fill:#a3ffcc,stroke:#333,stroke-width:1.2px;
    style A fill:#a3ffcc,stroke:#333,stroke-width:1.2px;


    %% note right of B
    %%     **Step 1: Add View**
    %%     ```swift
    %%     view.addSubview(childVC.view)
    %%     ```
    %%     Makes child view visible in parent's view hierarchy.
    %% end

    %% note right of C
    %%     **Step 2: Add Child VC**
    %%     ```swift
    %%     addChild(childVC)
    %%     ```
    %%     Establishes VC relationship.
    %%     Integrates lifecycle events.
    %% end

    %% note right of D
    %%     **Step 3: Notify Child VC**
    %%     ```swift
    %%     childVC.didMove(toParent: self)
    %%     ```
    %%     Informs child it's added.
    %%     Completes lifecycle integration.
    %% end
    %% note right of E
    %%     **Step 4: Layout Child View**
    %%     Using Frames or Auto Layout
    %%     Position & size child's view 
    %%     within parent's view.
    %% end
    
```

**Explanation of Enhancements:**

*   **4-Step Clarity:** Reframed as a 4-step process (including explicit "Layout") to improve instructional sequence.
*   **Integrated Code Snippets:** Key Swift code for each step (`view.addSubview`, `addChild`, `didMove(toParent:)`) is now embedded adjacent to the flowchart steps, directly linking actions to code. Code snippets are in `code` blocks within notes.
*   **Enhanced Step Descriptions:** Notes for each step are made more concise and action-oriented, directly explaining the *purpose* of each code call.
*   **Visual Flow Emphasis:** Used distinct fill styles for step nodes leading to a visually prominent "End Integration" node, reinforcing the successful completion of the process.
*   **Clearer Step Node Labels:** Node labels are action-based (e.g., "Add Child's View", "Call addChild(_:)") making the process steps immediately understandable.


---

## 4. Enhanced `loadView()` vs. Auto Layout: Comparative Table

This diagram is transformed into a comparative table format within Mermaid to directly contrast `loadView()` and Auto Layout options, highlighting pros and cons side-by-side.

```mermaid
---
title: Enhanced loadView() vs. Auto Layout - Comparative Table
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Comparison [Layout Method Comparison]
    direction LR
    TB[ ] -- "Feature" --- TC["loadView() Method"] --- TD["Auto Layout Constraints"]
    TB -- "Code Verbosity" --> TC1[Concise<br>Less Code] --> TD1[Verbose<br>More Code]
    TB -- "Layout Control" --> TC2[Full-Screen Only<br>ViewController View] --> TD2[Flexible<br>Any Layout]
    TB -- "Setup" --> TC3["Override<br>loadView() { view = childView }"] --> TD3["Explicit Constraints<br>(top, bottom, leading, trailing)"]
    TB -- "Best Use Case" --> TC4[Full-Screen Child View<br>Simple, Elegant] --> TD4[Complex Layouts<br>Custom Sizing & Positioning]
    end

    style Comparison fill:#f0f2f5,stroke:#333,stroke-width:1.2px
    classDef header fill:#e8f0fe,stroke:#333,stroke-width:1px;
    classDef methodOption fill:#d0e8ff,stroke:#333,stroke-width:1.1px;
    classDef featureRow fill:#e3eef9,stroke:#ccc,stroke-width:1px,stroke-dasharray: 5 5;

    class TB header
    class TC,TD methodOption
    class TC1,TD1,TC2,TD2,TC3,TD3,TC4,TD4 methodOption
    class TB,TC,TD featureRow

    linkStyle 1,2,3,4,5,6,7,8 stroke-width:1.5px;
    
```


**Explanation of Enhancements:**

*   **Comparative Table Format:**  Structure changed from side-by-side boxes to a table-like layout with "Feature" column and method columns (`loadView()`, `Auto Layout`) for direct comparison across features. This provides a structured and easily digestible format.
*   **Feature-Based Rows:** Rows are defined by key comparison features like "Code Verbosity", "Layout Control", "Setup", and "Best Use Case," making it focused on decision-making factors.
*   **Concise Feature Descriptors:**  Table cells contain short, impactful descriptions highlighting the key differences (e.g., "Concise\nLess Code" vs. "Verbose\nMore Code").
*   **Visual Table Structure:**  `graph LR` with strategically placed invisible nodes (`TB`, `TC`, `TD`) combined with link styling is used to simulate a table structure within Mermaid, without native table support.
*   **Styling for Table Elements:** CSS classes (`header`, `methodOption`, `featureRow`) are applied to style the table header, method option columns, and feature rows distinctly, enhancing table readability.


---

## 5. Enhanced Handling View Interactions via Closures: Detailed Sequence Flow

This sequence diagram is refined for a more detailed and visually clearer representation of event flow, handler execution and conditional logic.

```mermaid
---
title: Enhanced Handling View Interactions via Closures - Detailed Sequence Flow
config:
  layout: elk
  look: handDrawn
  theme: dark
---
sequenceDiagram
    autonumber
    participant ViewController [UIViewController]
    participant View [UIView Subclass]
    participant TextField [UITextField]

    Note over ViewController,View: VC sets closure handler in View
    ViewController->>View: Set searchTextFieldHandler = { fetchWeatherClosure }
    activate View

    View->>TextField: User interaction:<br>TextField Ends Editing
    activate TextField
    TextField-->>View: textFieldDidEndEditing(_:) Event Callback
    deactivate TextField

    View->>View: Check: searchTextFieldHandler?
    alt Handler is Set (Closure Defined)
        View->>ViewController: Execute searchTextFieldHandler(TextField)<br>Closure is called, TextField sent as param
        activate ViewController
        ViewController->>ViewController: fetchWeatherClosure(textField)<br>Process text, e.g., fetchWeather(city: textField.text)
        ViewController->>TextField: textField.text = ""<br>Clear TextField for next input
        deactivate ViewController
    else Handler is NOT Set (Closure nil)
        View-->>View: Return<br>No action taken - handler is nil
    end
    deactivate View
    
```

**Explanation of Enhancements:**

*   **Detailed Flow Breakdown:** Sequence diagram is made more granular, showing activation and deactivation of participants (`ViewController`, `View`, `TextField`) to better visualize lifecycle.
*   **Conditional Logic Emphasis:** `alt/else` block is used to visually separate and emphasize the two paths of execution based on whether `searchTextFieldHandler` is set, making the conditional behavior prominent.
*   **Inline Notes for Actions:** Notes are integrated at key points (e.g., "VC sets closure handler", "User Interaction: TextField Ends Editing", "Handler is Set (Closure Defined)") directly within the sequence flow to narrate the process step-by-step.
*   **Parameter Passing Clarity:** Diagram explicitly notes that `TextField` is passed as a parameter in the `searchTextFieldHandler` call, enhancing understanding of data flow.
*   **Action Descriptions in Messages:** Messages between participants are more descriptive (e.g., "Execute searchTextFieldHandler(TextField)\nClosure is called, TextField sent as param"), explaining *what* is happening in each interaction.
*   **Visual Cues for Events:**  Use of "Event Callback" to explicitly label `textFieldDidEndEditing(_:)` as an event originating from `TextField` to `View`.




---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---