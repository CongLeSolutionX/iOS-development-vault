---
created: 2025-02-18 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---



# An Overview on Tech License Subgroups - A Diagrammatic Guide
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---



## Tech License Subgroups

This document is an expansion of the initial version at [this doc](./Licensing_in_tech.md).




---

## 1. Permissive Licenses Subgroup


```mermaid
---
title: Permissive Licenses Subgroup
config:
  theme: dark
---
mindmap
  root(("Permissive Licenses:<br>Minimal Restrictions, Maximal Freedom"))
    Core_Features["Core Features"]
        Minimal Restrictions, Easy to Use, Broad Compatibility
        Freedom to Use -- Commercial and Non-Commercial Use Allowed
        Freedom to Modify -- Derivatives Permitted
        Freedom to Distribute -- Re-distribution Allowed
        Minimal Obligations -- Often just Attribution

    MIT 
        Short and Simple, Widely Used, Software Focus
        Characteristics -- Concise, Easy to Understand, No Patent Grant (Implicit Patent License)
        Use Cases -- Software Libraries, Utilities, Broad Adoption

    Apache-2.0
        Mature and Robust, Explicit Patent Grant, Software Focus
        Characteristics --  Patent Grant, Contributor Versioning, Addresses Patent Retaliation
        Use Cases -- Large Software Projects, Projects with Patent Concerns, Corporate Environments

    BSD_Licenses["BSD Licenses"]
        Variations in Clauses, Software Focus
            BSD-3-Clause -- Standard BSD, Original, Three Clauses
                Characteristics -- Original BSD Style, Includes 'No Endorsement' Clause
            BSD-2-Clause -- Simplified BSD, Fewer Clauses
                Characteristics -- Removed 'No Endorsement' for Simplicity

    ISC
        Simple and Permissive, Similar to MIT/Simplified BSD
        Characteristics -- Very Concise, Functionally Similar to MIT
        Use Cases -- Software Libraries, Where Simplicity is Key

    ECL-2.0
        Explicit Patent Language, Permissive, Software
        Characteristics -- Strong Patent Grant, Addresses Contributor Rights Clearly

    Zlib/Libpng
        Highly Permissive, Ideal for Libraries
        Characteristics -- Very Short, Focus on Software Libraries, Minimal Overhead

    WTFPL
        'Do What The F*ck You Want To' License, Extreme Permissiveness
        Characteristics -- Humorously Permissive, Essentially Public Domain for Practical Purposes

    Unlicense
        Public Domain Dedication, Effectively No Copyright
        Characteristics --  Attempts to Dedicate to Public Domain, Can be Ambiguous in some Jurisdictions

    Artistic-2.0
        Permissive, Designed for Artistic Works & Software
        Characteristics --  Balances Openness with Author's Artistic Control, Software & Art

    MS-PL
        Microsoft Public License, Permissive, Microsoft Ecosystem
        Characteristics -- Permissive within Microsoft's Licensing Framework

    BSL-1.0
        Boost Software License, Permissive, Used by Boost Libraries
        Characteristics -- Permissive, Used by Boost C++ Libraries

    AFL-3.0
        Academic Free License, Permissive, Academic Origin
        Characteristics -- Permissive, From Academic/Research Context

    c-uda
        Permissive, For CUDA Toolkit Software
        Characteristics -- Permissive for Software using NVIDIA CUDA Toolkit

    NCSA
        NCSA Open Source License, Permissive, Developed by NCSA
        Characteristics -- Permissive, Origin from NCSA

    OFL-1.1
        Permissive, SIL Open Font License, Specifically for Fonts
        Characteristics -- Designed for Fonts, Allows Embedding, Restrictions on Font Modification under Same Name

    etalab-2.0
        Permissive, French Open License, Broadly Applicable
        Characteristics -- French Origin, Broadly Permissive for Public Sector Information

    CDLA-Permissive-1.0
        Creative Commons for Data, Permissive for Data
        Characteristics -- Creative Commons Based, Permissive for Data Assets

    CDLA-Permissive-2.0
        Community Data License Agreement Permissive 2.0
        Characteristics -- Community-Driven, Permissive Data License
        
```


---


## 2. Copyleft (Reciprocal) Licenses Subgroup


