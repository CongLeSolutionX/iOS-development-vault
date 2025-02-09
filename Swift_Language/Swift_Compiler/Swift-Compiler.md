---
source_url: "https://www.swift.org/documentation/swift-compiler"
created: 2025-01-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://www.swift.org/documentation/swift-compiler/):

---



**Plan:**

1. Create a flowchart-style diagram to illustrate the overall compilation process.
2. Create individual component diagrams for key stages like parsing, semantic analysis, SIL generation, and LLVM IR generation, highlighting their inputs and outputs.
3. Consider using subgraphs to group related components.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Swift_Compiler_Architecture["Swift Compiler Architecture"]
        direction LR
        A["Swift Source Code"] --> B(Parsing)
        B --> C{"Abstract Syntax Tree <br> (AST)"}
        C --> D(Semantic Analysis)
        D --> E{Type-Checked AST}
        E --> F(SIL Generation)
        F --> G{Raw SIL}
        G --> H(SIL Guaranteed Transformations)
        H --> I{Canonical SIL}
        I --> J(SIL Optimizations)
        J --> K{Optimized SIL}
        K --> L(LLVM IR Generation)
        L --> M{LLVM IR}
    end
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Parsing
        direction TB
        A[Swift Source Code] --> B{Lexer}
        B --> C(Tokens)
        C --> D{Parser}
        D --> E["Abstract Syntax Tree <br> (AST)"]
    end
    
```

---



```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Semantic Analysis
        direction LR
        A["Abstract Syntax Tree <br> (AST)"] --> B(Type Checking)
        B --> C{Type Inference}
        C --> D{"Error/Warning Emission"}
        D -- Success --> E[Type-Checked AST]
        D -- Failure --> F[Error Messages]
    end
    
```


---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Clang Importer
        direction LR
        A[Clang Modules] --> B(Import)
        B --> C{"Imported AST <br> (C/ObjC)"}
        C --> D[Semantic Analysis can access]
    end
    
```

----


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph SIL_Generation["SIL Generation"]
        direction LR
        A[Type-Checked AST] --> B(Lowering)
        B --> C[Raw SIL]
        style C fill:#c5cf,stroke:#333,stroke-width:2px
    end
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph SIL Processing
        direction TB
        A[Raw SIL] --> B(SIL Guaranteed Transformations)
        B --> C{Canonical SIL}
        style C fill:#c5cf,stroke:#333,stroke-width:2px
        
        C --> D(SIL Optimizations)
        D --> E{Optimized SIL}
        style E fill:#c5cf,stroke:#333,stroke-width:2px
    end
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph LLVM_IR_Generation["LLVM IR Generation"]
        direction LR
        A[Optimized SIL] --> B(Lowering to LLVM IR)
        B --> C[LLVM IR]
        style C fill:#c5cf,stroke:#333,stroke-width:2px
    end
    
```

---


```mermaid
%% ---
%% config:
%%   layout: elk
%%   look: handDrawn
%%   theme: dark
%% ---
graph LR
    subgraph Swift_Compiler_Front-End["Swift Compiler Front-End"]
        style Swift_Compiler_Front-End fill:#539f,stroke:#333,stroke-width:2px
        direction TB
        A[Swift Source Code] --> B(Parsing)
        B --> C{"Abstract Syntax Tree <br> (AST)"}
        C --> D(Semantic Analysis)
        D -- Success --> E{Type-Checked AST}
        D -- Failure --> F[Error Messages]
        subgraph Clang_Integration["Clang Integration"]
            style Clang_Integration fill:#c59f,stroke:#333,stroke-width:2px
            G[Clang Modules] --> H(Clang Importer)
            H --> E
        end
    end
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Swift_Compiler_Back-End["Swift Compiler Back-End"]
        direction TB
        A[Type-Checked AST] --> B(SIL Generation)
        B --> C{Raw SIL}
        C --> D(SIL Guaranteed Transformations)
        D --> E{Canonical SIL}
        E --> F(SIL Optimizations)
        F --> G{Optimized SIL}
        G --> H(LLVM IR Generation)
        H --> I[LLVM IR]
    end
    
