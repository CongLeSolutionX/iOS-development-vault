---
created: 2024-11-05 05:01:39
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

# Connecting Design Patterns in iOS Development - Style 1

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


```mermaid
---
title: Connecting Design Patterns in iOS Development - Style 1
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Identify the core problem] --> B{Is the problem related to}
    B -- Creating objects --> C[Creational]
    B -- Assembling objects --> D[Structural]
    B -- Object interactions/responsibilities --> E[Behavioral]

    subgraph " "
        C --> F["Need single instance<br>Singleton"]
        C --> G["Decouple object creation from usage<br>Factory Method"]
        C --> H["Create families of related objects<br>Abstract Factory"]
        C --> I["Create duplicate objects<br>Prototype"]
        C --> J["Construct complex objects step by step<br>Builder"]

        F -.-> K["Single instance"]
        G -.-> L["Implement using"]
        G -.-> M["Configure factory<br>dynamically"]
        H -.-> K
        J -.-> N["Single instance"]


        D --> O["Simplify complex subsystems<br>Facade"]
        D --> P["Make incompatible interfaces compatible<br>Adapter"]
        D --> Q["Represent part-whole hierarchies<br>Composite"]
        D --> R["Control access to objects<br>Proxy"]
        D --> S["Dynamically add/remove behavior<br>Decorator"]
        D --> T["Decouple abstraction from implementation<br>Bridge"]

        O -.-> U["Creating composites"]
        P -.-> U
        Q -.-> V["Add responsibility<br>to objects"]
        S -.-> V
        S -.-> W["Often uses"]
        T -.-> X["Chaining skin versus guts"]


        E --> Y["Define a family of algorithms<br>Strategy"]
        E --> Z["Define algorithm skeleton, defer steps to subclasses.<br>Template Method"]
        E --> AA["Encapsulate requests as objects<br>Command"]
        E --> AB["Separate operations from objects they operate on<br>Visitor"]
        E --> AC["Encapsulate state-specific behavior<br>State"]
        E --> AD["Maintain a consistent state by being notified of changes<br>Observer"]
        E --> AE["Traverse collections without exposing internals<br>Iterator"]

        Y -.-> AF["Define algorithm<br> steps"]
        Z -.-> AF
        
        X --> AI["Composed using"]
    end
    
    style F fill:#CC19FF,stroke:#5E35B1
    style G fill:#CC19FF,stroke:#5E35B1
    style H fill:#CC19FF,stroke:#5E35B1
    style I fill:#CC19FF,stroke:#5E35B1
    style J fill:#CC19FF,stroke:#5E35B1
    style O fill:#E11511,stroke:#F57C00
    style P fill:#E11511,stroke:#F57C00
    style Q fill:#E11511,stroke:#F57C00
    style R fill:#E11511,stroke:#F57C00
    style S fill:#E11511,stroke:#F57C00
    style T fill:#E11511,stroke:#F57C00

    style Y fill:#111DFD,stroke:#1B5E20
    style Z fill:#111DFD,stroke:#1B5E20
    style AA fill:#111DFD,stroke:#1B5E20
    style AB fill:#111DFD,stroke:#1B5E20
    style AC fill:#111DFD,stroke:#1B5E20
    style AD fill:#111DFD,stroke:#1B5E20
    style AE fill:#111DFD,stroke:#1B5E20


    linkStyle 0,1,2 stroke:#5E35B1,stroke-width:1px
    linkStyle 3,4,5 stroke:#F57C00,stroke-width:1px
    linkStyle 6,7 stroke:#1B5E20,stroke-width:1px


    style B fill:#EC407A,stroke:#AD1457
    style C fill:#5E35B1,stroke:#5E35B1
    style D fill:#F57C00,stroke:#F57C00
    style E fill:#1B5E20,stroke:#1B5E20

```

---

# Connecting Design Patterns in iOS Development - Style 2

