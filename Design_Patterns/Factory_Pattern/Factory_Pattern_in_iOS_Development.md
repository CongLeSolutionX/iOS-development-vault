---
created: 2025-04-28 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# The Factory Pattern in iOS Development
> **Disclaimer:**
>
> This document contains my personal notes on the topic,
> compiled from publicly available documentation and various cited sources.
> The materials are intended for educational purposes, personal study, and reference.
> The content is dual-licensed:
> 1. **MIT License:** Applies to all code implementations (Swift, Mermaid, and other programming languages).
> 2. **Creative Commons Attribution 4.0 International License (CC BY 4.0):** Applies to all non-code content, including text, explanations, diagrams, and illustrations.
---



## 1. Introduction: Decoupling Object Creation

The **Factory Pattern** is a fundamental **creational design pattern** used extensively in software development, including iOS app development with Swift. Its primary goal is to **decouple the process of object creation** from the client code that uses those objects. Instead of creating objects directly using their initializers (`ClassName()`), the client asks a "factory" object to create instances on its behalf. This delegation provides flexibility, enhances maintainability, and promotes adherence to principles like the Single Responsibility Principle (SRP) and the Open/Closed Principle (OCP).

This explanation explores the common variations of the Factory Pattern (Simple Factory, Factory Method, Abstract Factory), their implementation in Swift, benefits, drawbacks, and typical use cases within the iOS ecosystem.

```mermaid
---
title: "Introduction: Decoupling Object Creation"
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
  root(("Factory Pattern<br/>[iOS]"))
    Core Idea
      ::icon(fa fa-cogs)
      Decouple Object Creation
      ::icon(fa fa-puzzle-piece)
      Client uses Factory, not direct initialization
    Type
      ::icon(fa fa-box-open)
      Creational Design Pattern
    Benefits
      ::icon(fa fa-thumbs-up)
      Flexibility
      Maintainability
      Testability
      Adherence_to_SOLID["Adherence to SOLID<br/>(SRP, OCP)"]
    Variations
      Simple Factory
      Factory Method Pattern
      Abstract Factory Pattern
```

---

## 2. Logical Sections & Breakdown

This document is structured as follows:

1.  **Introduction:** Core concept and initial mind map.
2.  **The "Simple Factory"**: A common starting point, though not a formal GoF pattern.
3.  **Factory Method Pattern**: Deferring instantiation to subclasses/conformers.
4.  **Abstract Factory Pattern**: Creating families of related objects.
5.  **Benefits and Drawbacks**: Weighing the pros and cons.
6.  **Use Cases in iOS Development**: Practical examples within the Apple ecosystem.
7.  **Conclusion & Summary Mind Map**: Synthesizing the key takeaways.

----

## 3. The "Simple Factory"

Often encountered, the **Simple Factory** isn't one of the original Gang of Four (GoF) design patterns but serves as a common, simpler approach or stepping stone. It typically involves a single class with a method (the "factory method") that returns instances of different object types based on input parameters (e.g., an enum, string, or other data).

The client interacts directly with this factory class to get the product it needs, without knowing the specific concrete class being instantiated.

```mermaid
---
title: "The 'Simple Factory'"
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
    'graph': { 'htmlLabels': false, 'curve': 'basis' },
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
    subgraph Simple_Factory_Structure["Simple Factory Structure"]
        Client -- "Requests Product" --> Factory("SimpleFactory")
        Factory -- "Creates & Returns" --> ProductA[("Product A")]
        Factory -- "Creates & Returns" --> ProductB[("Product B")]
        ProductA -- "Conforms to" --> IProduct{"Product Protocol/BaseClass"}
        ProductB -- "Conforms to" --> IProduct
    end
    style Factory fill:#28a745,stroke:#ffffff,stroke-width:2px,color:#ffffff
    style Client fill:#007bff,stroke:#ffffff,stroke-width:2px,color:#ffffff
```

**Swift Implementation Example:**

Imagine creating different types of UI alert views based on context:

