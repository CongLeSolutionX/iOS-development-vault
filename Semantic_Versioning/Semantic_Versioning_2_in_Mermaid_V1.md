---
source_url: "https://semver.org/"
created: 2025-2-3 09:50:26
author: NA
version: NA
license(s): NA
copyright: NA
---


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



Below is a collection of diagrams and illustrations aim to cover the core technical concepts of Semantic Versioning described in the original source document, using a combination of flowcharts, class diagrams, sequence diagrams, tables, textual examples, and a mind map-like structure to enhance understanding and visual clarity.



# 1. Semantic Versioning - Core Concept (Flowchart)

This diagram illustrates the fundamental decision process for incrementing the version number components (MAJOR, MINOR, PATCH).

```mermaid
---
title: Semantic Versioning - Core Concept
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A["Start with Version X.Y.Z"];
    B{"Incompatible API Changes?"};
    C["Increment MAJOR<br>(X+1).0.0"];
    D{"New Backward Compatible Functionality?"};
    E["Increment MINOR<br>X.(Y+1).0"];
    F{"Backward Compatible Bug Fixes?"};
    G["Increment PATCH <br> X.Y.(Z+1)"];
    H["No Version Change Needed<br>(Internal Changes Only)"];
    I["End"];
    
    A--> B
    B -- Yes --> C
    B -- No --> D
    D -- Yes --> E
    D -- No --> F
    F -- Yes --> G
    F -- No --> H
    
    C --> I
    E --> I
    G --> I
    H --> I

    classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
    class A,I Start_and_End_Point;

    classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
    class B,D,F Decision_Point

    classDef No_Choice fill:#f998,stroke:#33,stroke-width:2px;
    class H No_Choice;

    classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
    class C,E,G Yes_Choice;
    
```



**Explanation:** This flowchart visually breaks down the decision process for updating the MAJOR, MINOR, and PATCH versions based on the type of changes introduced.

---

# 2. Version Number Components (Class Diagram)

This diagram represents the structure of a Semantic Version number, highlighting its components.

```mermaid
---
title: Version Number Components
config:
  look: handDrawn
  theme: dark
---
classDiagram
    class SemanticVersion {
        -MAJOR: Integer
        -MINOR: Integer
        -PATCH: Integer
        -PRE-RELEASE: String (Optional)
        -BUILD-METADATA: String (Optional)
        --
        +incrementMajor()
        +incrementMinor()
        +incrementPatch()
        +setPreRelease(String)
        +setBuildMetadata(String)
        +toString()
    }
    
    SemanticVersion --|> VersionCore : Composed of
    SemanticVersion --|> PreRelease : Optional Extension
    SemanticVersion --|> BuildMetadata : Optional Extension
    
    class VersionCore{
        -MAJOR
        -MINOR
        -PATCH
    }
    
    class PreRelease{
        -Identifiers: Array<String>
    }
    
    class BuildMetadata{
        -Identifiers: Array<String>
    }
    
    VersionCore "1" -- "1" SemanticVersion : Contains
    PreRelease "0..1" -- "1" SemanticVersion : Extends
    BuildMetadata "0..1" -- "1" SemanticVersion : Extends
    
    style SemanticVersion fill:#e3f9,stroke:#333,stroke-width:1px
    style VersionCore fill:#e3e9,stroke:#333,stroke-width:1px
    style PreRelease fill:#e3e9,stroke:#333,stroke-width:1px
    style BuildMetadata fill:#e3e9,stroke:#333,stroke-width:1px
    
```


**Explanation:** This class diagram provides a structural view of a SemVer version number, showing its core components (Major, Minor, Patch) and optional extensions (Pre-release, Build Metadata). It illustrates that a `SemanticVersion` *is composed of* a `VersionCore` and *extends* with `PreRelease` and `BuildMetadata`.

---

# 3. Version Precedence (Sequence Diagram)

This diagram illustrates the process of comparing two Semantic Versions to determine precedence.

```mermaid
---
title: Version Precedence
config:
  layout: elk
  look: handDrawn
  theme: forest
---
sequenceDiagram
    autonumber
    participant VersionComparer
    participant VersionA
    participant VersionB

    VersionComparer->>VersionA: Get Major, Minor, Patch, Pre-release
    VersionComparer->>VersionB: Get Major, Minor, Patch, Pre-release

    VersionComparer->>VersionComparer: Compare Major Versions Numerically
    alt Major Versions Different
        VersionComparer->>VersionComparer: Precedence Determined by Major Version
    else Major Versions Same
        VersionComparer->>VersionComparer: Compare Minor Versions Numerically
        alt Minor Versions Different
            VersionComparer->>VersionComparer: Precedence Determined by Minor Version
        else Minor Versions Same
            VersionComparer->>VersionComparer: Compare Patch Versions Numerically
            alt Patch Versions Different
                VersionComparer->>VersionComparer: Precedence Determined by Patch Version
            else Patch Versions Same
                VersionComparer->>VersionComparer: Check for Pre-release Versions
                alt Only VersionA has Pre-release
                    VersionComparer->>VersionComparer: VersionB has higher precedence
                else Only VersionB has Pre-release
                    VersionComparer->>VersionComparer: VersionA has higher precedence
                else Both have Pre-release
                    VersionComparer->>VersionComparer: Compare Pre-release Identifiers Lexically/Numerically
                else Neither has Pre-release
                    VersionComparer->>VersionComparer: Versions have Same Precedence
                end
            end
        end
    end
    VersionComparer-->>VersionComparer: Return Precedence Result

    Note over VersionComparer,VersionA: Build Metadata Ignored in Precedence
    
    %% style VersionComparer fill:#fef,stroke:#333,stroke-width:1px
    %% style VersionA fill:#eee,stroke:#333,stroke-width:1px
    %% style VersionB fill:#eee,stroke:#333,stroke-width:1px
    
```


