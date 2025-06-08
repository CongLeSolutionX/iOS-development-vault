---
created: 2025-04-27 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# Dependency Injection in iOS Development: Building Modular and Testable Apps
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



## 1. Introduction: What is Dependency Injection?

Dependency Injection (DI) is a fundamental design pattern used extensively in software development, including iOS app creation. It's a specific form of Inversion of Control (IoC), where the responsibility of creating and providing dependencies (objects or services that another object needs to perform its function) is transferred from the object itself to an external entity.

Instead of a component creating its own dependencies internally (like `let service = MyNetworkService()`), these dependencies are "injected" from the outside. This promotes **loose coupling**, making components more independent, easier to test in isolation, and simpler to maintain and modify.

```mermaid
---
title: "What is Dependency Injection?"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
mindmap
  root(("Dependency Injection (DI) in iOS)")
    <b>Definition</b>
      Design Pattern
      Inversion_of_Control["Inversion of Control<br/>(IoC)"]
      External entity provides dependencies
    <b>Core Idea</b>
      Instead of: Component creates its dependencies
      DI: Dependencies are "injected" from outside
    <b>Primary Goals</b>
      Loose Coupling
      Increased Modularity
      Enhanced Testability
      Improved Maintainability
      Flexibility
```

---

## 2. Why Use Dependency Injection in iOS?

Tight coupling, where components directly create or reference concrete implementations of their dependencies, leads to several problems in iOS development:

*   **Difficult Testing:** Mocking or replacing dependencies for unit tests becomes cumbersome or impossible. If `ViewControllerA` directly creates `RealNetworkService`, you can't easily test `ViewControllerA` with a `MockNetworkService`.
*   **Reduced Reusability:** Components tied to specific dependencies are harder to reuse in different contexts.
*   **Rigidity:** Changing a dependency often requires modifying the components that use it, leading to ripple effects across the codebase.
*   **Maintenance Challenges:** Understanding and modifying tightly coupled code is complex and error-prone.

DI addresses these issues directly:

```mermaid
---
title: "Why Use Dependency Injection in iOS?"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph TD
    style Start fill:#1a1a1a,stroke:#eee,stroke-width:2px,color:#fff
    style Problem fill:#800000,stroke:#eee,stroke-width:1px,color:#fff
    style Solution fill:#006400,stroke:#eee,stroke-width:1px,color:#fff
    style Benefit fill:#004080,stroke:#eee,stroke-width:1px,color:#fff

    subgraph Traditional_Approach_No_DI["Traditional Approach<br/>(No DI)"]
      direction LR
      A["Component A<br>Needs Service X"] --> B("Component A<br>Creates 'ServiceX()'")
      B --> C{{"Tightly Coupled"}}
      C --> D["Hard to Test<br>Rigid<br>Low Reusability"]
      style B fill:#550000,stroke:#eee,stroke-width:1px,color:#fff
      style C fill:#770000,stroke:#eee,stroke-width:1px,color:#fff
      style D fill:#800000,stroke:#eee,stroke-width:1px,color:#fff
    end

    subgraph Dependency_Injection_Approach["Dependency Injection Approach"]
      direction LR
      E["Component B<br>Needs Service X"] --> F("External Assembler<br>Creates 'ServiceX()'")
      F --> G("Injects ServiceX<br>into Component B")
      E --> H{{"Loosely Coupled"}}
      H --> I["<b>Easy to Test</b> (Inject Mocks)<br><b>Flexible</b> (Swap Implementations)<br><b>Reusable</b><br><b>Maintainable</b>"]
      
      style F fill:#003300,stroke:#eee,stroke-width:1px,color:#fff
      style G fill:#004400,stroke:#eee,stroke-width:1px,color:#fff
      style H fill:#005500,stroke:#eee,stroke-width:1px,color:#fff
      style I fill:#006400,stroke:#eee,stroke-width:1px,color:#fff
    end

    Start("Start:<br/> iOS App Structure") --> A & E
    D --> Problem("Problems")
    I --> Solution("Solution")
    
    Solution --> Benefit("Benefits of DI")
    
```


**Key Benefits:**

1.  **Testability:** Dependencies can be easily replaced with mock objects during unit testing, allowing components to be tested in isolation.
2.  **Modularity & Loose Coupling:** Components don't depend on concrete implementations, only on abstractions (protocols/interfaces).
3.  **Flexibility & Reconfigurability:** Different implementations of a dependency can be swapped easily (e.g., switching from a real network service to a cached one) without changing the dependent component.
4.  **Maintainability:** Code becomes easier to understand, modify, and refactor due to clearer separation of concerns.
5.  **Parallel Development:** Teams can work on different components concurrently as long as the interfaces (protocols) are defined.

