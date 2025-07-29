---
created: 2025-02-12 05:48:19
author: NA
version: NA
license(s): NA
copyright: NA
original source: https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf

---



# Metal Shading Language Specification Version 3.2 - by Apple


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




Below is a collection of diagrams and illustrations on explaining Metal Shading Language accordingly to the original Apple specification documentation version 3.2 at [here](https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf).


---



## 1. Document Organization

This diagram visually represents the hierarchical structure of the MSL specification document, outlining the main chapters and their focus areas.

```mermaid
---
title: "Document Organization"
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "mindmap": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fcc326'
    }
  }
}%%
mindmap
  root((Metal Shading Language Specification v3.2))
    Chapter_1_Introduction
      Purpose_and_Scope
      Organization_Overview
      New_Features_in_3.2
      Compiler_and_Preprocessor
        Preprocessor_Options
        Math_Intrinsics_Options
        Optimization_Options
        Language_Version_Control
    Chapter_2_Data_Types
      Scalar_Types
      Vector_Types
      Matrix_Types
      Pixel_Data_Types
      Buffers
      Textures
      Samplers
      Imageblocks
      Ray_Tracing_Types
      Mesh_Shader_Types
      Type_Conversions
    Chapter_3_Operators
      Scalar_Vector_Operators
      Matrix_Operators
    Chapter_4_Address_Spaces
      Device_Address_Space
      Constant_Address_Space
      Thread_Address_Space
      Threadgroup_Address_Space
      Ray_Data_Address_Space
      Object_Data_Address_Space
      Memory_Coherency
    Chapter_5_Function_and_Variable_Declarations
      Functions
        Vertex_Functions
        Fragment_Functions
        Kernel_Functions
        Visible_Functions
        Intersection_Functions
        Mesh_Functions
        Tile_Functions
      Function_Arguments_and_Variables
      Attributes_for_Built_in_Variables
      Program_Scope_Function_Constants
    Chapter_6_Metal_Standard_Library
      Namespaces_and_Headers
      Common_Functions
      Integer_Functions
      Math_Functions
      Matrix_Functions
      Geometric_Functions
      Synchronization_Functions
      Texture_Functions
      Imageblock_Functions
      Atomic_Functions
      Ray_Tracing_Functions
      Logging_Functions
    Chapter_7_Numerical_Compliance
      INF_NaN_Denormalized_Numbers
      Rounding_Mode
      Floating_Point_Exceptions
      ULPs_and_Relative_Error
      Conversion_Rules
```


---

## 2. Metal and C++14 Relationship

This diagram illustrates how Metal Shading Language is based on C++14, highlighting the extensions and restrictions that MSL imposes.

```mermaid
---
title: "Metal and C++14 Relationship"
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
classDiagram
    class CPP_14 {
        <<Base Language>>
        - Grammar
        - Overloading
        - Templates
        - Preprocessing Directives
    }
    
    class Metal_Shading_Language {
        <<Language>>
        - Extensions
            - Address Space Attributes
            - Texture & Sampler Types
            - Imageblock Types
            - Ray Tracing Types
            - Mesh Shader Types
            - SIMD-group Matrix Types
            - Function Constants
            - Metal Standard Library
        - Restrictions
            - No Lambdas
            - No Dynamic Cast
            - No Type Identification
            - No New/Delete Operators
            - No Exceptions
            - Pointer Restrictions
            - C++ Standard Library Restrictions
    }
    
    CPP_14 <|-- Metal_Shading_Language : Extends and Restricts
    
```


----

# 3. Compiler Options Categories


This diagram categorizes the different compiler options available for MSL, illustrating the control that developers have over the compilation process.

