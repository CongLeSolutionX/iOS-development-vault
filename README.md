# iOS-development-vault


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

These notes cover a wide array of subjects. I aim to present iOS development concepts and practices using visual representations.

## Demo
Below is a sample of note in this repo.


```mermaid
---
title: Design Patterns in Mixed Languages
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
    A[Identify the core<br>problem] --> B{Is the<br>problem<br>related to}
    B -- Creating objects --> C(Creational)
    B -- Assembling objects --> D(Structural)
    B -- Object interactions/<br>responsibilities --> E(Behavioral)
    B -- Managing memory/resources --> M(Memory Management)

    subgraph Creational_Patterns["Creational Patterns"]
        direction LR
        C --> CR1[Need single instance<br>per app/module] --> S(Singleton)
        C --> CR2[Decouple object creation<br>from usage] --> FM(Factory Method)
        C --> CR3[Create families of<br>related objects] --> AF(Abstract Factory)
        C --> CR4[Create duplicate objects<br>efficiently] --> P(Prototype)
        C --> CR5[Construct complex objects<br>step by step] --> BLD(Builder)
        C --> CR6[Create objects based on<br> runtime parameters] --> BO(Builder with Options)
    end

    subgraph Structural_Patterns["Structural Patterns"]
        direction LR
        D --> ST1[Simplify complex<br>subsystems] --> F(Facade);
        D --> ST2["Make incompatible interfaces<br>compatible<br>(Swift/ObjC/C++)"] --> AD(Adapter);
        D --> ST3["Represent part-whole<br>hierarchies<br>(Views)"] --> CP(Composite);
        D --> ST4["Control access to objects<br>(Network, Files)"] --> PR(Proxy);
        D --> ST5["Dynamically add/remove<br>behavior<br>(at runtime)"] --> DC(Decorator);
        D --> ST6[Decouple abstraction from<br>implementation] --> BR(Bridge);
        D --> ST7[Efficiently share large numbers<br>of fine-grained objects] --> FW(Flyweight);
        D --> ST8[Combine multiple objects<br>into a single interface] --> AGG(Aggregator);
    end
    
    subgraph Behavioral_Patterns["Behavioral Patterns"]
        direction LR
        E --> BH1["Define a family of<br>algorithms<br>(Networking)"] --> STG(Strategy)
        E --> BH2[Define algorithm skeleton,<br> defer steps to subclasses] --> TM(Template Method)
        E --> BH3["Encapsulate requests as objects<br>(Undo/Redo)"] --> CMD(Command)
        E --> BH4[Separate operations from<br>objects they operate on] --> V(Visitor)
        E --> BH5["Encapsulate state-specific<br>behavior<br>(Game States)"] --> STE(State)
        E --> BH6["Maintain a consistent state by<br>being notified of changes<br>(KVO, Combine, Delegates)"] --> O(Observer)
        E --> BH7[Traverse collections without<br>exposing internals] --> I(Iterator)
        E --> BH8[Reduce coupling between<br>communicating objects] --> MED(Mediator)
        E --> BH9[Capture and restore an<br>object's internal state] --> MEM(Memento)
        E --> BH10[Provide a way to access elements<br>of an aggregate object sequentially] --> CHN(Chain of Responsibility)
        E --> BH11[Convert the interface of a class<br>into another interface clients expect] --> INT(Interpreter);

    end

    subgraph Memory_Management_Patterns["Memory Management Patterns"]
      direction LR
      M --> MM1[Automatic Reference Counting] --> ARC(ARC)
      M --> MM2[Manual Reference Counting] --> MRC(MRC)
      M --> MM3[Retain Cycles] --> RC(Retain Cycles)
      M --> MM4[Object Pooling] --> OP(Object Pool)
    end


    style CR1 fill:#1f1111,stroke:#fed7aa
    style CR2 fill:#1f1111,stroke:#fed7aa
    style CR3 fill:#1f1111,stroke:#fed7aa
    style CR4 fill:#1f1111,stroke:#fed7aa
    style CR5 fill:#1f1111,stroke:#fed7aa
    style CR6 fill:#1f1111,stroke:#fed7aa


    style ST1 fill:#1f1111,stroke:#fed7aa
    style ST2 fill:#1f1111,stroke:#fed7aa
    style ST3 fill:#1f1111,stroke:#fed7aa
    style ST4 fill:#1f1111,stroke:#fed7aa
    style ST5 fill:#1f1111,stroke:#fed7aa
    style ST6 fill:#1f1111,stroke:#fed7aa
    style ST7 fill:#1f1111,stroke:#fed7aa
    style ST8 fill:#1f1111,stroke:#fed7aa



    style BH1 fill:#121f91,stroke:#82b366
    style BH2 fill:#121f91,stroke:#82b366
    style BH3 fill:#121f91,stroke:#82b366
    style BH4 fill:#121f91,stroke:#82b366
    style BH5 fill:#121f91,stroke:#82b366
    style BH6 fill:#121f91,stroke:#82b366
    style BH7 fill:#121f91,stroke:#82b366
    style BH8 fill:#121f91,stroke:#82b366
    style BH9 fill:#121f91,stroke:#82b366
    style BH10 fill:#121f91,stroke:#82b366
    style BH11 fill:#121f91,stroke:#82b366



    style MM1 fill:#1f1111,stroke:#feda11
    style MM2 fill:#1f1111,stroke:#feda11
    style MM3 fill:#1f1111,stroke:#feda11
    style MM4 fill:#1f1111,stroke:#feda11


    style S fill:#e1d5,stroke:#1a73a6
    style FM fill:#e1d5,stroke:#1a73a6
    style AF fill:#e1d5,stroke:#1a73a6
    style P fill:#e1d5,stroke:#1a73a6
    style BLD fill:#e1d5,stroke:#1a73a6
    style BO fill:#e1d5,stroke:#1a73a6

    
    style F fill:#818129,stroke:#9673a6
    style AD fill:#818129,stroke:#9673a6
    style CP fill:#818129,stroke:#9673a6
    style PR fill:#818129,stroke:#9673a6
    style DC fill:#818129,stroke:#9673a6
    style BR fill:#818129,stroke:#9673a6
    style FW fill:#818129,stroke:#9673a6
    style AGG fill:#818129,stroke:#9673a6


    style STG fill:#d51114,stroke:#82b366
    style TM fill:#d51114,stroke:#82b366
    style CMD fill:#d51114,stroke:#82b366
    style V fill:#d51114,stroke:#82b366
    style STE fill:#d51114,stroke:#82b366
    style O fill:#d51114,stroke:#82b366
    style I fill:#d51114,stroke:#82b366
    style MED fill:#d51114,stroke:#82b366
    style MEM fill:#d51114,stroke:#82b366
    style CHN fill:#d51114,stroke:#82b366
    style INT fill:#d51114,stroke:#82b366

    style ARC fill:#c511f3,stroke:#824c68
    style MRC fill:#c511f3,stroke:#824c68
    style RC fill:#c511f3,stroke:#824c68
    style OP fill:#c511f3,stroke:#824c68

    style C fill:#c111f3,stroke:#824c68
    style D fill:#623ddd,stroke:#fbbd20
    style E fill:#911297,stroke:#4d884d
    style M fill:#f199,stroke:#4d884d
    style B fill:#e91f11,stroke:#b85450
    style A fill:#4e899f,stroke:#6c8ebf

    S -.-> SI1(Single instance<br>'static let shared = ...')
    FM -.-> SI2(Single instance<br>of concrete factory)
    FM -.-> IM("Implement<br>using:<br>'protocol Product { ... }'<br>'protocol Factory { ... }'")
    FM -.-> CFD(Configure factory<br>dynamically)
    CFD -.-> SI3(Single instance<br>of factory manager)
    AF -.-> IM2(Implement using:<br>Multiple factories<br>conforming to a protocol)
    P -.-> IM3("Implement using:<br>'NSCopying' (ObjC)<br>Custom 'clone()' (Swift)")
    BLD -.-> IM4(Implement using:<br>Separate 'Builder' class<br>with fluent interface)
    BO -.-> IM4
    BO -.-> USO(Use for:<br>Complex object creation<br>with many options)

    F -.-> USF(Use for:<br>Networking, Database access)
    AD -.-> IM5("Implement using:<br>Protocol extensions (Swift)<br>Category (ObjC)<br>Wrapper class")
    AD -.-> USO2(Use for:<br>Bridging Swift/ObjC/C++)
    CP -.-> CC(Creating composites<br>of 'UIView's)
    CP -.-> IM6(Implement using:<br>Recursive data structure)
    PR -.-> USPR(Use for:<br>Lazy loading, access control)
    DC -.-> AR(Add responsibility<br>to objects dynamically)
    DC -.-> OU(Often uses)
    CP -.-> CU(Composed using)
    CP -.-> CSSVG(Chaining skin versus guts<br>Good for 'UITableViewCell')
    FW -.-> USFW(Use for:<br>Drawing large numbers<br>of similar objects)
    AGG -.-> IMAG(Implement Using<br>Multiple Services and Combine)
    AGG -.-> USAG(Use for<br>Microservices, Data Aggregation)


    STG -.-> DAS(Define algorithm<br>steps as protocols)
    STG -.-> IM7("Implement using:<br>'protocol Algorithm { ... }'")
    STG -.-> USSTG(Use for:<br>Networking protocols,<br>Data processing)
    TM -.-> IM8(Implement using:<br>'open' and 'final' methods)
    TM -.-> USTM(Use for:<br>Customizable 'UIViewController's)
    CMD -.-> IM9("Implement using:<br>'protocol Command { ... }'<br>Invoker, Receiver")
    CMD -.-> USCMD(Use for:<br>Undo/Redo, Operations)
    V -.-> IM10(Implement using:<br>Double dispatch)
    V -.-> USV(Use for:<br>Operating on a hierarchy<br>of objects)
    STE -.-> IM11("Implement using:<br>'enum State { ... }'<br>Context class")
    STE -.-> USSTE(Use for:<br>Game states, UI states)
    O -.-> IMO(Implement using:<br>Delegates, Notifications,<br>Combine, KVO)
    O -.-> USO3(Use for:<br>Reacting to model changes)
    I -.-> IMI("Implement using:<br>'IteratorProtocol' (Swift)")
    I -.-> USI(Use for:<br>Custom collection types)
    MED -.-> IMMED(Implement using:<br>Centralized communication object)
    MED -.-> USMED(Use for:<br>Complex UI interactions)
    MEM -.-> IMMEM(Implement using:<br>Originator, Caretaker, Memento)
    MEM -.-> USMEM(Use for:<br>Saving and restoring game state)
    CHN -.-> IMCHN(Implement using:<br>Chain of handlers)
    CHN -.-> USCHN(Use for:<br>Event handling, Error handling)
    INT -.-> IMINT("Implement using:<br>Abstract Syntax Tree<br>(AST)")
    INT -.-> USINT(Use for:<br>Parsing, DSLs)


    ARC -.-> IMARC(Swift's primary memory management)
    MRC -.-> IMMRC(Objective-C, manual retain/release)
    RC -.-> IMARC
    RC -.-> IMRC
    RC -.-> UMRC(Use Weak/Unowned References)
    OP -.-> IMOP(Reusable objects to avoid allocation)
    OP -.-> USOP(UITableViewCells, UICollectionReusableView)

```

---