```swift
// Product Protocol
protocol AlertView {
    func show(title: String, message: String)
}

// Concrete Products
struct SuccessAlert: AlertView {
    func show(title: String, message: String) {
        print("✅ SUCCESS: \(title) - \(message)")
        // In reality, present a styled success alert
    }
}

struct ErrorAlert: AlertView {
    func show(title: String, message: String) {
        print("❌ ERROR: \(title) - \(message)")
        // In reality, present a styled error alert
    }
}

// Alert Type Enum
enum AlertType {
    case success
    case error
}

// Simple Factory
struct AlertFactory {
    static func createAlert(type: AlertType) -> AlertView {
        switch type {
        case .success:
            return SuccessAlert()
        case .error:
            return ErrorAlert()
        }
    }
}

// Client Code
let success = AlertFactory.createAlert(type: .success)
success.show(title: "Operation Complete", message: "Data saved successfully.")

let error = AlertFactory.createAlert(type: .error)
error.show(title: "Operation Failed", message: "Network connection lost.")
```

**Key Idea:** The `AlertFactory` centralizes the creation logic. The client only needs to know about the `AlertFactory` and the `AlertView` protocol, not the specific `SuccessAlert` or `ErrorAlert` structs.

---

## 4. Factory Method Pattern

The **Factory Method Pattern** defines an interface (protocol or base class) for creating an object but lets subclasses (or conforming types) decide which class to instantiate. It involves a "Creator" type defining a `factoryMethod` and "Concrete Creators" implementing this method to produce specific "Products".

This pattern is particularly useful when a class cannot anticipate the class of objects it must create or when a class wants its subclasses to specify the objects it creates.

```mermaid
---
title: "Factory Method Pattern"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'classDiagram': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#BB28',
      'primaryTextColor': '#000',
      'textColor': '#000',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#7C3',
      'secondaryColor': '#DD15'
    }
  }
}%%
classDiagram
    direction LR
    class Creator {
        <<protocol>>
        +factoryMethod() Product
        +someOperation()
    }
    class ConcreteCreatorA {
        +factoryMethod() ConcreteProductA
    }
    class ConcreteCreatorB {
        +factoryMethod() ConcreteProductB
    }
    class Product {
        <<protocol>>
        +operation()
    }
    class ConcreteProductA {
        +operation()
    }
    class ConcreteProductB {
        +operation()
    }

    Creator <|.. ConcreteCreatorA : Implements
    Creator <|.. ConcreteCreatorB : Implements
    Product <|.. ConcreteProductA : Implements
    Product <|.. ConcreteProductB : Implements
    Creator ..> Product : Creates
    ConcreteCreatorA ..> ConcreteProductA : Creates
    ConcreteCreatorB ..> ConcreteProductB : Creates

    note for Creator "Defines the factory method"
    note for ConcreteCreatorA "Implements the factory method"
    note for Product "Defines the product interface"
    Client --> Creator : Uses
    Client ..> Product : Uses Result
```

**Swift Implementation Example:**

Let's model creating different types of data loggers.

```swift
// Product Protocol
protocol Logger {
    func log(message: String)
}

// Concrete Products
struct ConsoleLogger: Logger {
    func log(message: String) {
        print("[Console] \(message)")
    }
}

struct FileLogger: Logger {
    let filePath: String
    func log(message: String) {
        // In reality, append message to file at filePath
        print("[File:\(filePath)] \(message)")
    }
}

// Creator Protocol (with the factory method)
protocol LoggerFactory {
    // The Factory Method
    func createLogger() -> Logger

    // Other operations that might use the logger
    func logProcess(action: String)
}

// Default implementation using the created logger
extension LoggerFactory {
     func logProcess(action: String) {
        let logger = createLogger() // Use the factory method
        logger.log(message: "Performing action: \(action)")
    }
}

// Concrete Creators
struct ConsoleLoggerFactory: LoggerFactory {
    func createLogger() -> Logger {
        return ConsoleLogger() // Creates ConsoleLogger
    }
}

struct FileLoggerFactory: LoggerFactory {
    let logFilePath: String
    init(logFilePath: String = "app.log") {
        self.logFilePath = logFilePath
    }

    func createLogger() -> Logger {
        return FileLogger(filePath: logFilePath) // Creates FileLogger
    }
}

// Client Code
let consoleCreator: LoggerFactory = ConsoleLoggerFactory()
consoleCreator.logProcess(action: "User Login") // Uses ConsoleLogger

let fileCreator: LoggerFactory = FileLoggerFactory(logFilePath: "debug.log")
fileCreator.logProcess(action: "Data Sync") // Uses FileLogger
```

