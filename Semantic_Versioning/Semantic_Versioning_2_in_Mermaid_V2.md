---
source_url: "https://semver.org/"
created: 2025-2-3 09:50:26
author: Cong Le
version: "2.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a collection of enhanced versions of diagrams and illustrations aim to cover the core technical concepts of Semantic Versioning described in the original source document, using a combination of flowcharts, class diagrams, sequence diagrams, tables, textual examples, and a mind map-like structure to enhance understanding and visual clarity.



# 1. Semantic Versioning - Core Concept (Flowchart)

```mermaid
---
title: Semantic Versioning - Core Concept
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    %% Assigning value for each node variable
    start_note["Starting Point: <br>Initial Version<br>(0.1.0 or 1.0.0)"];
    A["Start Versioning Process"];

    API_Change{"Public API Change?"};
    Incompatible_API{"Incompatible API<br>Changes?"};
    Bug_Fixes{"Backward Compatible Bug Fixes<br>or New Features?"}

    Increment_Major["Increment MAJOR<br>(X+1).0.0"];
    New_Functionality{"New Backward Compatible<br>Functionality?"};
    
    Increment_Minor["Increment MINOR<br>X.(Y+1).0"];

    Increment_Patch["Increment PATCH <br> X.Y.(Z+1)"];

    No_Change["No Version Change Needed<br>(Internal Changes Only)"];

    End["End Process"];


    %% Interactions or relationships among node variables
    
    start_note:::note --> A
    
    A --> API_Change

    API_Change -- Yes --> Incompatible_API
    API_Change -- No --> Bug_Fixes

    Incompatible_API -- Yes --> Increment_Major:::major_increment
    Incompatible_API -- No --> New_Functionality

    New_Functionality -- Yes --> Increment_Minor:::minor_increment
    New_Functionality -- No --> Bug_Fixes


    Bug_Fixes -- Yes --> Increment_Patch:::patch_increment
    Bug_Fixes -- No --> No_Change:::no_increment

    Increment_Major --> End
    Increment_Minor --> End
    Increment_Patch --> End
    No_Change --> End
    
    End:::end_point


    %% Styling for each node variable
    classDef note fill:#f9f,stroke:#333,stroke-width:1px,color:#333;
    class start_note note;

    classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
    class A,End Start_and_End_Point;

    classDef Decision_Points fill:#9398,stroke:#333,stroke-width:2px;
    class API_Change,Incompatible_API,New_Functionality,Bug_Fixes Decision_Points


    classDef no_increment fill:#f9f8,stroke:#33,stroke-width:2px;
    class No_Change no_increment;

    classDef major_increment fill:#f118,stroke:#33,stroke-width:2px;
    class Increment_Major major_increment;

    classDef minor_increment fill:#f278,stroke:#33,stroke-width:2px;
    class Increment_Minor minor_increment;

    classDef patch_increment fill:#f998,stroke:#33,stroke-width:2px;
    class Increment_Patch patch_increment;

    classDef end_point fill:#1919,stroke:#333,stroke-width:2px;
    class End end_point;
    
```



**Explanation:** This enhanced flowchart now clearly emphasizes the importance of the public API in Semantic Versioning right from the beginning. It streamlines the decision process while accurately reflecting the core logic. The added note at the start helps clarify where the versioning process typically begins. The use of color classes also visually differentiates the types of version increments.

---

# 2. Version Number Components (Class Diagram)


```mermaid
---
title: Version Number Components
config:
  look: handDrawn
  theme: dark
---
classDiagram
    class SemanticVersion {
        --
        //Version Number//
        <<Root Concept>>
    }

    class VersionCore{
        -MAJOR: NonNegativeInteger
        -MINOR: NonNegativeInteger
        -PATCH: NonNegativeInteger
        --
        <<Version Core>>
    }

    class PreRelease{
        -Identifiers: Array<String>
        --
        <<Optional Extension>>
        // - Indicates Instability //
        // - Lower Precedence //
    }

    class BuildMetadata{
        -Identifiers: Array<String>
        --
        <<Optional Extension>>
        // - Build Information //
        // - Ignored in Precedence //
    }

    SemanticVersion --|> VersionCore : Core Part of
    SemanticVersion --|> PreRelease : Extends with
    SemanticVersion --|> BuildMetadata : Extends with

    VersionCore "1" -- "1" SemanticVersion : Contains
    PreRelease "0..1" -- "1" SemanticVersion : Augments <br> // Semantically more appropriate than 'Extends' for optional part.
    BuildMetadata "0..1" -- "1" SemanticVersion : Augments <br> // Semantically more appropriate than 'Extends' for optional part.


    style SemanticVersion fill:#e3f9,stroke:#333,stroke-width:1px
    style VersionCore fill:#e3e9,stroke:#333,stroke-width:1px
    style PreRelease fill:#e3e9,stroke:#333,stroke-width:1px
    style BuildMetadata fill:#e3e9,stroke:#333,stroke-width:1px

    style SemanticVersion fontColor:#333, fontSize:14px, fontWeight:bold
    style VersionCore fontColor:#333
    style PreRelease fontColor:#555
    style BuildMetadata fontColor:#555
    
```