```mermaid
---
title: "Compiler Options Categories"
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%%%%%%% Available curve styles include the following keywords:
%% basis, bumpX, bumpY, cardinal, catmullRom, linear, monotoneX, monotoneY, natural, step, stepAfter, stepBefore.
%%{
  init: {
    "flowchart": { "htmlLabels": false, 'curve': 'linear' },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
flowchart TD
    A[Start] --> B{Compiler Options};
    B --> C{Preprocessor Options};
    B --> D{Math Intrinsics Options};
    B --> E{Invariance Options};
    B --> F{Optimization Options};
    B --> G{Maximum Threadgroup Size Option};
    B --> H{Texture Write Rounding Mode};
    B --> I{Module Options};
    B --> J{Logging Options};
    B --> K{Language Version Options};
    B --> L{Warning Control Options};
    B --> M{Target Conditionals};
    B --> N{Dynamic Library Linker Options};
    B --> O{GPU Binary Compilation Options};
    B --> P{Metal Library Symbol File Options};

    C --> Q["Preprocessor Directives (-D, -I)"];
    D --> R["Floating-Point Precision and Speed (-fmetal-math-...)"];
    E --> S["Vertex Invariance Preservation (-fpreserve-invariance)"];
    F --> T["Performance vs. Code Size (-O2, -Os)"];
    G --> U["Thread Limit per Threadgroup (-fmax-total-threads-per-threadgroup)"];
    H --> V["Rounding Modes for Texture Writes (-ftexture-write-rounding-mode)"];
    I --> W["Module Usage Control (-fmodules, -fmodule-map-file)"];
    J --> X["Enable Logging (-fmetal-enable-logging)"];
    K --> Y["MSL Language Version (-std=)"];
    L --> Z["Warning as Errors, Suppress Warnings (-Werror, -w)"];
    M --> AA["Platform Specific Compilation (TargetConditionals.h)"];
    N --> AB["Dynamic Library Output (-dynamiclib, -install_name)"];
    O --> AC["GPU Binary Output (-arch, -gpu-family, -N)"];
    P --> AD["Symbol File Generation (-frecord-sources)"];

    Q --> AE[Preprocessing];
    R --> AF[Math Intrinsics];
    S --> AG[Invariance];
    T --> AH[Optimization];
    U --> AI[Thread Management];
    V --> AJ[Texture Handling];
    W --> AK[Modules];
    X --> AL[Logging];
    Y --> AM[Language Version];
    Z --> AN[Warnings];
    AA --> AO[Target Platform];
    AB --> AP[Linking];
    AC --> AQ[Binary Output];
    AD --> AR[Symbol File];

    AE --> AS[Compilation Process];
    AF --> AS;
    AG --> AS;
    AH --> AS;
    AI --> AS;
    AJ --> AS;
    AK --> AS;
    AL --> AS;
    AM --> AS;
    AN --> AS;
    AO --> AS;
    AP --> AS;
    AQ --> AS;
    AR --> AS;
    AS --> AT[End];
    
```


----


## 4. Metal Data Types Hierarchy


This diagram organizes the various data types in Metal Shading Language into a class hierarchy, reflecting their categories and relationships.

