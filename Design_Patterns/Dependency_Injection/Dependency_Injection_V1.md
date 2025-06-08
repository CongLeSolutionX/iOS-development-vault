---
created: 2024-12-11 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


# Dependency Injection

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a Mermaid **Class Diagram** that visually represents the **Dependency Injection (DI) architecture**. This diagram illustrates how different components interact through DI, highlighting protocols, concrete implementations, view controllers, and how dependencies are injected. Additionally, it includes mock services for testing purposes.

```mermaid
---
title: Dependency Injection
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
      'lineColor': '#F8B229',
      'primaryBorderColor': '#7C3',
      'secondaryColor': '#DD15'
    }
  }
}%%
classDiagram
    %% Protocol Definition
    class NetworkServiceProtocol {
        <<interface>>
        +fetchData(completion: @escaping (Data?) -> Void)
    }

    %% Concrete Implementation
    class NetworkService {
        +fetchData(completion: @escaping (Data?) -> Void)
    }
    NetworkService --|> NetworkServiceProtocol

    %% Mock Service for Testing
    class MockNetworkService {
        +fetchData(completion: @escaping (Data?) -> Void)
    }
    MockNetworkService --|> NetworkServiceProtocol

    %% View Controller
    class DataViewController {
        -networkService: NetworkServiceProtocol
        +init(networkService: NetworkServiceProtocol)
        +viewDidLoad()
    }

    %% View Model Example
    class UserViewModel {
        -userService: UserServiceProtocol
        +init(userService: UserServiceProtocol)
        +getUser(completion: @escaping (User?) -> Void)
    }

    class UserServiceProtocol {
        <<interface>>
        +fetchUser(completion: @escaping (User?) -> Void)
    }

    class UserService {
        +fetchUser(completion: @escaping (User?) -> Void)
    }
    UserService --|> UserServiceProtocol

    %% DataViewController Dependencies
    DataViewController --> NetworkServiceProtocol : depends on
    DataViewController --> DataViewModel : uses

    %% UserViewModel Dependencies
    UserViewModel --> UserServiceProtocol : depends on

    %% Dependency Injection Container (e.g., Swinject)
    class DIContainer {
        +registerServices()
        +resolve<T>(_ type: T.Type) -> T
    }

    DIContainer --> NetworkServiceProtocol : registers
    DIContainer --> UserServiceProtocol : registers
    DIContainer --> DataViewController : resolves
    DIContainer --> UserViewModel : resolves

    %% Relationships
    DataViewController ..> DIContainer : retrieves dependencies from
    UserViewModel ..> DIContainer : retrieves dependencies from

```

### Explanation of the Diagram

1. **Protocols and Implementations:**
    - `NetworkServiceProtocol` and `UserServiceProtocol` are protocols that define the required methods for networking and user services, respectively.
    - `NetworkService` and `UserService` are concrete classes that conform to their respective protocols, providing actual implementations.
2. **Mock Services:**
    - `MockNetworkService` is a mock implementation of `NetworkServiceProtocol` used for testing purposes. It allows `DataViewController` to be tested without relying on real network calls.
3. **View Controllers and View Models:**
    - `DataViewController` depends on `NetworkServiceProtocol` to fetch data. Instead of instantiating `NetworkService` directly, it receives a `NetworkServiceProtocol` instance through its initializer, adhering to the DI principle.
    - `UserViewModel` depends on `UserServiceProtocol`, allowing it to fetch user data without being tightly coupled to a specific service implementation.
4. **Dependency Injection Container:**
    - `DIContainer` represents a DI container (e.g., **Swinject**, **Resolver**) responsible for registering and resolving dependencies. It handles the creation and injection of dependencies like `NetworkServiceProtocol`, `UserServiceProtocol`, `DataViewController`, and `UserViewModel`.
5. **Dependency Relationships:**
    - `DataViewController` and `UserViewModel` retrieve their dependencies from `DIContainer`, ensuring that they are provided with the appropriate service implementations.
    - This setup promotes loose coupling, making the components more modular, testable, and maintainable.

### Additional Notes

- **Constructor Injection:** Both `DataViewController` and `UserViewModel` receive their dependencies via their initializers, which is the preferred method of dependency injection as it ensures that dependencies are provided at the time of object creation.
- **Testing Advantages:** By depending on protocols rather than concrete implementations, it's easy to substitute real services with mock services during testing, enhancing the testability of your components.
- **Flexibility and Maintainability:** If you need to change the implementation of a service (e.g., switch from `NetworkService` to another networking library), you can do so without modifying the classes that depend on the service, provided they rely on the protocol.


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