**Key Idea:** The `LoggerFactory` protocol defines the *contract* for creating a logger, but the concrete types (`ConsoleLoggerFactory`, `FileLoggerFactory`) decide *which* specific logger to instantiate. The client interacts with the `LoggerFactory` protocol.

---

## 5. Abstract Factory Pattern

The **Abstract Factory Pattern** provides an interface for creating **families of related or dependent objects** without specifying their concrete classes. It deals with creating *sets* of objects that are designed to work together.

This pattern involves:
*   `AbstractFactory`: Protocol defining methods for creating each type of related product.
*   `ConcreteFactory`: Classes implementing the `AbstractFactory` protocol to produce a specific family of products.
*   `AbstractProduct`: Protocols defining the interface for each type of product in the family.
*   `ConcreteProduct`: Classes implementing the `AbstractProduct` protocols.

```mermaid
---
title: "Abstract Factory Pattern"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'classDiagram': { 'htmlLabels': false},
    'fontFamily': 'Monospace',
    'themeVariables': {
      'primaryColor': '#BB28',
      'primaryTextColor': '#000',
      'textColor': '#000',
      'lineColor': '#F8B229',
      'primaryBorderColor': '#7C3',
      'secondaryColor': '#DD15'
    }
  }
}%%
classDiagram
    direction TB

    class AbstractFactory {
        <<protocol>>
        +createProductA() AbstractProductA
        +createProductB() AbstractProductB
    }
    class ConcreteFactory1 {
        +createProductA() ConcreteProductA1
        +createProductB() ConcreteProductB1
    }
    class ConcreteFactory2 {
        +createProductA() ConcreteProductA2
        +createProductB() ConcreteProductB2
    }

    class AbstractProductA {
        <<protocol>>
        +operationA()
    }
    class ConcreteProductA1 {
        +operationA()
    }
    class ConcreteProductA2 {
        +operationA()
    }

    class AbstractProductB {
        <<protocol>>
        +operationB()
    }
    class ConcreteProductB1 {
        +operationB()
    }
    class ConcreteProductB2 {
        +operationB()
    }

    AbstractFactory <|.. ConcreteFactory1 : Implements
    AbstractFactory <|.. ConcreteFactory2 : Implements

    AbstractProductA <|.. ConcreteProductA1 : Implements
    AbstractProductA <|.. ConcreteProductA2 : Implements
    AbstractProductB <|.. ConcreteProductB1 : Implements
    AbstractProductB <|.. ConcreteProductB2 : Implements

    ConcreteFactory1 ..> ConcreteProductA1 : Creates
    ConcreteFactory1 ..> ConcreteProductB1 : Creates
    ConcreteFactory2 ..> ConcreteProductA2 : Creates
    ConcreteFactory2 ..> ConcreteProductB2 : Creates

    Client --> AbstractFactory : Uses Factory
    Client ..> AbstractProductA : Uses Product A
    Client ..> AbstractProductB : Uses Product B
    
```


**Swift Implementation Example:**

Creating UI elements for different themes (e.g., Light vs. Dark).