```mermaid
---
title: "Metal Data Types Hierarchy"
config:
  layout: elk
  look: handDrawn
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    "classDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#f529',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%
classDiagram
    class Data_Type {
        <<Abstract Class>>
        Name
        Description
    }
    class Scalar_Types {
        <<Category>>
        - bool
        - char, schar, uchar
        - short, ushort
        - int, uint
        - long, ulong
        - half, bfloat, float
        - void
        - size_t, ptrdiff_t
    }
    class Vector_Types {
        <<Category>>
        - booln, charn, ucharn, shortn, ushortn, intn, uintn, longn, ulongn, halfn, bfloatn, floatn (n=2,3,4)
        - packed_charn, packed_ucharn, packed_shortn, packed_ushortn, packed_intn, packed_uintn, packed_halfn, packed_bfloatn, packed_floatn, packed_longn (n=2,3,4)
        - vec<T,n>, packed_vec<T,n>
    }
    class Matrix_Types {
        <<Category>>
        - halfnxm, floatnxm (n,m=2,3,4)
        - matrix<T,c,r>
        - simdgroup_half8x8, simdgroup_bfloat8x8, simdgroup_float8x8
    }
    class Texture_Types {
        <<Category>>
        - texture1d<T>, texture1d_array<T>
        - texture2d<T>, texture2d_array<T>, texture2d_ms<T>, texture2d_ms_array<T>
        - texture3d<T>
        - texturecube<T>, texturecube_array<T>
        - depth2d<T>, depth2d_array<T>, depth2d_ms<T>, depth2d_ms_array<T>
        - depthcube<T>, depthcube_array<T>
        - texture_buffer<T>
    }
    class Sampler_Type {
        <<Category>>
        - sampler
    }
    class Pixel_Data_Types {
        <<Category>>
        - r8unorm<T>, r8snorm<T>
        - r16unorm<T>, r16snorm<T>
        - rg8unorm<T>, rg8snorm<T>
        - rg16unorm<T>, rg16snorm<T>
        - rgba8unorm<T>, srgba8unorm<T>, rgba8snorm<T>
        - rgba16unorm<T>, rgba16snorm<T>
        - rgb10a2<T>, rg11b10f<T>, rgb9e5<T>
    }
    class Atomic_Types {
        <<Category>>
        - atomic<T> (T=int, uint, bool, ulong, float)
        - atomic_int, atomic_uint, atomic_bool, atomic_ulong, atomic_float (aliases)
    }
    class Buffer_Type {
        <<Category>>
        - buffer (pointers to device, constant, threadgroup memory)
        - argument_buffer
    }
    class Imageblock_Type {
        <<Category>>
        - imageblock<T, L>
    }
    class Ray_Tracing_Types {
        <<Category>>
        - ray
        - intersection_function_table
        - intersection_result
        - intersection_result_ref
        - intersector
        - acceleration_structure
        - intersection_query
    }
     class Mesh_Shader_Types {
        <<Category>>
        - mesh_grid_properties
        - mesh<V, P, NV, NP, t>
    }
    class Uniform_Type {
        <<Category>>
        - uniform<T>
    }
    class Visible_Function_Table_Type {
        <<Category>>
        - visible_function_table<T>
    }

    Data_Type <|-- Scalar_Types
    Data_Type <|-- Vector_Types
    Data_Type <|-- Matrix_Types
    Data_Type <|-- Texture_Types
    Data_Type <|-- Sampler_Type
    Data_Type <|-- Pixel_Data_Types
    Data_Type <|-- Atomic_Types
    Data_Type <|-- Buffer_Type
    Data_Type <|-- Imageblock_Type
    Data_Type <|-- Ray_Tracing_Types
    Data_Type <|-- Mesh_Shader_Types
    Data_Type <|-- Uniform_Type
    Data_Type <|-- Visible_Function_Table_Type
    
```



----

## 5. Address Spaces and Memory Model (Component Diagram) - TODO

This diagram componentizes the different address spaces in MSL and their relationship to memory and access permissions.

```mermaid
componentDiagram
    component Device_Address_Space {
        Memory_Pool [Device Memory]
        Access_Permissions [Read & Write]
        Lifespan [App Memory Allocation]
        Data_Types [Basic, Vector, Matrix, Aggregates]
    }
    component Constant_Address_Space {
        Memory_Pool [Device Memory (Read-Only)]
        Access_Permissions [Read-Only]
        Lifespan [Program Lifetime]
        Initialization [Required at Declaration (Core Constant Expression)]
        Data_Types [Basic, Vector, Matrix, Aggregates]
    }
    component Thread_Address_Space {
        Memory_Pool [Per-Thread Memory]
        Access_Permissions [Thread-Local]
        Lifespan [Function Call]
        Allocation [Automatic (Function Variables)]
        Data_Types [Basic, Vector, Matrix, Aggregates]
    }
    component Threadgroup_Address_Space {
        Memory_Pool [Threadgroup Shared Memory]
        Access_Permissions [Threadgroup Shared]
        Lifespan [Threadgroup Execution]
        Allocation [Explicit (threadgroup keyword)]
        Data_Types [Basic, Vector, Matrix, Aggregates, Imageblocks]
    }
    component Ray_Data_Address_Space {
        Memory_Pool [Ray-Tracing Function Local Memory]
        Access_Permissions [Intersection Function Access]
        Lifespan [Intersection Function Call]
        Purpose [Custom Ray Payload]
        Data_Types [Limited Set (No Atomics, Imageblocks)]
    }
    component Object_Data_Address_Space {
        Memory_Pool [Object Function Local Memory]
        Access_Permissions [Mesh Function Payload]
        Lifespan [Object Function Execution]
        Purpose [Mesh Shader Payload]
        Data_Types [Limited Set (No Atomics, Imageblocks)]
    }
    component Threadgroup_Imageblock_Address_Space {
        Memory_Pool [Threadgroup Imageblock Memory]
        Access_Permissions [Tile Function Access]
        Lifespan [Tile Shading Function Execution]
        Purpose [2D Image Data Processing in Tiles]
        Data_Types [Scalar, Vector, Pixel, Arrays, Structures]
    }

    Device_Address_Space --|> Memory_Model [Metal Memory Model]
    Constant_Address_Space --|> Memory_Model
    Thread_Address_Space --|> Memory_Model
    Threadgroup_Address_Space --|> Memory_Model
    Ray_Data_Address_Space --|> Memory_Model
    Object_Data_Address_Space --|> Memory_Model
    Threadgroup_Imageblock_Address_Space --|> Memory_Model
```