```

---


```mermaid
sequenceDiagram
    autonumber
    participant Source Code
    participant Parser
    participant Semantic Analysis
    participant Clang Importer
    participant SIL Generation
    participant SIL Transformations
    participant SIL Optimizations
    participant LLVM IR Generation
    participant LLVM

    Source Code->>Parser: Swift Source Code
    Parser->>Semantic Analysis: Abstract Syntax Tree (AST)
    Semantic Analysis->>Clang Importer: Request Imported Modules
    Clang Importer->>Semantic Analysis: Imported ASTs
    Semantic Analysis->>SIL Generation: Type-Checked AST
    SIL Generation->>SIL Transformations: Raw SIL
    SIL Transformations->>SIL Optimizations: Canonical SIL
    SIL Optimizations->>LLVM IR Generation: Optimized SIL
    LLVM IR Generation->>LLVM: LLVM IR
    LLVM->> Machine Code: TODO <br> (I need to add a task in this phase)
    
```


Below are the major components of the Swift compiler:

- **Parsing**: The parser is a simple, recursive-descent parser (implemented in [lib/Parse](https://github.com/swiftlang/swift/tree/main/lib/Parse)) with an integrated, hand-coded lexer. The parser is responsible for generating an Abstract Syntax Tree (AST) without any semantic or type information, and emits warnings or errors for grammatical problems with the input source.
    
- **Semantic analysis**: Semantic analysis (implemented in [lib/Sema](https://github.com/swiftlang/swift/tree/main/lib/Sema)) is responsible for taking the parsed AST and transforming it into a well-formed, fully-type-checked form of the AST, emitting warnings or errors for semantic problems in the source code. Semantic analysis includes type inference and, on success, indicates that it is safe to generate code from the resulting, type-checked AST.
    
- **Clang importer**: The Clang importer (implemented in [lib/ClangImporter](https://github.com/swiftlang/swift/tree/main/lib/ClangImporter)) imports [Clang modules](http://clang.llvm.org/docs/Modules.html) and maps the C or Objective-C APIs they export into their corresponding Swift APIs. The resulting imported ASTs can be referred to by semantic analysis.
    
- **SIL generation**: The Swift Intermediate Language (SIL) is a high-level, Swift-specific intermediate language suitable for further analysis and optimization of Swift code. The SIL generation phase (implemented in [lib/SILGen](https://github.com/swiftlang/swift/tree/main/lib/SILGen)) lowers the type-checked AST into so-called “raw” SIL. The design of SIL is described in [docs/SIL.rst](https://github.com/swiftlang/swift/blob/main/docs/SIL.rst).
    
- **SIL guaranteed transformations**: The SIL guaranteed transformations (implemented in [lib/SILOptimizer/Mandatory](https://github.com/swiftlang/swift/tree/main/lib/SILOptimizer/Mandatory)) perform additional dataflow diagnostics that affect the correctness of a program (such as a use of uninitialized variables). The end result of these transformations is “canonical” SIL.
    
- **SIL optimizations**: The SIL optimizations (implemented in [lib/SILOptimizer/Analysis](https://github.com/swiftlang/swift/tree/main/lib/SILOptimizer/Analysis), [lib/SILOptimizer/ARC](https://github.com/swiftlang/swift/tree/main/lib/SILOptimizer/ARC), [lib/SILOptimizer/LoopTransforms](https://github.com/swiftlang/swift/tree/main/lib/SILOptimizer/LoopTransforms), and [lib/SILOptimizer/Transforms](https://github.com/swiftlang/swift/tree/main/lib/SILOptimizer/Transforms)) perform additional high-level, Swift-specific optimizations to the program, including (for example) Automatic Reference Counting optimizations, devirtualization, and generic specialization.
    
- **LLVM IR generation**: IR generation (implemented in [lib/IRGen](https://github.com/swiftlang/swift/tree/main/lib/IRGen)) lowers SIL to [LLVM IR](http://llvm.org/docs/LangRef.html), at which point [LLVM](http://llvm.org/) can continue to optimize it and generate machine code.



---