```swift
// Abstract Product Protocols
protocol Button {
    var color: String { get }
    func render()
}

protocol Label {
    var textColor: String { get }
    func display(text: String)
}

// Concrete Products - Light Theme
struct LightButton: Button {
    let color = "LightGray"
    func render() { print("Rendering Button with color: \(color)") }
}

struct LightLabel: Label {
    let textColor = "Black"
    func display(text: String) { print("Displaying Label with text '\(text)' in color: \(textColor)") }
}

// Concrete Products - Dark Theme
struct DarkButton: Button {
    let color = "DarkGray"
    func render() { print("Rendering Button with color: \(color)") }
}

struct DarkLabel: Label {
    let textColor = "White"
    func display(text: String) { print("Displaying Label with text '\(text)' in color: \(textColor)") }
}

// Abstract Factory Protocol
protocol UIFactory {
    func createButton() -> Button
    func createLabel() -> Label
}

// Concrete Factories
struct LightThemeFactory: UIFactory {
    func createButton() -> Button { return LightButton() }
    func createLabel() -> Label { return LightLabel() }
}

struct DarkThemeFactory: UIFactory {
    func createButton() -> Button { return DarkButton() }
    func createLabel() -> Label { return DarkLabel() }
}

// Client Code - Represents a View or ViewController
struct SettingsScreen {
    let factory: UIFactory // Injected factory

    func displayUI() {
        let saveButton = factory.createButton()
        let titleLabel = factory.createLabel()

        titleLabel.display(text: "User Preferences")
        saveButton.render()
    }
}

// Usage
print("--- Using Light Theme ---")
let lightFactory = LightThemeFactory()
let lightSettings = SettingsScreen(factory: lightFactory)
lightSettings.displayUI()

print("\n--- Using Dark Theme ---")
let darkFactory = DarkThemeFactory()
let darkSettings = SettingsScreen(factory: darkFactory)
darkSettings.displayUI()
```

**Key Idea:** The `UIFactory` protocol defines how to create a *set* of UI elements (Button, Label). Concrete factories (`LightThemeFactory`, `DarkThemeFactory`) provide consistent families of these elements. The `SettingsScreen` uses the abstract `UIFactory` and doesn't need to know if it's dealing with light or dark components specifically.

----

## 6. Benefits and Drawbacks

Using Factory patterns brings several advantages but also introduces some trade-offs.

```mermaid
---
title: "Benefits and Drawbacks"
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
    'graph': { 'htmlLabels': false, 'curve': 'basis' },
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
    subgraph Benefits["Benefits 👍"]
    direction LR
        B1["Decoupling"] --> B1_Desc("Client code isolated from concrete product creation")
        B2["Flexibility & Extensibility"] --> B2_Desc("Easy to add new product types without modifying client code <br/><b>(Open/Closed Principle)</b>")
        B3["Single Responsibility"] --> B3_Desc("Creation logic centralized in factories <br/><b>(Single Responsibility Principle)</b>")
        B4["Consistency<br/>(Abstract Factory)"] --> B4_Desc("Ensures products within a family work together")
        B5["Testability"] --> B5_Desc("Easier to mock factories or inject test doubles")
    end

    subgraph Drawbacks["Drawbacks 👎"]
    direction LR
        D1["Increased Complexity"] --> D1_Desc("Introduces more protocols/classes/structs")
        D2["Subclassing/Conformance Burden"] --> D2_Desc("Factory Method may require parallel hierarchies;<br/>Abstract Factory requires implementing all creation methods")
        D3["Abstraction Overhead"] --> D3_Desc("Can sometimes feel like over-engineering for simple cases")
    end

    style Benefits fill:#28a745,stroke:#fff,stroke-width:1px,color:#fff
    style Drawbacks fill:#dc3545,stroke:#fff,stroke-width:1px,color:#fff
    
```


----

## 7. Use Cases in iOS Development

The Factory pattern and its variations appear frequently in iOS development, sometimes explicitly and sometimes implicitly:

1.  **Dependency Injection:** Factories are commonly used to create and provide dependencies (like services, managers, view models) to other objects, often managed by a Dependency Injection container. Abstract Factory can configure dependencies for different environments (dev, staging, prod).
2.  **Creating View Controllers:** A factory can instantiate different `UIViewController` subclasses based on navigation actions or data, hiding the specific initialization logic (e.g., `Storyboard.instantiateViewController`).
3.  **Configurable Components:** Creating complex UI components (like charts, custom views) with different configurations or data sources. A factory can handle the setup logic.
4.  **Cross-Platform Abstraction (Less common in pure iOS):** If sharing logic with other platforms, an Abstract Factory could create platform-specific implementations (e.g., network clients, storage adapters).
5.  **Data Source/Delegate Creation:** Factories can create specific data source or delegate objects based on the context (e.g., different `UITableViewDataSource` implementations for different table view sections).
6.  **Mocking for Tests:** Replacing production factories with mock factories that return test doubles (stubs, mocks) during unit or integration testing.
7.  **Theme Management:** As shown in the Abstract Factory example, managing different visual themes (light/dark, different brandings).
8.  **Network Request Building:** Creating different types of `URLRequest` objects based on endpoint definitions or parameters.