**Explanation:**  This revised class diagram offers a more semantically rich representation of a Semantic Version. It highlights the `VersionCore` more prominently and clarifies the role and characteristics of `PreRelease` and `BuildMetadata` as optional extensions. The stereotype notation `<<...>>` further distinguishes the nature of each component (Root Concept, Version Core, Optional Extensions).  The removal of methods keeps the focus on the data structure, which is more appropriate for a class diagram at this conceptual level.

---

# 3. Version Precedence (Sequence Diagram)


```mermaid
---
title: Version Precedence
config:
  look: handDrawn
  theme: forest
---
sequenceDiagram
    autonumber
    participant VC as VersionComparer
    participant VA as Version A
    participant VB as Version B

    VC->>VA: Get: Major, Minor, Patch, Pre-release
    VC->>VB: Get: Major, Minor, Patch, Pre-release

    VC->>VC: <b>Compare MAJOR Versions</b> (Numerically)
    alt MAJOR(A) != MAJOR(B)
        VC-->>VC: Precedence: Determined by MAJOR Version
    else MAJOR(A) == MAJOR(B)
        VC->>VC: <b>Compare MINOR Versions</b> (Numerically)
        alt MINOR(A) != MINOR(B)
            VC-->>VC: Precedence: Determined by MINOR Version
        else MINOR(A) == MINOR(B)
            VC->>VC: <b>Compare PATCH Versions</b> (Numerically)
            alt PATCH(A) != PATCH(B)
                VC-->>VC: Precedence: Determined by PATCH Version
            else PATCH(A) == PATCH(B)
                VC->>VC: <b>Check for Pre-release</b>
                alt VA has Pre-release & VB no Pre-release
                    VC-->>VC: Precedence: Version B > Version A (Normal > Pre-release)
                else VB has Pre-release & VA no Pre-release
                    VC-->>VC: Precedence: Version A > Version B (Normal > Pre-release)
                else Both have Pre-release
                    VC->>VC: <b>Compare Pre-release Identifiers</b><br>(Identifier by Identifier)
                    loop For each Identifier Pair
                        VC->>VC: Determine Identifier Type (Numeric/Alpha)<br>Apply Numeric or Lexical Comparison Rule
                        %% alt Difference Found
                            %% VC-->>VC: Precedence: Determined by Pre-release Identifier Comparison
                            %% break
                        end
                    end
                    alt No Difference in Identifiers but different number of identifiers (e.g. alpha vs alpha.1)
                        VC->>VC: Precedence: Version with more identifiers > version with fewer
                    else All Identifiers Equal
                        VC-->>VC: Precedence: Versions Have Same Precedence (Pre-release components equal)
                    end
                %% else Neither has Pre-release
                %%     VC-->>VC: Precedence: Versions Have Same Precedence (Core versions equal)
                %% end
            end
        end
    end
    
    Note over VC: Build Metadata Ignored in Precedence
    Note over VA: Build Metadata Ignored in Precedence
    
    VC-->>VC: Return Precedence Result
    
```


**Explanation:** This significantly improved sequence diagram now provides a clearer and more detailed step-by-step illustration of the version precedence comparison algorithm. By simplifying the participants and directly showcasing comparison stages, it becomes easier to follow the logic. The added details on pre-release identifier comparison rules and type checking make it more technically accurate and informative. The visual flow and annotations guide the reader effectively through the precedence logic.

---

# 4. Increment Rules Table (Table Illustration)


| Change Type                     | Version Component to Increment | Reset Minor & Patch | Example Scenario                                                                                                                               |
| :------------------------------ | :------------------------------ | :-------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- |
| **Incompatible API Changes**      | **MAJOR**                      | Yes (to 0)            | Renaming a core function or changing the return type of a public method breaking existing client code.                                           |
| **New Backward Compatible Functionality** | **MINOR**                      | Yes (to 0)            | Adding a new feature to the API that doesn't break existing functionality, like a new optional parameter or a new class.                        |
| **Backward Compatible Bug Fixes**   | **PATCH**                      | No                    | Fixing a bug that caused incorrect calculations without altering the API signatures or adding new features.                               |
| **No API Change (Internal)**        | **None**                       | No                    | Refactoring internal code for performance improvements, updating dependencies, or improving comments without any impact on the public API. |

