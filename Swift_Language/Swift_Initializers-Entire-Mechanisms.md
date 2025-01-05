---
source_url: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/"
created: 2025-1-1 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


The mermaid diagram below is my attempt to translate and to explain the initialization process from the official original documentation on [Swift Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization). This is still a work in progress.


In essence, below is a comprehensive Mermaid diagram cover all the concepts involved in Swift Initialization.


Here's a breakdown components will be covered in the Mermaid diagram:

1. **Basic Initialization:** Diagram showing the `init()` syntax and a simple example.
2. **Default Property Values:**  Illustrate how default values simplify initialization.
3. **Initialization Parameters:** Show initializers with parameters and argument labels.
4. **Initializer Parameters Without Argument Labels:**  Demonstrate the use of `_`.
5. **Optional Property Types:** Visualize how optional properties are initialized to `nil`.
6. **Assigning Constant Properties:** Show the timing of constant property assignment during initialization.
7. **Default Initializers:** Depict the automatic creation of default initializers for structures and classes.
8. **Memberwise Initializers:** Illustrate memberwise initializers for structures.
9. **Initializer Delegation for Value Types:** Diagram the `self.init` call for delegation in structs.
10. **Class Inheritance and Initialization:** Show the concepts of designated and convenience initializers.
11. **Initializer Delegation for Class Types:** Illustrate the rules of delegation (up for designated, across for convenience).
12. **Two-Phase Initialization:** Create diagrams for Phase 1 and Phase 2 of class initialization.
13. **Initializer Inheritance and Overriding:** Show how subclasses can override superclass initializers.
14. **Automatic Initializer Inheritance:** Illustrate the rules for automatic inheritance.
15. **Designated and Convenience Initializers in Action:** Visualize the initializer chains for the `Food`, `RecipeIngredient`, and `ShoppingListItem` example.
16. **Failable Initializers:** Show the `init?` syntax and how they return optionals.
17. **Failable Initializers for Enumerations:** Diagram the use of failable initializers for enums.
18. **Failable Initializers for Enumerations with Raw Values:** Show the automatic `init?(rawValue:)`.
19. **Propagation of Initialization Failure:** Illustrate how failure propagates through initializer delegation.
20. **Overriding a Failable Initializer:**  Show overriding with both failable and non-failable initializers.
21. **The init! Failable Initializer:** Diagram the `init!` syntax.
22. **Required Initializers:** Visualize the use of the `required` keyword.
23. **Setting a Default Property Value with a Closure or Function:** Illustrate the use of closures for default values.


---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Initialization] --> B{Set Initial Values};
    A --> C{Perform One-Time Setup};
    B --> D{Stored Properties};
    C --> E{Required Before Use};
    D --> F{Initial Value Assignment};
    F --> G{Initializer};
    F --> H{Default Property Value};
    G -- Like special methods --> I(init keyword);
    I -- No return value --> J{Correct Initialization};
    H -- Part of property's definition --> K{Ties to Declaration};
    K --> L{Shorter, Clearer Initializers};
    K --> M{Enable Default and Inheritance};
    B --> N{No Indeterminate State};
    style A fill:#f9f,stroke:#333,stroke-width:2px
