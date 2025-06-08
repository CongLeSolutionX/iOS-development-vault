---
created: 2025-04-27 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# MVVM-C Design Pattern in iOS Development
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



## 1. Introduction: What is MVVM-C?

The **Model-View-ViewModel-Coordinator (MVVM-C)** pattern is an architectural pattern used in iOS development. It extends the popular **MVVM (Model-View-ViewModel)** pattern by introducing a new component: the **Coordinator**.

**Core Idea:** While MVVM effectively separates UI logic (View) from business logic and state management (ViewModel), it often leaves the responsibility of **navigation** ambiguous. ViewModels shouldn't know about `UINavigationController` or how to present other View Controllers, and Views (View Controllers) become bloated if they handle navigation directly. MVVM-C addresses this by isolating navigation logic into Coordinators.

**Purpose:** To decouple View Controllers from navigation responsibilities, making them more reusable, testable, and focused solely on presenting the UI and forwarding user interactions. Coordinators manage the application's flow and the creation/presentation of View Controllers.

```mermaid
---
title: "What is MVVM-C?"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
mindmap
  root(("**MVVM-C Pattern** <br> iOS Architecture"))
    Core_Components["**Core Components**"]
      Model
        ::icon(fa fa-database)
        Data<br/>Domain Logic
      View["View<br/>(ViewController/SwiftUI View)"]
        ::icon(fa fa-desktop)
        UI Presentation<br/>User Input
      ViewModel
        ::icon(fa fa-cogs)
        Business Logic<br/>State Management<br/>Data Formatting
      Coordinator
        ::icon(fa fa-route)
        Navigation_Logic["**Navigation Logic** <br/>Flow Management<br/>Dependency Injection"]
    Key_Benefit_Over_MVVM["**Key Benefit Over MVVM**"]
      ::icon(fa fa-lightbulb)
      Decouples Navigation Logic
      Improves Testability
      Enhances Reusability
    Addresses_Problem["**Addresses Problem**"]
      ::icon(fa fa-exclamation-triangle)
      Where to put navigation code in MVVM?
      Avoids bloated ViewControllers
      Avoids_ViewModels_knowing_UI_specifics["Avoids ViewModels knowing UI specifics<br/>(UIKit/SwiftUI)"]
      
```


---

## 2. Core Components Breakdown

MVVM-C consists of four main components:

### a. Model
The Model represents the application's data and core domain logic. It's unaware of the ViewModel, View, or Coordinator. This is identical to the Model in MVC or MVVM.

*   **Responsibilities:** Holds data, enforces business rules, performs data operations (fetching, saving).
*   **Example:** Structs or classes representing user data, network responses, database entities.

```mermaid
---
title: "Core Components - Model"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
graph TD
    style M fill:#558,stroke:#fff,stroke-width:1px,color:#fff
    M["<b>Model</b><br/><br/><i>e.g., User struct,<br/> Product class</i>"]
    M --> D(Data Representation):::dashed
    M --> BL(Business Logic):::dashed
    M --> DO(Data Operations):::dashed

    subgraph Responsibilities
        direction LR
        D --- BL --- DO
    end

    classDef dashed stroke-dasharray: 5 5, stroke-width:1px, stroke:#ccc
```

### b. View (ViewController / SwiftUI View)
The View is responsible for presenting the UI to the user and capturing user input. In UIKit, this is typically a `UIViewController` subclass. In SwiftUI, it's a `View` struct. It owns or has a reference to its ViewModel.

*   **Responsibilities:** Renders UI based on ViewModel state, forwards user actions (button taps, text input) to the ViewModel, binds UI elements to ViewModel properties. **Crucially, it does NOT handle navigation directly.** It delegates navigation requests (often triggered by the ViewModel) to its Coordinator.
*   **Interaction:** Binds to ViewModel properties (e.g., using Combine, RxSwift, delegates, or closures). Receives formatted data from the ViewModel. Notifies the ViewModel of user interactions.

