# QA Testing References

Use these files for classic software QA and automated testing work. This reference set intentionally excludes LLM/agent-specific eval methodology; use `$agent-llm-evals` for model, prompt, tool-call, trace, grader, or agent workflow evaluation.

## Route

- `01-testing-strategy.md`: risk-first QA strategy.
- `02-test-pyramid-and-feedback-loops.md`: test pyramid, size/scope, feedback-loop economics.
- `03-unit-tests.md`: maintainable unit tests, public API, state over interactions, DAMP.
- `04-test-doubles.md`: real implementations, fakes, stubs, mocks, contract tests.
- `05-integration-and-larger-tests.md`: fidelity, system tests, configuration, load, exploratory testing.
- `06-ci-cd-quality-gates.md`: presubmit, post-submit, release candidates, staged rollout.
- `07-checklists-and-templates.md`: reusable QA templates.
- `data-infrastructure-and-recovery-checks.md`: risk-to-layer fixtures, differential outputs, SQL regression, and restart-state evidence.

## Source Notes

- Google Testing Blog: [Just Say No to More End-to-End Tests](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html).
- Martin Fowler: [The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html).
- The original testing notes use broad public themes. Selected additions draw on Software Engineering at Google (test size and doubles), Infrastructure as Code, 3e (fixtures and outcome testing), Architecture Patterns with Python / Cosmic Python (real persistence tests), Designing Data-Intensive Applications, 2e (verification and recovery), Use The Index, Luke! (query diagnosis), and Web Browser Engineering (incremental comparisons). These are bounded mechanisms, not complete source coverage or current engine/framework conformance claims.
