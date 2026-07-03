# Pyramid Principle

Related: [SCR/SCQA](02-scr-scqa-communication.md), [MECE issue trees](04-mece-issue-trees.md), [presentation checklist](10-presentation-review-checklist.md)

## Purpose

The Pyramid Principle is an answer-first communication method: lead with the governing thought, then support it with grouped reasons and evidence.

## Direct Source

Barbara Minto's official site says the principle organizes ideas as a pyramid under a single point so the reader can grasp the thinking. Public materials describe it as a technique for working out thinking before presenting it clearly.

Minto's site also says the 1996 edition `The Minto Pyramid Principle: Logic in Writing, Thinking and Problem Solving` supersedes the earlier `The Pyramid Principle: Logic in Writing and Thinking`.

## Extension For Product Development

Use the pyramid for:

- PRD executive summaries;
- RFC decision sections;
- product strategy memos;
- market analysis;
- incident reviews;
- design critiques;
- AI evaluation reports;
- leadership updates.

The pyramid should answer: "What should we believe or do, and why?"

## Structure

```text
Main answer / recommendation
  Reason 1
    Evidence
    Implication
  Reason 2
    Evidence
    Implication
  Reason 3
    Evidence
    Implication
```

Each group should contain ideas at the same logical level. Do not mix root causes, solutions, metrics and stakeholders in one sibling list.

## Good Main Answers

Weak:

- "Analysis of onboarding."
- "We looked at checkout performance."
- "AI review seems useful."

Better:

- "We should redesign onboarding around first-value completion, because activation drops before users reach the core workflow."
- "Checkout reliability should be prioritized over visual polish this sprint, because payment confirmation defects are now the largest revenue risk."
- "AI review should roll out only for low-risk modules until evals and ownership are stable."

## Storyline For Engineering Decisions

1. Recommendation.
2. Why now.
3. Why this option beats alternatives.
4. Evidence and uncertainty.
5. Risks and guardrails.
6. Decision needed.

## Checklist

- Can the whole recommendation fit in one sentence?
- Are supporting points mutually distinct and collectively enough?
- Does each supporting point directly support the main answer?
- Are the points ordered by importance, causality, chronology or process?
- Is evidence attached to claims?
- Does every chart, table or code finding have a `so what`?
- Would a skeptical stakeholder know what to challenge?

## Red Flags

- The conclusion is hidden at the end.
- The file reads like "what we did" rather than "what we learned".
- The same argument appears under multiple headings.
- Evidence is listed without implication.
- The recommendation is too vague to act on.
- There are more than 5 top-level reasons without a clear grouping rule.

## Example Prompts

- "Rewrite this RFC into pyramid structure with one governing thought."
- "Find claims that do not support the main recommendation."
- "Group these findings into 3 logical reasons and add the missing so what."
- "Turn this analysis into an executive summary."
