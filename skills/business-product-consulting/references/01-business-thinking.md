# Business Thinking

Related: [SCR/SCQA](02-scr-scqa-communication.md), [MECE issue trees](04-mece-issue-trees.md), [product and market analysis](05-product-discovery-and-market-analysis.md), [risk](09-risk-and-second-order-effects.md)

## Purpose

Business thinking is the habit of treating a request as a decision under constraints, not as a task to execute. A good agent should ask what outcome the work is meant to change before choosing code, architecture, UI or process.

## Core Idea

Every product engineering task sits inside a business situation:

- a user behavior should change;
- a cost, risk or delay should go down;
- revenue, retention, trust, reliability or speed should improve;
- a stakeholder needs a decision, not just information.

If the task cannot be tied to one of these, the agent should make the gap explicit.

## Direct Source

StrategyU frames consulting as a process: define the problem, research, form questions/hypotheses, refine, then tell the story. Management Consulted describes SCR as a way to clarify situation, complication and resolution before communicating.

## Extension For Product Development

Before implementation, translate the request into:

- `business problem`: what hurts the company or product;
- `user problem`: what hurts the user, operator, buyer or internal team;
- `decision`: what must be chosen now;
- `desired outcome`: what should improve;
- `constraints`: time, cost, risk, legal, quality, architecture, team capacity;
- `non-goals`: what should not be solved in this change.

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

## Example Translation

Request: "Add AI summary to tickets."

Better framing:

- Situation: support agents spend time reading long ticket threads.
- Complication: response time is rising and senior agents are becoming a bottleneck.
- Decision: should we automate ticket summarization or fix routing and templates first?
- Desired outcome: reduce time to first useful response without increasing wrong answers.
- Guardrails: summary correctness, escalation quality, customer satisfaction, privacy.
- Ownership: support tooling team owns prompt/eval/release; support ops owns workflow policy.

## Red Flags

- The task starts with a solution and has no problem statement.
- "Business value" means "we shipped it".
- Stakeholder is unclear.
- User, buyer and operator are treated as the same person.
- There is no downside or failure condition.
- The agent suggests UI, model, vendor or architecture before outcome.
- Success metric can be gamed by doing more low-value work.

## Example Prompts

- "Rewrite this ticket as SCR with a clear business outcome."
- "List the stakeholders, desired outcomes and non-goals before implementation."
- "What decision does this PRD actually ask leadership to make?"
- "What would make this feature not worth building?"