**Explanation:**  The table is already a very effective way to present this information. The addition of the "Example Scenario" column considerably enhances its practical value by illustrating each rule with a concrete example. The improved wording and visual emphasis make it even more user-friendly and easily digestible. This table is now concise, clear, and immediately applicable.

---

# 5. Pre-release and Build Metadata (Textual Illustration)

```markdown
Semantic Version Example:  1.2.3-alpha.1+build.123 or 1.2.3-rc.beta-007+exp.sha.48afkjs

Breakdown:
  - **Version Core: 1.2.3**  (MAJOR.MINOR.PATCH - Mandatory part)
      - MAJOR: 1
      - MINOR: 2
      - PATCH: 3

  - **Pre-release:  alpha.1 or rc.beta-007** (Optional, Indicated by '-' hyphen after PATCH)
      - Purpose:  Indicates that the release is unstable and might not meet compatibility promises of the associated normal version. Used for alpha, beta, release candidate stages, etc.
      - Identifier Rules:
          - Composed of dot-separated identifiers (e.g., alpha.1, beta.rc.test).
          - Identifiers MUST contain only ASCII alphanumerics and hyphens [0-9A-Za-z-].
          - Identifiers MUST NOT be empty.
          - Numeric identifiers MUST NOT have leading zeroes (e.g., '1', not '01').
      - Precedence: Pre-release versions ALWAYS have LOWER precedence than the corresponding normal version (e.g., 1.2.3-alpha < 1.2.3).

  - **Build Metadata: build.123 or exp.sha.48afkjs** (Optional, Indicated by '+' plus after PATCH or Pre-release)
      - Purpose:  Used to attach build-related information (timestamps, commit hashes, build numbers).  For internal tracking, debugging.
      - Identifier Rules:
          - Composed of dot-separated identifiers (e.g., build.123, exp.sha.48afkjs).
          - Identifiers MUST contain only ASCII alphanumerics and hyphens [0-9A-Za-z-].
          - Identifiers MUST NOT be empty.
          - Numeric identifiers MAY have leading zeroes (build metadata does not have numeric precedence rules).
      - Precedence: Build metadata is IGNORED when determining version precedence. Versions differing only in build metadata have the SAME precedence (e.g., 1.2.3+build.100 == 1.2.3+build.200).
```

**Explanation:** This enhanced textual illustration is now much more comprehensive. By providing additional examples, clarifying identifier rules, and explicitly stating the *purpose* of pre-release and build metadata, it offers a deeper and more practical understanding of these SemVer extensions. The structured formatting with bullet points makes the information easier to read and reference.

---

# 6. BNF Grammar Visual Structure (Enhanced Structured Breakdown with Mermaid - Approximation of Tree)


