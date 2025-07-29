---
source_url: "https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/ReferenceManual/LexicalStructure.md"
created: 2025-02-04 11:50:26
author: NA
version: NA
license(s): NA
copyright: NA
---


> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


The document on Swift's [Lexical Structure](https://github.com/swiftlang/swift-book/blob/main/TSPL.docc/ReferenceManual/LexicalStructure.md) describes the basic building blocks of the Swift language - tokens - and how they are formed from characters.

To visually represent this, I'll use a variety of Mermaid diagrams, focusing on flowcharts and mind maps to illustrate the parsing process and categorize different lexical elements. 

Here's a breakdown of diagrams to cover the article's content:



----
# Diagram 1: Lexical Structure Overview (Mind Map)

```mermaid
---
config:
  theme: forest
---
mindmap
  root((Swift Lexical Structure))
    centralisation(Characters to Language)
    centralisation --> A[Source File]
    centralisation --> B[Lexical Analysis]
    centralisation --> C[Tokens]
    centralisation --> D[Syntax Analysis]
    centralisation --> E[Language Structure]
    
    A --> F(Sequence of Characters)
    B --> G(Longest Match, Maximal Munch)
    C --> H(Identifiers)
    C --> I(Keywords)
    C --> J(Punctuation)
    C --> K(Literals)
    C --> L(Operators)
    D --> M(Grammar Rules)
    E --> N(Executable Code)
    
```



This mind map provides a high-level view of the lexical structure process in Swift, starting from the source file and progressing to the final language structure. It highlights the central role of lexical analysis in converting characters into tokens, which are then used for syntax analysis.

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
    CMA["Single-line '//'"];
    CMA1["Until Line Break<br>(U+000A/U+000D)"];
    CMB["Multi-line '/* ... */'"];
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
    style Whitespace fill:#32e4,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        W --> WA
        W --> WB
        W --> WC
        W --> WD
        W --> WE
        W --> WF
        W --> WG
    end
    
    subgraph Comments
    style Comments fill:#e314,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
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



This flowchart illustrates the Swift compiler's handling of whitespace and comments during lexical analysis. It shows that both are essentially treated as separators and ignored for the purpose of tokenization, except for their role in operator disambiguation. The diagram details types of whitespace and comment syntax.

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
    C{"Letter (A-Z, a-z)?"};
    D{"Underscore '_'?"};
    E{"Unicode BMP Non-Combining?"};
    F{"Unicode Outside BMP<br>(Not Private Use)?"};
    G["Valid Head"];
    
    H["Invalid Start"];
    
    I{"Subsequent Characters?"};
    J{"Digit (0-9)?"};
    K{"Combining Unicode?"};
    L{"Identifier Head Chars?"};
    
    M["Valid Character"];
    
    N["Identifier Complete"];
    
    O["Check for Reserved Words"];
    
    P{"Is Reserved Word?"};
    Q{"Backticks?<br>\'word\'"};
    
    S["Valid Identifier"];
    
    R["Invalid Identifier<br>(Unless Backticked)"];
    
    T["End:<br>Identifier Token"];

    SI["Special Identifiers"];
    SIA["Underscore Prefix"];
    SIA1["Internal Convention"];
    SIB["Double Underscore Prefix"];
    SIB1["Reserved for Compiler/Stdlib"];
    SIC["Implicit Parameters<br>'$0', '$1', ..."];
    SID["Property Wrapper Projection<br>'$variable'"];
    
    A --> B
    B --> C
    B --> D
    B --> E
    B --> F
    C -- Yes --> G
    D -- Yes --> G
    E -- Yes --> G
    F -- Yes --> G
    B -- No --> H
    G --> I
    I --> J
    I --> K
    I --> L
    J -- Yes --> M
    K -- Yes --> M
    L -- Yes --> M
    I -- No --> N
    M --> I
    N --> O
    O --> P
    P -- Yes --> Q
    P -- No --> S
    Q -- Yes --> S
    Q -- No --> R
    O -- No --> S
    S --> T
    R --> T
    H --> T

    S --> SI

    subgraph Special_Identifiers["Special Identifiers"]
    style Special_Identifiers fill:#3293,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        SI --> SIA
        SIA --> SIA1
        SI --> SIB
        SIB --> SIB1
        SI --> SIC
        SI --> SID
        style SI fill:#2229,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    end
   

  classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
  class A,T Start_and_End_Point;

  classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
  class B,C,D,E,F,I,J,K,L,P,Q Decision_Point

  classDef No_Choice fill:#f998,stroke:#33,stroke-width:2px;
  class H,N,S,R No_Choice;

  classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
  class G,M Yes_Choice;

