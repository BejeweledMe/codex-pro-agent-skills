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

## Source Notes

- Google Testing Blog: [Just Say No to More End-to-End Tests](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html).
- Martin Fowler: [The Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html).
- External testing publications are used only as broad public themes, not as detailed source attribution.