```mermaid
---
title: "Core Components - View"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
graph LR
    style V fill:#363,stroke:#fff,stroke-width:1px,color:#fff
    style VM fill:#643,stroke:#fff,stroke-width:1px,color:#fff
    style C fill:#337,stroke:#fff,stroke-width:1px,color:#fff

    subgraph View_Layer["View Layer<br/>(UIKit/SwiftUI)"]
        V["<b>View / ViewController</b><br/><br/><i>Owns ViewModel<br/>Displays UI<br/>Forwards User Actions</i>"]
    end

    subgraph ViewModel_Layer["ViewModel Layer"]
        VM("<b>ViewModel</b><br/><i>Provides display data<br/>Handles user actions</i>")
    end

    subgraph Coordinator_Layer["Coordinator Layer"]
        C("<b>Coordinator</b><br/><i>Handles Navigation Requests</i>")
    end

    V -- "Binds UI to<br>Properties<br/>(e.g., Combine)" --> VM
    VM -- "Provides Formatted Data" --> V
    V -- "Forwards User Actions<br/>(e.g., buttonTap())" --> VM
    V -- "Delegates Navigation<br/>Request<br/>(via ViewModel/Directly)" --> C

    %% Dashed lines indicate indirect or delegated action
    VM -.-> C
    style C stroke-dasharray: 5 5
    
```


### c. ViewModel
The ViewModel acts as an intermediary between the Model and the View. It prepares data from the Model for display in the View and handles logic triggered by user interactions forwarded from the View.

*   **Responsibilities:** Holds UI state, performs data formatting, contains presentation logic, handles user actions passed from the View. **Crucially, it asks the Coordinator to perform navigation** when a specific flow needs to start (e.g., after successful login, tapping a detail button). It does *not* know *how* the navigation happens, only *that* it needs to happen.
*   **Communication for Navigation:** Typically uses a delegate protocol or closure property, implemented/provided by the Coordinator, to signal navigation events.

```mermaid
---
title: "Core Components - ViewModel"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
graph TD
    style M fill:#558,stroke:#fff,stroke-width:1px,color:#fff
    style V fill:#363,stroke:#fff,stroke-width:1px,color:#fff
    style VM fill:#643,stroke:#fff,stroke-width:1px,color:#fff
    style C fill:#337,stroke:#fff,stroke-width:1px,color:#fff

    subgraph ViewModel_Layer["ViewModel Layer"]
        VM["<b>ViewModel</b><br/><br/><i>Holds UI State<br/>Formats Model Data<br/>Handles View Actions<br/>Requests Navigation</i>"]
    end

    M("<b>Model</b>") -- "Fetches/Updates" --> VM
    VM -- "Provides Formatted Data<br/>(Bindings)" --> V("<b>View</b>")
    V -- "Forwards User Actions" --> VM
    VM -- "Requests Navigation<br><i>(e.g., showDetails(itemID), loginSucceeded())</i><br/><b>via Delegate/Closure</b>" --> C("<b>Coordinator</b>")
    
```


### d. Coordinator
This is the defining component of MVVM-C. The Coordinator manages the navigation flow for a specific part of the application (e.g., authentication flow, settings flow, main tab flow).

*   **Responsibilities:**
    *   Instantiates ViewControllers and their corresponding ViewModels.
    *   Injects dependencies (like the ViewModel itself, or services) into the ViewController/ViewModel.
    *   Listens for navigation requests from ViewModels (via delegate/closure).
    *   Performs the actual navigation (pushing, presenting modally, switching tabs) using UIKit APIs (`UINavigationController`, `UITabBarController`, `present(_:animated:completion:)`).
    *   Manages the lifecycle of child coordinators for sub-flows.
    *   Starts and stops itself or its children.
*   **Key Aspect:** It encapsulates *how* to navigate, abstracting this away from Views and ViewModels.

```mermaid
---
title: "Core Components - Coordinator"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
graph TD
    style C fill:#337,stroke:#fff,stroke-width:2px,color:#fff
    style V fill:#363,stroke:#fff,stroke-width:1px,color:#fff
    style VM fill:#643,stroke:#fff,stroke-width:1px,color:#fff
    style Dep fill:#777,stroke:#fff,stroke-width:1px,color:#fff
    style ChildC fill:#337,stroke:#fff,stroke-width:1px,color:#fff,stroke-dasharray: 5 5


    subgraph Coordinator_Layer["Coordinator Layer"]
        C["<b>Coordinator</b><br/><br/><i><b>Central Navigation Hub</b><br/>Manages App Flow</i>"]
    end

    C -- "Step 1:<br/>Creates" --> VM[<b>ViewModel</b>]
    C -- "Step 2:<br/>Creates & <br>Injects ViewModel" --> V["<b>View / ViewController</b>"]
    Dep("Dependencies<br><i>e.g., Services</i>") -- "Injects" --> VM
    VM -- "Step 3:<br/>Requests Navigation<br>(via Delegate/Closure)<br><i>e.g., userTappedDetails(for: id)</i>" --> C
    C -- "Step 4:<br/>Performs Navigation<br><i>(e.g., pushViewController,<br>present modally)</i>" --> V
    C -- "Manages Lifecycle" --> ChildC("<b>Child Coordinator</b>")
    C -- "Starts/Stops" --> ChildC

```

