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

The sections on shared capacity, product boundary tradeoffs and foundation exceptions add a separately attributed practitioner lens from Cagan's *Вдохновленные*; see [source scope](00_README.md#direct-sources-vs-extensions). They complement Team Topologies' team types, interaction modes and cognitive-load guidance.

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

## Conflicting Objectives And Shared Capacity

When a team's goal slips, inspect competing assignments to the same people. A functional initiative can be valuable yet displace a shared product result if engineers, designers or QA receive it independently of team priorities. Make the work visible and reconcile priorities and capacity through responsible leaders; functional management and individual learning goals remain legitimate.

Across teams, look for uncovered work, inconsistent proposed results and dependencies between platform and consuming teams. A platform goal may support business outcomes indirectly, and important maintenance can sit outside leading corporate objectives. Coordination makes these relationships explicit; it does not itself authorize reorganization.

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

### Product Boundary Tradeoffs

For a boundary decision, compare customer/segment, journey, device, business-capability and architectural options against actual work. Ask what each team can change today, which skills and architecture constrain it, what future investment it enables and where coordination costs move. Shared customers across business units may need a coherent experience even when budgets differ. Architectural alignment is not automatically a defect; distinguish feasible current ownership from a path toward better value flow.

Include continuing responsibility for defects, performance, optimization and content where relevant. Compare a new boundary's gain with lost domain knowledge, relationships and change effort. Record the decisive benefit, sacrifice and conditions for reconsideration. Prefer triggers such as changed investment or persistent dependency cost to a mandatory reorganization calendar.

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
- Platform goals and commitments reflect consuming teams' needs and dependencies.

### Shared-Foundation Exceptions

When a team wants to depart from a shared foundation, investigate the conflict. Consider competence, speed, integration, where innovation is needed, team size/location, working culture, foundation maturity, business criticality and accountability. These are contextual questions, not an additive score or permanent grade for a team.

Check readiness for consuming work and where an exception transfers integration, maintenance or reliability costs. Standardizing an immature component can harm dependent teams; a capable accountable team may have a sound reason to improve or replace it. If innovation belongs in the product solution, reducing foundational variation may help without freezing the foundation.

Before interpreting repeated disagreements as incompetence or mistrust, inspect product direction and team goals. Preserve real technical constraints and decision authority; communication does not dissolve every conflict. Compare standard use, improving the shared service and a bounded exception by relevant consequences.

## Red Flags

- "Platform" means a team that manually handles tickets.
- Every feature requires front-end, back-end, data and infra handoffs.
- Technical-layer boundaries create repeated handoffs without a compensating capability or ownership benefit.
- Collaboration between teams remains costly without revisiting the needed interaction mode; this differs from sustained joint work inside a product team.
- Cognitive load is ignored because the team is "senior".
- Ownership is unclear after launch.

## Example Prompts

- "Review this architecture with Team Topologies fast-flow lens."
- "Name team types and interaction modes for this initiative."
- "Find handoffs and cognitive-load risks in this roadmap."
- "Turn this platform idea into an internal product promise."
