---
source_url: "https://github.com/swiftlang/swift/blob/main/lib/Parser/Parser.cpp"
created: 2025-01-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---


Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift/blob/main/lib/Parse/Parser.cpp):

---




Here's a breakdown of the steps:

1. **Identify Core Classes and Structures:** Look for key classes like `Parser`, `Lexer`, `SourceFile`, `Token`, etc., and their relationships.
2. **Visualize Parsing Process:**  Represent the flow of parsing, including tokenization and AST construction.
3. **Illustrate Key Methods and Functions:**  Pick out important functions and their roles in the parsing process.
4. **Represent Data Flow:** Depict how data, like tokens and AST nodes, moves between different parts of the parser.
5. **Choose Appropriate Mermaid Diagram Types:** Select diagram types that best represent the information (e.g., class diagrams, flowcharts, state diagrams).
6. **Create Mermaid Code:** Translate the identified components and relationships into Mermaid syntax.

```mermaid
%% ---
%% config:
%%   layout: elk
%%   look: handDrawn
%%   theme: dark
%% ---
graph LR
    subgraph Lexing Process
        A[Lexer] --> B{Tokenize Source Code};
        B --> C(Token Stream);
        direction LR
    end

    subgraph Parsing Process
        D[Parser] --> E{Consume Tokens};
        E --> F{"Build Abstract Syntax Tree <br> (AST)"};
        F --> G(AST Nodes);
        direction LR
    end

    C -- Feeds Tokens to --> E
    
```

---



