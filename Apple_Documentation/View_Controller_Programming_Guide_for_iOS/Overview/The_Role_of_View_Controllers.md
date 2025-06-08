---
created: 2025-02-25 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
source: "https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/index.html#//apple_ref/doc/uid/TP40007457"
---



# The Role of View Controllers - A Diagrammatical Summary
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift, Mermaid, and any other programming languages provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



## 1. Core Concept: View Controller's Role

First, let's establish the fundamental role of a view controller.  It's the central hub for managing a portion of the UI, handling user interactions, and connecting the UI to the underlying data.

```mermaid
---
title: The Role of View Controller
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
    subgraph ViewController["View Controller"]
    style ViewController fill:#ccf5,stroke:#333,stroke-width:2px
        A[UI Management] -- Manages --> B(Views);
        A -- Handles --> C(User Interactions);
        A -- Connects --> D(Data Model);
    end
    
```


**Explanation:**

*   **View Controller:**  The central node, representing the `UIViewController` or its subclass.
*   **UI Management:**  The view controller's primary responsibility.
*   **Views:** The visual elements the view controller manages (its own root view and subviews).
*   **User Interactions:** Events like taps, swipes, etc., are often handled by the view controller (or delegated from views).
*   **Data Model:** The underlying data that the UI represents. The view controller acts as the intermediary.

---

## 2. Types of View Controllers

The document mentions two main types: content and container view controllers.

```mermaid
---
title: Types of View Controllers
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
    A[View Controllers] --> B(Content View Controllers);
    A --> C(Container View Controllers);

    B -- Manages --> B1[Discrete Piece of Content];
    B -- Example --> B2[Single Screen with Data];

    C -- Manages --> C1[Child View Controllers];
    C -- Purpose --> C2[Facilitates Navigation];
    C -- Example --> C3[UINavigationController, UITabBarController];
style A fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **View Controllers:** The top-level category.
*   **Content View Controllers:**  The most common type, directly managing content on the screen.
*   **Container View Controllers:**  Manage other view controllers, often for navigation purposes.  Examples include navigation controllers (stack of screens) and tab bar controllers.

---

## 3. View Management Hierarchy

This section emphasizes the hierarchical relationship between a view controller, its root view, and subviews.

```mermaid
---
title: View Management Hierarchy
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
    A[View Controller] --> B(Root View);
    B -- Has --> C(Subviews);
    C -- Can have --> D(More Subviews);
    B -- Strong Reference --> C;
    C -- Strong Reference --> D;
    A -- "1" --> B;
    B -- '*' --> C;
    C -- '*' --> D;
style A fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **View Controller:**  Has a single root view.
*   **Root View:** The top-level view in the view controller's hierarchy.
*   **Subviews:**  Views contained within the root view (and potentially nested further).
*   **Strong References:**  Indicates the ownership relationship, preventing views from being deallocated prematurely.  This is crucial for memory management.
*   **Cardinality:**  "1" to "many" (*) relationships are shown.

**Alternative Representation (Image Analogy):**

Imagine a set of Russian nesting dolls (Matryoshka dolls).  The view controller is like the outermost doll.  Inside is the root view (the next doll).  Inside the root view are subviews (smaller dolls), and so on.

---

## 4. Data Marshaling (Data Flow)

This is about how data moves between the views and the data model, with the view controller acting as the intermediary.

```mermaid
---
title: Data Marshaling (Data Flow)
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
    A[View Controller] -- Updates --> B(Views);
    A -- Receives Input from --> B;
    A -- Formats Data for --> C(Data Model);
    A -- Retrieves Data from --> C;
    B -- Displays --> D(Data);
    C -- Stores --> D;

style A fill:#ccf5,stroke:#333,stroke-width:2px
    
```

**Explanation:**

*   **View Controller:**  The central coordinator.
*   **Views:**  Display data and send user input to the view controller.
*   **Data Model:**  Holds the underlying data (e.g., a `struct`, `class`, or a `UIDocument`).
*   **Updates:** The view controller updates views with data from the model.
*   **Receives Input:**  The view controller gets input from views (e.g., text field entries).
*   **Formats Data:**  The view controller may need to convert data between the format used by the views and the format used by the model.

**Key Principle: Separation of Concerns**

The documentation stresses keeping data logic separate from view controller logic.  The data model should be responsible for data integrity, while the view controller focuses on presentation and user interaction.

---

## 5. User Interactions (Responder Chain)

View controllers are part of the responder chain, meaning they can handle events.

