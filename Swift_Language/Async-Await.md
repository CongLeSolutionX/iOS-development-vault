---
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/proposals/0296-async-await.md"
created: 2024-12-31 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


Below is a breakdown of the diagrams I will create, aligning with [the original proposal documentation's structure of Async/Await in Swift](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0296-async-await.md):

It's a comprehensive explanation of the feature, its motivations, and its implications.

---


# Diagram 1: Problems with Completion Handlers

This diagram explains issues with completion handlers, setting the stage for the introduction of `async/await`.


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph "Motivation: Completion Handlers"
    A[Problem: Pyramid of Doom] --> B(Deeply Nested Closures);
    B --> C{Difficult to Read/Track};
    
    D[Problem: Error Handling] --> E(Verbose Error Handling);
    E --> F{"Repetitive 'guard' or 'do-catch' "};
    
    G[Problem: Conditional Execution] --> H(Inverted Code Structure);
    H --> I{Hard to Reason About};

    J[Problem: Easy to Make Mistakes] --> K(Forgetting Completion Handlers);
    K --> L{"Bailing Out Early/Not Returning"};    
    
     M[Problem: Synchronous APIs] --> N(Too many synchronous block APIs);
    N --> O{"Performance & Responsiveness Problems"}

    end
    
style A fill:#f19f,stroke:#333,stroke-width:2px
style D fill:#f19f,stroke:#333,stroke-width:2px
style G fill:#f19f,stroke:#333,stroke-width:2px
style J fill:#f19f,stroke:#333,stroke-width:2px
style M fill:#f19f,stroke:#333,stroke-width:2px

```

---

# Diagram 2: Async/await Solution

This diagram explains how `async/await` solves the problems and simplifies asynchronous code.


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A["Proposed Solution: <br> async/await"] --> B(Asynchronous Code as Straight-Line Code);
    B --> C{Normal Control Flow};
    C --> D(Fewer Errors);
    D --> E[Better Performance];
    E --> F{Better Tooling};
    F --> G[Future Concurrency];
    
    subgraph Async_Function_Analogy["Async Function Analogy"]
        style Async_Function_Analogy fill:#c1295,stroke:#333,stroke-width:2px
        H[Sync Function] --> I(Calls Complete Immediately);
        I --> J(Uses Thread & Stack);
        
        K[Async Function] --> L(Can Give Up Thread);
        L --> M(Own Separate Storage);
    end
    
    subgraph Suspension_Points["Suspension Points"]
        style Suspension_Points fill:#c192,stroke:#333,stroke-width:2px
        N[Suspension Points] --> O{Explicit event in function};
        O --> P(Call to async functions);
        P --> Q(Enclosed in 'await' Expression);
        Q --> R[Potential Suspension Points];    
    end

style A fill:#c1cf,stroke:#333,stroke-width:2px
style N fill:#c1cf,stroke:#333,stroke-width:2px

```

# Diagram 3: Detailed Design

This diagram explains technical details about asynchronous functions: their declarations, types, `await` expressions, closures, overloading, autoclosures, and protocol conformance.


---
```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    %% Note over B syntax does not support in Mermaid yet
    A[Async Function Declaration] --> B(" 'func myFunction() async -> Int' "); 
    B --> C(Explicit `async` Keyword);
    C --> D(Part of Function Type);

    E[Async Function Types] --> F(Distinct from Synchronous);
    F --> G("Implicit Conversion <br> (Sync -> Async)");    
	
    H[Await Expressions] --> I(" 'await myFunctionCall()' ");
    I --> J(Potential Suspension Point);
    J --> K("Must be Within 'async' Context");

	L[Closures] --> M(" '{ () async -> Int in ... }' ");
    M --> N("Explicit 'async' keyword");
    N --> O("Inferred to be 'async' ");
    
    P[Overloading] --> Q(Prefer Sync in Sync Context);
    Q --> R(Prefer Async in Async Context);
    R --> S("Requires 'await' for Async Calls");
    
    T[Autoclosures] --> U("No 'async' autoclosures");
    U --> V("Unless function is itself 'async' ");

    W[Protocol Conformance] --> X(Async Requirement);
    X --> Y(Satisfied by Async or Sync Function);
    Y --> Z(Sync Requirement not satisfied by Async Function);
    

style A fill:#c1ff,stroke:#333,stroke-width:1.5px;
style E fill:#c1ff,stroke:#333,stroke-width:1.5px;
style H fill:#c1ff,stroke:#333,stroke-width:1.5px;
style L fill:#c1ff,stroke:#333,stroke-width:1.5px;
style P fill:#c1ff,stroke:#333,stroke-width:1.5px;
style T fill:#c1ff,stroke:#333,stroke-width:1.5px;
style W fill:#c1ff,stroke:#333,stroke-width:1.5px;

```

---


# Diagram 4: Compatibility & Future
This diagram explains source and ABI compatibility, API resilience, and the potential future direction of `reasync`.


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Source Compatibility] --> B("Contextual Keywords: 'async', 'await' ");
    B --> C("Limited Source Break: 'await' function calls");
    
    D[ABI Stability] --> E(Additive to ABI);
    E --> F(No effect);

    G[API Resilience] --> H(Not Resilient);
    H --> I("Addition/Removal of 'async' is a breaking change"); 
     
    J[Future Directions] --> K(" 'reasync' ");
    K --> L("Potentially for functions like 'map', optionals' '??' ");
    L --> M("Requires careful design due to ABI issues and potential concurrency implementation for map");

style A fill:#a1fa,stroke:#333,stroke-width:1.5px
style D fill:#a1fa,stroke:#333,stroke-width:1.5px
style G fill:#a1fa,stroke:#333,stroke-width:1.5px   
style J fill:#a1fa,stroke:#333,stroke-width:1.5px

```

---


# Diagram 5: Alternatives
This diagram explains the alternatives that were considered and the reasons for rejection.


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Alternatives Considered] --> B(" 'await' Implies 'try' ");
    B --> C("Rejected, 'await' for suspension, 'try' for errors");
    
    A --> D(Launching Async Tasks);
     D --> E(Addressed in Structured Concurrency);

    A --> F(" 'await' as Syntactic Sugar");
    F --> G("Rejected, no Future type, no overload, perf issues");

style A fill:#f1aa,stroke:#333,stroke-width:1.5px;

```

---

# Summary

**Key Concepts Illustrated:**

*   **Problems with Completion Handlers:** The "pyramid of doom," error handling challenges, conditional execution complexity, easy mistakes, and the prevalence of synchronous APIs.
*   **Async/await as a solution:**  How it simplifies async code, enabling straight-line coding with normal control flow, better performance and tooling, and a foundation for concurrency.
*   **Core Features:** Async functions, suspension points, await expressions, async closures , overloading, `reasync`, and protocol conformance.
* **ABI & API effects:** No ABI impact and the API resilience impacts.
*   **Alternatives:** The rationale behind not making `await` imply `try`, and the rejection of a syntactic sugar approach to async/await.


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---