---

## 3. Component Interactions & Communication Flow

The power of MVVM-C lies in its clean separation and defined communication paths, especially for navigation.

**Typical Flow (e.g., User Taps a Button to See Details):**

1.  **User Interaction:** User taps a button on the `View` (ViewController).
2.  **Forward Action:** The `View` calls a method on its `ViewModel` (e.g., `viewModel.didTapDetailsButton(for: itemID)`).
3.  **Process Logic:** The `ViewModel` handles any necessary logic (e.g., validating the ID).
4.  **Request Navigation:** The `ViewModel` determines navigation is needed and calls a method on its `coordinatorDelegate` (which is the `Coordinator`) (e.g., `coordinatorDelegate?.viewModelDidRequestDetails(for: itemID)`).
5.  **Coordinator Acts:** The `Coordinator` receives the request.
6.  **Instantiate & Configure:** The `Coordinator` creates the `DetailsViewModel` and the `DetailsViewController`, injecting the ViewModel and any other dependencies.
7.  **Perform Navigation:** The `Coordinator` uses its `UINavigationController` (or other presentation context) to push or present the newly created `DetailsViewController`.

```mermaid
---
title: "Component Interactions & Communication Flow"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
sequenceDiagram
    autonumber

    actor User

    box rgb(202, 12, 22, 0.1) The App System
        participant V as View<br/>(ViewController)
        participant VM as ViewModel
        participant C as Coordinator
        participant DetailVC as Detail View<br/>(Created by C)
        participant DetailVM as Detail ViewModel<br/>(Created by C)
    end

    User->>+V: Taps 'Details' Button<br/>(for item X)
    V->>+VM: Calls 'didTapDetails(for: itemX)'
    VM->>VM: Performs logic<br/>(optional)
    VM->>+C: Requests Navigation<br/>via delegate/closure:<br/>'showDetails(for: itemX)'
    C->>+DetailVM: Creates DetailViewModel(item: itemX)
    C->>+DetailVC: Creates DetailViewController(viewModel: DetailVM)
    C->>-V: Performs Navigation<br/>(e.g., navigationController.pushViewController(DetailVC))
    Note right of C: Coordinator now showing Detail Screen
    V-->>-User: Detail Screen is Presented
    
```

---

## 4. Coordinator Hierarchy & Flow Management

For non-trivial applications, a single coordinator becomes unmanageable. MVVM-C promotes a hierarchy of coordinators:

*   **App Coordinator:** The root coordinator, often started in the `AppDelegate` or `SceneDelegate`. It typically manages top-level navigation components like `UITabBarController` or orchestrates the initial flow (e.g., deciding whether to show onboarding, authentication, or the main app).
*   **Parent/Child Coordinators:** A coordinator can start other coordinators (`Child Coordinators`) to manage specific sub-flows (e.g., an `AuthCoordinator` started by the `AppCoordinator`, or a `SettingsCoordinator` started from a `ProfileCoordinator`).
*   **Lifecycle:** Parent coordinators typically hold strong references to their active children. When a child coordinator's flow finishes (e.g., user logs out, completes onboarding), it notifies its parent, which then removes the reference, allowing the child coordinator and its associated view controllers/view models to be deallocated.

