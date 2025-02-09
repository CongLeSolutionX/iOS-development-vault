---
created: 2024-17-01 06:13:34
author: Cong Le
version: "1.0"
license(s): MIT, CC BY 4.0
copyright: Copyright (c) 2025 Cong Le. All Rights Reserved.
---


# DNS Record Types
> This content is dual-licensed under your choice of the following licenses:
> 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
> 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

---

 Here's a breakdown of the DNS Record Types diagram using Mermaid syntax, capturing the complexities and relationships shown in the image. I'll create multiple diagrams to cover different aspects:

## 1. Main Diagram: DNS Record Types Overview

```mermaid
graph TD
    A[DNS Record Types] --> B(A - Address);
    A --> C(CNAME);
    A --> D(TXT - Text);
    A --> E(AAAA);
    A --> F(SRV);
    A --> G(PTR);
    A --> H(NS - Name Server);
    A --> I(MX - Mail);

    B --> B1[Domain]
    B1 --> |maps to| B2[IPv4 Address]
    B2 -.-> B3[(Most common DNS Record Type<br>- Used to map FQDN to IPv4)]

    C --> C1[Subdomains]
    C1 --> |maps to| C2[Target Domain]
    C2 -.-> C3[(Simplifies domain management<br>by aliasing one domain to another)]

    D --> D1[domain, record, value]
    D1 -.-> D2[(Allows DNS admins to add<br>human & machine readable notes<br>- Use for verification records like SPF)]

    E --> E1[Domain]
    E1 --> |maps to| E2[IPv6 Address]
    E2 -.-> E3[(Maps domain name to IPv6 address<br>- Used for websites that support IPv6)]

    F --> F1[service, protocol, name, port]
    F1 -.-> F2[(SRV Record specifies a host & port<br>for specific services such as VoIP<br>- Used in conjunction with A record)]
    
    G --> G1[Receiver]
    G1 --> |Who owns IP?| G2[mail.example.com]
    G2 --> G3[DNS]
    G3 -.-> G4[(Provides reverse DNS lookup, mapping<br>an IP to domain name)]

    H --> H1[DNS Resolver]
    H1 --> |queries| H2[DNS Authoritative Server]
    H2 --> H3[Root Server]
    H2 --> H4[TLD Server]
    H4 -.-> H5[(Specifies authoritative DNS Servers for domain<br>- Helps direct queries to correct DNS servers)]
    

    I --> I1[MX Record]
    I1 --> |directs email traffic to| I2[A Record]
    I2 -.-> I3[DNS]
    I3 -.-> I4[(MX Record directs email traffic to<br>the correct mail server<br>- Used with A records)]

    
classDef detail fill:#f29f,stroke:#333,stroke-width:2px;
classDef highlight fill:#c2cf,stroke:#333,stroke-width:2px;

```

## 2. A Record Detail

```mermaid
graph TD
    A[A Record] --> B{Domain};
    B -- maps to --> C{IPv4 Address};
    C --> D>Most common DNS Record Type<br>- Used to map FQDN<br>to an IPv4 address];
```

## 3. CNAME Record Detail

```mermaid
graph TD
    A[CNAME Record] --> B{Subdomains};
    B -- maps to --> C{Target Domain};
    C --> D>Simplifies domain management<br>by aliasing one domain name<br>to another];
```

## 4. TXT Record Detail

```mermaid
graph TD
    A[TXT Record] --> B{domain, record, value};
    B --> C>Allows DNS admins to add<br>limited human & machine<br>readable notes<br>- Use for verification records<br>like SPF for email security];
```

## 5. AAAA Record Detail

```mermaid
graph TD
    A[AAAA Record] --> B{Domain};
    B -- maps to --> C{IPv6 Address};
    C --> D>Maps domain name to an<br>IPv6 address<br>- Used for websites that<br>support IPv6];
```

## 6. SRV Record Detail

```mermaid
graph TD
    A[SRV Record] --> B{service, protocol, name, port};
    B --> C>SRV Record specifies a<br>host & port for specific<br>services such as VoIP<br>- Used in conjunction with<br>A record];
```

## 7. PTR Record Detail

```mermaid
graph TD
    A[PTR Record] --> B{Receiver};
    B -- Who owns IP? --> C{mail.example.com};
    C --> D[DNS];
    D --> E>Provides reverse DNS<br>lookup, mapping an IP<br>address to domain name];
```

## 8. NS Record Detail

```mermaid
graph TD
    A[NS Record] --> B{DNS Resolver};
    B -- queries --> C{DNS Authoritative Server};
    C --> D[Root Server];
    C --> E[TLD Server];
    E --> F>Specifies the authoritative<br>DNS Servers for the domain<br>- Helps direct queries to<br>correct DNS servers];
```

## 9. MX Record Detail

```mermaid
graph TD
    A[MX Record] --> B{MX Record};
    B -- directs email traffic to --> C{A Record};
    C --> D[DNS];
    D --> E>MX Record directs email<br>traffic to the correct mail<br>server<br>- Used in conjunction with<br>A records];
```

## Explanation of the Diagrams

*   **Main Diagram:** Shows the relationships between different DNS record types and provides an overview of their purposes.
*   **Detail Diagrams:** Each record type (A, CNAME, TXT, AAAA, SRV, PTR, NS, MX) has its own diagram, providing a more detailed breakdown of its structure and function.
*   **Nodes and Edges:**
    *   Nodes represent entities like "DNS Record Types," "Domain," "IPv4 Address," etc.
    *   Edges (arrows) represent relationships like "maps to," "queries," etc.
    *   Dotted edges with text boxes are used to provide additional information and context.

### Mermaid Features Used:

*   `graph TD`: Defines a top-down flowchart.
*   `-->`: Represents a directed edge (arrow).
*   `-.->`: Represents a dotted directed edge.
*   `|text|`: Adds text to an edge.
*   `classDef`: Defines styles for nodes (not fully utilized in the provided example, but can be added to enhance visualization).
*   `>...<br>...`: Formats text within a node.
*   `(...)`: Creates rounded rectangle nodes.
*   `{...}`: Creates diamond-shaped nodes.
*   `[...]`: Creates rectangle nodes.


---
