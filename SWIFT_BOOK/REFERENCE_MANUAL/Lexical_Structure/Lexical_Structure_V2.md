---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/ReferenceManual/LexicalStructure.md"
created: 2025-02-04 11:50:26
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




Below is a collection of enhanced diagrams and illustrations, which providing a more complete, clear, and effective visual representation of [Swift's Lexical Structure](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/ReferenceManual/LexicalStructure.md).

The diagrams and illustrations below are optimized versions of [their previous first versions in this doc](./Lexical_Structure_V1.md)

----


# Diagram 1: Lexical Structure Overview (Mind Map)


```mermaid
---
config:
  theme: dark
---
mindmap
  root((Swift Lexical Structure))
    overview(Process Overview:<br>Characters to Executable Code)
    overview --> A[Source File]
    overview --> B[Lexical Analysis Phase]
    overview --> C[Tokens]
    overview --> D[Syntax Analysis]
    overview --> E["Language Structure<br>(AST, etc.)"]
    overview --> F[Executable Code]

    A --> A1(Sequence of Characters)
    B --> B1(Longest Match / Maximal Munch)
    B --> B2(Whitespace &<br>Comment Handling)
    C --> C1["Identifiers <br> (e.g., `variableName`, `_internalFunc`)"]
    C --> C2["Keywords <br> (e.g., `class`, `func`, `if`)"]
    C --> C3["Punctuation <br> (e.g., `(`, `{`, `.`, `,`)"]
    %% C --> C4["Literals <br> (e.g., `42`, `"Hello"`, `/regex/`, `true`)"]
    C --> C5["Operators <br> (e.g., `+`, `-`, `*`, `/`, `+++`)"]
    D --> D1(Grammar Rules Application)
    E --> E1(Abstract Syntax Tree)
    F --> F1(Machine Code)

    %% style overview fill:#a2faff,stroke:#333,stroke-width:1px;
    %% style B fill:#ccf,stroke:#333,stroke-width:1px,stroke-dasharray: 5 5;
    %% style C fill:#ccf,stroke:#333,stroke-width:1px,stroke-dasharray: 5 5;
    %% style D fill:#ccf,stroke:#333,stroke-width:1px,stroke-dasharray: 5 5;
    %% style E fill:#ccf,stroke:#333,stroke-width:1px,stroke-dasharray: 5 5;
    %% style F fill:#ccf,stroke:#333,stroke-width:1px,stroke-dasharray: 5 5;
    
```

This enhanced mind map now provides a more structured process overview and richer context for each stage, especially for "Tokens," by giving concrete examples, making it easier to understand the role of lexical analysis in the broader compilation process.

---

# Diagram 2: Whitespace and Comments (Flowchart)


```mermaid
---
title: Whitespace and Comments
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TD
    A["Start:<br>Source File"];
    B{"Character Read"};
    C{"Is Whitespace?"};
    D["Ignore/Separator"];
    E{"Is Comment?"};
    F["Ignore<br>(Treat as Whitespace)"];
    G["Tokenize"];
    H["Continue Scanning"];
    I{"End of File?"};
    J["End:<br>Tokens Stream"];

    W["Whitespace Characters"];
    WA("U+0020 Space");
    WB("U+000A Line Feed");
    WC("U+000D Carriage Return");
    WD("U+0009 Horizontal Tab");
    WE("U+000B Vertical Tab");
    WF("U+000C Form Feed");
    WG("U+0000 Null");

    CM["Comments"];
    CMA["Single-line `//`"];
    CMA1["Until Line Break<br>(U+000A/U+000D)"];
    CMB["Multi-line `/* ... */`"];
    CMB1["Nested Allowed"];
    CMB2["Balanced Markers Required"];
    CMC["Treated as Whitespace"];


    A --> B
    B --> C

    C -- Yes --> D
    C -- No --> E
    C -- Yes --> W

    E -- Yes --> F
    E -- No --> G
    E -- Yes --> CM

    D --> H
    F --> H
    G --> H
    H --> I

    I -- No --> B
    I -- Yes --> J


    subgraph Whitespace
    style Whitespace fill:#c355,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        W --> WA
        W --> WB
        W --> WC
        W --> WD
        W --> WE
        W --> WF
        W --> WG
    end

    subgraph Comments
    style Comments fill:#c299,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        CM --> CMA
        CMA --> CMA1
        CM --> CMB
        CMB --> CMB1
        CMB --> CMB2
        CM --> CMC
    end

    classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
    class A,J Start_and_End_Point;

    classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
    class C,E,I Decision_Point

    classDef No_Choice fill:#f998,stroke:#33,stroke-width:2px;
    class B,G No_Choice;

    classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
    class D,F,W,CM Yes_Choice;

```

The flowchart is now more detailed and structured. The visual grouping of whitespace and comment characteristics in subgraphs enhances readability and makes it easier to grasp the specifics of how Swift handles these elements. The node styling further improves the flow visualization.

---

# Diagram 3: Identifiers (Flowchart)

```mermaid
---
title: Identifiers
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TB
    A["Start:<br>Identifier Scan"];
    B{"First Character?"};
    C{"Letter (A-Z, a-z) or Unicode Head Char?"};
    D{"Underscore `_` Initial?"};
    E{"Valid Identifier Head"};

    F["Invalid Start"];

    G{"Subsequent Character?"};
    H{"Digit (0-9), Combining Unicode, or Valid Head Char?"};
    I["Valid Identifier Character"];

    J["Identifier Complete"];

    K["Check for Reserved Words"];

    L{"Is Reserved Word?"};
    M{"Backticks? \`word\`"};

    N["Valid Identifier"];

    O["Invalid Identifier<br>(Unless Backticked)"];

    P["End:<br>Identifier Token"];

    SI["Special Identifiers"];
    SIA["Underscore Prefix"];
    SIA1["Internal Convention"];
    SIB["Double Underscore Prefix"];
    SIB1["Reserved for Compiler/Stdlib"];
    SIC["Implicit Parameters `$0`, `$1`, ..."];
    SID["Property Wrapper Projection `$variable`"];


    A --> B
    B -- Yes --> C
    B -- Yes --> D
    C -- Yes --> E
    D -- Yes --> E
    C -- No --> D
    D -- No --> F
    E --> G
    F --> P
    G --> H
    H -- Yes --> I
    H -- No --> J
    I --> G
    J --> K
    K --> L
    L -- Yes --> M
    L -- No --> N
    M -- Yes --> N
    M -- No --> O
    N --> SI
    N --> P
    O --> P
    E --> N

    subgraph Special_Identifiers["Special Identifiers"]
    style Special_Identifiers fill:#c3c3,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        SI --> SIA
        SIA --> SIA1
        SI --> SIB
        SIB --> SIB1
        SI --> SIC
        SI --> SID
        style SI fill:#e3e9,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    end


  classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
  class A,P Start_and_End_Point;

  classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
  class B,C,D,G,H,K,L,M Decision_Point

  classDef No_Choice fill:#f998,stroke:#33,stroke-width:2px;
  class F,J,N,O No_Choice;

  classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
  class E,I Yes_Choice;
  
```


This revised flowchart has a cleaner flow, improved decision point logic, and prominently highlights the special identifier cases within a subgraph.  It is now more effective in guiding someone through the process of validating Swift identifiers.

---

# Diagram 4: Keywords and Punctuation (Mind Map)

## Diagram 4a: Keywords (Mind Map)

```mermaid
---
config:
  look: handDrawn
  theme: dark
---
mindmap
  root(("Keywords"))
    Declaration_Keyword["Declaration Keywords"]
        A[associatedtype]
        B[borrowing]
        C[class]
        D[consuming]
        E[deinit]
        F[enum]
        G[extension]
        H[fileprivate]
        I[func]
        J[import]
        K[init]
        L[inout]
        M[internal]
        N[let]
        O[nonisolated]
        P[open]
        Q[operator]
        R[precedencegroup]
        S[private]
        T[protocol]
        U[public]
        V[rethrows]
        W[static]
        X[struct]
        Y[subscript]
        Z[typealias]
        Z1[var]
    Statement_Keywords["Statement Keywords"]
        SA[break]
        SB[case]
        SC[catch]
        SD[continue]
        SE[default]
        SF[defer]
        SG[do]
        SH[else]
        SI[fallthrough]
        SJ[for]
        SK[guard]
        SL[if]
        SM[in]
        SN[repeat]
        SO[return]
        SP[switch]
        SQ[throw]
        SR[where]
        SS[while]
    Expression_Type_Keywords["Expression/Type Keywords"]
        EA[Any]
        EB[as]
        EC[await]
        ED[catch]
        EE[false]
        EF[is]
        EG[nil]
        EH[rethrows]
        EI[self]
        EJ[Self]
        EK[super]
        EL[throw]
        EM[throws]
        EN[true]
        EO[try]
    Pattern_Keywords["Pattern Keywords"]
        PA["_ (Wildcard)"]
    Number_Sign_Keywords["Number Sign Keywords (`#`)"]
        NA[#available]
        NB[#colorLiteral]
        NC[#else]
        ND[#elseif]
        NE[#endif]
        NF[#fileLiteral]
        NG[#if]
        NH[#imageLiteral]
        NI[#keyPath]
        NJ[#selector]
        NK[#sourceLocation]
        NL[#unavailable]
    Context-Specific Keywords
        CA[associativity]
        CB[async]
        CC[convenience]
        CD[didSet]
        CE[dynamic]
        CF[final]
        CG[get]
        CH[indirect]
        CI[infix]
        CJ[lazy]
        CK[left]
        CL[mutating]
        CM[none]
        CN[nonmutating]
        CO[optional]
        CP[override]
        CQ[package]
        CR[postfix]
        CS[precedence]
        CT[prefix]
        CU[Protocol]
        CV[required]
        CW[right]
        CX[set]
        CY[some]
        CZ[Type]
        CZ1[unowned]
        CZ2[weak]
        CZ3[willSet]

```

## Diagram 4b: Punctuation (Mind Map)

```mermaid
---
config:
  look: handDrawn
  theme: dark
---
mindmap
  root(("Punctuation [Reserved Tokens]"))
      P1["( ) <br> Parentheses <br> (Grouping, function calls, etc.)"]
      P2["{ } <br> Braces <br> (Code blocks, closures, etc.)"]
      P3["[ ] <br> Brackets <br> (Arrays, subscripts, attributes)"]
      P4[". <br> Dot <br> (Member access)"]
      P5[", <br> Comma <br> (Separators in lists, tuples)"]
      P6[": <br> Colon <br> (Type annotations, dictionary literals)"]
      P7["; <br> Semicolon <br> (Statement separator - optional)"]
      P8["= <br> Equal <br> (Assignment)"]
      P9["@ <br> At Sign <br> (Attributes)"]
      P10["# <br> Number Sign <br> (Compiler directives, macros)"]
      P11["& <br> Prefix Ampersand <br> (Inout parameters)"]
      P12["-> <br> Arrow <br> (Function type return, closures)"]
      P13["\` <br> Backtick <br> (Escaping keywords as identifiers)"]
      P14["? <br> Question Mark <br> (Optional types, optional chaining, ternary)"]
      P15["! <br> Postfix Exclamation <br> (Forced unwrapping)"]
      
```


By separating Keywords and Punctuation, and creating dedicated mind maps for each, both become more focused and easier to read and understand. The descriptions added to punctuation nodes provide immediate context and function.

---

# Diagram 5: Literals (Mind Map)


```mermaid
---
config:
  look: handDrawn
  theme: dark
---
mindmap
  root(("Literals"))
    type_integer[Integer Literal]
      type_integer_syntax[Syntax]
        type_integer_syntax_decimal["Decimal<br>(digits 0-9)"]
        type_integer_syntax_binary["Binary<br>(0b prefix, 0-1)"]
        type_integer_syntax_octal["Octal<br>(0o prefix, 0-7)"]
        type_integer_syntax_hex["Hexadecimal<br>(0x prefix, 0-9, A-F)"]
        type_integer_syntax_negative["Negative (-) prefix"]
        type_integer_syntax_underscore["Underscores (_) for readability"]
        type_integer_syntax_leading_zeros["Leading zeros<br>(ignored)"]
      type_integer_default[Default Type]
        type_integer_default_int[Int]
      type_integer_protocol[Protocol]
        type_integer_protocol_expressible[ExpressibleByIntegerLiteral]
    type_float[Floating-Point Literal]
      type_float_syntax[Syntax]
        type_float_syntax_decimal["Decimal<br>(digits, ., e/E exponent)"]
        type_float_syntax_hex["Hexadecimal<br>(0x prefix, 0-9, A-F, ., p/P exponent)"]
        type_float_syntax_negative["Negative (-) prefix"]
        type_float_syntax_underscore["Underscores (_) for readability"]
        type_float_syntax_leading_zeros["Leading zeros<br>(ignored)"]
      type_float_default[Default Type]
        type_float_default_double[Double]
      type_float_protocol[Protocol]
        type_float_protocol_expressible[ExpressibleByFloatLiteral]
    type_string[String Literal]
      type_string_syntax[Syntax]
        type_string_syntax_single_line["Single-line<br>(\)"]
        type_string_syntax_multi_line["Multi-line<br>(\\)"]
        type_string_syntax_extended_delimiter["Extended Delimiter<br>(#\...\#, #\\\...\\\#)"]
        type_string_syntax_escape_sequences["Escape Sequences<br>(\\0, \\\\, \\t, \\n, \\r, \\\, \\', \\u{n})"]
        type_string_syntax_interpolation["Interpolation<br>(\\(expression))"]
      type_string_default[Default Type]
        type_string_default_string[String]
      type_string_protocol[Protocol]
        type_string_protocol_expressible_string[ExpressibleByStringLiteral]
        type_string_protocol_expressible_unicode["ExpressibleByUnicodeScalarLiteral<br>(single Unicode scalar)"]
        type_string_protocol_expressible_grapheme["ExpressibleByExtendedGraphemeClusterLiteral<br>(single grapheme cluster)"]
    type_regex[Regular Expression Literal]
      type_regex_syntax[Syntax]
        type_regex_syntax_slash["Slash Delimited<br>(/)"]
        type_regex_syntax_extended_delimiter["Extended Delimiter<br>(#/.../#, #/\n...\n/#)"]
        type_regex_syntax_multiline[Multiline with Extended Delimiter]
      type_regex_default[Default Type]
        type_regex_default_regex[Regex]
      type_regex_protocol[Protocol]
        type_regex_protocol_none["None<br>(No Default Protocol Mentioned)"]
    type_boolean[Boolean Literal]
      type_boolean_syntax[Syntax]
        type_boolean_syntax_true[true]
        type_boolean_syntax_false[false]
      type_boolean_default[Default Type]
        type_boolean_default_bool[Bool]
      type_boolean_protocol[Protocol]
        type_boolean_protocol_expressible[ExpressibleByBooleanLiteral]
    type_nil[Nil Literal]
      type_nil_syntax[Syntax]
        type_nil_syntax_nil[nil]
      type_nil_default[Default Type]
        type_nil_default_optional["Optional<br>(implicitly inferred)"]
      type_nil_protocol[Protocol]
        type_nil_protocol_expressible["ExpressibleByNilLiteral<br>(not recommended directly)"]

    %% style Literals fill:#ccf,stroke:#333,stroke-width:1px
    %% style type_integer fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    %% style type_float fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    %% style type_string fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    %% style type_regex fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    %% style type_boolean fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    %% style type_nil fill:#eee,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
```

The restructured Literals mind map is now much more organized and easier to navigate. The consistent branch structure and expanded details under "Syntax" make it a more effective reference for understanding Swift literals.

---

# Diagram 6: Operators (Flowchart and Character Set)

```mermaid
---
title: Operators
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart TB
    A["Start:<br>Operator Scan"];
    B{"Whitespace Left?"};
    C{"Whitespace Right?"};
    D{"Followed by Dot '.'?"};
    E["Infix Operator"];
    F["Postfix Operator"];
    G["Prefix Operator"];


    H["End:<br>Operator Token<br>(Infix)"];
    I["End:<br>Operator Token<br>(Postfix)"];
    J["End:<br>Operator Token<br>(Prefix)"];


    A --> B
    B -- Yes --> C
    B -- No --> D
    C -- Yes --> E
    C -- No --> F
    D -- Yes --> F
    D -- No --> G

    E --> H
    F --> I
    G --> J


    OC["Operator Start Chars"];
    OCA["ASCII:<br>/=+-!*%<> &|^~?"];
    OCB["Unicode:<br>Math, Symbols, Dingbats"];

    OC_dot["Dot Operator Start"];
    OCD[".<br>(Can have more dots)"];


    OC_combine["Combining Unicode<br>(after 1st char)"];

    subgraph Operator_Characters["Operator Characters"]
    style Operator_Characters fill:#c339,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        OC --> OCA
        OC --> OCB
        OC_dot --> OCD
        OC --> OC_combine
        style OC fill:#e13,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        style OC_dot fill:#e39,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    end

    E --> OC
    F --> OC
    G --> OC
    OC --> OC_dot
    OC --> H
    OC --> I
    OC --> J


    classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
    class A,H,I,J Start_and_End_Point;

    classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
    class B,C,D Decision_Point

    classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
    class E,F,G Yes_Choice;
    
```


The optimized Operators diagram now offers a more direct and understandable flowchart for operator type classification based on whitespace. The enhanced "Operator Characters" subgraph provides richer detail and clarity about valid characters for custom operators.


---