```mermaid
---
title: "Coordinator Hierarchy & Flow Management"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'flowchart': { 'htmlLabels': false, 'curve': 'basis' },
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28122',
      'primaryTextColor': '#000',
      'primaryBorderColor': '#7C33',
      'lineColor': '#F8B229',
      'stroke':'#000',
      'stroke-width': '0.5px'
    }
  }
}%%
graph TD
    style AppC fill:#337,stroke:#fff,stroke-width:2px,color:#fff
    style AuthC fill:#55a,stroke:#fff,stroke-width:1px,color:#fff
    style MainC fill:#5a5,stroke:#fff,stroke-width:1px,color:#fff
    style OnboardC fill:#a55,stroke:#fff,stroke-width:1px,color:#fff
    style Tab1C fill:#77c,stroke:#fff,stroke-width:1px,color:#fff, stroke-dasharray: 5 5
    style Tab2C fill:#7c7,stroke:#fff,stroke-width:1px,color:#fff, stroke-dasharray: 5 5

    AppC["<b>App Coordinator</b><br/>(Root)"] -- Manages --> Nav("UINavigationController /<br>UITabBarController")

    subgraph "Initial Flow Decision"
        AppC -->|If NOT Onboarded| OnboardC(<b>Onboarding Coordinator</b>)
        AppC -->|If NOT Logged In| AuthC(<b>Authentication Coordinator</b>)
        AppC -->|If Logged In| MainC(<b>Main Tab Coordinator</b>)
    end

    subgraph "Sub-Flows"
       AuthC -- "Manages Login/Signup Flow" --> AuthViews[[Auth Views...]]
       OnboardC -- "Manages Onboarding Screens" --> OnboardViews[[Onboarding Views...]]
       MainC -- "Manages Tab Bar & Child Flows" --> TabBar(UITabBarController)
       MainC -- Starts / Owns --> Tab1C(<b>Tab 1 Coordinator</b>)
       MainC -- Starts / Owns --> Tab2C(<b>Tab 2 Coordinator</b>)
       Tab1C -- "Manages Flow within Tab 1" --> Tab1Views[...]
       Tab2C -- "Manages Flow within Tab 2" --> Tab2Views[...]
    end

    %% Finish Callbacks
    AuthC -.->|"'didFinishAuth(user)'"| AppC
    OnboardC -.->|"'didFinishOnboarding()'"| AppC
    Tab1C -.->|"'didFinishFlow()'"| MainC

    classDef finishLink stroke:#f90,stroke-dasharray: 2 2
    linkStyle 8,9,10 stroke-width:1px,color:#f90,stroke:#f90,stroke-dasharray: 3 3;

```

*(Note: Dashed arrows indicate potential notification/completion flow)*

---

## 5. Implementation Example (Conceptual Swift Structure)

```swift
// Protocol for ViewModel to signal navigation needs
protocol SomeViewModelCoordinatorDelegate: AnyObject {
    func viewModelDidRequestNavigateToNextScreen(_ viewModel: SomeViewModel, data: SomeData)
    func viewModelDidFinish(_ viewModel: SomeViewModel)
}

// ViewModel asks Coordinator via delegate
class SomeViewModel {
    weak var coordinatorDelegate: SomeViewModelCoordinatorDelegate?
    // ... other properties and logic ...

    func userTappedNextButton() {
        let dataToSend = // ... prepare data ...
        coordinatorDelegate?.viewModelDidRequestNavigateToNextScreen(self, data: dataToSend)
    }

    func userTappedCloseButton() {
        coordinatorDelegate?.viewModelDidFinish(self)
    }
}

// Coordinator Protocol (Common interface for coordinators)
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set } // Or other context

    func start()
    func childDidFinish(_ child: Coordinator?) // For cleanup
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        childCoordinators.removeAll { $0 === child }
    }
}


// Concrete Coordinator Implementation
class SomeCoordinator: Coordinator, SomeViewModelCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = SomeViewModel()
        viewModel.coordinatorDelegate = self // ViewModel talks back to Coordinator
        let viewController = SomeViewController(viewModel: viewModel)
        // Inject other dependencies if needed

        // How it's presented depends on context (push, modal, root)
        navigationController.pushViewController(viewController, animated: true)
    }

    // --- SomeViewModelCoordinatorDelegate ---

    func viewModelDidRequestNavigateToNextScreen(_ viewModel: SomeViewModel, data: SomeData) {
        // Start another coordinator or directly present another VC
        let nextCoordinator = NextCoordinator(navigationController: navigationController, initialData: data)
        childCoordinators.append(nextCoordinator)
        nextCoordinator.start() // Start the sub-flow
    }

     func viewModelDidFinish(_ viewModel: SomeViewModel) {
        // Logic to dismiss the flow, e.g., pop the VC, or tell the parent coordinator
        // parentCoordinator?.childDidFinish(self) // If this coordinator itself needs to end
        navigationController.popViewController(animated: true) // Example: just pop
    }
}

// ViewController remains relatively simple
class SomeViewController: UIViewController {
    let viewModel: SomeViewModel

    init(viewModel: SomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        // Setup view bindings to viewModel properties here
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // ... UI setup, button actions calling viewModel methods ...
    @objc func handleNextButtonTap() {
        viewModel.userTappedNextButton()
    }

     @objc func handleCloseButtonTap() {
        viewModel.userTappedCloseButton(
     }
}
```