```mermaid
---
title: Copyleft (Reciprocal) Licenses Subgroup
config:
  theme: dark
---
mindmap
    root(("Copyleft (Reciprocal) Licenses:<br>Share-Alike, Derivatives Open"))
        Core_Features["Core Features"]
            'Viral' Openness, Share-Alike Requirement
            Share-Alike Clause -- Derivatives Must Be Licensed Under Same or Compatible License
            Promotes Open Source Ecosystem -- Encourages Community Contribution
            Stronger Guarantees of Openness -- Prevents Proprietary Derivatives

        GPL Family -- Strong Copyleft, Software, Source Code Sharing
            GPL-3.0
                Modern GPL, Patent and Tivoization Protections
                Characteristics -- Addresses Patent Issues, Anti-Tivoization, Broad Software Copyleft
                Use Cases -- Operating Systems, Tools, Strong Open Source Communities
            AGPL-3.0
                Network Copyleft, For Networked Software
                Characteristics -- GPL + Network Use Clause, Closes "ASP Loophole"
                Use Cases -- Server Software, Network Applications, SaaS Components
            GPL-2.0
                Older, Widely Used GPL Version
                Characteristics -- Established GPL License, Large Existing Codebase
                Use Cases -- Legacy Projects, Linux Kernel Components

        LGPL_Family["LGPL Family"]
            Weak Copyleft, Software Libraries, Proprietary Linking Allowed
            LGPL-3.0
                Modern LGPL, GPL-3.0 Compatible
                Characteristics -- Allows Linking with Proprietary Software, Copyleft on Library Itself
                Use Cases -- Software Libraries Intended for Broad Use, Including Proprietary Applications
            LGPL-2.1
                Common LGPL Version
                Characteristics -- Established LGPL License Version
                Use Cases -- Software Libraries, Flexibly Used in Many Contexts
            LGPL-lr
                Assuming LGPL, need clarification on '-lr' variant
                Characteristics -- Needs Clarification if Variant, Likely Related to LGPL

        MPL-2.0
            File-Based Copyleft, Software Modules
            Characteristics -- Copyleft Applies Per File, Allows Combining with Proprietary Code at Module Level
            Use Cases -- Web Browsers, Components Where File-Level Copyleft is Desired

        EUPL-1.1
            European Union Public Licence, Copyleft, Broadly Applicable
            Characteristics -- Multi-lingual, EU Legal Framework, Software & Broader Works

        ODbL
            Open Data Commons Open Database License, Copyleft for Databases
            Characteristics --  Specifically for Databases, Requires Share-Alike for Database Derivatives
            Use Cases -- Open Data Repositories, Databases Shared Under Copyleft

        LPPL-1.3c
            LaTeX Project Public License, Copyleft, LaTeX Software
            Characteristics -- Specific to LaTeX Ecosystem, Copyleft for LaTeX Related Software

        OSL-3.0
            Open Software License 3.0, Copyleft-leaning, Source Available
            Characteristics -- Copyleft-leaning, Requires Source Availability, Some Patent Considerations
            Use Cases -- Projects Desiring Some Copyleft Influence with Source Availability Requirements

        CDLA-Sharing-1.0
            Community Data License Agreement Sharing, Share-Alike for Data
            Characteristics --  Community Data License, Share-Alike for Data Derivatives
            Use Cases -- Data Repositories Where Share-Alike Data Derivatives are Encouraged
            
```


----

## 3. Creative Commons Licenses Subgroup


