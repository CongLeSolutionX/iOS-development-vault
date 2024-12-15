---
created: 2024-12-15 12:37:20
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---

# Swift-generated header file in Mermaid diagrams

Let's break down the explanation of the Swift-generated header file into a set of Mermaid diagrams. I'll focus on the main structural elements and their relationships.

## Diagram 1: Overall Structure of the Header File

```mermaid
graph LR
    A[Header File: MyApp-Swift.h] --> B{Preprocessor Directives};
    A --> C{Includes};
    A --> D{Architecture & Pointer Authentication};
    A --> E{Swift Type Definitions};
    A --> F{Macros};
    A --> G{Forward Declarations};
    A --> H{Objective-C Class Definitions};
    A --> I{"External Source Symbol Attributes"};

    B --> B1[Header Guards];
    B --> B2[Compiler Pragmas];
    C --> C1[System Headers];
    C --> C2[Platform Specific Headers];
    D --> D1["Pointer Authentication Check"];
    D1 --> D2[Includes <ptrauth.h> or defines placeholder macros];
    
    E --> E1[Vector Type Aliases];
    F --> F1[Swift Compatibility Macros];
    F --> F2[Type Declaration Macros];
    F --> F3[Attribute Macros];
    G --> G1[Forward Declaration of Classes];
    H --> H1[Objective-C Interfaces];
    I --> I1[Clang Attributes Marking Swift Source Origin];

        style A fill:#f19f,stroke:#333,stroke-width:2px
        
```

## Diagram 2: Preprocessor Directives Details

```mermaid
graph LR
    A[Preprocessor Directives] --> B[Header Guards];
    A --> C[Compiler Pragmas];
        B --> B1["#ifndef MYAPP_SWIFT_H"];
        B --> B2["#define MYAPP_SWIFT_H"];
        B --> B3["#endif"];

      C --> C1["#pragma clang diagnostic push"];    
      C --> C2["#pragma clang diagnostic ignored"];
      C --> C3["#pragma clang diagnostic pop"];
 style A fill:#c1cf;
 
```

## Diagram 3: Includes Section

```mermaid
graph LR
    A[Includes] --> B[System Headers];
    A --> C[Platform Specific Headers];

    B1["swift/objc-prologue.h"]
    B2["Foundation/Foundation.h"]
    B3("
        stdint
        cstddef
        ...
        string.h
        "
    )

    B --> B1
    B --> B2
    B --> B3
 
    C --> C1["#if defined(__OBJC__)"];
    C --> C2["#if defined(__cplusplus)"];

style A fill:#a1fa;

```

## Diagram 4: Swift Type Definitions

```mermaid
graph LR
    A[Swift Type Definitions] --> B[Vector Type Aliases];
        B --> B1[("typedef float swift_float2 ...")];
        B --> B2[("typedef float swift_float3 ...")];
        B --> B3[("typedef double swift_double2 ...")];
      	B --> B4[("typedef int swift_int2 ...")];
        B --> B5[("typedef unsigned int swift_uint2 ...")];

style A fill:#a1af;
```

## Diagram 5: Macros Section


```mermaid
graph LR
    A[Macros] --> B[Swift Compatibility Macros];
    A --> C[Type Declaration Macros];
    A --> D[Attribute Macros];
       
    B --> B1;
	C --> C1;
    D --> D1;
    
    B1("
        SWIFT_PASTE
        SWIFT_METATYPE
        ...
        "
    )

    C1("
        SWIFT_CLASS
        SWIFT_PROTOCOL
        SWIFT_EXTENSION
        SWIFT_ENUM
        ...
        "
    )

    D1("
        SWIFT_WARN_UNUSED_RESULT
        SWIFT_NOESCAPE
        SWIFT_NORETURN
        ...
        "
    )

style A fill:#f1aa;


```

## Diagram 6: Objective-C Class Definitions

```mermaid
graph LR
    A[Objective-C Class Definitions] --> B[Interfaces];
    
    B --> B1[AppDelegate];
    B1 --> B11["Methods from UIApplicationDelegate"];

    B --> B2[CustomUIKitView];
    B --> B3[MyUIKitViewController];
    B --> B4[NativeUIKitViewController];
    B --> B5[SceneDelegate];
    B --> B6[VideoCapture];
    B --> B7[YOLOSettingsViewController];
    B --> B8[YOLOStatisticsViewController];
    B --> B9[YOLOViewController]


    B2 --> B21;
    B3 --> B31;
    B4 --> B41;
    B5 --> B51;
    B6 --> B61;
    B7 --> B71;
    B8 --> B81;
    B9 --> B91;

    B21("
        initWithFrame
        initWithCoder
        lifecycle methods
        "
    )

    B31("
        viewDidLoad
        initializers
        "
    )

    B41("
        viewDidLoad
        initializers
        "
    )

    B51("
        UIWindow property
        Scene lifecycle methods
        "
    )

    B61("
        AVCaptureVideoDataOutputSampleBufferDelegate
        delegate methods
        "
    )

    B71("
        viewDidLoad
        developerModeToggled
        telephotoCameraToggled
        initializers
        "
    )

    B81("
        viewDidLoad
        viewWillAppear
        initializers
        "
    )

    B91("
        viewDidLoad
        viewWillLayoutSubviews
        delegate methods
        navigation methods
        initializers
        "
    )

style A fill:#a1ab;
linkStyle default stroke:#262,stroke-width:3px
  
```

## Diagram 7: External Source Symbol Attributes

```mermaid
graph LR
    A[External Source Symbol Attributes] --> B[Clang Attributes];
    B --> B1["#if __has_attribute(external_source_symbol) ... #endif"];
    B --> B2["#pragma push_macro('any') ... #pragma pop_macro('any')"];
    B --> B3["#pragma clang attribute push( ... )"];
    B --> B4["Marks declarations as originating from Swift"];

style A fill:#d1df;
      
```

-----