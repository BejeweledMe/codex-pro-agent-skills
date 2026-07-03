# MECE And Issue Trees

Related: [business thinking](01-business-thinking.md), [product and market analysis](05-product-discovery-and-market-analysis.md), [pyramid principle](03-pyramid-principle.md)

## Purpose

MECE helps decompose a problem into buckets that do not overlap and do not leave important gaps. Issue trees turn those buckets into an investigation plan.

## Direct Source

MECE stands for `mutually exclusive, collectively exhaustive`. StrategyU presents MECE and issue trees as consulting tools for structuring problem solving. The user-provided PrepLounge URL was not accessible during verification, so this folder does not rely on it as a direct source.

## Extension For Product Development

Use MECE for:

- why a product metric changed;
- user or account segmentation;
- defect taxonomy;
- support ticket themes;
- roadmap options;
- architecture alternatives;
- risk categories;
- experiment design;
- workstreams across a team.

## Issue Tree Pattern

Start with a question:

```text
Why did activation drop?
  1. Acquisition quality changed
  2. First-session UX degraded
  3. Core value was not reached
  4. Technical reliability worsened
  5. Pricing or access blocked users
```

Then turn each branch into testable hypotheses:

```text
First-session UX degraded
  - Are users failing at signup?
  - Are they skipping required setup?
  - Are they confused by first screen?
  - Did time-to-first-value increase?
```

## MECE Tests

- `No overlap`: can one observation belong to two buckets?
- `No gaps`: where would an unexpected observation go?
- `Same level`: are all buckets causes, segments, options or steps?
- `Useful`: does the decomposition help choose work?
- `Testable`: can each branch be supported or rejected by evidence?

## Common Product Decompositions

### Metric Drop

- Measurement change.
- Traffic mix change.
- User behavior change.
- Product experience change.
- Reliability/performance change.
- External market or competitor change.

### Feature Opportunity

- User pain.
- Business value.
- Feasibility.
- Viability.
- Adoption friction.
- Risk and compliance.

### Technical Decision

- User impact.
- Business impact.
- Operational impact.
- Security/reliability impact.
- Team ownership impact.
- Reversibility.

## Where MECE Fails

MECE is a tool, not a worldview. Complex systems can have interacting causes. If categories overlap in reality, do not force false separation. Use MECE to organize inquiry, then let data and qualitative evidence update the tree.

## Red Flags

- "Other" becomes the largest bucket.
- Buckets mix causes and symptoms.
- A branch mirrors org structure instead of the problem.
- The tree creates workstreams before the core question is clear.
- The agent treats MECE as proof rather than a hypothesis map.
- Important second-order effects are excluded because they do not fit the tree.

## Example Prompts

- "Build a MECE issue tree for this product metric drop."
- "Find overlaps and gaps in this decomposition."
- "Convert this issue tree into research questions and data checks."
- "Separate causes, symptoms, solutions and stakeholders."
