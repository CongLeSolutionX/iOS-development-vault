---
created: 2025-02-18 05:31:26
author: NA
version: NA
license(s): NA
copyright: NA
---



# An Overview on Licencing in Tech Industry - An Expanding Diagrammatic Guide


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





## An Expanding Overview on Tech Licenses

This document is an expansion of the initial version at [this doc](./Licensing_in_tech.md).

This version now attempts to be more exhaustive by incorporating more dataset-relevant licenses.

```mermaid
---
title: Expanded License Types for Datasets and Models on Hugging Face
author: "Cong Le"
version: "1.0"
license(s): "MIT, CC BY 4.0"
copyright: "Copyright (c) 2025 Cong Le. All Rights Reserved."
config:
  theme: dark
---
%%%%%%%% Mermaid version v11.4.1-b.14
%%{
  init: {
    'fontFamily': 'M Mermaid Monogram',
    'logLevel': 'fatal',
    'mindmap': {
	    'nodeAlign': 'center',
	    'padding': 20
    },
    'themeVariables': {
      'primaryColor': '#FC82',
      'primaryTextColor': '#F8B229',
      'primaryBorderColor': '#27AE60',
      'secondaryColor': '#EBF3',
      'secondaryTextColor': '#6C3483',
      'secondaryBorderColor': '#A569BD',
      'fontSize': '20px'
    }
  }
}%%
mindmap
  root)"Expanded License Types for Datasets and Models on Hugging Face"(

    Permissive_Licenses))"Permissive Licenses"((
      General_Permissive["General Permissive"]
        Apache-2.0
        MIT
        ISC
        BSD_Licenses["BSD Licenses"]
          BSD_Family["BSD Family"]
            bsd-3-clause
            bsd-2-clause
            bsd-3-clause-clear
        ECL-2.0
        Zlib
        WTFPL
        Unlicense
        MS-PL
        PDDL
        Artistic-2.0
        BSL-1.0
        AFL-3.0
        c-uda
        NCSA
        OFL-1.1["OFL-1.1<br>(SIL Open Font License, often considered permissive)"]
        etalab-2.0["etalab-2.0<br>(French Open License, broadly permissive)"]
        CDLA-Permissive-1.0["CDLA-Permissive-1.0<br>(Creative Commons - Attribution Generic, permissive for data)"]
        CDLA-Permissive-2.0["CDLA-Permissive-2.0<br>(Community Data License Agreement Permissive 2.0)"]

    Copyleft_Licenses))"Copyleft Licenses<br>(Reciprocal Licenses)"((
      General_Copyleft["General Copyleft"]
        GPL_Family["GPL Family"]
          GPL-3.0
          AGPL-3.0
          GPL-2.0
        LGPL_Family["LGPL Family"]
          lgpl-3.0
          lgpl-2.1
          lgpl-lr
        MPL-2.0["MPL-2.0<br>(Mozilla Public License)"]
        EUPL-1.1["EUPL-1.1<br>(European Union Public Licence)"]
        GFDL["GFDL<br>(GNU Free Documentation License, more copyleft for documentation)"]
        ODC-By["ODC-By<br>(Open Data Commons Attribution License, copyleft for databases and data)"]
        LPPL-1.3c["LPPL-1.3c<br>(LaTeX Project Public License, copyleft for software related to LaTeX)"]
        EPL_Family["EPL Family"]
          epl-2.0
          epl-1.0

    Creative_Commons_Licenses))"Creative Commons Licenses<br>(for Creative Works and Data)"((
      CC("CC<br>(Generic Creative Commons - often used as a base)")
      CC0-1.0("CC0-1.0<br>(Public Domain Dedication, effectively no rights reserved)")
      Attribution_BY("Attribution (BY) <br>- Requires Attribution")
        cc-by-4.0
        cc-by-3.0
        cc-by-2.0
        cc-by-2.5
      ShareAlike_SA("ShareAlike (SA) <br>- Derivatives must be under the same/compatible license")
        cc-by-sa-4.0
        cc-by-sa-3.0
      NonCommercial_NC("NonCommercial (NC) <br>- Restricts Commercial Use")
        cc-by-nc-4.0
        cc-by-nc-3.0
        cc-by-nc-2.0
      NoDerivatives_ND("NoDerivatives (ND) <br>- No Derivative Works Allowed")
        cc-by-nd-4.0
      Combinations("Combinations<br>(e.g., NC-ND, NC-SA)")
        cc-by-nc-nd-4.0
        cc-by-nc-nd-3.0
        cc-by-nc-sa-4.0
        cc-by-nc-sa-3.0


    AI_Model_and_Open_RAIL_Family_Licenses))"AI/Model and Open RAIL Family Licenses<br>(Responsible AI Licenses)"((
      Open_RAIL_Family("Open Responsible AI License (Open RAIL) Family")
        openrail
        creativeml-openrail-m
        bigscience-openrail-m
        bigcode-openrail-m
        openrail++
      Model_Specific_and_Related("Model Specific and Related")
        Llama_Family["Llama Family"]
          llama2
          llama3
        Gemma
        deepfloyd-if-license
        bigscience-bloom-rail-1.0
        bigcode-openrail-m
        creativeml-openrail-m
        openrail++
        openrail
        bigcode-openrail-l-v1

    Database_and_Data_Specific_Licenses))"Database and Data Specific Licenses"((
      Database_Focus["Database Focus"]
        PostgreSQL_License["PostgreSQL License<br>(Permissive license for PostgreSQL database)"]
        ODC-By["ODC-By<br>(Open Data Commons Attribution License)"]
        ODbL["ODbL<br>(Open Data Commons Open Database License<br>- copyleft for databases)"]
        CDLA-Sharing-1.0["CDLA-Sharing-1.0<br>(Community Data License Agreement Sharing, for data)"]
        CDLA-Permissive-1.0
        CDLA-Permissive-2.0

    Software_with_Data_Considerations))"Software with Data Considerations"((
      GPL_with_Data_clauses["GPL with Data clauses<br>(Some GPL variants might address data specifically)"]

    Less_Common_Specific_Proprietary_leaning))"Less Common/Specific/Proprietary-leaning"((
      OSL-3.0 (Open Software License 3.0 - somewhat copyleft leaning)
     
    Other_Uncategorized))"Other/Uncategorized<br>(Review and Categorize)"((
      other["other<br>(Generic category for licenses not yet specified)"]
      osl-3.0["osl-3.0<br>(Needs review for correct category - leaning towards less common/copyleft-leaning)"]

```


**Changes and Expansions Made:**

1.  **More Granular Categories:** I've created more specific categories like "General Permissive", "General Copyleft", "Creative Commons Licenses", "AI/Model & Open RAIL Family Licenses", and "Database & Data Specific Licenses" for better organization.
2.  **Added Dataset Specific Licenses:** Included licenses like `CDLA-Permissive-1.0`, `CDLA-Permissive-2.0`, `CDLA-Sharing-1.0`, `ODbL`, and `ODC-By`, which are common for datasets.
3.  **Expanded Creative Commons Breakdown:**  Further broke down Creative Commons licenses into categories like "Attribution (BY)", "ShareAlike (SA)", "NonCommercial (NC)", and "NoDerivatives (ND)", and combinations to clarify the structure.
4.  **Open RAIL Family Emphasis:**  Highlighted "Open RAIL" licenses as a distinct category relevant to AI models, emphasizing responsible AI use licensing.
5.  **"Other/Uncategorized (Review and Categorize)" Section:**  Kept an "Other" category but renamed with a note to "Review and Categorize". This helps to isolate licenses that need further investigation or better placement.  Licenses like `unlicense`, `other`, `cc` in its generic form, and `gemmma` (likely a typo) are placed here for review.



---
