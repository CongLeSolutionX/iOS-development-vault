---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/TypeCasting.md"
created: 2025-01-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/LanguageGuide/TypeCasting.md):

---



Here's a plan:

1. **Class Hierarchy Diagram:** Show the inheritance relationship between `MediaItem`, `Movie`, and `Song`.
2. **Type Checking Diagram:** Illustrate how the `is` operator is used to check the type of objects in the `library` array.
3. **Downcasting Diagram:** Demonstrate the use of `as?` and `as!` to cast `MediaItem` objects to `Movie` or `Song`.
4. **Any Type Diagram:**  Show how different types can be stored in an array of type `[Any]` and how a `switch` statement can be used to identify the specific type.


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Class Hierarchy
        direction LR
        A[MediaItem] --> B(Movie)
        A --> C(Song)
    end

style A fill:#f59f,stroke:#333,stroke-width:2px;
style B fill:#c5cf,stroke:#333,stroke-width:2px;
style C fill:#c5cf,stroke:#333,stroke-width:2px;

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
    subgraph Type_Checking["Type Checking with 'is'"]
        direction TB
        A["library: [MediaItem]"] --> B{"item is Movie?"}
        B -- Yes --> C["movieCount += 1"]
        B -- No --> D{"item is Song?"}
        D -- Yes --> E["songCount += 1"]
        D -- No --> F["Continue to next item"]
    end

style A fill:#e5ee,stroke:#333,stroke-width:1px
style B fill:#c5cf,stroke:#333,stroke-width:2px
style D fill:#c5cf,stroke:#333,stroke-width:2px
style C fill:#a5af,stroke:#333,stroke-width:1px
style E fill:#a5af,stroke:#333,stroke-width:1px
style F fill:#d5dd,stroke:#333,stroke-width:1px

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
    subgraph Downcasting["Downcasting with <br> 'as?' and 'as!'"]
        direction TB
        A[item: MediaItem] --> B{Attempt downcast: <br> item as? Movie}
        B -- Success --> C[movie: Movie?]
        C --> D{if let movie}
        D -- Yes --> E[Access <br> movie.director]
        D -- No --> F{Attempt downcast: <br> item as? Song}
        B -- Failure --> F
        F -- Success --> G[song: Song?]
        G --> H{if let song}
        H -- Yes --> I[Access <br> song.artist]
        H -- No --> J[Handle other cases]
    end

style A fill:#e5ee,stroke:#333,stroke-width:1px
style B fill:#c5cf,stroke:#333,stroke-width:2px
style F fill:#c5cf,stroke:#333,stroke-width:2px
style C fill:#a5af,stroke:#333,stroke-width:1px
style E fill:#a5af,stroke:#333,stroke-width:1px
style G fill:#a5af,stroke:#333,stroke-width:1px
style I fill:#a5af,stroke:#333,stroke-width:1px
style J fill:#d5dd,stroke:#333,stroke-width:1px

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
    subgraph Working_with_Any_type["Working with 'Any' Type"];
        direction TB
        A["things: [Any]"] --> B{"Iterate through 'things' "};
        B --> C{"switch thing"};
        C --> D{"case 0 as Int"};
        C --> E{"case 0 as Double"};
        C --> F{"case let someInt as Int"};
        C --> G{"case let someDouble as Double where someDouble > 0"};
        C --> H{"case is Double"};
        C --> I{"case let someString as String"};
        C --> J{"case let (x, y) as (Double, Double)"};
        C --> K{"case let movie as Movie"};
        C --> L{"case let stringConverter as (String) -> String"};
        C --> M{"default"};
    end

style A fill:#e599,stroke:#333,stroke-width:1px;
style B fill:#c599,stroke:#333,stroke-width:2px;
style C fill:#a599,stroke:#333,stroke-width:1px;
style D fill:#d599,stroke:#333,stroke-width:1px;
style E fill:#d599,stroke:#333,stroke-width:1px;
style F fill:#d599,stroke:#333,stroke-width:1px;
style G fill:#d599,stroke:#333,stroke-width:1px;
style H fill:#d599,stroke:#333,stroke-width:1px;
style I fill:#d599,stroke:#333,stroke-width:1px;
style J fill:#d599,stroke:#333,stroke-width:1px;
style K fill:#d599,stroke:#333,stroke-width:1px;
style L fill:#d599,stroke:#333,stroke-width:1px;
style M fill:#d599,stroke:#333,stroke-width:1px;

```

---

