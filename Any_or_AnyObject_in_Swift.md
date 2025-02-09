---
created: 2024-12-01 06:13:34
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


# Any or AnyObject in Swift
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

Below is a set of Mermaid diagrams to visually explain `Any` and `AnyObject` in Swift.

## Diagram 1: Type Hierarchy

This diagram illustrates the relationship between `Any`, `AnyObject`, concrete types (like `Person`, `Animal`, `Int`, `String`, `Bool`), and bridged Objective-C types (like `NSNumber` and `NSString`).

```mermaid
classDiagram
    Any <|-- AnyObject
    AnyObject <|-- Person
    AnyObject <|-- Animal
		AnyObject <|-- NSNumber : Bridged from Int
    AnyObject <|-- NSString : Bridged from String
    Any <|-- Int
    Any <|-- String
    Any <|-- Bool
    Person : +String name
    Animal : +String name
    class Person{
        +init(name: String)
    }
    class Animal{
       +init(name: String)
    }

```

## Diagram 2: Array Storage

This diagram shows how different types can be stored in arrays of `Any` and `AnyObject`, highlighting the bridging behavior.

```mermaid
graph LR
    A[Array of Any] --> B{1}
    A --> C{"2"}
    A --> D[true]
    B --> B1(Int)
    C --> C1(String)
    D --> D1(Bool)

    E[Array of AnyObject] --> F[Person Instance]
    E --> G[Animal Instance]
		E --> H["1 as AnyObject"]
		H --> H1(NSNumber)
    F --> F1(Person Class)
    G --> G1(Animal Class)
```

## Diagram 3:  Type Casting and Identification

This diagram demonstrates how to use `is` to check types within an `Any` array and the bridging that occurs when value types are cast to `AnyObject`.

```mermaid
graph TD
    A[Element in Any Array] --> B{Is String?};
    B -- Yes --> C[String];
    B -- No --> D{Is Int?};
    D -- Yes --> E[Int];
    D -- No --> F{Is Bool?};
    F -- Yes --> G[Bool];
		F -- No --> H{Other Type};

		I[Element in AnyObject Array] --> J{Is Int?}
		J -- Yes --> K[Int]
		J-- No --> L{"Type(of: obj) = NSNumber"}
		L --> M[NSNumber - Bridged]
		
```

## Diagram 4:  Bridging in Detail

This diagram specifically focuses on the bridging process from Swift value types to Objective-C reference types.

```mermaid
graph LR
    A[Swift Int] -- Cast to AnyObject --> B{Bridging}
    B --> C[Objective-C NSNumber]
    D[Swift String] -- Cast to AnyObject --> E{Bridging}
    E --> F[Objective-C NSString]
```
---