Full GitHub repo implementation [GitHub - CongLeSolutionX/MyApp at DESIGN\_PATTERNS\_MVVM-C](https://github.com/CongLeSolutionX/MyApp/tree/DESIGN_PATTERNS_MVVM-C)



---

## 6. Advantages of MVVM-C

*   **Improved Separation of Concerns:** Navigation logic is cleanly extracted from ViewControllers and ViewModels.
*   **Enhanced Testability:**
    *   ViewModels can be tested without importing UIKit or needing a navigation context (mock the coordinator delegate).
    *   Coordinators can be tested independently to verify navigation flow logic.
    *   ViewControllers become simpler and easier to test (primarily UI and action forwarding).
*   **Increased Reusability:** ViewControllers and ViewModels don't contain specific navigation paths, making them potentially reusable in different flows managed by different coordinators. Coordinators themselves can sometimes be reused.
*   **Clearer Application Flow:** The coordinator hierarchy provides a clear map of the application's possible navigation paths and states.
*   **Simplified ViewControllers:** Reduces the "Massive View Controller" problem by offloading navigation responsibilities.


----

## 7. Disadvantages/Considerations

*   **Increased Boilerplate:** Introduces an extra layer (Coordinator) which can add more files and initial setup code, potentially feeling like overkill for very simple applications.
*   **Complexity:** Managing the coordinator hierarchy, parent-child relationships, and their lifecycles (especially cleanup) can add complexity compared to simpler patterns. Requires careful handling of `childCoordinators` arrays and finish callbacks.
*   **Learning Curve:** Developers new to the pattern need to understand the role of each component and the communication flow, particularly how ViewModels signal navigation needs to coordinators.
*   **Dependency Management:** Coordinators often become responsible for dependency injection (creating ViewModels and injecting services), requiring a clear strategy.

---

## 8. Summary Mind Map

```mermaid
---
title: "Summary in Mind Map"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'themeVariables': {
      'fontSize': '12px',
      'fontFamily': 'Fantasy'
    }
  }
}%%
mindmap
  root(("**MVVM-C Pattern Summary**"))
    Definition["**Definition**"]
      ::icon(fa fa-info-circle)
      Extension of MVVM
      Adds <b>Coordinator</b> for Navigation Logic
    Components["**Components**"]
      Model
        Data & Domain Logic
      View (VC/SwiftUI View)
        UI & User Input
        Delegates navigation requests
      ViewModel
        State & Presentation Logic
        Requests navigation (via delegate/closure)
      Coordinator
        <b>Owns Navigation Flow</b>
        Creates V/VM pairs
        Injects Dependencies
        Manages Child Coordinators
    Key_Interaction["**Key Interaction**"]
      ::icon(fa fa-arrows-alt-h)
      View -> ViewModel (User Actions)
      ViewModel -> Coordinator (Navigation Requests)
      Coordinator -> Creates/Configures V+VM
      Coordinator -> Performs Navigation (UIKit/AppKit)
    Hierarchy["**Hierarchy**"]
      ::icon(fa fa-sitemap)
      App Coordinator (Root)
      Parent Coordinators own Child Coordinators
      Lifecycle Management (Start/Finish/Cleanup)
    Advantages["**Advantages**"]
      ::icon(fa fa-thumbs-up)
      Clear Separation of Concerns (SoC)
      Improved Testability (V, VM, C)
      Enhanced Reusability (V, VM)
      Clearer App Flow Control
      Simpler ViewControllers
    Disadvantages["**Disadvantages**"]
      ::icon(fa fa-thumbs-down)
      More Boilerplate Code
      Added Complexity (Hierarchy Mgmt)
      Learning Curve
      Dependency Injection Strategy Needed
    Use_Case["**Use Case**"]
      ::icon(fa fa-check-circle)
      Apps with complex navigation flows
      When testability is a high priority
      When decoupling ViewControllers is desired
      
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
