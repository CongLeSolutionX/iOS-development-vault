---
created: 2024-11-11 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---

# The UIView lifecycle - The standalone view

> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---


```mermaid
graph TD
    A[UIView Initialization] --> B["init(frame:)"]
    A --> C["init(coder:)"]
    B --> D["awakeFromNib()"]
    C --> D
    D --> E["layoutSubviews()"]
    E --> F["draw(_ rect: CGRect)"]
    F --> G["didMoveToSuperview()"]
    G --> H["didMoveToWindow()"]
    H --> I["setNeedsLayout() / layoutIfNeeded()"]
    I --> E
    H --> J["setNeedsDisplay() / setNeedsDisplay(_ rect:)"]
    J --> F
    G --> K["removeFromSuperview()"]
    K --> L[deinit]

```


---
**Licenses:**

- **MIT License:**  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) - Full text in [LICENSE](LICENSE) file.
- **Creative Commons Attribution 4.0 International:** [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/88x31.png)](LICENSE-CC-BY) - Legal details in [LICENSE-CC-BY](LICENSE-CC-BY) and at [Creative Commons official site](http://creativecommons.org/licenses/by/4.0/).

---