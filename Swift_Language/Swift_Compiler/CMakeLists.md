---
source_url: "https://github.com/swiftlang/swift/blob/main/lib/Parse/CMakeLists.txt"
created: 2025-01-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift/blob/main/lib/Parse/CMakeLists.txt):

---


Here's a breakdown of the structure and the diagrams I can create:

1. **Overall Structure:** The CMake code defines a Swift host library (`swiftParse`) and its dependencies.
2. **Conditional Logic:** There are `if` statements that control certain configurations based on the operating system (`CMAKE_HOST_SYSTEM_NAME`) and build flags (`SWIFT_BUILD_SWIFT_SYNTAX`, `SWIFT_BUILD_REGEX_PARSER_IN_COMPILER`, `SWIFT_COMPILER_VERSION`).
3. **Components:**
    - Target: `swiftParse` (a static library)
    - Source files: List of `.cpp` files
    - Private Link Libraries: `swiftAST`
    - Conditional Private Link Libraries: `swiftASTGen` (based on `SWIFT_BUILD_SWIFT_SYNTAX`)
    - Conditional Compile Definitions: `SWIFT_BUILD_REGEX_PARSER_IN_COMPILER`
    - Conditional Compile Flags: `SWIFT_COMPILER_VERSION`
    - Function Call: `add_swift_host_library`
    - Function Call: `target_link_libraries`
    - Function Call: `add_dependencies`
    - Function Call: `target_compile_definitions`
    - Function Call: `set_property`
    - Function Call: `set_swift_llvm_is_available`

Based on this, I can create several diagrams:

- **Diagram 1: Overall Module Structure:**  Shows `swiftParse` and its direct dependencies (both always and conditionally).
- **Diagram 2: Conditional Compilation:** Focuses on the `if` statements and their impact on the build process.
- **Diagram 3: Source File Composition:** Lists the C++ source files that make up `swiftParse`.
- **Diagram 4:  CMake Command Flow:** Illustrates the sequence of CMake commands.

I will use `graph TD` for most of these to show dependencies and flow.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Operating System Specific Flags
        direction LR
        A["Check OS: <br> CMAKE_HOST_SYSTEM_NAME"] -->|Windows| B{"Set SWIFT_GYB_FLAGS: <br> --line-directive"};
        A -->|Other| C{"Set SWIFT_GYB_FLAGS: <br> --line-directive"};
    end

    subgraph swiftParse Library Definition
        direction TB
        D["add_swift_host_library(swiftParse STATIC ...)"];
        E["Source Files"];
        F["target_link_libraries(swiftParse PRIVATE swiftAST)"];
    end

    subgraph Conditional Swift Syntax Linking
        direction LR
        G[Check Flag: <br> SWIFT_BUILD_SWIFT_SYNTAX] -->|True| H["target_link_libraries(swiftParse PRIVATE swiftASTGen)"];
        H --> I["add_dependencies(swiftParse swiftASTGen)"];
    end

    subgraph Conditional Regex Parser Definition
        J["Check Flag: <br> SWIFT_BUILD_REGEX_PARSER_IN_COMPILER"] -->|True| K["target_compile_definitions(swiftParse PUBLIC SWIFT_BUILD_REGEX_PARSER_IN_COMPILER)"];
    end

    subgraph Conditional Compiler Version Flag
        L["Check Flag: <br> SWIFT_COMPILER_VERSION"] -->|Exists| M["set_property(SOURCE ParseVersion.cpp APPEND_STRING PROPERTY COMPILE_FLAGS ...)"];
    end

    N["set_swift_llvm_is_available(swiftParse)"];

    linkStyle default stroke:#33,stroke-width:2px

    D --> E
    D --> F
    F --> G
    G --> J
    J --> L
    L --> N
    