---

## 3. Common Types of Dependency Injection in Swift/iOS

There are several ways to inject dependencies into an object in Swift:

### a) Initializer Injection

This is the **most common and generally preferred** method in Swift. Dependencies are provided through the object's initializer (`init`).

*   **Mechanism:** Dependencies are passed as parameters to the `init` method.
*   **Advantages:**
    *   Ensures the object has all required dependencies upon creation (no partially initialized state).
    *   Dependencies can be declared as non-optional constants (`let`), enforcing immutability.
    *   Clear declaration of requirements.
*   **Disadvantages:**
    *   Can lead to initializers with many parameters if an object has numerous dependencies.

----

```swift
// Protocol defining the dependency
protocol NetworkFetching {
    func fetchData() -> Data?
}

// Concrete implementation
class NetworkService: NetworkFetching {
    func fetchData() -> Data? {
        print("Fetching data from network...")
        // ... actual network call ...
        return Data()
    }
}

// Dependent class using Initializer Injection
class DataViewModel {
    private let networkFetcher: NetworkFetching // Dependency declared using protocol

    // Dependency injected via initializer
    init(networkFetcher: NetworkFetching) {
        self.networkFetcher = networkFetcher
    }

    func loadData() {
        let data = networkFetcher.fetchData()
        // ... process data ...
        print("Data loaded using \(type(of: networkFetcher))")
    }
}

// Usage: Injecting the dependency
let realService = NetworkService()
let viewModel = DataViewModel(networkFetcher: realService)
viewModel.loadData()

// For Testing: Injecting a mock
class MockNetworkFetcher: NetworkFetching {
    func fetchData() -> Data? {
        print("Returning mock data...")
        return Data("Mock".utf8)
    }
}
let mockService = MockNetworkFetcher()
let testViewModel = DataViewModel(networkFetcher: mockService)
testViewModel.loadData()

```