```


This flowchart details the rules for forming valid Swift identifiers. It covers the allowed starting and subsequent characters, handling of reserved words (with backticks), and highlights special identifier types like those for implicit parameters and property wrapper projections.  It visually represents the decision process the compiler uses to identify tokens as valid identifiers.

---

# Diagram 4: Keywords and Punctuation (Mind Map)

```mermaid
---
config:
  look: handDrawn
  theme: default
---
mindmap
  root(("Keywords and Punctuation"))
    Keywords
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
    Punctuation_Reserved["Punctuation [Reserved]"]
      P1["( ) Parentheses"]
      P2["{ } Braces"]
      P3["[ ] Brackets"]
      P4[. Dot]
      P5[, Comma]
      P6[: Colon]
      P7[; Semicolon]
      P8[= Equal]
      P9[@ At Sign]
      P10[# Number Sign]
      P11[& Prefix Ampersand]
      P12[-> Arrow]
      P13[\` Backtick]
      P14[? Question Mark]
      P15[! Postfix Exclamation]
   
```



This mind map categorizes Swift keywords based on their usage context: declaration, statement, expression & type, pattern, number sign keywords, and context-specific keywords. It also lists reserved punctuation marks. This representation offers a structured overview of these essential lexical elements, making it easy to grasp their variety and purpose.



To make a nicer view for the mindmap, I break down the keyword graph into a separate mindmap below: 


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


---

# Diagram 5: Literals (Mind Map)


```mermaid
---
config:
  look: handDrawn
  theme: default
---
mindmap
  root((Literals))
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



This comprehensive mind map breaks down Swift literals by type: Integer, Floating-point, String, Regular Expression, Boolean, and Nil. For each literal type, it details the syntax variations, default inferred type, and the relevant `ExpressibleBy` protocol from the Swift standard library. This diagram is designed to serve as a quick reference guide for understanding different types of literals and their properties in Swift.

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
    D{"Followed by Dot `.`?"};
    E{"Followed by `(` `[` `{`?"};
    F["Infix Operator"];
    G["Postfix Operator"];
    H{"Followed by `)` `]` `}`?"};
    I{"Followed by `,` `;` `:`?"};
    J["Prefix Operator"];
    K["Infix Operator"];

    L["End:<br>Operator Token<br>(Infix)"];
    M["End:<br>Operator Token<br>(Postfix)"];
    N["End:<br>Operator Token<br>(Prefix)"];


    A --> B
    B -- Yes --> C
    B -- No --> D
    B -- No --> E
    C -- Yes --> F
    C -- No --> G
    D -- Yes --> G
    D -- No --> H
    H -- Yes --> G
    H -- No --> I
    I -- Yes --> G
    I -- No --> J
    E -- Yes --> J
    E -- No --> K
    
    F --> L
    G --> M
    J --> N
    K --> L

    OC["Start Characters"];
    %% The full list of characters is this OCA[`/`, `=`, `-`, `+`, `!`, `*`, `%`, `<`, `>`, `&`, `|`, `^`, `~`, `?`"];
    %% Below is a concise version without special characters to avoid parsing error in Mermaid syntax
    OCA["/, =, -, +, !, *, %, <, >, &, |, ^, ~, ?"];
    OCB["Unicode from Math Symbols, Misc Symbols, Dingbats blocks"];

    OC_dot["Dot Operator Start"];
    OCD[`.`];
    OCE["Can contain more dots"];
    OCF["Combining Unicode<br>(after first char)"];
    
    subgraph Operator_Characters["Operator Characters"]
    style Operator_Characters fill:#119,stroke:#333,stroke-width:2px;
        OC --> OCA
        OC --> OCB
        OC_dot --> OCD
        OC_dot --> OCE
        OC --> OCF
        style OC fill:#e3e9,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
        style OC_dot fill:#e3e9,stroke:#333,stroke-width:1px,stroke-dasharray:5 5
    end
    
    F --> OC
    G --> OC
    J --> OC
    
    OC_dot --> L
    OC --> M
    OC --> N

    classDef Start_and_End_Point fill:#1919,stroke:#333,stroke-width:2px;
    class A,L,M,N Start_and_End_Point;

    classDef Decision_Point fill:#9398,stroke:#333,stroke-width:2px;
    class B,C,D,E,H,I Decision_Point

    classDef No_Choice fill:#f998,stroke:#33,stroke-width:2px;
    class G,J,K No_Choice;

    classDef Yes_Choice fill:#f118,stroke:#33,stroke-width:2px;
    class F,G,J Yes_Choice;
    
```

This diagram combines a flowchart explaining how Swift determines if an operator is infix, prefix, or postfix based on whitespace rules, with a 'character set' subgraph detailing valid characters for custom operators. The flowchart visualizes the decision process based on whitespace around the operator. The character set provides a reference for allowed operator head characters (ASCII and Unicode ranges) and the special case of dot operators.



---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---