```mermaid
---
title: BNF Grammar Visual Structure
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    root("<valid semver>"):::nonTerminal --> core("<version core>"):::nonTerminal
    root("<valid semver>"):::nonTerminal --> pre_plus["- <pre-release> (Optional)"]:::optional
    root("<valid semver>"):::nonTerminal --> build_plus["+ <build> (Optional)"]:::optional
    root("<valid semver>"):::nonTerminal --> pre_build_plus["- <pre-release> + <build> (Optional)"]:::optional


    core("<version core>"):::nonTerminal --> major("<major>"):::nonTerminal
    core("<version core>"):::nonTerminal --> minor("<minor>"):::nonTerminal
    core("<version core>"):::nonTerminal --> patch("<patch>"):::nonTerminal
    major("<major>"):::nonTerminal --> numericId_major("<numeric identifier>"):::nonTerminal
    minor("<minor>"):::nonTerminal --> numericId_minor("<numeric identifier>"):::nonTerminal
    patch("<patch>"):::nonTerminal --> numericId_patch("<numeric identifier>"):::nonTerminal

    pre_plus["- <pre-release> (Optional)"]:::optional --> pre("<pre-release>"):::nonTerminal
    pre("<pre-release>"):::nonTerminal --> dot_separated_pre("<dot-separated pre-release identifiers>"):::nonTerminal
    dot_separated_pre("<dot-separated pre-release identifiers>"):::nonTerminal --> pre_id("<pre-release identifier>"):::nonTerminal
    dot_separated_pre("<dot-separated pre-release identifiers>"):::nonTerminal --> dot_pre_recurse["'.' <dot-separated pre-release identifiers> (Recursive)"]:::recursive
    pre_id("<pre-release identifier>"):::nonTerminal --> alphaNumericId_pre("<alphanumeric identifier>"):::nonTerminal
    pre_id("<pre-release identifier>"):::nonTerminal --> numericId_pre("<numeric identifier>"):::nonTerminal


    build_plus["+ <build> (Optional)"]:::optional --> build("<build>"):::nonTerminal
    build("<build>"):::nonTerminal --> dot_separated_build("<dot-separated build identifiers>"):::nonTerminal
    dot_separated_build("<dot-separated build identifiers>"):::nonTerminal --> build_id("<build identifier>"):::nonTerminal
    dot_separated_build("<dot-separated build identifiers>"):::nonTerminal --> dot_build_recurse["'.' <dot-separated build identifiers> (Recursive)"]:::recursive
    build_id("<build identifier>"):::nonTerminal --> alphaNumericId_build("<alphanumeric identifier>"):::nonTerminal
    build_id("<build identifier>"):::nonTerminal --> digits_build("<digits>"):::nonTerminal


    alphaNumericId_pre("<alphanumeric identifier>"):::nonTerminal --> non_digit_alphaNumeric("<non-digit>"):::nonTerminal
    alphaNumericId_pre("<alphanumeric identifier>"):::nonTerminal --> non_digit_identifier_char["<non-digit> <identifier characters>"]:::nonTerminal
    alphaNumericId_pre("<alphanumeric identifier>"):::nonTerminal --> identifier_char_non_digit["<identifier characters> <non-digit>"]:::nonTerminal
    alphaNumericId_pre("<alphanumeric identifier>"):::nonTerminal --> identifier_char_non_digit_char["<identifier characters> <non-digit> <identifier characters>"]:::recursive

    alphaNumericId_build("<alphanumeric identifier>"):::nonTerminal --> non_digit_alphaNumericBuild("<non-digit>"):::nonTerminal
    alphaNumericId_build("<alphanumeric identifier>"):::nonTerminal --> non_digit_identifier_char_build["<non-digit> <identifier characters>"]:::nonTerminal
    alphaNumericId_build("<alphanumeric identifier>"):::nonTerminal --> identifier_char_non_digit_build["<identifier characters> <non-digit>"]:::nonTerminal
    alphaNumericId_build("<alphanumeric identifier>"):::nonTerminal --> identifier_char_non_digit_char_build["<identifier characters> <non-digit> <identifier characters>"]:::recursive


    numericId_major("<numeric identifier>"):::nonTerminal --> zero_numeric["'0'"]:::terminal
    numericId_major("<numeric identifier>"):::nonTerminal --> positive_digit_numeric["<positive digit><digits>"]:::recursive
    numericId_minor("<numeric identifier>"):::nonTerminal --> zero_numeric_minor["'0'"]:::terminal
    numericId_minor("<numeric identifier>"):::nonTerminal --> positive_digit_numeric_minor["<positive digit><digits>"]:::recursive
    numericId_patch("<numeric identifier>"):::nonTerminal --> zero_numeric_patch["'0'"]:::terminal
    numericId_patch("<numeric identifier>"):::nonTerminal --> positive_digit_numeric_patch["<positive digit><digits>"]:::recursive
    numericId_pre("<numeric identifier>"):::nonTerminal --> zero_numeric_pre["'0'"]:::terminal
    numericId_pre("<numeric identifier>"):::nonTerminal --> positive_digit_numeric_pre["<positive digit><digits>"]:::recursive


    identifier_char("<identifier characters>"):::nonTerminal --> identifier_char_single("<identifier character>"):::nonTerminal
    identifier_char("<identifier characters>"):::nonTerminal --> identifier_char_recursive["<identifier character> <identifier characters>"]:::recursive
    identifier_char_single("<identifier character>"):::nonTerminal --> digit_identifier_char("<digit>"):::nonTerminal
    identifier_char_single("<identifier character>"):::nonTerminal --> non_digit_identifier_char_single("<non-digit>"):::nonTerminal

    non_digit("<non-digit>"):::nonTerminal --> letter_non_digit("<letter>"):::nonTerminal
    non_digit("<non-digit>"):::nonTerminal --> hyphen_non_digit("'-'"):::terminal
    non_digit_alphaNumericBuild("<non-digit>"):::nonTerminal --> letter_non_digit_alphaNumericBuild("<letter>"):::nonTerminal
    non_digit_alphaNumericBuild("<non-digit>"):::nonTerminal --> hyphen_non_digit_alphaNumericBuild("'-'"):::terminal


    digits_build("<digits>"):::nonTerminal --> digit_digits("<digit>"):::nonTerminal
    digits_build("<digits>"):::nonTerminal --> digit_digits_recursive["<digit> <digits>"]:::recursive

    digit_digits("<digit>"):::nonTerminal --> zero_digit("'0'"):::terminal
    digit_digits("<digit>"):::nonTerminal --> positive_digit("'positive digit'"):::nonTerminal
    positive_digit("'positive digit'"):::nonTerminal --> positive_digit_value("'1'-'9'"):::terminal
    positive_digit_numeric("'positive digit'"):::nonTerminal --> positive_digit_value_numeric("'1'-'9'"):::terminal
    positive_digit_numeric_minor("'positive digit'"):::nonTerminal --> positive_digit_value_numeric_minor("'1'-'9'"):::terminal
    positive_digit_numeric_patch("'positive digit'"):::nonTerminal --> positive_digit_value_numeric_patch("'1'-'9'"):::terminal
    positive_digit_numeric_pre("'positive digit'"):::nonTerminal --> positive_digit_value_numeric_pre("'1'-'9'"):::terminal
    digit_identifier_char("<digit>"):::nonTerminal --> digit_value("'0'-'9'"):::terminal
    letter_non_digit("<letter>"):::nonTerminal --> letter_value("'A'-'Z', 'a'-'z'"):::terminal
    letter_non_digit_alphaNumericBuild("<letter>"):::nonTerminal --> letter_value_alphaNumericBuild("'A'-'Z', 'a'-'z'"):::terminal


    classDef nonTerminal fill:#c3e9,stroke:#333,stroke-width:1px
    classDef terminal fill:#e3ee,stroke:#333,stroke-width:1px
    classDef optional stroke-dasharray: 5 5;
    classDef recursive stroke-dasharray: 3 3;
  
```