```


---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Initialization] --> B{Set Initial Values};
    A --> C{Perform One-Time Setup};
    B --> D{Stored Properties};
    C --> E{Required Before Use};
    D --> F{Initial Value Assignment};
    F --> G{Initializer};
    F --> H{Default Property Value};
    G -- Like special methods --> I(init keyword);
    I -- No return value --> J{Correct Initialization};
    H -- Part of property's definition --> K{Ties to Declaration};
    K --> L{Shorter, Clearer Initializers};
    K --> M{Enable Default and Inheritance};
    B --> N{No Indeterminate State};
    style A fill:#f9f,stroke:#333,stroke-width:2px

subgraph Basic_Initializer
    O[Fahrenheit Structure]
    O --> P{var temperature: Double}
    O --> Q{"init() { <br> temperature = 32.0 <br> }"}
    R("var f = Fahrenheit()")
    Q --> P
end

subgraph Default_Property_Value
    S[Fahrenheit Structure with Default]
    S --> T{var temperature = 32.0}
end

subgraph Initialization_Parameters
    U[Celsius Structure]
    U --> V{var temperatureInCelsius: Double}
    U --> W{"init(fromFahrenheit fahrenheit: Double) { <br> temperatureInCelsius = ... <br> }"}
    U --> X{"init(fromKelvin kelvin: Double) { <br> temperatureInCelsius = ... <br> }"}
    Y("let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)")
    Z("let freezingPointOfWater = Celsius(fromKelvin: 273.15)")
    W --> V
    X --> V
end

subgraph Parameter_Names_and_Argument_Labels
    AA[Color Structure]
    AA --> AB{let red, green, blue: Double}
    AA --> AC{"init(red: Double, green: Double, blue: Double) { <br> self.red = red <br> self.green = green <br> self.blue = blue <br> }"}
    AA --> AD{"init(white: Double) { <br> red = white <br> green = white <br> blue = white <br> }"}
    AE("let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)")
    AF("let halfGray = Color(white: 0.5)")
    AC --> AB
    AD --> AB
    AG["Error: let veryGreen = Color(0.0, 1.0, 0.0)"]
    style AG fill:#ffe0e0,stroke:#f00,stroke-width:2px
end

subgraph Initializer_Parameters_Without_Argument_Labels
    AH[Celsius Structure with Unlabeled Param]
    AH --> AI{var temperatureInCelsius: Double}
    AH --> AJ{"init(_ celsius: Double) { <br> temperatureInCelsius = celsius <br> }"}
    AK("let bodyTemperature = Celsius(37.0)")
    AJ --> AI
end

subgraph Optional_Property_Types
    AL[SurveyQuestion Class]
    AL --> AM{var text: String}
    AL --> AN{var response: String?}
    ALO{"init(text: String) { <br> self.text = text <br> }"}
    AP("let cheeseQuestion = SurveyQuestion(text: 'Do you like cheese?')")
    ALO --> AM
end

subgraph Assigning_Constant_Properties
    AQ[SurveyQuestion Class with let]
    AQ --> AR{let text: String}
    AQ --> AS{var response: String?}
    AT{"init(text: String) { <br> self.text = text <br> }"}
    AU("let beetsQuestion = SurveyQuestion(text: 'How about beets?')")
    AT --> AR
end

subgraph Default_Initializers
    AV[ShoppingListItem Class]
    AV --> AW{var name: String?}
    AV --> AX{var quantity = 1}
    AV --> AY{var purchased = false}
    AZ("var item = ShoppingListItem()")
end

subgraph Memberwise_Initializers
    BA[Size Structure]
    BA --> BB{var width = 0.0, height = 0.0}
    BC("let twoByTwo = Size(width: 2.0, height: 2.0)")
    BD("let zeroByTwo = Size(height: 2.0)")
    BE("let zeroByZero = Size()")
end

subgraph Initializer_Delegation_for_Value_Types
    BF[Rect Structure]
    BF --> BG{"var origin = Point()"}
    BF --> BH{"var size = Size()"}
    BI{"init() {}"}
    BJ{"init(origin: Point, size: Size) { <br> self.origin = origin <br> self.size = size <br> }"}
    BK{"init(center: Point, size: Size) { <br> let originX = ... <br> let originY = ... <br> self.init(origin: Point(x: originX, y: originY), size: size) <br> }"}
    BL("let basicRect = Rect()")
    BM("let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))")
    BN("let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))")
    BK -- self.init --> BJ
end

subgraph Class_Inheritance_and_Initialization
    BO[Vehicle Class]
    BO --> BP{var numberOfWheels = 0}
    BO --> BQ{var description: String}
    BR("init()")
    BS("let vehicle = Vehicle()")

    BT[Bicycle Class]
    BT --> BU("override init() { <br> super.init() <br> numberOfWheels = 2 <br> }")
    BV("let bicycle = Bicycle()")
    BU -- super.init() --> BR

    BW[Hoverboard Class]
    BW --> BX{var color: String}
    BW --> BY("init(color: String) { <br> self.color = color <br> }")
    BZ("let hoverboard = Hoverboard(color: 'silver')")
end

subgraph Initializer_Delegation_for_Class_Types
    direction LR
    CA[Superclass]
    CA --> CB{Designated Initializer}
    CA --> CC{Convenience Initializer 1}
    CA --> CD{Convenience Initializer 2}
    CC --> CD
    CD --> CB

    CE[Subclass]
    CE --> CF{Designated Initializer A}
    CE --> CG{Designated Initializer B}
    CE --> CH{Convenience Initializer}
    CH --> CF
    CH --> CG
    CF --> CB
    CG --> CB
    style CA fill:#ccf
    style CE fill:#aaf
end

subgraph Two-Phase_Initialization
    direction LR
    DA[Phase 1: Initialization]
    DA --> DB{Designated/Convenience Initializer Called}
    DB --> DC{Allocate Memory}
    DC -- Not yet initialized --> DD(Designated Initializer Sets Properties)
    DD --> DE{Delegate to Superclass Initializer}
    DE --> DF{Repeat Up Chain}
    DF --> DG{Top of Chain Reached}
    DG --> DH{Memory Fully Initialized}

    DI[Phase 2: Customization]
    DH --> DJ{"Customize Instance (Top Down)"}
    DJ --> DK{Access self, Modify Properties, etc.}
    DK --> DL{Convenience Initializers Customize}
    DL --> DM{Initialization Complete}

    style DA fill:#efe
    style DI fill:#eef
end

subgraph Initializer_Inheritance_and_Overriding
    EA[Vehicle Class]
    EA --> EB("init()")
    EC("let vehicle = Vehicle()")

    ED[Bicycle Class]
    ED --> EE("override init() { <br> super.init() <br> numberOfWheels = 2 <br> }")
    EF("let bicycle = Bicycle()")
    EE -- super.init() --> EB

    EG[Hoverboard Class]
    EG --> EH("init(color: String) { <br> self.color = color <br> }")
    EI("let hoverboard = Hoverboard(color: 'silver')")
    style ED fill:#ddf
    style EG fill:#ddf
end

subgraph Automatic_Initializer_Inheritance
    direction TB
    FA[Rule 1: No Designated Initializers in Subclass] --> FB{Inherit All Superclass Designated Initializers}
    FC[Rule 2: Implement All Superclass Designated Initializers] --> FD{Inherit All Superclass Convenience Initializers}
    FD --> FE(Even with added Convenience Initializers)
end

subgraph Designated_and_Convenience_Initializers_in_Action
    direction TB
    GA[Food Class] --> GB("init(name: String)")
    GA --> GC("convenience init()")
    GC -- delegate --> GB

    GD[RecipeIngredient Class] --> GE("init(name: String, quantity: Int)")
    GD --> GF("override convenience init(name: String)")
    GF -- delegate --> GE
    GD -- inherits --> GC

    GG[ShoppingListItem Class] -- inherits --> GE
    GG -- inherits --> GF
    GG -- inherits --> GC

    GH("let namedMeat = Food(name: 'Bacon')")
    GI("let mysteryMeat = Food()")
    GJ("let oneMysteryItem = RecipeIngredient()")
    GK("let oneBacon = RecipeIngredient(name: 'Bacon')")
    GL("let sixEggs = RecipeIngredient(name: 'Eggs', quantity: 6)")
    GM("var breakfastList = [...]")
end

subgraph Failable_Initializers
    HA[Animal Structure]
    HA --> HB{let species: String}
    HA --> HC("init?(species: String) { <br> if species.isEmpty { return nil } <br> self.species = species <br> }")
    HD("let someCreature = Animal(species: 'Giraffe')")
    HE("let anonymousCreature = Animal(species: '')")

    HF[TemperatureUnit Enum]
    HF --> HG{"case kelvin, celsius, fahrenheit"}
    HF --> HH("init?(symbol: Character) { <br> switch symbol { ... } <br> }")
    HI("let fahrenheitUnit = TemperatureUnit(symbol: 'F')")
    HJ("let unknownUnit = TemperatureUnit(symbol: 'X')")

    HK[TemperatureUnit Enum Raw Value]
    HK --> HL{"case kelvin = 'K', celsius = 'C', fahrenheit = 'F' "}
    HK --> HM("init?(rawValue: Character)")
    HN("let fahrenheitUnitRaw = TemperatureUnit(rawValue: 'F')")
    HO("let unknownUnitRaw = TemperatureUnit(rawValue: 'X')")
end

subgraph Propagation_of_Initialization_Failure
    direction LR
    IA[Struct S]
    IA --> IB("init?(string1: String) { <br> self.init(string2: string1) <br> //No Print <br> }")
    IA --> IC("init?(string2: String) { return nil }")
    ID("let s = S(string1: 'bing')")

    IE[Class C]
    IE --> IF("convenience init?(string1: String) { <br> self.init(string2: string1) <br> //No Print <br> }")
    IE --> IG("init?(string2: String) { return nil }")
    IH("let c = C(string1: 'bing')")

    II[Class C Super]
    II --> IJ("init?(string1: String) { return nil }")
    IK[Class D Sub]
    IK --> IL("init?(string2: String) { <br> super.init(string1: string2) <br> //No Print <br> }")
    IM("let d = D(string2: 'bing')")
    IL -- super.init --> IJ
    style IE fill:#e0ffe0
    style IK fill:#e0e0ff
end

subgraph Overriding_a_Failable_Initializer
    JA[Document Class]
    JA --> JB("var name: String?")
    JA --> JC("init()")
    JA --> JD("init?(name: String) { <br> if name.isEmpty { return nil } <br> self.name = name <br> }")

    JE[AutomaticallyNamedDocument Class]
    JE --> JF("override init() { <br> super.init() <br> self.name = '[Untitled]' <br> }")
    JE --> JG("override init(name: String) { <br> super.init() <br> if name.isEmpty { ... } else { ... } <br> }")

    JH[UntitledDocument Class]
    JH --> JI("override init() { <br> super.init(name: '[Untitled]')! <br> }")
    JI -- super.init --> JD
    style JE fill:#f0f0ff
    style JH fill:#f0fff0
end

subgraph Failable_Initializer_with_force_unwrap["The init! Failable Initializer"]
    KA[Syntax: init!]
    KB[Creates Implicitly Unwrapped Optional]
    KC[Can Delegate From init? to init! and Vice Versa]
    KD[Can Override init? with init! and Vice Versa]
    KE["Can Delegate From init to init! (Assertion on Failure)"]
end

subgraph Required_Initializers
    LA[SomeClass]
    LA --> LB("required init() { ... }")

    LC[SomeSubclass]
    LC --> LD("required init() { ... }")
    style LC fill:#ffddff
end

subgraph Setting_Default_with_Closure
    MA[SomeClass]
    MA --> MB("let someProperty: SomeType = { <br> // Create default value <br> return someValue <br> }()")
    MC[Chessboard Structure]
    MC --> MD("let boardColors: [Bool] = { <br> // Logic to set up colors <br> return temporaryBoard <br> }()")
    ME("let board = Chessboard()")
end

```

---