```


**Explanation:**

* **Operating System Specific Flags:** This subgraph highlights the conditional setting of `SWIFT_GYB_FLAGS` based on whether the host system is Windows.
* **swiftParse Library Definition:** This shows the core definition of the `swiftParse` library, including the source files it comprises and its basic dependency on `swiftAST`.
* **Conditional Swift Syntax Linking:** This illustrates the conditional inclusion of `swiftASTGen` as a dependency based on the `SWIFT_BUILD_SWIFT_SYNTAX` flag.
* **Conditional Regex Parser Definition:** This shows the conditional compilation definition based on the `SWIFT_BUILD_REGEX_PARSER_IN_COMPILER` flag.
* **Conditional Compiler Version Flag:** This depicts how a compile flag is conditionally set based on the existence of `SWIFT_COMPILER_VERSION`.
* **Overall Flow:** The main diagram connects these subgraphs to show the overall flow of the CMake configuration.

---

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph swiftParse_Library["swiftParse Library"]
        style swiftParse_Library fill:#539f,stroke:#333,stroke-width:2px
        direction TB
        A["swiftParse <br> (Static Library)"]
        B[Confusables.cpp]
        C[Lexer.cpp]
        D[ParseDecl.cpp]
        E[ParseDeclName.cpp]
        F[ParseExpr.cpp]
        G[ParseGeneric.cpp]
        H[ParseIfConfig.cpp]
        I[ParsePattern.cpp]
        J[Parser.cpp]
        K[ParseRegex.cpp]
        L[ParseRequests.cpp]
        M[ParseStmt.cpp]
        N[ParseType.cpp]
        O[ParseVersion.cpp]
        P[PersistentParserState.cpp]
    end

    subgraph Dependencies
        style Dependencies fill:#319f,stroke:#333,stroke-width:2px
        direction LR
        Q[swiftParse] -->|Depends Privately On| R[swiftAST]
        subgraph Conditional_Dependencies["Conditional Dependencies"]
            style Conditional_Dependencies fill:#41f,stroke:#333,stroke-width:2px
            S[Check: SWIFT_BUILD_SWIFT_SYNTAX]
            S -->|True| T[swiftParse]
            T -->|Depends Privately On| U[swiftASTGen]
        end
    end

    subgraph Compile_Definitions["Compile Definitions"]
        style Compile_Definitions fill:#451f,stroke:#333,stroke-width:2px
        direction LR
        V[Check: SWIFT_BUILD_REGEX_PARSER_IN_COMPILER]
        V -->|True| W["SWIFT_BUILD_REGEX_PARSER_IN_COMPILER <br> (Compile Definition)"]
    end

    subgraph Compile_Flags["Compile Flags"]
        style Compile_Flags fill:#651f,stroke:#333,stroke-width:2px
        direction LR
        X[Check: SWIFT_COMPILER_VERSION]
        X -->|Exists| Y[ParseVersion.cpp]
        Y -->|Compile Flag:| Z[DSWIFT_COMPILER_VERSION]
    end

    linkStyle default stroke:#399,stroke-width:1px

    A --> B
    A --> C
    A --> D
    A --> E
    A --> F
    A --> G
    A --> H
    A --> I
    A --> J
    A --> K
    A --> L
    A --> M
    A --> N
    A --> O
    A --> P
    Q --> S
    Q --> V
    Q --> X

```

**Explanation:**

* **swiftParse Library:** This subgraph visually represents the `swiftParse` library and lists all the `.cpp` files that are part of it.
* **Dependencies:** This section illustrates the dependencies of `swiftParse`. It shows the direct private dependency on `swiftAST` and the conditional private dependency on `swiftASTGen`.
* **Compile Definitions:** This shows the conditional compilation definition based on the `SWIFT_BUILD_REGEX_PARSER_IN_COMPILER` flag.
* **Compile Flags:** This depicts how a compile flag (`DSWIFT_COMPILER_VERSION`) is conditionally added to `ParseVersion.cpp` if `SWIFT_COMPILER_VERSION` is defined.

---

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    A[Start] --> B{"CMAKE_HOST_SYSTEM_NAME STREQUAL 'Windows'?"};
    B -- Yes --> C["set(SWIFT_GYB_FLAGS --line-directive ...)"];
    B -- No --> D["set(SWIFT_GYB_FLAGS --line-directive ...)"];
    C --> E["add_swift_host_library(swiftParse STATIC ...)"];
    D --> E;
    E --> F["target_link_libraries(swiftParse PRIVATE swiftAST)"];
    F --> G{"SWIFT_BUILD_SWIFT_SYNTAX?"};
    G -- Yes --> H["target_link_libraries(swiftParse PRIVATE swiftASTGen)"];
    H --> I["add_dependencies(swiftParse swiftASTGen)"];
    G -- No --> J{"SWIFT_BUILD_REGEX_PARSER_IN_COMPILER?"};
    I --> J;
    J -- Yes --> K["target_compile_definitions(swiftParse PUBLIC SWIFT_BUILD_REGEX_PARSER_IN_COMPILER)"];
    J -- No --> L{"SWIFT_COMPILER_VERSION?"};
    K --> L;
    L -- Yes --> M["set_property(SOURCE ParseVersion.cpp ...)"];
    L -- No --> N["set_swift_llvm_is_available(swiftParse)"];
    M --> N;
    N --> O[End];

linkStyle default stroke:#339,stroke-width:2px

```


**Explanation:**

This diagram uses a flowchart style to illustrate the sequential flow of the CMake commands and the conditional logic involved:

1. **Start:** The process begins.
2. **Operating System Check:** Checks if the OS is Windows.
3. **Set GYB Flags (Windows):** Sets the `SWIFT_GYB_FLAGS` for Windows.
4. **Set GYB Flags (Other):** Sets the `SWIFT_GYB_FLAGS` for other operating systems.
5. **Add swiftParse Library:** Defines the `swiftParse` library.
6. **Link swiftAST:** Links the `swiftParse` library with `swiftAST`.
7. **Check SWIFT_BUILD_SWIFT_SYNTAX:** Checks the value of the `SWIFT_BUILD_SWIFT_SYNTAX` flag.
8. **Link swiftASTGen:** If true, links `swiftParse` with `swiftASTGen`.
9. **Add Dependencies:** Adds a dependency on `swiftASTGen` if the flag is true.
10. **Check SWIFT_BUILD_REGEX_PARSER_IN_COMPILER:** Checks the value of this flag.
11. **Define Regex Parser Flag:** If true, defines the compile flag.
12. **Check SWIFT_COMPILER_VERSION:** Checks if `SWIFT_COMPILER_VERSION` is defined.
13. **Set Compiler Version Flag:** If defined, sets the compile flag for `ParseVersion.cpp`.
14. **Set LLVM Availability:** Calls the function to set LLVM availability.
15. **End:** The CMake configuration process ends.

These diagrams provide different visual perspectives on the provided Swift documentation, making it easier to understand the structure, dependencies, and conditional configurations within the CMake build system.

----

