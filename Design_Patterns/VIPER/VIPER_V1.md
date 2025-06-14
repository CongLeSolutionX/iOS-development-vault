---
created: 2024-12-11 06:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

# VIPER in Swift

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a **Mermaid** illustration that visualizes the **VIPER** architecture as discussed in the comprehensive guide. This class diagram showcases the relationships and interactions between the primary VIPER components: **View**, **Interactor**, **Presenter**, **Entity**, and **Router**.

```mermaid
---
title: VIPER in Swift
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% VIPER Components
    class View {
        <<interface>>
        +displayData(entities: [Entity])
        +showError(message: String)
    }

    class Presenter {
        <<interface>>
        +viewDidLoad()
        +userDidSelectItem(index: Int)
    }

    class Interactor {
        <<interface>>
        +fetchData()
    }

    class Entity {
        <<model>>
        +dataProperties
    }

    class Router {
        <<interface>>
        +navigateToDetail(entity: Entity)
    }

    %% Concrete Implementations
    class ArticleListViewController {
        +presenter: Presenter
        +displayData(entities: [Entity])
        +showError(message: String)
    }

    class ArticleListPresenter {
        +view: View
        +interactor: Interactor
        +router: Router
        +viewDidLoad()
        +userDidSelectItem(index: Int)
        +didFetchData(entities: [Entity])
        +didFailToFetchData(error: Error)
    }

    class ArticleListInteractor {
        +presenter: Presenter
        +fetchData()
    }

    class Article {
        +id: Int
        +title: String
        +content: String
        +author: String
    }

    class ArticleListRouter {
        +viewController: View
        +navigateToDetail(entity: Entity)
    }

    %% Relationships
    View <|.. ArticleListViewController
    Presenter <|.. ArticleListPresenter
    Interactor <|.. ArticleListInteractor
    Router <|.. ArticleListRouter
    Entity <|.. Article

    ArticleListPresenter --> "1" View : interacts with
    ArticleListPresenter --> "1" Interactor : interacts with
    ArticleListPresenter --> "1" Router : interacts with
    ArticleListInteractor --> "1" Presenter : communicates with
    ArticleListRouter --> "1" View : navigates from

```

### Explanation of the Diagram

- **Interfaces and Models**:
    - **View**, **Presenter**, **Interactor**, and **Router** are defined as interfaces, representing the contracts each VIPER component must adhere to.
    - **Entity** is marked as a model, representing the data structures used within the application (e.g., `Article`).
- **Concrete Implementations**:
    - **ArticleListViewController** implements the **View** interface, handling UI rendering and user interactions.
    - **ArticleListPresenter** implements the **Presenter** interface, orchestrating the flow between View, Interactor, and Router.
    - **ArticleListInteractor** implements the **Interactor** interface, managing business logic and data fetching.
    - **ArticleListRouter** implements the **Router** interface, handling navigation and module transitions.
    - **Article** is a concrete implementation of the **Entity**, representing the data model for articles.
- **Relationships**:
    - **Inheritance**: Concrete classes inherit from their respective interfaces.
    - **Interactions**:
        - **Presenter** interacts with **View**, **Interactor**, and **Router**.
        - **Interactor** communicates back to the **Presenter** with fetched data or errors.
        - **Router** uses the **View** (typically a `UIViewController`) to perform navigation.

### Additional Diagram Elements

- **Multiplicity**: Indicated by `"1"`, showing that each Presenter interacts with one View, one Interactor, and one Router.
- **Interfaces and Models**: Highlighted using stereotypes `<<interface>>` and `<<model>>` for clarity.

---

## Enhancing the Diagram

You can further enhance the diagram by adding more details, such as method signatures or additional components, depending on the complexity of your application. Here's an expanded version with more interactions:

```mermaid
---
title: VIPER in Swift - Enhanced version
config:
  layout: elk
  look: handDrawn
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#B2C3',
      'primaryTextColor': '#B92',
      'primaryBorderColor': '#7c2',
      'lineColor': '#F8B229'
    }
  }
}%%
classDiagram
    %% VIPER Components
    class View {
        <<interface>>
        +displayData(entities: [Entity])
        +showError(message: String)
    }

    class Presenter {
        <<interface>>
        +viewDidLoad()
        +userDidSelectItem(index: Int)
    }

    class Interactor {
        <<interface>>
        +fetchData()
    }

    class Entity {
        <<model>>
        +dataProperties
    }

    class Router {
        <<interface>>
        +navigateToDetail(entity: Entity)
    }

    %% Concrete Implementations
    class ArticleListViewController {
        +presenter: Presenter
        +displayData(entities: [Entity])
        +showError(message: String)
    }

    class ArticleListPresenter {
        +view: View
        +interactor: Interactor
        +router: Router
        +viewDidLoad()
        +userDidSelectItem(index: Int)
        +didFetchData(entities: [Entity])
        +didFailToFetchData(error: Error)
    }

    class ArticleListInteractor {
        +presenter: Presenter
        +fetchData()
    }

    class Article {
        +id: Int
        +title: String
        +content: String
        +author: String
    }

    class ArticleListRouter {
        +viewController: View
        +navigateToDetail(entity: Entity)
    }

    %% Relationships
    View <|.. ArticleListViewController
    Presenter <|.. ArticleListPresenter
    Interactor <|.. ArticleListInteractor
    Router <|.. ArticleListRouter
    Entity <|.. Article

    ArticleListPresenter --> "1" View : interacts with
    ArticleListPresenter --> "1" Interactor : interacts with
    ArticleListPresenter --> "1" Router : interacts with
    ArticleListInteractor --> "1" Presenter : communicates with
    ArticleListRouter --> "1" View : navigates from

```

### Using the Diagram

- **Development Reference**: Use this diagram as a blueprint when structuring your VIPER modules, ensuring each component adheres to its specific role.
- **Team Communication**: Share the diagram with your development team to maintain a common understanding of the architecture, facilitating better collaboration.
- **Documentation**: Include the diagram in your project documentation to provide a visual overview of the VIPER implementation.


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
