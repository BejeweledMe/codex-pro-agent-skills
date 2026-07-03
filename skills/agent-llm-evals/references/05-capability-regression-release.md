# Capability Regression Release

Use when: evaluating a new agent capability, prompt change, model upgrade, tool change, multi-agent architecture, or release candidate.

## Core Ideas

- Capability evals answer: what can the agent do?
- Regression evals answer: did we preserve behavior we already rely on?
- A high pass rate can be good for regression but weak for measuring improvement.
- Agent behavior is nondeterministic; repeated trials and consistency metrics matter.
- Release decisions should combine evals, tests, traces, production guardrails and rollback criteria.

## Capability Evals

Use capability evals when:

- Building a new feature.
- Comparing model, prompt, tool or architecture variants.
- Measuring whether a previously impossible workflow is now feasible.
- Testing future-facing bets.

Properties:

- May start with low pass rate.
- Should include hard tasks.
- Should evolve as models improve.
- Should be inspected for saturation.

If a capability eval reaches near-perfect pass rate, it may become a regression suite and a harder capability suite should be added.

## Regression Evals

Use regression evals when:

- Changing prompt, model, routing, tool schemas or policies.
- Upgrading dependencies.
- Refactoring workflow code.
- Preparing a release.

Properties:

- Should have stable expected behavior.
- Should usually have high pass threshold.
- Should include incidents and important user failures.
- Should be cheap enough to run regularly or be split by CI stage.

## Repeated Trials

For nondeterministic agents, one run can mislead.

Use:

- pass@k when one successful attempt is acceptable, such as generating several candidate solutions.
- pass^k when consistency matters, such as customer-facing workflows where users expect success every time.
- pass@1 for first-attempt reliability, especially coding-style tasks or workflows where the first answer/action is the product experience. For customer-facing reliability across repeated attempts, prefer pass^k or another consistency metric.

Also track variance by task. A suite average can hide unstable critical cases.

## Release Readiness

Before release, define:

- Required regression pass rate.
- Allowed known failures and rationale.
- Capability metrics expected to improve.
- Latency, token and cost budgets.
- Safety and guardrail thresholds.
- Tool error and timeout thresholds.
- Handoff loop limits.
- Canary and A/B plan.
- Rollback or kill-switch criteria.

## Model And Prompt Changes

Treat model upgrades like risky dependency changes:

- Run regression suite before switching.
- Compare capability suite for expected improvements.
- Inspect traces for behavior shifts, not only final scores.
- Recalibrate LLM judges if judge model changes.
- Keep old prompt/model fallback path when product risk justifies it.

## Anti-Patterns

- Using saturated evals as evidence of progress.
- Shipping from a capability eval without regression checks.
- Comparing one noisy run per variant.
- Upgrading model, prompts and tools simultaneously without attribution.
- Release gate with no rollback criteria.
- Ignoring latency, cost and operational metrics because quality score improved.
- Running evals offline but not monitoring the same failure modes in production.

## Checklist

- Is this suite capability, regression or release gate?
- What must improve and what must not regress?
- Are repeated trials needed?
- Is the threshold tied to product risk?
- Are high-severity cases weighted or separated?
- Are failures fair after transcript review?
- Are model, prompt, tools, datasets and graders versioned?
- Are rollout metrics and rollback criteria defined?

## Sources

- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)
- [OpenAI Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices)
- [OpenAI Evaluate agent workflows](https://developers.openai.com/api/docs/guides/agent-evals)

## Source Scope Note

OpenAI methodology here is used for eval objectives, continuous evaluation and workflow evidence. Any OpenAI-specific Evals API/dashboard reference should be rechecked against current docs because the legacy Evals platform is deprecated.

## Cross-Links

- [08-continuous-evaluation-gates.md](08-continuous-evaluation-gates.md)
- [01-evals-foundations.md](01-evals-foundations.md)
- [04-traces-transcripts-observability.md](04-traces-transcripts-observability.md)