Link to GitHub repo implementation: [GitHub - CongLeSolutionX/MyApp at DESIGN\_PATTERNS\_Dependency\_Injections](https://github.com/CongLeSolutionX/MyApp/tree/DESIGN_PATTERNS_Dependency_Injections)


```mermaid
---
title: "Initializer Injection"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph LR
    style Svc fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    style MockSvc fill:#505000,stroke:#eee,stroke-width:1px,color:#fff
    style Proto fill:#603060,stroke:#eee,stroke-width:1px,color:#fff
    style VM fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style Assembler fill:#404040,stroke:#eee,stroke-width:1px,color:#fff

    Proto("<code>protocol NetworkFetching</code>")

    subgraph Dependencies
        Svc("<code>class NetworkService</code><br>Implements NetworkFetching") -- implements --> Proto
        MockSvc("<code>class MockNetworkFetcher</code><br>Implements NetworkFetching") -- implements --> Proto
    end

    subgraph Consumer
        VM("<code>class DataViewModel</code><br>Requires: 'NetworkFetching'") -- depends on --> Proto
        VM --> Init["<code>init(networkFetcher: NetworkFetching)</code>"]
    end

    subgraph Assembly
        Assembler("Assembler<br>(e.g., SceneDelegate, Coordinator)") -- creates --> Svc
        Assembler -- creates --> MockSvc
        Assembler -- creates & injects --> VM
        Svc --> Init
        MockSvc --> Init
    end

    linkStyle 0,1 stroke-width:2px,stroke:#aaa,stroke-dasharray: 5 5
    linkStyle 2 stroke-width:2px,stroke:#66f
    linkStyle 4 stroke-width:2px,stroke:#f66
    linkStyle 5 stroke-width:2px,stroke:#f66,stroke-dasharray: 5 5
    linkStyle 6 stroke-width:2px,stroke:#ddd
    linkStyle 7 stroke-width:2px,stroke:#ddd
    linkStyle 8 stroke-width:2px,stroke:#ddd
    
```

---


### b) Property Injection

Dependencies are provided by setting public `var` properties after the object has been initialized.

*   **Mechanism:** Dependencies are assigned to mutable properties (often optional or implicitly unwrapped optionals).
*   **Advantages:**
    *   Can break up dependency resolution over time (though often discouraged).
    *   Sometimes used to break initializer circular dependencies (an indicator of potential design issues).
*   **Disadvantages:**
    *   The object might be in an inconsistent state between initialization and dependency injection.
    *   Dependencies must be mutable (`var`) and often optional (`?` or `!`), hiding the requirement.
    *   Less common and generally less safe than initializer injection in Swift.
    *   Can make tracking down where a dependency is set more difficult.

---


```swift
class AnotherViewModel {
    // Dependency declared as an optional var
    var networkFetcher: NetworkFetching?

    // No dependency in init
    init() {}

    func loadData() {
        guard let fetcher = networkFetcher else {
            print("Error: NetworkFetcher not set!")
            return
        }
        let data = fetcher.fetchData()
        // ... process data ...
        print("Data loaded using \(type(of: fetcher))")
    }
}

// Usage: Injecting after initialization
let viewModel = AnotherViewModel()
// Potential issue: viewModel is usable here, but `loadData` would fail
viewModel.networkFetcher = NetworkService() // Injection via property
viewModel.loadData()

```


Link to GitHub repo implementation: [GitHub - CongLeSolutionX/MyApp at DESIGN\_PATTERNS\_Dependency\_Injections](https://github.com/CongLeSolutionX/MyApp/tree/DESIGN_PATTERNS_Dependency_Injections)


```mermaid
---
title: "Property Injection"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph LR
    style Svc fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    style Proto fill:#603060,stroke:#eee,stroke-width:1px,color:#fff
    style VM fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style Assembler fill:#404040,stroke:#eee,stroke-width:1px,color:#fff

    Proto("<code>protocol NetworkFetching</code>")
    Svc("<code>class NetworkService</code><br>Implements NetworkFetching") -- implements --> Proto

    subgraph Consumer
        VM("<code>class AnotherViewModel</code><br>Has: 'var networkFetcher: NetworkFetching?'") -- depends on --> Proto
        VM --> Init["<code>init()</code><br>(No dependency)"]
        VM --> PropSet["<code>viewModel.networkFetcher = ...</code><br>(Injection Point)"]
    end

    subgraph Assembly
        Assembler("Assembler") -- creates --> Svc
        Assembler -- creates --> VM
        Assembler -- later sets property --> PropSet
        Svc --> PropSet
    end

    linkStyle 0 stroke-width:2px,stroke:#aaa,stroke-dasharray: 5 5
    linkStyle 1 stroke-width:2px,stroke:#66f
    linkStyle 4 stroke-width:2px,stroke:#ddd
    linkStyle 5 stroke-width:2px,stroke:#ddd
    linkStyle 6 stroke-width:2px,stroke:#ddd,stroke-dasharray: 3 3
    linkStyle 7 stroke-width:2px,stroke:#aaa
    
```

---

### c) Method Injection

Dependencies are provided via parameters to specific methods that require them.

*   **Mechanism:** The dependency is passed only to the method(s) that need it, not stored as a property for the object's lifetime.
*   **Advantages:**
    *   Useful when only a single method needs the dependency.
    *   Clearly shows which methods rely on which dependencies.
*   **Disadvantages:**
    *   Can lead to methods with many parameters.
    *   Dependency needs to be passed repeatedly if multiple methods require it.
    *   Not suitable if the dependency is needed throughout the object's lifecycle or by multiple methods.


---

```swift
class ReportGenerator {
    func generateReport(data: Data, formatter: ReportFormatting) -> String {
        // Dependency 'formatter' injected directly into the method
        let formattedReport = formatter.format(data: data)
        print("Generating report using \(type(of: formatter))")
        return formattedReport
    }
}

// Protocol and implementations
protocol ReportFormatting { func format(data: Data) -> String }
class StandardFormatter: ReportFormatting { func format(data: Data) -> String { "Standard: \(data.count) bytes" } }
class FancyFormatter: ReportFormatting { func format(data: Data) -> String { "** Fancy: \(data.count) bytes **" } }

// Usage
let generator = ReportGenerator()
let reportData = Data("Report Content".utf8)

let standardFormatter = StandardFormatter()
let standardReport = generator.generateReport(data: reportData, formatter: standardFormatter) // Inject StandardFormatter

let fancyFormatter = FancyFormatter()
let fancyReport = generator.generateReport(data: reportData, formatter: fancyFormatter) // Inject FancyFormatter

```


Link to GitHub repo implementation: [GitHub - CongLeSolutionX/MyApp at DESIGN\_PATTERNS\_Dependency\_Injections](https://github.com/CongLeSolutionX/MyApp/tree/DESIGN_PATTERNS_Dependency_Injections)


```mermaid
---
title: "Method Injection"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph LR
    style Formatter fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    style Proto fill:#603060,stroke:#eee,stroke-width:1px,color:#fff
    style Gen fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style Caller fill:#404040,stroke:#eee,stroke-width:1px,color:#fff

    Proto("<code>protocol ReportFormatting</code>")
    Formatter1("<code>StandardFormatter</code>") -- implements --> Proto
    Formatter2("<code>FancyFormatter</code>") -- implements --> Proto

    subgraph Consumer
        Gen("<code>class ReportGenerator</code>") --> Method["<code>generateReport(data:,<br>formatter: ReportFormatting)</code>"]
        Method -- requires --> Proto
    end

    subgraph Assembly/Caller
        Caller("Caller Code") -- creates --> Formatter1
        Caller -- creates --> Formatter2
        Caller -- creates --> Gen
        Caller -- calls & injects --> Method
        Formatter1 --> Method
        Formatter2 --> Method
    end

    linkStyle 0 stroke-width:2px,stroke:#aaa,stroke-dasharray: 5 5
    linkStyle 1 stroke-width:2px,stroke:#aaa,stroke-dasharray: 5 5
    linkStyle 3 stroke-width:2px,stroke:#66f
    linkStyle 4 stroke-width:2px,stroke:#ddd
    linkStyle 5 stroke-width:2px,stroke:#ddd
    linkStyle 6 stroke-width:2px,stroke:#ddd
    linkStyle 7 stroke-width:2px,stroke:#ddd,stroke-dasharray: 3 3
    linkStyle 8 stroke-width:2px,stroke:#aaa
    linkStyle 9 stroke-width:2px,stroke:#aaa

```

----

## 4. Manual DI vs. DI Containers/Frameworks

You can implement DI in two main ways:

### a) Manual Dependency Injection ("Pure DI")

You manually create and connect ("wire") your objects and their dependencies. This is often done in a dedicated composition root – a single place in your application (like the `AppDelegate` or `SceneDelegate`, or a dedicated `AppCoordinator`) where the object graph is constructed.

*   **Pros:**
    *   No external library dependency.
    *   Full control over object creation and lifecycle.
    *   Easier to understand the flow initially for smaller projects.
*   **Cons:**
    *   Can become verbose and complex ("boilerplate") in large applications.
    *   Managing object lifecycles (singleton, transient) requires manual effort.
    *   Refactoring can be tedious if dependencies change frequently.

```mermaid
---
title: "Manual Dependency Injection ('Pure DI')"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph TD
    A["Composition Root<br>(e.g., SceneDelegate)"] --> B{"Creates 'NetworkService'"}
    A --> C{"Creates 'DatabaseService'"}
    B --> D{"Creates 'AuthRepository'<br>(Needs 'NetworkService')"}
    C --> E{"Creates 'UserRepository'<br>(Needs 'DatabaseService')"}
    D & E --> F{"Creates 'ProfileViewModel'<br>(Needs 'AuthRepository', 'UserRepository')"}
    F --> G["Creates 'ProfileViewController'<br>(Needs `ProfileViewModel')"]
    G --> H["Sets 'window.rootViewController'"]

    style A fill:#404040,stroke:#eee,stroke-width:2px,color:#fff
    style B fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    style C fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    style D fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style E fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style F fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style G fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style H fill:#603060,stroke:#eee,stroke-width:1px,color:#fff

    linkStyle default stroke-width:2px,stroke:#aaa
    
```

### b) DI Containers / Frameworks

These are third-party libraries that automate the process of dependency registration and resolution. You register your types and how they should be created (their dependencies, lifecycle), and then ask the container to provide instances when needed.

*   **Popular iOS DI Frameworks:** Swinject, Resolver, Needle, Dip.
*   **Pros:**
    *   Reduces boilerplate code for wiring dependencies.
    *   Manages object lifecycles (singleton, transient, weak, etc.).
    *   Often provides advanced features like auto-wiring, circular dependency detection (sometimes), and modular configuration.
*   **Cons:**
    *   Adds an external dependency to your project.
    *   Requires learning the framework's API and concepts ("magic").
    *   Can sometimes make debugging dependency resolution issues harder.
    *   Some frameworks use reflection or runtime tricks which might feel less "Swifty".

```mermaid
---
title: "DI Containers / Frameworks"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    'graph': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#B28',
      'primaryTextColor': '#F82',
      'primaryBorderColor': '#7C33',
      'secondaryColor': '#0615',
      'lineColor': '#F8B229'
    }
  }
}%%
graph TD
    subgraph Registration["Step 1:<br/>Registration Phase<br/>(Composition Root)"]
      A["Composition Root"] --> B("DI Container<br>'container.register(...)'")
      B -- "Register NetworkFetching as NetworkService<br/>(singleton)" --> C(("NetworkService"))
      B -- "Register DatabaseManaging as DatabaseService<br/>(singleton)" --> D((DatabaseService))
      B -- "Register AuthRepository<br/>(needs NetworkFetching)" --> E(("AuthRepository"))
      B -- "Register UserRepository<br/>(needs DatabaseManaging)" --> F(("UserRepository"))
      B -- "Register ProfileViewModel<br/>(needs Repositories)" --> G(("ProfileViewModel"))
      B -- "Register ProfileViewController<br/>(needs ViewModel)" --> H(("ProfileViewController"))
    end

    subgraph Resolution["Step 2:<br/>Resolution Phase<br/>(Later in App)"]
       J["Need Instance of<br/>ProfileViewController"] --> K{"Ask Container<br/>'container.resolve(ProfileViewController.self)'"}
       K -- "Container resolves dependencies recursively" --> L("Provides Initialized<br/>'ProfileViewController' Instance")
    end

    style A fill:#404040,stroke:#eee,stroke-width:2px,color:#fff
    style B fill:#AA6C39,stroke:#eee,stroke-width:2px,color:#fff
    
    classDef Elements fill:#005050,stroke:#eee,stroke-width:1px,color:#fff
    class C,D,E,F,G,H Elements
    
    style J fill:#202060,stroke:#eee,stroke-width:1px,color:#fff
    style K fill:#AA6C39,stroke:#eee,stroke-width:1px,color:#fff
    style L fill:#202060,stroke:#eee,stroke-width:2px,color:#fff

    linkStyle default stroke-width:1px,stroke:#aaa
    linkStyle 0,1,2,3,4,5,6,7,8 stroke-dasharray: 3 3
    %% linkStyle 9 stroke-width:2px,stroke:#ccc
    %% linkStyle 10 stroke-width:2px,stroke:#ccc
    
