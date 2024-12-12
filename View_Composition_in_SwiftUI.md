---
created: 2024-12-01 05:48:19
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


# View Composition in SwiftUI


Below are some Mermaid diagrams to visually represent the concepts of View Composition in SwiftUI.

## Diagram 1: Basic View Composition Structure

This diagram illustrates the hierarchical structure of a composed view, breaking down the `ProfileView` into its subcomponents.

```mermaid
graph LR
    A[ProfileView] --> B(ProfileImageView)
    A --> C(ProfileNameView)
    A --> D(ProfileBioView)
    B --> E{Image}
    C --> F{Text}
    D --> G{Text}
    
    subgraph "Profile Component Views"
        B;C;D;
    end
    
   style A fill:#f11,stroke:#333,stroke-width:2px
```

## Diagram 2: View Extension for Styling

This diagram demonstrates how a View extension is used to apply a reusable style to a view component.

```mermaid
graph LR
    A[View Extension] -- Applies --> B(ProfileTitleModifier)
    B --> C[Text]
    C -- Styled with --> A
    
    subgraph "Styling"
      A;B;
    end

```

## Diagram 3: Environment Object for Shared Data

This diagram shows how an `EnvironmentObject` is used to share data between different views in the composition.

```mermaid
graph LR
    A[UserData] -- Injected into --> B[ProfileView]
    B --> C(ProfileNameView)
    B --> D(ProfileBioView)
    C -- Accesses --> A
    D -- Accesses --> A
    
    subgraph "Environment"
        A
    end
    
    style A fill:#cc11ff,stroke:#333,stroke-width:2px

```

## Diagram 4: Reusable Subview for Repeated Patterns

This diagram illustrates the use of a reusable subview, `StatView`, within a larger view, `ProfileStatsView`.

```mermaid
graph LR
    A[ProfileStatsView] --> B(StatView)
    A --> B1(StatView)
    A --> B2(StatView)
    B -- Displays --> C{Value & Label}
    B1 -- Displays --> C1{Value & Label}
    B2 -- Displays --> C2{Value & Label}
    
    subgraph Reusable Subview
    B;B1;B2
    end
    
    style B fill:#11f,stroke:#333,stroke-width:2px
```

## Diagram 5: Conditional Content with @ViewBuilder

This diagram depicts how `@ViewBuilder` is utilized to conditionally display different views based on a state variable.

```mermaid
graph LR
    A[ProfileView] --> B(ProfileContent)
    B --> C{isLoggedIn?}
    C -- true --> D(ProfileDetailsView)
    C -- false --> E{"Text: "Please log in""}

      subgraph Condition
        C
      end
        
    style C fill:#f1b,stroke:#333,stroke-width:2px
```
---