**Explanation:** This sequence diagram outlines the steps involved in comparing two SemVer versions, emphasizing the order of comparison (Major -> Minor -> Patch -> Pre-release) and the rules for pre-release identifier comparison. It also highlights that build metadata is not considered in precedence.

---

# 4. Increment Rules Table (Table Illustration)

Instead of a Mermaid diagram, a table might be best to summarize the increment rules.

| Change Type                     | Version Component to Increment | Reset Minor & Patch |
|---------------------------------|--------------------------------|----------------------|
| Incompatible API Changes        | **MAJOR**                      | Yes (to 0)           |
| New Backward Compatible Functionality | **MINOR**                      | Yes (to 0)           |
| Backward Compatible Bug Fixes   | **PATCH**                      | No                     |
| No API Change (Internal)        | **None**                       | No                     |

**Explanation:** This table concisely summarizes when to increment each part of the version number based on the type of change. It's a direct and easy-to-read format for this information.

---

# 5. Pre-release and Build Metadata (Textual Illustration)

Here's a simple textual illustration breaking down the components of a version with pre-release and build metadata.

```markdown
Semantic Version Example:  1.2.3-alpha.1+build.123

Breakdown:
  - Version Core: 1.2.3  (MAJOR.MINOR.PATCH)
  - Pre-release:  alpha.1 (Indicates unstable, lower precedence)
  - Build Metadata: build.123 (For build information, ignored in precedence)
```

**Explanation:** This textual illustration provides a clear example of a version string with pre-release and build metadata, breaking down each part for clarity.

---

# 6. BNF Grammar Structure (Mind Map - PlantUML Style)

While Mermaid doesn't directly support Mind Maps in the same way as PlantUML's `@startmindmap`, we can use a nested graph structure to approximate a mind map, or present it in a structured list form. Let's use a structured list for better readability as mindmaps in text are not very efficient.

**BNF Grammar Breakdown:**

*   **\<valid semver\>**:  Defines the overall structure of a valid semantic version.
    *   **\<version core\>**: The mandatory MAJOR.MINOR.PATCH part.
        *   **\<major\>**: Numeric identifier (non-negative integer, no leading zeros).
        *   **\<minor\>**: Numeric identifier.
        *   **\<patch\>**: Numeric identifier.
    *   **\<pre-release\>**: Optional, denoted by `-` followed by dot-separated identifiers.
        *   **\<dot-separated pre-release identifiers\>**: One or more pre-release identifiers separated by dots.
        *   **\<pre-release identifier\>**: Alphanumeric or numeric identifier.
    *   **\<build\>**: Optional, denoted by `+` followed by dot-separated identifiers.
        *   **\<dot-separated build identifiers\>**: One or more build identifiers separated by dots.
        *   **\<build identifier\>**: Alphanumeric identifier or digits (numeric string).
    *   **\<alphanumeric identifier\>**: Starts with a letter or hyphen, followed by zero or more identifier characters.
    *   **\<numeric identifier\>**: "0" or positive digit followed by digits.
    *   **\<identifier characters\>**: Digits or letters or hyphens.
    *   **\<non-digit\>**: Letters or hyphen.
    *   **\<digits\>**: One or more digits.
    *   **\<digit\>**: "0" or a positive digit ("1" - "9").
    *   **\<positive digit\>**: "1", "2", ..., "9".
    *   **\<letter\>**: "A" - "Z", "a" - "z".

**Explanation:**  This structured list breaks down the Backus-Naur Form (BNF) grammar, explaining each rule and term used in defining a valid SemVer string. It mirrors the hierarchical nature of the grammar.

-----

# 7. Benefits of Semantic Versioning (Mind Map - Approximated with Mermaid Graph)

We can use a nested graph to represent the benefits like a mind map.

```mermaid
---
title: Benefits of Semantic Versioning
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    root(Semantic Versioning Benefits)
    root --> A[Avoid Dependency Hell]
    root --> B[Clear Communication]
    root --> C[Safe Upgrades]
    root --> D[Developer Efficiency]

    A --> A1[Reduces Version Lock]
    A --> A2[Prevents Version Promiscuity]

    B --> B1[Version Meaning is Clear]
    B --> B2[Easy to Understand Changes]
    B --> B3[Intentions are Communicated]

    C --> C1[Compatible Updates]
    C --> C2[Predictable Compatibility]

    D --> D1[Saves Time & Hassle]
    D --> D2[Less Package Management Nightmares]
    D --> D3[Faster Development Cycle]
    
    style root fill:#f3e9,stroke:#333,stroke-width:1px
    style A fill:#e3e9,stroke:#333,stroke-width:1px
    style B fill:#e3e9,stroke:#333,stroke-width:1px
    style C fill:#e3e9,stroke:#333,stroke-width:1px
    style D fill:#e3e9,stroke:#333,stroke-width:1px

```


**Explanation:** This diagram illustrates the key benefits of using Semantic Versioning. It shows the main advantages and their sub-points, similar to a mind map structure.


---
