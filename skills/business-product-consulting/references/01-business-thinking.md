# Business Thinking

Related: [SCR/SCQA](02-scr-scqa-communication.md), [MECE issue trees](04-mece-issue-trees.md), [product and market analysis](05-product-discovery-and-market-analysis.md), [risk](09-risk-and-second-order-effects.md)

## Purpose

Business thinking connects a request to the decision and constraints that matter for its outcome. Reuse known business context and accepted choices; when implementation is already requested, resolve only gaps that could materially alter that work.

## Core Idea

Every product engineering task sits inside a business situation:

- a user behavior should change;
- a cost, risk or delay should go down;
- revenue, retention, trust, reliability or speed should improve;
- a stakeholder needs a decision, not just information.

If the task cannot be tied to one of these, the agent should make the gap explicit.

## Direct Source

StrategyU frames consulting as a process: define the problem, research, form questions/hypotheses, refine, then tell the story. Management Consulted describes SCR as a way to clarify situation, complication and resolution before communicating.

The framing-depth and product-commitment additions draw on Cagan's *Вдохновленные*; see [source scope](00_README.md#direct-sources-vs-extensions). Examples and decision prompts are applied synthesis, not measured claims about effectiveness.

## Extension For Product Development

For an unresolved product decision, establish the relevant fields or reuse them from context:

- `business problem`: what hurts the company or product;
- `user problem`: what hurts the user, operator, buyer or internal team;
- `decision`: what must be chosen now;
- `desired outcome`: what should improve;
- `constraints`: time, cost, risk, legal, quality, architecture, team capacity;
- `non-goals`: what should not be solved in this change.

### Choose The Framing Depth

Use the light framing above for ordinary product decisions. If a substantial initiative is hard to understand, a clearly fictional future customer account and a short explanation of the business benefit can make the intended change concrete. They express a proposal, not observed demand or an actual testimonial. For a new business, widen inquiry to linked assumptions about value, revenue, channels, costs and market; avoid rebuilding an unchanged business model for every feature. Use the [lightweight product memo](05-product-discovery-and-market-analysis.md#a-lightweight-marketproduct-memo) when it helps the decision.

## Questions Before Doing Work

- What changed in the situation?
- Why is this important now?
- Who is the stakeholder and what decision do they need?
- What happens if nothing changes?
- Which user or customer segment is affected?
- What is the smallest useful outcome?
- What would make this work a bad idea?
- What trade-off are we accepting?
- What metric can move without creating fake progress?
- Who will own this after launch?

## Business Value Layers

- `Revenue`: conversion, expansion, retention, pricing power.
- `Cost`: support load, manual operations, cloud spend, rework, incident cost.
- `Risk`: compliance, security, trust, safety, reputation.
- `Speed`: lead time, decision latency, cycle time, unblock rate.
- `Quality`: reliability, correctness, UX, maintainability.
- `Strategic option`: learning, market entry, platform leverage, future capability.

Do not claim business value generically. Say which layer is expected to move and what would falsify that assumption.

## Realized Economics

For a cost or productivity claim, define the useful delivered outcome, required quality, accounting boundary, and comparison period. Compare total cost per accepted task, valid prediction, or completed workload at the same quality and service requirements. Count review, redo, support, failure/recovery waste, idle capacity, data staging, and egress where they fall inside that boundary; generated output or allocated compute time alone is not delivered value.

Distinguish cash savings, avoided future spend, and released capacity. A utilization gain or faster step becomes savings only through a lower bill, shorter paid runtime, removed or avoided capacity, or another measured financial change. If staff time is released, identify the work it can realistically absorb and its value; do not book both unchanged payroll as cash savings and that same time as additional capacity. State the adoption, traffic, lifetime, and bottleneck assumptions that connect the local gain to the business result.

For ML data-selection proposals, compare selection plus training on the selected data with full-data and random-subset alternatives under the same total budget and evaluation conditions. Include scoring, annotation, indexing, I/O, and justified future reuse, not just the smaller training bill. Use quality at fixed total cost or total cost to the required quality; a selector that loses protected rare or safety-relevant slices is not an economic success. Model/data owners establish those quality floors and measurements; this skill evaluates the business trade-off.

Keep an estimate distinct from a realized result and show which changed cost or outcome supports the claim. Use current price and workload evidence for numerical projections; efficiency does not establish a universal savings ratio.

## Estimates And Product Commitments

Preliminary estimates are legitimate planning inputs. State the assumed solution, a useful range and uncertainties that could change it. When turning an estimate into a scope/date promise, account for relevant investigation, iteration capacity, queued work and dependencies. A business constraint may require committing before uncertainty is resolved: make assumptions, accepted risks and conditions for revisiting scope or date explicit. Describe useful work displaced when it affects the choice; do not invent an opportunity-cost total or assume every change needs multiple releases.

Keep expected impact separate from delivery confidence and realized results. If project funding or staffing ends at release, identify who can still assess the outcome and respond to evidence. For the team's promise and coordination basis, see [product operating model](../../product-design/references/02-product-operating-model.md#основание-для-обязательства).

## Example Translation

Request: "Add AI summary to tickets."

Better framing:

- Situation: support agents spend time reading long ticket threads.
- Complication: response time is rising and senior agents are becoming a bottleneck.
- Decision: should we automate ticket summarization or fix routing and templates first?
- Desired outcome: reduce time to first useful response without increasing wrong answers.
- Guardrails: summary correctness, escalation quality, customer satisfaction, privacy.
- Ownership: support tooling team owns prompt/eval/release; support ops owns workflow policy.

When stakeholders request conflicting features, identify their interests before averaging the requests. Support may want shorter reading time while compliance wants the original record preserved. A linked summary with traceable source text may address both concerns; whether it saves time and supports review remains to be established. A compatible design does not remove required decision authority.

## Red Flags

- An unresolved product choice starts with a solution and has no known problem or outcome.
- "Business value" means "we shipped it".
- Stakeholder is unclear.
- User, buyer and operator are treated as the same person.
- There is no downside or failure condition.
- The agent selects UI, model, vendor or architecture without a known outcome when that selection is the requested decision.
- Success metric can be gamed by doing more low-value work.

## Example Prompts

- "Rewrite this ticket as SCR with a clear business outcome."
- "List the stakeholders, desired outcomes and non-goals before implementation."
- "What decision does this PRD actually ask leadership to make?"
- "What would make this feature not worth building?"