```mermaid
---
title: Connecting Design Patterns in iOS Development - Style 2
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Identify the core problem] --> B{Is the problem related to};
    B -- Creating objects --> C[Creational];
    B -- Assembling objects --> D[Structural];
    B -- Object interactions/responsibilities --> E[Behavioral];

    subgraph "Creational Patterns"
        C --> Singleton["Singleton <br> Need single instance"];
        C --> FactoryMethod["Factory Method <br> Decouple object creation from usage"];
        C --> AbstractFactory["Abstract Factory <br> Create families of related objects"];
        C --> Prototype["Prototype <br> Create duplicate objects"];
        C --> Builder["Builder <br> Construct complex objects step by step"];
    end

    Singleton <--> FactoryMethod -.-> SingleInstance["Single instance"];
    AbstractFactory -.-> ImplementUsing["Implement <br> using"];
    AbstractFactory <--> Builder -.-> ConfigureFactoryDynamically["Configure factory <br> dynamically"];
    Prototype --> SingleInstance1["Single instance"];


    subgraph "Structural Patterns"
        D --> Facade["Facade <br> Simplify complex subsystems"];
        D --> Adapter["Adapter <br> Make incompatible interfaces compatible"];
        D --> Composite["Composite <br> Represent part-whole hierarchies"];
        D --> Proxy["Proxy <br> Control access to objects"];
        D --> Decorator["Decorator <br> Dynamically add/remove behavior"];
        D --> Bridge["Bridge <br> Decouple abstraction from implementation"];
    end

    Facade <--> Adapter -.-> CreatingComposites["Creating composites"];
    Composite -.-> AddResponsibilityToObjects["Add responsibility <br> to objects"];
    Decorator <--> Bridge -.-> OftenUses["Often uses"];
    Decorator --> ComposedUsing["Composed using"];
    Adapter --> ChainingSkinVersusGuts["Chaining skin versus guts"];



    subgraph "Behavioral Patterns"
        E --> Strategy["Strategy <br> Define a family of algorithms"];
        E --> TemplateMethod["Template Method <br> Define algorithm skeleton, <br> defer steps to subclasses."];
        E --> Command["Command <br> Encapsulate requests as objects"];
        E --> Visitor["Visitor <br> Separate operations from <br> objects they operate on"];
        E --> State["State <br> Encapsulate state-specific behavior"];
        E --> Observer["Observer <br> Maintain a consistent state by <br> being notified of changes"];
        E --> Iterator["Iterator <br> Traverse collections without <br> exposing internals"];
    end

    Strategy <--> TemplateMethod -.-> DefineAlgorithmSteps["Define algorithm <br> steps"];

```

---


# Connecting Design Patterns in iOS Development - Style 3

 
```mermaid
---
title: Connecting Design Patterns in iOS Development - Style 3
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Identify the core<br>problem] --> B{Is the<br>problem<br>related to};
    B -- Creating objects --> C(Creational);
    B -- Assembling objects --> D(Structural);
    B -- Object interactions/<br>responsibilities --> E(Behavioral);

    subgraph " "
        direction LR
        C --> CR1[Need single instance] --> S(Singleton);
        C --> CR2[Decouple object creation from usage] --> FM(Factory Method);
        C --> CR3[Create families of related objects] --> AF(Abstract Factory);
        C --> CR4[Create duplicate objects] --> P(Prototype);
        C --> CR5[Construct complex objects step by step] --> BLD(Builder);
    end

    subgraph " "
        direction LR
        D --> ST1[Simplify complex subsystems] --> F(Facade);
        D --> ST2[Make incompatible interfaces compatible] --> AD(Adapter);
        D --> ST3[Represent part-whole hierarchies] --> CP(Composite);
        D --> ST4[Control access to objects] --> PR(Proxy);
        D --> ST5[Dynamically add/remove behavior] --> DC(Decorator);
        D --> ST6[Decouple abstraction from implementation] --> BR(Bridge);
    end
    
    subgraph " "
        direction LR
        E --> BH1[Define a family of algorithms] --> STG(Strategy)
        E --> BH2[Define algorithm skeleton,<br> defer steps to subclasses.] --> TM(Template Method)
        E --> BH3[Encapsulate requests as objects] --> CMD(Command)
        E --> BH4[Separate operations from<br>objects they operate on] --> V(Visitor)
        E --> BH5[Encapsulate state-specific behavior] --> STE(State)
        E --> BH6[Maintain a consistent state by<br>being notified of changes] --> O(Observer)
        E --> BH7[Traverse collections without<br>exposing internals] --> I(Iterator)
    end

    style CR1 fill:#1f1111,stroke:#fed7aa
    style CR2 fill:#1f1111,stroke:#fed7aa
    style CR3 fill:#1f1111,stroke:#fed7aa
    style CR4 fill:#1f1111,stroke:#fed7aa
    style CR5 fill:#1f1111,stroke:#fed7aa

    style ST1 fill:#1f1111,stroke:#fed7aa
    style ST2 fill:#1f1111,stroke:#fed7aa
    style ST3 fill:#1f1111,stroke:#fed7aa
    style ST4 fill:#1f1111,stroke:#fed7aa
    style ST5 fill:#1f1111,stroke:#fed7aa
    style ST6 fill:#1f1111,stroke:#fed7aa

    style BH1 fill:#121f91,stroke:#82b366
    style BH2 fill:#121f91,stroke:#82b366
    style BH3 fill:#121f91,stroke:#82b366
    style BH4 fill:#121f91,stroke:#82b366
    style BH5 fill:#121f91,stroke:#82b366
    style BH6 fill:#121f91,stroke:#82b366
    style BH7 fill:#121f91,stroke:#82b366

    style S fill:#e1d5,stroke:#1a73a6
    style FM fill:#e1d5,stroke:#1a73a6
    style AF fill:#e1d5,stroke:#1a73a6
    style P fill:#e1d5,stroke:#1a73a6
    style BLD fill:#e1d5,stroke:#1a73a6
    
    style F fill:#818129,stroke:#9673a6
    style AD fill:#818129,stroke:#9673a6
    style CP fill:#818129,stroke:#9673a6
    style PR fill:#818129,stroke:#9673a6
    style DC fill:#818129,stroke:#9673a6
    style BR fill:#818129,stroke:#9673a6

    style STG fill:#d51114,stroke:#82b366
    style TM fill:#d51114,stroke:#82b366
    style CMD fill:#d51114,stroke:#82b366
    style V fill:#d51114,stroke:#82b366
    style STE fill:#d51114,stroke:#82b366
    style O fill:#d51114,stroke:#82b366
    style I fill:#d51114,stroke:#82b366

    style C fill:#c111f3,stroke:#824c68
    style D fill:#623ddd,stroke:#fbbd20
    style E fill:#911297,stroke:#4d884d
    style B fill:#e91f11,stroke:#b85450
    style A fill:#4e899f,stroke:#6c8ebf

    S -.-> SI1(Single instance)
    FM -.-> SI2(Single instance)
    FM -.-> IM(Implement<br>using)
    FM -.-> CFD(Configure factory<br>dynamically)
    CFD -.-> SI3(Single instance)
    CP -.-> CC(Creating composites)

    DC -.-> AR(Add responsibility<br>to objects)
    DC -.-> OU(Often uses)
    CP -.-> CU(Composed using)
    CP --> CSSVG(Chaining skin versus guts)

    STG -.-> DAS(Define algorithm<br>steps)

```