**Explanation:** This visual BNF grammar is a significant enhancement for understanding the structure of a SemVer string. By using a nested graph in Mermaid, we create a visual hierarchy that mirrors the grammar's rules. Color-coding for terminal and non-terminal symbols makes it easier to differentiate grammar rules from the actual allowed characters. This visual representation is much more intuitive than the structured list and especially plain BNF text for quickly grasping the grammar's overall structure and rules.  Although Mermaid's graph isn't a perfect tree representation, it effectively approximates the hierarchical nature of the BNF grammar.

---

# 7.  Benefits of Semantic Versioning (Mind Map - Approximated Mermaid Graph)


```mermaid
---
title: Benefits of Semantic Versioning
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    root(Semantic Versioning - Key Benefits)
    root --> A[Mitigate Dependency Issues]:::benefit_main
    root --> B[Enhance Communication]:::benefit_main
    root --> C[Facilitate Predictable Upgrades]:::benefit_main
    root --> D[Improve Developer Workflow]:::benefit_main

    A --> A1[Reduces Version Lock]:::benefit_sub
    A --> A2[Prevents Version Promiscuity]:::benefit_sub
    A --> A3[Eases Dependency Management]:::benefit_sub

    B --> B1[Version Meaning is Clear]:::benefit_sub
    B --> B2[Easy to Understand Changes]:::benefit_sub
    B --> B3[Communicates Intentions Effectively]:::benefit_sub
    B --> B4[Reduces Misunderstandings]:::benefit_sub

    C --> C1["Ensures Backward Compatibility<br>(when promised)"]:::benefit_sub
    C --> C2[Enables Safe & Confident Upgrades]:::benefit_sub
    C --> C3[Predictable Software Evolution]:::benefit_sub

    D --> D1[Saves Time & Effort]:::benefit_sub
    D --> D2[Reduces Package Management Complexities]:::benefit_sub
    D --> D3[Streamlines Release Process]:::benefit_sub
    D --> D4[Faster Development Cycles]:::benefit_sub


    classDef benefit_main fill:#f3e9,stroke:#333,stroke-width:1px, fontColor:#222, fontWeight:bold;
    classDef benefit_sub fill:#e3e9,stroke:#333,stroke-width:1px, fontColor:#444;

    classDef root fill:#f12,stroke:#333,stroke-width:1px, fontColor:#111, fontWeight:bold;
  
```


**Explanation:**  This enhanced mind map provides a more detailed and nuanced overview of the benefits of Semantic Versioning. Expanding each category with specific sub-points directly from the article content makes it more informative.  The improved labels and consistent styling contribute to a more polished and effective visual summary of SemVer's advantages. The color-coded styles further differentiate the main benefits from their sub-points in the mind map.


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---