----

## 6. Function Types and Attributes (Sequence Diagram)


This diagram illustrates different types of MSL functions and the attributes that define their roles and execution contexts within the Metal pipeline.

```mermaid
---
title: Different Types of MSL functions and Attributes 
config:
  theme: dark
---
%%{
  init: {
    "sequenceDiagram": { "htmlLabels": false },
    'fontFamily': 'Fantasy',
    'themeVariables': {
      'lineColor': '#F8B229'
    }
  }
}%%
sequenceDiagram
	autonumber
    actor Developer

    box rgb(20, 22, 55) The System
        participant MSL_Compiler as MSL Compiler
        participant Metal_API as Metal API
        participant GPU
    end

    Developer->>MSL_Compiler: Declare Function with Attribute<br>(e.g., [[kernel]])
    MSL_Compiler->>MSL_Compiler: Analyze Attribute

    rect rgb(20, 15, 255)
        alt Attribute is [[kernel]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Compute Kernel in API
            Metal_API->>GPU: Enqueue Compute Dispatch
            GPU->>GPU: Execute Data-Parallel Kernel over Grid
            end
        else Attribute is [[vertex]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Vertex Function in API
            Metal_API->>GPU: Enqueue Render Pass
            GPU->>GPU: Execute Vertex Function per Vertex Stream
            end
        else Attribute is [[fragment]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Fragment Function in API
            Metal_API->>GPU: Enqueue Render Pass
            GPU->>GPU: Execute Fragment Function per Fragment
            end
        else Attribute is [[visible]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Visible Function in API
            Note over MSL_Compiler: Can be called by other MSL functions
            end
        else Attribute is [[intersection]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Internal Use for Ray Tracing
            GPU->>GPU: Called by Intersect Operations
            end
        else Attribute is [[mesh]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Mesh Function in Mesh Pipeline
            GPU->>GPU: Execute Mesh Function in Mesh Stage
            end
        else Attribute is [[object]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Object Function in Mesh Pipeline
            GPU->>GPU: Execute Object Function in Object Stage
            end
        else Attribute is [[tile]]
            rect rgb(10, 100, 200)
            MSL_Compiler->>Metal_API: Expose as Tile Function in Render Pass
            GPU->>GPU: Execute Tile Function per Tile
            end
        else No Attribute (User Function)
            rect rgb(10, 100, 200)
            MSL_Compiler->>MSL_Compiler: Standard MSL Function
            Note over MSL_Compiler: Callable from other MSL functions
            end
        end
    end
     
```


These diagrams provide a semantic and strategic visual overview of the Metal Shading Language Specification document. Each diagram is designed to highlight specific aspects of MSL and their underlying technical complexities, following the instructions and guidelines provided. They should be helpful for anyone trying to understand and navigate the MSL specification.



---