```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
classDiagram
    class Parser {
        -SourceManager SourceMgr
        -DiagnosticEngine Diags
        -SourceFile& SF
        -Lexer* L
        -SILParserStateBase* SIL
        -DeclContext* CurDeclContext
        -ASTContext& Context
        -ConsumeTokenReceiver* TokReceiver
        -PersistentParserState* State
        -std::optional<StableHasher> CurrentTokenHash
        -Token Tok
        -SourceLoc PreviousLoc
        -SmallVector<Token, 4> SplitTokens
        --
        +Parser(unsigned BufferID, SourceFile &SF, SILParserStateBase *SIL, PersistentParserState *PersistentState)
        +~Parser()
        +isInSILMode() bool
        +isDelayedParsingEnabled() bool
        +shouldEvaluatePoundIfDecls() bool
        +allowTopLevelCode() bool
        +isInMacroExpansion(SourceLoc loc) bool
        +peekToken() const Token&
        +discardToken() SourceLoc
        +consumeTokenWithoutFeedingReceiver() SourceLoc
        +recordTokenHash(StringRef token) void
        +consumeExtraToken(Token Extra) void
        +consumeToken() SourceLoc
        +getEndOfPreviousLoc() SourceLoc
        +consumeAttributeLParen() SourceLoc
        +consumeIfAttributeLParen() bool
        +consumeStartingCharacterOfCurrentToken(tok Kind, size_t Len) SourceLoc
        +markSplitToken(tok Kind, StringRef Txt) void
        +consumeStartingLess() SourceLoc
        +consumeStartingGreater() SourceLoc
        +startsWithEllipsis(Token Tok) bool
        +consumeStartingEllipsis() SourceLoc
        +skipSingle() ParserStatus
        +skipUntil(tok T1, tok T2 = tok::NUM_TOKENS) ParserStatus
        +skipUntilAnyOperator() void
        +skipUntilGreaterInTypeList(bool protocolComposition) SourceLoc
        +skipUntilDeclRBrace() void
        +skipListUntilDeclRBrace(SourceLoc startLoc, tok T1, tok T2) void
        +skipUntilDeclRBrace(tok T1, tok T2) void
        +skipUntilConditionalBlockClose() void
        +skipUntilTokenOrEndOfLine(tok T1, tok T2 = tok::NUM_TOKENS) bool
        +parseEndIfDirective(SourceLoc &Loc) bool
        +parseIdentifier(Identifier &Result, SourceLoc &Loc, DiagRef D, bool diagnoseDollarPrefix = true) bool
        +parseSpecificIdentifier(StringRef expected, SourceLoc &loc, DiagRef D) bool
        +parseAnyIdentifier(Identifier &Result, SourceLoc &Loc, DiagRef D, bool diagnoseDollarPrefix = true) bool
        +parseToken(tok K, SourceLoc &TokLoc, DiagRef D) bool
        +parseMatchingToken(tok K, SourceLoc &TokLoc, DiagRef ErrorDiag, SourceLoc OtherLoc) bool
        +parseUnsignedInteger(unsigned &Result, SourceLoc &Loc, DiagRef D) bool
        +getLocForMissingMatchingToken() const SourceLoc
        +getErrorOrMissingLoc() const SourceLoc
        +parseListItem(ParserStatus &Status, tok RightK, SourceLoc LeftLoc, SourceLoc &RightLoc, bool AllowSepAfterLast, llvm::function_ref<ParserStatus()>) ParseListItemResult
        +parseList(tok RightK, SourceLoc LeftLoc, SourceLoc &RightLoc, bool AllowSepAfterLast, DiagRef ErrorDiag, llvm::function_ref<ParserStatus()>) ParserStatus
        +getStringLiteralIfNotInterpolated(SourceLoc Loc, StringRef DiagText) std::optional<StringRef>
        +parseTopLevelItems(SmallVector<ASTNode, 128>& items) void
        +takeTokenReceiver() ConsumeTokenReceiver*
        +recordTokenHash(StringRef token) void
    }
    class Lexer {
        -LangOptions LangOpts
        -SourceManager& SM
        -unsigned BufferID
        -DiagnosticEngine* Diags
        -LexerMode Mode
        -HashbangMode Hashbang
        -CommentRetentionMode RetainComments
        -unsigned CurrentBufferOffset
        -unsigned EndBufferOffset
        --
        +Lexer(const LangOptions &LangOpts, const SourceManager &SM, unsigned BufferID, DiagnosticEngine *Diags, LexerMode Mode, HashbangMode Hashbang, CommentRetentionMode RetainComments, unsigned Offset = 0, unsigned EndOffset = 0)
        +~Lexer()
        +lex(Token &Result) void
        +peekNextToken() const Token&
        +getBufferID() unsigned
        +getStateForBeginningOfTokenLoc(SourceLoc Loc) State
        +restoreState(const State &Saved) void
        +cutOffLexing() void
        +getStringLiteralSegments(const Token &Tok, SmallVectorImpl<StringSegment> &Result, DiagnosticEngine *Diags = nullptr) void
        +lexingCutOffOffset() std::optional<unsigned>
        +isMultilineStringLiteral(const Token &Tok) bool
    }
    class SourceFile {
        -ModuleDecl &ParentModule
        -SourceFileKind Kind
        -unsigned BufferID
        -ParsingOptions Options
        -ASTContext &Ctx
        -std::optional<SourceLoc> InterfaceHashSourceLoc
        -std::optional<Fingerprint> InterfaceHash
        -std::unique_ptr<PersistentParserState> DelayedState
        -std::unique_ptr<ASTScope> Scope
        -std::unique_ptr<std::vector<Token>> CollectedTokens
        --
        +SourceFile(ModuleDecl &ParentModule, SourceFileKind Kind, unsigned BufferID, ParsingOptions Options)
        +~SourceFile()
        +getASTContext() ASTContext&
        +getBufferID() unsigned
        +getParsingOptions() const ParsingOptions&
        +isScriptMode() bool
        +hasDelayedBodyParsing() bool
        +shouldCollectTokens() bool
        +hasInterfaceHash() bool
        +getDelayedParserState() PersistentParserState*
        +clearScope() void
        +addTopLevelDecl(Decl *D) void
        +getCollectedTokens() std::optional<ArrayRef<Token>>
    }
    class Token {
        -tok::TokenKind Kind
        -SourceLoc Loc
        -StringRef Text
        --
        +Token()
        +Token(tok::TokenKind kind, SourceLoc loc, StringRef text)
        +getKind() tok::TokenKind
        +setKind(tok::TokenKind kind) void
        +getLoc() SourceLoc
        +getText() StringRef
        +getLength() size_t
        +is(tok::TokenKind kind) bool
        +isNot(tok::TokenKind kind) bool
        +isAny(tok::TokenKind kind1, tok::TokenKind kind2, ...) bool
        +isNotAny(tok::TokenKind kind1, tok::TokenKind kind2, ...) bool
        +isKeyword() bool
        +isIdentifier() bool
        +isAnyOperator() bool
        +isPunctuation() bool
        +isAtStartOfLine() bool
        +isFollowingLParen() bool
        +canBeArgumentLabel() bool
        +setStringLiteral(bool isMultiline, unsigned customDelimiterLen) void
        +isMultilineString() bool
        +getCustomDelimiterLen() unsigned
        +setCommentRange(CharSourceRange range) void
        +hasComment() bool
        +getCommentRange() CharSourceRange
    }
    class ASTNode {
        <<abstract>>
    }
    class ASTContext {
        --
        +getIdentifier(StringRef Str) Identifier
        +Diags DiagnosticEngine&
        +SourceMgr SourceManager&
        +evaluator Evaluator&
    }
    class DiagnosticEngine {
        --
        +diagnose(SourceLoc Loc, DiagRef Message) Diagnostic &
        +diagnose(const Token &Tok, DiagRef Message) Diagnostic &
    }
    class SourceManager {
        --
        +getLocForBufferStart(unsigned BufferID) SourceLoc
        +getRangeForBuffer(unsigned BufferID) CharSourceRange
        +isBeforeInBuffer(SourceLoc A, SourceLoc B) bool
        +extractText(CharSourceRange Range) StringRef
        +getLocOffsetInBuffer(SourceLoc Loc, unsigned BufferID) unsigned
        +getLocForOffset(unsigned BufferID, unsigned Offset) SourceLoc
        +findBufferContainingLoc(SourceLoc Loc) unsigned
        +getGeneratedSourceInfo(unsigned BufferID) GeneratedSourceInfo*
    }
    class PersistentParserState {
        --
    }
    class SILParserStateBase {
        <<abstract>>
        +anchor() void
    }
    class ConsumeTokenReceiver {
        <<abstract>>
        +receive(const Token &Tok) virtual void
        +registerTokenKindChange(SourceLoc Loc, tok NewKind) virtual void
        +finalize() virtual std::optional<std::vector<Token>>
    }

    Parser --|> PrettyStackTraceParser
    Parser *-- Lexer
    Parser *-- SourceFile
    Parser *-- SILParserStateBase
    Parser *-- PersistentParserState
    Parser *-- ConsumeTokenReceiver
    SourceFile o-- ASTContext
    SourceFile *-- PersistentParserState
    Lexer o-- LangOptions
    Lexer *-- SourceManager
    Lexer *-- DiagnosticEngine
    Token --|> ASTNode
    ASTContext *-- DiagnosticEngine
    ASTContext *-- SourceManager
    SourceFile *-- ModuleDecl
    PrettyStackTraceParser --|> Parser
    
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
    A["Start Parsing"] --> B{"Get Next Token"};
    B -- Token --> C["Check Token Kind"];
    C -- Matches Expected --> D["Consume Token"];
    C -- Does Not Match --> E["Report Error"];
    D --> F{"Build AST Node"};
    F --> B;
    E --> G["Recovery/Skip Tokens"];
    G --> B;
    B -- EOF --> H["End Parsing"];
    
```

