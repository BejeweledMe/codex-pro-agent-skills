# SCR And SCQA Communication

Related: [business thinking](01-business-thinking.md), [pyramid principle](03-pyramid-principle.md), [presentation checklist](10-presentation-review-checklist.md)

## Purpose

SCR and SCQA help turn messy analysis into a short business narrative. They are useful for emails, RFCs, PRDs, deck summaries, demos, postmortems and executive updates.

## Direct Source

Management Consulted describes SCR as `Situation -> Complication -> Resolution`, updated April 2, 2026, and positions it for presentations, emails and reports. The same article distinguishes SCR from SCQA: SCR is shorter and more answer-first, while SCQA includes `Question` and `Answer`.

Barbara Minto's official site uses `SCQ Framework`, not necessarily `SCQA`: Situation, Complication, Question. StrategyU uses SCQA as Situation, Complication, Question, Answer and places it inside the consulting workflow.

## When To Use SCR

Use SCR when the audience needs speed:

- executive email;
- project status;
- incident update;
- release decision;
- sales or stakeholder briefing;
- short deck summary.

Template:

```text
Situation: What is the stable context or current state?
Complication: What changed, broke, blocked or became risky?
Resolution: What should we do now?
Ask: What decision or action is required?
```

## When To Use SCQA

Use SCQA when the audience needs to follow the reasoning:

- PRD;
- strategy memo;
- root-cause analysis;
- market or product opportunity;
- postmortem;
- architecture option review.

Template:

```text
Situation: Shared context.
Complication: Tension, change, gap, risk or opportunity.
Question: The central decision or investigation question.
Answer: Recommendation or conclusion.
```

## Product Engineering Examples

### RFC

```text
Situation: Checkout failures are concentrated in payment confirmation.
Complication: Retry logic hides the failure from dashboards and support sees repeated tickets.
Question: Should we redesign the payment state machine or add another retry layer?
Answer: Redesign the state machine; retries reduce symptoms but increase ambiguity and support cost.
```

### Executive Update

```text
Situation: AI-assisted code review is available in the repo.
Complication: Review latency improved, but escaped defects rose in payment code.
Resolution: Keep AI review for low-risk modules and require human review plus tests for payment paths.
Ask: Approve a two-week guarded rollout instead of broad enablement.
```

## Checklist

- Is the situation factual and short?
- Does the complication explain why action is needed now?
- Is the question actually the stakeholder's decision?
- Is the answer or resolution concrete?
- Does the narrative say what the audience should do next?
- Is the recommendation supported by evidence, not just activity?
- Are risks and trade-offs visible?

## Red Flags

- Context takes most of the message and the recommendation appears late.
- "Complication" is just a complaint, not a decision-relevant change.
- The question is too broad to answer.
- The answer is a feature list.
- The ask is missing.
- The narrative is a work diary rather than a decision aid.

## Example Prompts

- "Turn this status update into SCR and add the missing ask."
- "Use SCQA to frame this PRD before listing requirements."
- "Find the complication in this memo and sharpen it."
- "Rewrite this postmortem summary so leadership can decide what to fund."
