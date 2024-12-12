---
created: 2024-11-11 05:31:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---

# The UIView lifecycle - The standalone view


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
