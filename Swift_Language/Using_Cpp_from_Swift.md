---
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/visions/using-c%2B%2B-from-swift.md"
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

Below is a breakdown of the diagrams I will create, aligning with [the original proposal documentation Using C++ from Swift](https://github.com/swiftlang/swift-evolution/blob/main/visions/using-c%2B%2B-from-swift.md):

---


# Overall Structure

First, let's outline the overall structure of the document and how we will approach its visual representation:

```mermaid
graph LR
    A[C++ and Swift Interoperability Vision] --> B(Introduction);
    A --> C(Goals);
    A --> D(The Approach);
    D --> DA(Importing Types);
    DA --> DAA(Reference Types);
    DAA --> DAAA(Criteria for Importing as Reference Type);
    DAA --> DAAB(Object Management);
    DA --> DAB(Value Types);
	    DAB --> DABA(Simple Data Types);
        DAB --> DABB(Self-Contained Types);
        DAB --> DABC(View Types);
    
    D --> DAC(Projections);
    D --> DAD(Iterators);
    D --> DAE(Mutability);
    D --> DAF(Computed Properties);
    D --> DAG(Templates and Generic APIs);
    A --> E(The Standard Library);
    E -->  EA(C++ Standard Library Overlay);
    E -->  EB(Swift Interop Specific APIs);

    A --> F(Evolution);
    A --> G(Tooling and Build Process);
    A --> H(Appendix 1: Examples and Definitions);
    A --> I(Appendix 2: Lifetime and Safety of Self-Contained Types and Projections);
    
```

This diagram gives a roadmap for the following detailed sections.

---

# 1. Goals

The core goals of C++ and Swift interop as described in the document, highlighting the overarching aim of safety and idiomatic use:

```mermaid
graph LR
    A[Goals of C++ Interop] --> B(Safe Import of C++ APIs);
    B --> C(Preserve Swift's Memory Safety);
    B --> D(Avoid inheriting C++'s unsafety);
    A --> E(Idiomatic Usage of C++ APIs);
    E --> F(Natural Swift API feel);
    E --> G(Fit Swift's idioms);
    A --> H(Eliminate Bridging Layers);
    H --> I(No C or Obj-C bridging);
    A --> J(Incremental Adoption);
    J --> K(File-by-file interoperability);
```

This shows how the interop tries to strike a balance between safety, usability and practicality.

---

# 2. The Approach: API Patterns

This section explains the core strategy of finding the right API pattern to map C++ apis:

```mermaid
graph LR
    A[The Approach] --> B(Recognize C++ API Patterns);
    B --> C(Semantic Analysis/Annotations);
    B --> D(Heuristics for common patterns);
    C --> E(Guide the importer);
    D --> F(Try to recognize correct patterns);
    A --> G(Map patterns to Swift);
    G --> H(Automatic mapping for known patterns);
    G --> I(User annotation where inference is not possible);
    A --> J(Decline importing when no suitable pattern);

    style B fill:#f19f,stroke:#333,stroke-width:2px
    style C fill:#c1cf,stroke:#333
    style D fill:#c1cf,stroke:#333
    style G fill:#c1cf,stroke:#333
    style J fill:#c1cf,stroke:#333
    
```

This illustrates the fundamental approach of the interop.

---

# 3. Importing Types

Here's how the document describes importing types, with a focus on reference and value types:

```mermaid
graph LR
    A[Importing Types] --> B(Reference Types);
    B --> C(Managed);
    C --> D(ARC);
    B --> E(Unmanaged);
    E --> F(Manual Memory Management);
    
    B --> G(Imortal);
    G --> GA(Unmanaged classes only);

	B --> H(Unique);
    H --> HA(using raw pointers or std::unique_ptr);
    H --> HB(managed with Swift noncopyable features);

    B --> I(Shared);
	I --> IA(Reference-counted: std::shared_ptr);
    IA --> IAA(Intrusive);
	IA --> IAB(Non-intrusive);

    A --> J(Value Types);
    J --> K(Simple data types);
    K --> KA(fundamental types, no pointers);
    J --> L(Self-contained types);
    L --> LA(Internally managed pointers);
    J --> M(View types);
    M --> MA(Not self-contained, pointers to unowned memory);  
    style B fill:#f19f,stroke:#333,stroke-width:2px;
    style J fill:#f19f,stroke:#333,stroke-width:2px;
    style C fill:#c1cf,stroke:#333;
    style E fill:#c1cf,stroke:#333;
    style G fill:#c1cf,stroke:#333;
    style H fill:#c1cf,stroke:#333;
    style I fill:#c1cf,stroke:#333;

    style K fill:#c1cf,stroke:#333;
    style L fill:#c1cf,stroke:#333;
    style M fill:#c1cf,stroke:#333;
    
```

This shows the distinctions in types and their memory management implications.

---

# 4. Reference Type Criteria

The following diagram breaks down the criteria for a C++ type to be imported as a Swift `class` (reference type):

```mermaid
graph LR
	A[Reference Type Criteria] --> B(Object Identity as part of value?);
	A --> C(Polymorphic Class?);
	C  --> CA(Having Virtual Methods);

	A --> D(Passed Around By Reference?);
	D --> DA(Raw Pointers/References);
	D --> DB(Smart Pointers);

style B fill:#c1cf,stroke:#333
style C fill:#c1cf,stroke:#333
style D fill:#c1cf,stroke:#333

```

This will help developers understand how the choice between value and reference type is made by the compiler.

---

# 5. Projections

Here we illustrate projections, which are ways of extracting views of data in C++:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Projections] --> B(Common Pattern: Method returns ref/ptr to memory dependent on 'this')
    B --> C("Example: const std::string& getName() const { return this->_name; }")

    A --> D(Other projections cases)
    D --> DA(method returns a vector of internal pointers);
    DA --> GAA("std::vector<int *> OwnedType::projectsInternalStorage()");

    D --> DB(method fills in a pointer with 2 levels of indirection);
    DB --> GAB("void VectorLike::begin(int **out) { *out = data(); }")
    
    D --> DC(Global Functions);
    DC --> GACB(" int *begin(std::vector<int> *v) { return v->data(); }");


    style B fill:#c1cf,stroke:#333
    style D fill:#c1cf,stroke:#333
    