---

# Style 4 - Customized fonts and text colors 

```mermaid
---
title: Design Patterns
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
    A[Identify the core<br>problem] --> B{Is the<br>problem<br>related to};
    B -- Creating objects --> C(Creational);
    B -- Assembling objects --> D(Structural);
    B -- Object interactions/<br>responsibilities --> E(Behavioral);

    subgraph "Creational Patterns"
        direction LR
        C --> CR1[Need single instance<br><font color="#e9afaf">Ensure only one instance of a class</font>] --> S(Singleton);
        C --> CR2[Decouple object creation from usage<br><font color="#e9afaf">Define interface for creating objects</font>] --> FM(Factory Method);
        C --> CR3[Create families of related objects<br><font color="#e9afaf">Interface for creating families of objects</font>] --> AF(Abstract Factory);
        C --> CR4[Create duplicate objects<br><font color="#e9afaf">Create objects by cloning</font>] --> P(Prototype);
        C --> CR5[Construct complex objects step by step<br><font color="#e9afaf">Separate construction from representation</font>] --> BLD(Builder);
    end

    subgraph "Structural Patterns"
        direction LR
        D --> ST1[Simplify complex subsystems<br><font color="#e9afaf">Provide a high-level interface</font>] --> F(Facade);
        D --> ST2[Make incompatible interfaces compatible<br><font color="#e9afaf">Allow classes with incompatible interfaces to work together</font>] --> AD(Adapter);
        D --> ST3[Represent part-whole hierarchies<br><font color="#e9afaf">Compose objects into tree structures</font>] --> CP(Composite);
        D --> ST4[Control access to objects<br><font color="#e9afaf">Provide a surrogate or placeholder</font>] --> PR(Proxy);
        D --> ST5[Dynamically add/remove behavior<br><font color="#e9afaf">Attach responsibilities dynamically</font>] --> DC(Decorator);
        D --> ST6[Decouple abstraction from implementation<br><font color="#e9afaf">Separate interface from implementation</font>] --> BR(Bridge);
    end

    subgraph "Behavioral Patterns"
        direction LR
        E --> BH1[Define a family of algorithms<br><font color="#e9afaf">Encapsulate algorithms in classes</font>] --> STG(Strategy)
        E --> BH2[Define algorithm skeleton,<br> defer steps to subclasses.<br><font color="#e9afaf">Define the skeleton of an algorithm</font>] --> TM(Template Method)
        E --> BH3[Encapsulate requests as objects<br><font color="#e9afaf">Encapsulate a request as an object</font>] --> CMD(Command)
        E --> BH4[Separate operations from<br>objects they operate on<br><font color="#e9afaf">Represent an operation to be performed on elements of an object structure</font>] --> V(Visitor)
        E --> BH5[Encapsulate state-specific behavior<br><font color="#e9afaf">Allow an object to alter its behavior when its internal state changes</font>] --> STE(State)
        E --> BH6[Maintain a consistent state by<br>being notified of changes<br><font color="#e9afaf">Define a one-to-many dependency</font>] --> O(Observer)
        E --> BH7[Traverse collections without<br>exposing internals<br><font color="#e9afaf">Access the elements of an aggregate object sequentially</font>] --> I(Iterator)
    end

    style CR1 fill:#1f1111,stroke:#fed7aa
    style CR2 fill:#1f1111,stroke:#fed7aa
    style CR3 fill:#1f1111,stroke:#fed7aa
    style CR4 fill:#1f1111,stroke:#fed7aa
    style CR5 fill:#1f1111,stroke:#fed7aa

    style ST1 fill:#1f1111,stroke:#fed7aa
    style ST2 fill:#1f1111,stroke:#fed7aa
    style ST3 fill:#1f1111,stroke:#fed7aa
    style ST4 fill:#1f1111,stroke:#fed7aa
    style ST5 fill:#1f1111,stroke:#fed7aa
    style ST6 fill:#1f1111,stroke:#fed7aa

    style BH1 fill:#121f91,stroke:#82b366
    style BH2 fill:#121f91,stroke:#82b366
    style BH3 fill:#121f91,stroke:#82b366
    style BH4 fill:#121f91,stroke:#82b366
    style BH5 fill:#121f91,stroke:#82b366
    style BH6 fill:#121f91,stroke:#82b366
    style BH7 fill:#121f91,stroke:#82b366

    style S fill:#e1d5,stroke:#1a73a6
    style FM fill:#e1d5,stroke:#1a73a6
    style AF fill:#e1d5,stroke:#1a73a6
    style P fill:#e1d5,stroke:#1a73a6
    style BLD fill:#e1d5,stroke:#1a73a6

    style F fill:#818129,stroke:#9673a6
    style AD fill:#818129,stroke:#9673a6
    style CP fill:#818129,stroke:#9673a6
    style PR fill:#818129,stroke:#9673a6
    style DC fill:#818129,stroke:#9673a6
    style BR fill:#818129,stroke:#9673a6

    style STG fill:#d51114,stroke:#82b366
    style TM fill:#d51114,stroke:#82b366
    style CMD fill:#d51114,stroke:#82b366
    style V fill:#d51114,stroke:#82b366
    style STE fill:#d51114,stroke:#82b366
    style O fill:#d51114,stroke:#82b366
    style I fill:#d51114,stroke:#82b366

    style C fill:#c111f3,stroke:#824c68
    style D fill:#623ddd,stroke:#fbbd20
    style E fill:#911297,stroke:#4d884d
    style B fill:#e91f11,stroke:#b85450
    style A fill:#4e899f,stroke:#6c8ebf

    S -.-> SI1(Single instance<br><font color="#9673a6">Global access point, lazy initialization</font>)
    FM -.-> SI2(Single instance<br><font color="#9673a6">Can return singleton, but not enforced</font>)
    FM -.-> IM(Implement<br>using<br><font color="#9673a6">Abstract classes or interfaces</font>)
    FM -.-> CFD(Configure factory<br>dynamically<br><font color="#9673a6">Subclasses decide which class to instantiate</font>)
    CFD -.-> SI3(Single instance<br><font color="#9673a6">Flexibility in object creation</font>)
    CP -.-> CC(Creating composites<br><font color="#9673a6">Recursive composition</font>)

    DC -.-> AR(Add responsibility<br>to objects<br><font color="#9673a6">Without subclassing</font>)
    DC -.-> OU(Often uses<br><font color="#9673a6">Composition</font>)
    CP -.-> CU(Composed using<br><font color="#9673a6">Tree structure</font>)
    CP --> CSSVG(Chaining skin versus guts<br><font color="#9673a6">Leafs and composites, uniform interface</font>)

    STG -.-> DAS(Define algorithm<br>steps<br><font color="#9673a6">Interchangeable algorithms</font>)

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---