```mermaid
---
title: User Interactions (Responder Chain)
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
    A[User Interaction] --> B(View);
    B -- Forwards Event --> C(View Controller);
    C -- Handles via --> D(Delegate Methods);
    C -- OR --> E(Action Methods);
    C -- OR --> F(Responder Chain);

style C fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **User Interaction:**  A user taps a button, swipes, etc.
*   **View:**  The view usually receives the initial event.
*   **View Controller:**  The view often forwards the event to the view controller.
*   **Delegate Methods:**  A common way to handle events (e.g., `UITableViewDelegate`).
*   **Action Methods:**  Methods connected to UI elements in Interface Builder (e.g., `@IBAction`).
* **Responder Chain**: The chain of objects that the app uses to respond to events that happen within the app.

---

## 6. Resource Management (Memory)

View controllers are responsible for managing the memory of their views and other objects they create.

```mermaid
---
title: Resource Management (Memory)
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
    A[View Controller] -- Creates --> B(Views)
    A -- Creates --> C(Other Objects)
    A -- Receives --> D(Low Memory Warning)
    D -- Triggers --> E(didReceiveMemoryWarning)
    E -- Requires --> F(Release Unnecessary Resources)
    F -- Example --> G(Clear Caches)
    F -- Example --> H(Remove References)
    
style A fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **Low Memory Warning:**  iOS notifies the app when memory is low.
*   **didReceiveMemoryWarning:**  The view controller's method that's called in response.
*   **Release Unnecessary Resources:**  The view controller should release any objects it can easily recreate later.  This is crucial to prevent the app from being terminated.

---

## 7. Adaptivity (Size Classes and Auto Layout)

View controllers must adapt to different screen sizes and orientations.

```mermaid
---
title: Adaptivity (Size Classes and Auto Layout)
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
    A[View Controller] -- Adapts to --> B(Traits)
    B -- Include --> C(Horizontal Size Class)
    B -- Include --> D(Vertical Size Class)
    C -- Values --> C1(Regular)
    C -- Values --> C2(Compact)
    D -- Values --> D1(Regular)
    D -- Values --> D2(Compact)
    A -- Uses --> E(Auto Layout)
    E -- To --> F(Adjust View Size & Position)
    A -- May also --> G(Make Manual Adjustments)
    
style A fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **Traits:**  Describe the environment (size classes, display scale, etc.).
*   **Size Classes:**  Categorize the available space (regular or compact) for width and height.
*   **Auto Layout:**  The primary mechanism for adapting views to different sizes.
*   **Manual Adjustments:**  The view controller can also make additional changes if needed.

**Visual Analogy (Responsive Web Design):**

Think of responsive web design, where a website's layout changes based on the screen size.  iOS adaptivity is similar, but it uses size classes and Auto Layout instead of CSS media queries.

---

## 8. Container View Controller Example: Split View Controller

The documentation uses a split view controller as an example of a container view controller.

```mermaid
---
title: Container View Controller Example - Split View Controller
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
    A[Split View Controller] -- Manages --> B(Child View Controller 1)
    A -- Manages --> C(Child View Controller 2)
    B -- Controls --> B1(Root View 1)
    C -- Controls --> C1(Root View 2)
    A -- Determines --> D(Size & Position of Root Views)
    B1 -- Contains --> B2(Content)
    C1 -- Contains --> C2(Content)
style A fill:#ccf5,stroke:#333,stroke-width:2px

```


**Explanation:**

*   **Split View Controller:** The container.
*   **Child View Controllers:**  Manage their own content.
*   **Root Views:**  The top-level views of the child view controllers.
*   **Size & Position:** The split view controller controls the overall layout of the child view controllers' root views.
*   **Content:**  Each child view controller manages its own content within its root view.

---

## 9. Putting It All Together: A Comprehensive View

This final diagram combines the key aspects into a single, holistic view.

```mermaid
---
title: A Comprehensive View
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
    subgraph ViewController["View Controller"]
    style ViewController fill:#ccf5,stroke:#333,stroke-width:2px
        VC[UIViewController Subclass] -- Manages --> Views
        Views -- Display --> Data
        Views -- Send --> UserInput[User Input]
        UserInput --> VC;
        VC -- Interacts with --> DataModel[Data Model]
        DataModel -- Provides --> Data
        VC -- Handles --> Events[Events]
        Events -- Triggered by --> UserInput
        VC -- Responds to --> Memory[Low Memory Warnings]
        Memory --> didReceiveMemoryWarning
        VC -- Adapts to --> Traits[Device Traits]
        Traits -- Include --> SizeClasses[Size Classes]
    end

    
    %% subgraph Container["Container View Controller<br>(Optional)"]
    %% %% style Container fill:#ddf5,stroke:#333,stroke-width:1px
        %% Container -- Manages --> VC
    %% end

```


**Explanation:**

This summarizes all the key functions and relationships:

*   View management and display of data.
*   Handling of user input and events.
*   Interaction with the data model.
*   Response to low memory warnings.
*   Adaptation to device traits (size classes).
*   The optional role of a container view controller.


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