---


```mermaid
sequenceDiagram
    autonumber
    participant Parser
    participant Lexer
    participant TokenReceiver
    participant SourceManager

    Parser->>Lexer: peekNextToken()
    Lexer-->>Parser: Next Token

    Parser->>Parser: consumeToken()
    Parser->>TokenReceiver: receive(Token)
    TokenReceiver->>TokenReceiver: Store Token (if needed)
    Parser->>Lexer: lex(Token)
    Lexer-->>Parser: New Token
    
```

---


```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
stateDiagram
    [*] --> Start
    Start --> Lexing: Initiate Lexer
    Lexing --> Parsing: Token Stream Ready
    Parsing --> BuildingAST: Consume & Build
    BuildingAST --> Parsing: More Tokens
    Parsing --> ErrorRecovery: Syntax Error
    ErrorRecovery --> Parsing: Skip & Continue
    Parsing --> End: EOF
    Lexing --> End: EOF
    End --> [*]
    
```

---



```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
flowchart LR
    A[Parser] -- calls --> B("Lexer::lex()");
    B -- returns Token --> C{Is Token Expected?};
    C -- Yes --> D[Consume Token];
    C -- No --> E[Report Error];
    D --> F{Build AST Structure};
    F --> A;
    E --> G[Attempt Recovery];
    G --> A;
    A -- reaches end --> H[Parsing Complete];
    
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
    subgraph performIDEInspectionSecondPassImpl
        A[restoreParserPosition] --> B{info.Kind};
        B -- TopLevelCodeDecl --> C[parseExprOrStmt];
        B -- Decl --> D[parseDecl];
        B -- FunctionBody --> E[parseAbstractFunctionBodyImpl];
        C --> F[Set TLCD Body];
        D --> G[Add Decl to DC];
        E --> H[Parse Function Body];
        F --> I[DoneParsingCallback->doneParsing];
        G --> I;
        H --> I;
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
    subgraph getStringPartTokens["getStringPartTokens(Tok, LangOpts, SM, BufID, Toks)"]
        A{"Tok.is(tok::string_literal)"} -->|Yes| B{IsMultiline?}
        B -- Yes --> C{QuoteLen = 3 + CustomDelimiterLen}
        B -- No --> D{QuoteLen = 1 + CustomDelimiterLen}
        C --> E{Lexer::getStringLiteralSegments}
        D --> E
        E --> F{Iterate Segments}
        F -- Literal --> G[Extract Text with Quotes]
        G --> H["Create NewTok(string_literal)"]
        H --> I["Toks.push_back(NewTok)"]
        F -- Expr --> J[GetOffset & EndOffset]
        J --> K{isFirst?}
        K -- Yes --> L["Create NewTok(string_literal for quote)"]
        L --> I
        K -- No --> M["tokenize(Offset, EndOffset)"]
        M --> N["Toks.insert(NewTokens)"]
        N --> O{isLast?}
        O -- Yes --> P["Create NewTok(string_literal for quote)"]
        P --> I
        O -- No --> I
    end
    
```





----