```mermaid
---
title: Creative Commons Licenses Subgroup
config:
  theme: dark
---
mindmap
    root(("Creative Commons (CC) Licenses:<br>Spectrum of Rights for Creative and Data Works"))
        Core_Features["Core Features"]
            Flexible Copyright for Creative and Data Content
            Modular Rights -- Combine 'BY', 'SA', 'NC', 'ND' Conditions
            Attribution_Requirement_BY["Attribution Requirement (BY) -- Always Present, Credit to Author"]

        Public_Domain_Dedication["Public Domain Dedication<br>(No Rights Reserved)"]
            CC0-1.0
                Public Domain Dedication, No Copyright Reserved
                Characteristics --  Effectively Public Domain, Maximally Permissive, For Data & Creative Works
                Use Cases -- Datasets, Media Where Public Domain Status is Desired

        Attribution_BY_Family["Attribution (BY) Family -- Requires Credit"]
            cc-by-4.0
                Attribution 4.0 International
                Characteristics -- Modern Version, International Scope
            cc-by-3.0
                Attribution 3.0 Unported
                Characteristics -- Older, Unported Version
            cc-by-2.0
                Attribution 2.0 Generic
                Characteristics -- Older Version
            cc-by-2.5
                Attribution 2.5 Generic
                Characteristics -- Older Version

        ShareAlike_SA_Enhancements["ShareAlike (SA) Enhancements -- Requires Share-Alike Derivatives"]
            cc-by-sa-4.0
                Attribution-ShareAlike 4.0 International
                Characteristics -- Copyleft for Creative Works, Derivatives Must Be SA
            cc-by-sa-3.0
                Attribution-ShareAlike 3.0 Unported
                Characteristics -- Older Version

        NonCommercial_NC_Restrictions["NonCommercial (NC) Restrictions -- Limits Commercial Use"]
            cc-by-nc-4.0
                Attribution-NonCommercial 4.0 International
                Characteristics -- Non-Commercial Restriction, Definitions of "Commercial" Can Vary
            cc-by-nc-3.0
                Attribution-NonCommercial 3.0 Unported
                Characteristics -- Older Version
            cc-by-nc-2.0
                Attribution-NonCommercial 2.0 Generic
                Characteristics -- Older Version

        NoDerivatives_ND_Restrictions["NoDerivatives (ND) Restrictions -- No Modifications Allowed"]
            cc-by-nd-4.0
                Attribution-NoDerivatives 4.0 International
                Characteristics -- No Modifications Permitted, Only Distribution of Original Work

        Combinations_and_Variations["Combinations and Variations (NC-ND, NC-SA) -- Combine Restrictions"]
            cc-by-nc-nd-4.0
                Attribution-NonCommercial-NoDerivatives 4.0
                Characteristics -- Non-Commercial and No-Derivatives Combined
            cc-by-nc-nd-3.0
                Attribution-NonCommercial-NoDerivatives 3.0
                Characteristics -- Older Version
            cc-by-nc-sa-4.0
                Attribution-NonCommercial-ShareAlike 4.0
                Characteristics -- Non-Commercial and Share-Alike Combined
            cc-by-nc-sa-3.0
                Attribution-NonCommercial-ShareAlike 3.0
                Characteristics -- Older Version
                
```



---

## 4. AI & Responsible Use Licenses Subgroup


```mermaid
---
title: AI and Responsible Use Licenses Subgroup
config:
  theme: dark
---
mindmap
    root(("AI and Responsible Use Licenses:<br>Ethical Use, Harm Restriction"))
        Core_Focus["Core Focus"]
            Ethical Considerations for AI Models and Use Cases
            Restrictions on Harmful Use --  Prohibition of Misuse, Harmful Applications
            Responsible AI Development --  Encourage Ethical AI Practices
            Relatively New Domain -- Licenses Evolving Rapidly

        Open_RAIL_Family["Open RAIL (Responsible AI License) Family"]
            openrail
                Generic Open RAIL License
                Version Context Needed
                Characteristics -- Base Open RAIL Framework, Need to Check Specific Version for Terms
            creativeml-openrail-m
                CreativeML Open RAIL-M
                For Models
                Characteristics -- Developed by CreativeML, For AI Models, Restrictions on Harmful Uses
            bigscience-openrail-m
                BigScience RAIL-M
                Specific Model License
                Characteristics -- Developed by BigScience Workshop, Model-Specific Terms, Responsible Use
            bigcode-openrail-m
                BigCode RAIL-M
                For BigCode Project Models
                Characteristics -- For BigCode Project Models,  Responsible Use Focus
            openrail++
                Enhanced Open RAIL
                Version Context Needed
                Characteristics -- Likely an Updated Version of Open RAIL, Check Terms
            bigcode-openrail-l-v1
                BigCode OpenRAIL-L v1
                Specific Version
                Characteristics -- Specific Version of BigCode Open RAIL, Precise Terms Defined

        Model_Specific_Examples["Model Specific Examples <br>(Often Custom or Specialized)"]
            Llama_Family["Llama Family"]
                Custom Terms for Llama Models
                    Llama 2 Licenses
                    Llama 3 Licenses
                Characteristics -- Check Meta AI Llama License, Often Includes Use Restrictions and Terms
                Note -- Llama licenses are often more restrictive than typical Open Source licenses
            Gemma_License["Gemma License"]
                License for Google's Gemma Models, Check Specific Terms
                Characteristics -- Google License, Need to Consult Specific Terms, Potentially Model-Specific
            deepfloyd-if-license
                DeepFloyd IF License
                For DeepFloyd IF Model
                Characteristics -- For DeepFloyd IF Model, License Terms Need Review
            bigscience-bloom-rail-1.0
                BigScience Bloom RAIL License 1.0
                For Bloom Model
                Characteristics --  Specific to the Bloom Model, Combines Permissive Base with Responsible Use Clauses

        Implications_and_Considerations["Implications and Considerations"]
            Ambiguity and Enforcement -- Legal Interpretations Still Evolving
            Community Norms --  Reflecting Emerging Ethical Norms in AI Field
            Balancing Openness with Responsibility --  Finding Trade-off between Open Access and Misuse Prevention
            
```