```

---

## 5. Potential Drawbacks of Dependency Injection

While powerful, DI is not without potential downsides:

*   **Increased Complexity:** Especially when using frameworks, understanding the setup and how dependencies are resolved can add initial complexity.
*   **Boilerplate (Manual DI):** Manually wiring large object graphs can be tedious.
*   **Debugging:** Tracing dependency resolution, especially with complex container setups or auto-wiring, can sometimes be challenging.
*   **Framework Overhead:** DI containers add a dependency and might introduce a small runtime overhead (usually negligible).

---

## 6. Conclusion: Embracing DI for Better iOS Apps

Dependency Injection is a cornerstone of modern iOS development, enabling the creation of applications that are modular, flexible, and, crucially, testable. By inverting the control of dependency creation, developers gain significant advantages in managing complexity and maintaining code quality over the long term.

Whether implemented manually for simpler projects or using sophisticated DI containers for larger applications, understanding and applying DI principles leads to more robust and adaptable iOS software. The preferred method in Swift is typically **Initializer Injection** due to its explicitness and support for immutability.

```mermaid
---
title: "Embracing DI for Better iOS Apps"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
mindmap
  root(("<b>Dependency Injection (DI) in iOS - Summary</b>"))
    <b>What?</b>
      Design Pattern / IoC
      Inject dependencies instead of self-creation
    <b>Why?</b>
      <b>Testability</b> (Mocking)
      <b>Modularity</b> (Loose Coupling)
      <b>Flexibility</b> (Swap Implementations)
      Maintainability
      Reusability
    <b>Types</b>
      Type_1["<b>Initializer Injection</b><br><i>(Preferred in Swift)</i><br>- Via 'init'<br>- Enforces completeness<br>- Supports 'let'"]
      Type_2["<b>Property Injection</b><br>- Via `var` property<br>- Often requires optionals<br>- Risk of inconsistent state"]
      Type_3["<b>Method Injection</b><br>- Via method parameter<br>- For specific method needs"]
    <b>Implementation</b>
      Implementation_method_1["<b>Manual DI</b><br>- Composition Root (AppDelegate, SceneDelegate, Coordinator)<br>- Pros: No library, Full control<br>- Cons: Boilerplate, Manual lifecycle mgmt"]
      Implementation_method_2["<b>DI Containers / Frameworks</b><br>- Swinject, Resolver, Needle, etc.<br>- Pros: Reduces boilerplate, Lifecycle mgmt, Advanced features<br>- Cons: Library dependency, Learning curve, 'Magic'"]
    <b>Drawbacks</b>
      Complexity (especially frameworks)
      Boilerplate (manual)
      Debugging challenges
    <b>Key Principle</b>
      Principle["Depend on Abstractions (Protocols), not Concretions"]
      
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