```mermaid
---
title: "Use Cases in iOS Development"
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
    'graph': { 'htmlLabels': false, 'curve': 'basis' },
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
    subgraph iOS_Use_Cases["Factory Pattern in iOS"]
        direction LR
        UC1["Dependency Injection<br/>(Create Services)"] --> F1{"Factory/DI Container"}
        UC2["ViewController Creation<br/>(Instantiate VCs)"] --> F2{"VC Factory"}
        UC3["Configurable UI<br/>(Build Charts, Views)"] --> F3{"Component Factory"}
        UC4["Data Source/Delegates<br/>(Provide Helpers)"] --> F4{"DataSource Factory"}
        UC5["Mocking for Tests<br/>(Return Test Doubles)"] --> F5{"Mock Factory"}
        UC6["Theme Management<br/>(Light/Dark UI)"] --> F6("Abstract UI Factory")
        UC7["Network Requests<br/>(Build URLRequest)"] --> F7{"Request Factory"}
    end

    style UC1 fill:#17a2b8,color:#fff
    style UC2 fill:#17a2b8,color:#fff
    style UC3 fill:#17a2b8,color:#fff
    style UC4 fill:#17a2b8,color:#fff
    style UC5 fill:#ffc107,color:#333
    style UC6 fill:#6f42c1,color:#fff
    style UC7 fill:#fd7e14,color:#fff
    
```


---

## 8. Conclusion & Summary Mind Map

The Factory patterns (Simple Factory, Factory Method, Abstract Factory) are powerful tools in an iOS developer's arsenal for managing object creation. They promote loose coupling, enhance flexibility, and improve the testability and maintainability of codebases by abstracting away the specifics of how objects are instantiated. While they introduce some complexity, the benefits often outweigh the drawbacks, especially in larger or evolving applications. Choosing the right factory variation depends on the specific problem: use Simple Factory for basic centralized creation, Factory Method for deferring instantiation to subtypes, and Abstract Factory for creating families of related objects.

```mermaid
---
title: "Summary Mind Map"
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
  root(("Factory Pattern<br/>[iOS Summary]"))
    Definition
      Creational Pattern
      Decouples object creation logic from client
    Variations
      Simple Factory
        Centralized creation method
        Not a formal GoF pattern
      Factory Method
        Define_interface["Define interface ('Creator'), let subtypes ('ConcreteCreator') decide class to instantiate ('Product')"]
        Uses inheritance/protocol conformance
      Abstract Factory
        Interface["Interface ('AbstractFactory') for creating *families* of related objects ('AbstractProduct')"]
        ConcreteFactory_produces_specific_family["'ConcreteFactory' produces specific family ('ConcreteProduct')"]
    Key Roles
      Factory / Creator
      Product
      Client
    Benefits["Benefits (+)"]
      Flexibility_Extensibility["Flexibility / Extensibility<br/>(OCP)"]
      Decoupling
      Maintainability["Maintainability<br/>(SRP)"]
      Testability["Testability<br/>(Mocking)"]
      Consistency["Consistency<br/>(Abstract Factory)"]
    Drawbacks["Drawbacks (-)"]
      Increased_Complexity["Increased Complexity<br/>(more types)"]
      Potential for large hierarchies
      Overhead for simple cases
    iOS Use Cases
      Dependency Injection
      ViewController Creation
      Configurable UI Components
      Data Source/Delegate Creation
      Mocking for Testing
      Theme Management
      Network Request Building
    Core_Principle["Core Principle:<br/>Client depends on abstractions (protocols), not concrete implementations"]
      ::icon(fa fa-lightbulb)
      
```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---