---

## 5. Database Licenses Subgroup


```mermaid
---
title: Database Licenses Subgroup
config:
  theme: dark
---
mindmap
    root(("Database Licenses:<br>Optimized for Data Repositories"))
        Core_Focus["Core Focus"]
            Licensing Data Content and Database Access
            Addresses Data-Specific Rights -- Beyond Software Copyright
            Facilitates Data Sharing and Collaboration -- For Data Repositories, Datasets
            Considerations for Data as a Unique Asset -- Not Just Code

        ODbL
            Open Data Commons Open Database License
            Copyleft for Databases
            Characteristics -- Copyleft for Databases, Requires Share-Alike for Database Derivatives
            Use Cases -- OpenStreetMap, Databases Intended to Remain Open and Shared

        ODC-By
            Open Data Commons Attribution License
            Attribution for Data/Databases
            Characteristics -- Attribution Required, Similar to CC-BY for Data
            Use Cases -- Data where simple attribution is sufficient, less restrictive than ODbL

        CDLA-Sharing-1.0
            Community Data License Agreement Sharing
            Share-Alike for Data
            Characteristics -- Data Focused, Share-Alike for Data Derivatives
            Use Cases -- Data Repositories where Share-Alike principle is valued for data contributions

        CDLA-Permissive-1.0
            Creative Commons for Data, Permissive for Data
            Characteristics -- Creative Commons Based, Permissive for Data Assets, Attribution
            Use Cases -- Data where permissive use with attribution is desired

        CDLA-Permissive-2.0
            Community Data License Agreement Permissive 2.0
            Characteristics -- Community-Driven, Permissive Data License, More Updated than 1.0
            Use Cases -- Data Projects Seeking a Modern, Permissive Data License

        PDDL
            Public Domain Dedication and License
            For Data/Databases
            Characteristics -- Public Domain Dedication + License, Effectively Permissive for Data
            Use Cases -- Data intended for broad use, minimizing restrictions

        PostgreSQL License
            Permissive, Database Software Specific
            Characteristics -- Permissive License for PostgreSQL Database Software Itself  - Not Data within it
            Note --  More about licensing the Database *Software* than Data *Content*, but relevant in Database context

```



---

<!-- 
```mermaid
%% Current Mermaid version
info
```  -->


```mermaid
---
title: "CongLeSolutionX"
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY-SA 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: base
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'flowchart': { 'htmlLabels': false },
    'fontFamily': 'Bradley Hand',
    'themeVariables': {
      'primaryColor': '#fc82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#81c784',
      'secondaryTextColor': '#6C3483',
      'lineColor': '#F8B229',
      'fontSize': '20px'
    }
  }
}%%
flowchart LR
  My_Meme@{ img: "https://raw.githubusercontent.com/CongLeSolutionX/CongLeSolutionX/refs/heads/main/assets/images/My-meme-light-bulb-question-marks.png", label: "Ăn uống gì chưa ngừi đẹp?", pos: "b", w: 200, h: 150, constraint: "off" }

  Closing_quote@{ shape: braces, label: "...searching insights in the process of formulating better questions..." }
    
  My_Meme ~~~ Closing_quote
    
  Link_to_my_profile{{"<a href='https://github.com/CongLeSolutionX' target='_blank'>Click here if you care about my profile</a>"}}

  Closing_quote ~~~ My_Meme
  My_Meme animatingEdge@--> Link_to_my_profile
  
  animatingEdge@{ animate: true }

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---
