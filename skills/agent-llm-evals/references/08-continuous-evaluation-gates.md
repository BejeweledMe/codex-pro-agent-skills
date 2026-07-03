# CI CD Quality Gates

Use when: deciding what blocks a PR, what runs after merge, what validates release candidates, and what must be watched in production.

## Core Ideas

- CI is a feedback system for integrating changes early.
- CI/CD should run the right checks at the right time, not every check at the earliest time.
- Presubmit should favor fast, reliable and actionable checks.
- Post-submit, release candidate, staging, canary and production stages can handle broader, slower and higher-fidelity checks.
- Release safety comes from smaller batches, clear rollback, feature flags, production metrics and actionable feedback.

## Stage Matrix

### Local

Use for:

- Unit tests near edited code.
- Type/lint/schema checks.
- Small deterministic tool tests.
- Focused eval cases during prompt or workflow iteration.

Goal: seconds to minutes.

### Presubmit

Use for:

- Fast unit tests.
- Contract tests that are hermetic and reliable.
- Static checks.
- Small smoke evals if they are stable and cheap.
- Tool schema and permission checks.

Avoid:

- Flaky UI/E2E suites.
- Long-running load tests.
- Nonhermetic integrations with shared staging state.
- LLM judges with unstable scores unless nonblocking.

### Post-Submit Or Nightly

Use for:

- Broader integration tests.
- Larger eval datasets.
- Trace grading where the platform supports it, or equivalent workflow-log grading in a custom harness.
- Repeated trials for nondeterministic agents.
- Fuzz/property-like tests.
- Less reliable but useful checks with owner and triage process.

Goal: catch issues early enough that culprit set is small.

### Release Candidate And Staging

Use for:

- Code plus static configuration.
- Deployment startup and health checks.
- Critical E2E flows.
- Manual QA where needed.
- Agent workflow evals against release-like tools and data.

Goal: verify the deployable unit, not just repository code.

### Canary And Production

Use for:

- Guardrail metrics.
- Error rates, latency, tokens, cost, safety events.
- User feedback and support reports.
- A/B tests for product impact.
- Production probers and alerting.
- Incident-derived regression cases.

Goal: detect distribution drift and unknown unknowns with limited blast radius.

## Practices

- Make feedback accessible and actionable: logs, history, owner, failure classification.
- Quarantine flaky tests only with owner and fix deadline.
- Do not block PRs on unreliable checks; move them later or fix them.
- Test configuration with the code that consumes it.
- Use feature flags to isolate risky behavior and decouple rollout from code deployment.
- Prefer small, frequent releases when the pipeline is mature enough.
- Define rollback/rollforward criteria before launch.
- For agent changes, compare prompt/model/tool variants against both capability and regression suites.

## Platform Scope Note

OpenAI's agent workflow page describes specific OpenAI Platform surfaces such as traces, graders, datasets and eval runs. The durable engineering pattern is broader: capture inspectable workflow evidence, grade it with structured criteria, and move stable cases into repeatable datasets. Do not couple a long-term QA strategy to a vendor surface without checking current product status.

## Anti-Patterns

- Running every test on presubmit and making developers wait for broad flaky suites.
- Treating post-submit failures as "someone else's problem".
- Shipping config changes outside review and test paths.
- Release candidates that do not include the real config or dependency versions.
- Feature flags without cleanup, staged rollout, owner or metrics.
- Production alerts that are not actionable.

## Checklist

- Which checks block PRs and why?
- Which slower checks run after merge or nightly?
- What validates the release candidate as a deployable unit?
- Are code, config and model/prompt/tool changes tested together where needed?
- What metrics gate rollout?
- What is the rollback or kill-switch path?
- Who owns failures at each stage?
- Are agent eval failures linked to traces and transcripts?

## Sources

- [Google Testing Blog, Just Say No to More End-to-End Tests](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html)
- [OpenAI Evaluate agent workflows](https://developers.openai.com/api/docs/guides/agent-evals)
- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

## Cross-Links

- [07-eval-pyramid-and-feedback-loops.md](07-eval-pyramid-and-feedback-loops.md)
- [02-agent-eval-design.md](02-agent-eval-design.md)
- [05-capability-regression-release.md](05-capability-regression-release.md)
