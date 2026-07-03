# Developer Productivity With SPACE

Related: [AI-assisted development](07-ai-assisted-development-dora.md), [Team Topologies](08-team-topologies-fast-flow.md), [risk](09-risk-and-second-order-effects.md)

## Purpose

SPACE prevents teams from measuring developer productivity with one noisy number. It is especially useful when evaluating dev tools, platform work, AI coding, CI/CD, code review, onboarding, incidents and process changes.

## Direct Source

The ACM Queue article defines SPACE as:

- `Satisfaction and well-being`;
- `Performance`;
- `Activity`;
- `Communication and collaboration`;
- `Efficiency and flow`.

The article warns against single-metric productivity measurement and against using activity measures in isolation.

It also cautions that metrics must be interpreted at the right level - individual, team or system - and that organizations should handle developer privacy, aggregation, bias and cultural norms carefully.

## Extension For Product Development

Use SPACE whenever a proposed change claims to "make engineering faster". Ask faster at what, for whom, with what quality and downstream effect?

## Metric Design

A useful productivity view should include at least three dimensions. Example for code review:

- Satisfaction: do engineers see review as useful or frustrating?
- Performance: escaped defects, reliability, customer impact.
- Activity: review count, PR count, commits.
- Communication: review quality, knowledge spread, onboarding.
- Efficiency/flow: review latency, handoffs, interruption timing.

Activity is allowed, but it is not enough.

## AI Coding Evaluation Through SPACE

- Satisfaction: does AI reduce toil or create anxiety/rework?
- Performance: defect rate, security findings, maintainability.
- Activity: tasks completed, PRs, generated tests.
- Communication: review clarity, shared understanding, documentation.
- Efficiency/flow: lead time, wait time, interruptions, context switching.

If AI increases activity but worsens quality or collaboration, it is not a clean productivity win.

## Checklist

- What decision will the metric support?
- Which SPACE dimensions are included?
- Which dimension is missing and why?
- Is this metric individual, team, group or system-level?
- Is at least one perceptual measure included?
- Are metrics aggregated at an appropriate level?
- Are individual-level signals private or opt-in where appropriate?
- Are results anonymized and aggregated before management reporting?
- What bias, norm or context could distort the metric?
- Could this metric punish invisible work?
- Could it be gamed?
- What guardrail catches burnout, defects or rework?
- What action will be taken if the metric moves?

## Red Flags

- Productivity equals commits, story points, PR count or lines of code.
- Individual ranking from telemetry.
- No satisfaction or well-being signal.
- No quality or customer outcome.
- Local speed hides downstream rework.
- Collaboration is treated as overhead.
- Metrics are compared across teams with different context.

## Example Prompts

- "Design a SPACE metric set for this platform initiative."
- "Review this AI coding rollout for productivity measurement risk."
- "Find vanity metrics in this engineering dashboard."
- "Add guardrails so faster delivery does not hide rework."
