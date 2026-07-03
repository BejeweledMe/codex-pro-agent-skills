# Decision Making And Productivity Measurement

Use when: comparing designs, choosing process changes, measuring developer productivity,
or deciding whether an engineering metric is worth collecting.

## Core Ideas

- Good engineering decisions combine data, assumptions, precedent, argument, and cost. Data should dominate where possible, but not every important factor is directly measurable.
- Ambiguous problems rarely have permanent answers. Mature teams decide, observe, and revise when evidence changes.
- Trade-offs are first-class: time, scale, quality, risk, reversibility, ownership, user impact, and operational cost all matter.
- Productivity measurement is only useful if it leads to action. A metric that cannot change decisions is usually noise.
- Google frames useful productivity measurement through goals, signals, and metrics, then checks whether metrics actually represent the intended signal.
- QUANTS reminds teams not to optimize one dimension, such as velocity, while damaging quality, attention, satisfaction, or other system health.
- Qualitative evidence matters. Surveys, interviews, and narratives can reveal context that raw numbers miss.

## Practices

- State the decision, alternatives, assumptions, and expected cost of being wrong.
- Prefer reversible choices when uncertainty is high and irreversible choices only when the value justifies the risk.
- Use metrics at aggregate system level, not as a scorecard for individual engineers.
- Define the goal first, then the signal, then the metric. Do not start from numbers that are easy to collect.
- Validate metrics against qualitative feedback. If numbers and lived experience disagree, investigate the metric before blaming people.
- Build recommendations into the developer workflow and incentive structure, not just training slides.
- Track whether a process change improved the intended outcome and whether it harmed adjacent outcomes.

## Anti-Patterns

- Measuring because data is available rather than because the result is actionable.
- Using productivity metrics for performance reviews, which encourages gaming and destroys trust.
- Optimizing lines of code, change count, or raw velocity as if they were value.
- Treating a trade-off as solved forever after one decision.
- Hiding assumptions behind "data-driven" language.
- Making process heavier without evidence that the added cost pays for itself.

## Agent Checklist

- What decision will this measurement change?
- What is the goal, what is the signal, and why is this metric a reasonable proxy?
- What adjacent quality or satisfaction dimension could be harmed?
- Is this metric aggregate and system-improvement oriented?
- What qualitative evidence should be collected alongside numbers?
- What assumptions must be revisited after rollout?

## Cross-Links

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md)
- [04-leadership-ownership-and-delegation.md](04-leadership-ownership-and-delegation.md)
- [09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
