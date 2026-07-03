# Team Topologies For Fast Flow

Related: [business thinking](01-business-thinking.md), [AI-assisted development](07-ai-assisted-development-dora.md), [risk](09-risk-and-second-order-effects.md)

## Purpose

Team Topologies helps evaluate whether product and architecture decisions will let value flow quickly or create dependency, handoff and cognitive-load problems.

## Direct Source

Team Topologies describes itself as an approach to designing team-of-teams organizations for fast flow of value. Its key concepts page lists four fundamental team types:

- stream-aligned team;
- enabling team;
- complicated subsystem team;
- platform team.

It also lists three interaction modes:

- collaboration;
- X-as-a-Service;
- facilitation.

The official public page says the second edition was released on September 23, 2025 and adds new case studies.

The key concepts page also cautions that Team Topologies is not primarily an org-chart drawing method. It is a way to understand how work flows, where business performance slows down, and how team relationships should evolve as goals and learning change. Using only one part of the approach - for example team types without interaction modes and cognitive load - is unlikely to be enough.

## Extension For Product Development

Use Team Topologies in product and architecture review:

- Which team owns the value stream?
- Does the architecture match team boundaries?
- Where are handoffs slowing work?
- Is a platform reducing cognitive load or acting as a ticket queue?
- Are interactions explicit or vague?
- Does the solution create long-term coordination cost?

## Team Type Lens

- `Stream-aligned`: owns a flow of value for a customer, user segment, business capability or product area.
- `Enabling`: temporarily helps teams learn a capability or remove an obstacle.
- `Complicated subsystem`: owns specialized work that requires deep expertise.
- `Platform`: provides internal products that let stream teams deliver faster with less cognitive load.

Avoid creating a new team type when one of these explains the responsibility.

## Interaction Mode Lens

- `Collaboration`: high-bandwidth joint discovery for a limited period.
- `X-as-a-Service`: one team consumes a clear service from another.
- `Facilitation`: one team mentors or helps another team become capable.

If a dependency has no interaction mode, it will usually become meetings, tickets and waiting.

## Architecture Review Questions

- Does one team own the path from idea to user value?
- Which dependencies are permanent?
- Can the platform be consumed self-service?
- Is the platform treated as a product with internal customers?
- What is the thinnest viable platform that reduces cognitive load now?
- Does the design reduce or increase cognitive load?
- Are boundaries based on value streams or technical layers?
- What would change when the product grows?
- How will team relationships change when new learning appears?
- Which team wakes up when this breaks?

## Platform Checklist

- Clear internal customer.
- Product promise and service boundaries.
- Thinnest viable platform scope.
- Self-service path.
- Documentation and support model.
- Adoption metrics.
- Reliability and ownership.
- No unnecessary scope.
- Feedback loop from stream-aligned teams.

## Red Flags

- "Platform" means a team that manually handles tickets.
- Every feature requires front-end, back-end, data and infra handoffs.
- Team boundaries mirror technical layers, not value streams.
- Collaboration is permanent and expensive.
- Cognitive load is ignored because the team is "senior".
- Ownership is unclear after launch.

## Example Prompts

- "Review this architecture with Team Topologies fast-flow lens."
- "Name team types and interaction modes for this initiative."
- "Find handoffs and cognitive-load risks in this roadmap."
- "Turn this platform idea into an internal product promise."