```


This shows that there are other use cases for projections, not just simple methods returning internal data.

---

# 6. Iterators

How iterators are handled in C++ interop is important, here's the diagram for that:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Iterators] --> B(C++ Iterators as Swift Sequences);
    B --> C(Idiomatic Swift Iterators);
    B --> D(Conform to the Sequence protocol);
    A --> E("Map C++ Range 'begin()'/'end()' ");
    A --> F(C++ APIs taking iterators can be problematic);
    
style B fill:#91ff,stroke:#333
style F fill:#f1cc,stroke:#333
    
```

This shows that C++ iterators will be adapted and integrated with Swift APIs.

---

# 7. Mutability

Mutability handling is a notable challenge with very different models in each language:
```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Mutability] --> B(C++: const is not fully reliable);
    B --> C(const can be casted away);
    B --> D(Mutability in the type system, can overload on const or non-const);

    A --> E(Swift: Immutability by default);
    E --> F(Swift enforces mutability with local information strictly);

    A --> G(Overloaded functions disambiguated in Swift);
    A --> H(Swift assumes C++ const correctness);

style B fill:#f1cc,stroke:#333
style E fill:#91ff,stroke:#333

```

This highlights the differences and how interop may enforce stricter rules on C++ const.

---

# 8. Computed Properties

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Computed Properties] --> B(Map C++ Getters/Setters)
    B --> C(Idiomatic way to handle this API)
    A --> D(Leverage safety and performance);
    D --> DA(Generalized accessors - yield storage safely)
    
```


This highlights how those can be used for a more performant and idiomatic code.

---

# 9. Templates and Generic APIs

The next diagram describes dealing with C++ templates:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Templates and Generic APIs] --> B(C++: Eager instantiation);
    B --> C(Template args type-checked at each use);
    A --> D(Swift: Type-checked on requirements);
    D --> E(Specializations may not always be possible);

    A --> F(Swift generics with C++ types works out-of-the-box);

    A --> G(Using C++ templates in Swift generics can be difficult);

    G --> GA(Significant language and implementation work)
    G --> GB(Ad-Hoc nature of constraint in C++)
    G --> H(May require user guidance / annotation);

style G fill:#f2cc,stroke:#333

```

