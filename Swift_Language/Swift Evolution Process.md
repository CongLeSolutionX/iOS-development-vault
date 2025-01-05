---
source_url: "https://github.com/swiftlang/swift-evolution/blob/main/process.md"
created: 2025-02-05 03:50:26
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
---

Below is a breakdown of the diagrams I will create, aligning with [the original documentation](https://github.com/swiftlang/swift-evolution/blob/main/process.md):

1. **Overview Diagram:** Create a high-level flowchart of the entire process from idea to implementation.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph LR
    subgraph Swift Evolution Process Overview
        direction LR
        A[Idea/Problem] --> B{"Socialize the Idea (Pitches Forum)"};
        B --> C{Develop Formal Proposal & Implementation};
        C -- Draft PR to swift-evolution repo --> D{Request a Review};
        D -- Review Manager Accepts --> E{Review Process};
        E -- Decision Made --> F{Proposal States};
        F --> G{"Implemented (Swift Next)"};
    end
    
```


---
2. **Proposal Lifecycle Diagram:** Focus on the different stages a proposal goes through.


```mermaid
sequenceDiagram
    participant Community Member
    participant Pitches Forum
    participant Swift Evolution Repository
    participant Review Manager
    participant Proposal Reviews Forum
    participant Language Steering Group
    participant Swift Implementation

    Community Member->>Pitches Forum: Pitch a Rough Idea
    Pitches Forum-->>Community Member: Community Feedback
    Community Member->>Swift Evolution Repository: Create Draft Proposal (PR)
    Community Member->>Pitches Forum: Announce Draft PR
    Swift Evolution Repository-->>Community Member: Feedback/Refinement
    Community Member->>Swift Evolution Repository: Mark PR as Ready for Review
    Review Manager->>Swift Evolution Repository: Accept Proposal
    Review Manager->>Proposal Reviews Forum: Announce Review
    Proposal Reviews Forum-->>Community Member: Review Feedback
    Community Member->>Review Manager: Respond to Feedback
    Review Manager->>Language Steering Group: Determine Consensus
    Language Steering Group->>Review Manager: Decision (Accept/Reject/Revise)
    Review Manager->>Swift Evolution Repository: Update Proposal State
    Review Manager->>Proposal Reviews Forum: Announce Decision
    alt Proposal Accepted
        Review Manager->>Swift Implementation: Implement Proposal
    end
```

---

3. **Community Structure Diagram:** Illustrate the roles of the Core Team and Language Steering Group.

```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Community Structure
        direction TB
        A(Core Team) --> B{Create Workgroups};
        B --> C{Evolution Workgroups};
        C --> D(Language Steering Group);
        D -- Authority over --> E{Swift Language & Standard Library Evolution};
        A -- Manage/Delegate --> F{Other Evolution Areas};
        A -- Override --> C;
    end
```

---

4. **Participation Diagram:** Show how the community can engage in the process.


```mermaid
graph TD
    subgraph How_to_Propose_a_Change["How to Propose a Change"]
        direction TB
        A["Check Prior Proposals <br> (Forums, Rejected List)"] --> B{"Consider Goals of Upcoming Swift Release"};
        B --> C{"Socialize the Idea <br> (Pitches Forum)"};
        C --> D{"Develop Proposal & Implementation"};
        D --> E{"Expand Sketch to Formal Proposal <br> (Template)"};
        E --> F{"Open Draft PR in swift-evolution Repo"};
        F --> G{"Announce PR on Forums"};
        G --> H{"Refine Proposal <br> (Feedback)"};
        H --> I{"Work on Implementation"};
        I --> J{"Working Implementation Required for Review"};
        J --> K{"Request a Review <br> (Mark PR as Ready)"};
    end
    
```



---

5. **Review Process Diagram:** Detail the steps involved in reviewing a proposal.

6. **Proposal States Diagram:**  (The documentation already provides a basic Mermaid diagram for this, I can enhance it if needed).

7. **How to Propose a Change Diagram:**  Show the steps involved in creating and submitting a proposal.


8. **What Goes into a Review Diagram:** Highlight the key questions to consider during a review.


```mermaid
graph TD
    subgraph What_Goes_into_a_Review["What Goes into a Review"]
        direction TB
        A["What is your evaluation of the proposal?"] --> B;
        C["Is the problem significant enough?"] --> B;
        D["Does this fit with the feel of Swift?"] --> B;
        E["Comparison to other languages/libraries?"] --> B;
        F["How much effort did you put into the review?"] --> B;
        B{"State explicitly whether proposal should be accepted"};
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
flowchart LR
    subgraph Review_Process["Review Process"]
        direction TB
        A[Review Manager Accepts PR] --> B{Proposal Enters Review Queue};
        B --> C{Review Manager Schedules Review};
        C --> D{Review Announced on Forums};
        D --> E{Community Provides Feedback};
        E --> F{Authors Respond to Feedback};
        F --> G{Evolution Workgroup Determines Consensus};
        G --> H{"Decision Made <br> (Accept/Reject/Revise)"};
        H --> I{Review Manager Reports Decision};
        I --> J{Proposal State Updated};
    end
    
```


---




```mermaid
stateDiagram-v2
    state Awaiting_Review <<initial>>
    state Scheduled_for_review
    state Active_review
    state Returned_for_revision
    state Withdrawn <<end>>
    state Rejected <<end>>
    state Accepted
    state Accepted_with_revisions
    state Previewing
    state Implemented <<end>>

    [*] --> Awaiting_Review
    Awaiting_Review --> Scheduled_for_review : Review Scheduled
    Scheduled_for_review --> Active_review : Review Begins
    Active_review --> Accepted : Accepted
    Active_review --> Accepted_with_revisions : Accepted with Revisions
    Active_review --> Rejected : Rejected
    Active_review --> Returned_for_revision : Returned for Revision
    Active_review --> Withdrawn : Withdrawn
    Returned_for_revision --> Awaiting_Review : Resubmitted
    Accepted --> Implemented : Implemented
    Accepted_with_revisions --> Previewing : Revisions Complete
    Previewing --> Implemented : Implemented
```

---



```mermaid
---
config:
  layout: elk
  look: handDrawn
  theme: dark
---
graph TD
    subgraph Types_of_Evolution_Documents["Types of Evolution Documents"]
        direction TB
        A[Evolution Proposal] --> B{"Specific Proposed Change <br> (Detailed)"};
        C[Evolution Roadmap] --> D{"Concrete Plan for Complex Change (Separate Proposals)"};
        E[Evolution Vision] --> F{"High-Level Design for Broad Topic <br>(Goals & Program of Work)"};
        F -- Requires Approval by --> G(Appropriate Evolution Workgroup);
        G --> E;
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
graph TD
    subgraph Community_Participation["Community Participation"]
        direction TB
        A[Evolution Section of Swift Forums] --> B{Propose Ideas};
        A --> C{Discuss Proposals};
        A --> D{Review Proposals};
        E[Before Posting Review] --> F{"Check 'What goes into a review?' "};
        B --> E;
        C --> E;
        D --> E;
    end
    
```



---