This section clearly presents the limitations of interop with generic C++ templates

---

# 10. The Standard Library

This covers how the Swift standard library will play a role in interop

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Standard Library] --> B(Swift Overlay for C++ standard Library)
    B --> C(Assists in import of C++ APIs)
    B --> D(Provides helpful bridging utilities, range/iterator protocols, conversion to Swift types)
    A --> E(Swift APIs for interop, independent of C++ standard library);
    E --> F(Imported implicitly when C++ module is used);
    
```

This shows that Swift will try to assist in the process of bridging C++ std libraries.

---

# 11. Evolution

This section outlines an incremental approach to interop.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Evolution] --> B(Incremental Evolution);
    B --> C(Start with usable subset);
    B --> D(Formalize APIs over time);

    A --> E(Versioning Scheme);

    E --> F(Rapid deprecation as APIs evolve);
    E --> G(Independent of Swift compiler versions);

style B fill:#f1cf,stroke:#333

```

This emphasizes that the feature will be developed iteratively.

---

# 12. Tooling and Build Process

The following illustrates the tooling and build concerns:

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Tooling and Build Process] --> B(Support interop on all Swift platforms);
    A --> C(Update Swift ecosystem tools);
    C --> D(SourceKit: Autocompletion, jump-to-def);
    C --> E(lldb: Print C++ types in Swift);

    A --> F(SwiftPM support C++ dependencies);
    A --> G("Annotations - inline, side-file <br> (API Notes update or new file)");
    
```


This highlights how existing tools need enhancements for interop.

---

# 13. Appendix 1: Examples and Definitions

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Appendix 1: <br> Examples and Definitions] --> B(Reference Types);
    B --> BA("Pointer or references to some object");
    B --> BB("When copied, the pointer value is copied not the storage");
    B --> BC(Represent non copyable types in C++);
    
    B --> BD("'LLVM::Instruction', 'Qt::QWidget' classes");
    A --> C(Manually managed reference types);
    C --> CA("Large objects that are not meant to be copied, must be allocated on heap with create methods");
    
    A --> D(Immortal Reference Type);
    D --> DA("Exist for the duration of program, like pool allocators and various contexts");

    A --> E(Automatically Managed Reference Types);
    E --> EA("Reference-counted objects managed by Swift using retain and release or ARC");

    A --> F(Owned types);
    F --> FA("Owns storage that can be copied and destroyed, copy constructor must copy and destructor must destroy, should have no side effects.");
    F --> FB(" 'std::vector' and 'std::string' ");

    A --> G(Trivial Types);
    G --> GA("Subset of owned types.  Copy by copying bits. No special destruction. 'std::pair<int,int>' and 'std::array' are trivial types");
    A--> H(Pointer Types);
    H --> HA("Pointers or refs to unowned storage. 'std::span', 'std::string_view', int*, void* ");
    A --> I(Projections);
    I --> IA(" 'std::string::c_str()' ");
    
style B fill:#c1cf,stroke:#333;
style C fill:#c1cf,stroke:#333;
style D fill:#c1cf,stroke:#333;
style E fill:#c1cf,stroke:#333;
style F fill:#c1cf,stroke:#333;
style G fill:#c1cf,stroke:#333;
style H fill:#c1cf,stroke:#333;
style I fill:#c1cf,stroke:#333;

```

The first appendix expands on the definition and provides examples.


---

# 14. Appendix 2: Lifetime and Safety

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    A[Appendix 2: Lifetime and Safety] --> B(Problem - naively importing a self contained type, then projections);
    B --> C(Swift copies the value and creates a temporary before getting a pointer)
    C --> CA(results in a dangling pointer)
    B --> D(The issue is with subtly different lifetime models)

    A --> E(Swift cannot import unsafe projections of memory owning types);

    E --> EA(Compiler should infer API semantics, library author must specify via annotation);

    A --> F(Safety model of C++ does not fully work in Swift);

    F --> FA(Projecting from self contained types is very foreign to Swift)

    A --> G(Swift API model enforces safety in projections/accessors via ownership);

style B fill:#f1cc,stroke:#333

```

This appendix goes more in-depth on a specific problem related to safety.


---

