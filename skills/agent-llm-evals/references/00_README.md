# Agent LLM Evals References

Use these files for LLM evals, agent workflow evals, grader design, trace/transcript review, continuous evaluation, and release validation for model/prompt/tool changes. Use `$qa-testing` for classic unit/integration/E2E testing details.

## Route

- `01-evals-foundations.md`: eval objective, dataset, metrics, anti-patterns.
- `02-agent-eval-design.md`: agent tasks, harnesses, tools, handoffs, multi-turn evals.
- `03-graders-rubrics-human-calibration.md`: deterministic graders, LLM-as-judge, human calibration.
- `04-traces-transcripts-observability.md`: traces, transcript review, production feedback.
- `05-capability-regression-release.md`: capability vs regression evals, pass@k/pass^k, release readiness.
- `06-agent-eval-checklists-and-templates.md`: eval case, grader, CI gate, and release templates.
- `07-eval-pyramid-and-feedback-loops.md`: eval pyramid and feedback-loop placement.
- `08-continuous-evaluation-gates.md`: CI/CD-style eval gates.

## Source Notes

- OpenAI: [Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices), [Evaluate agent workflows](https://developers.openai.com/api/docs/guides/agent-evals).
- Anthropic: [Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents).
- Classic QA/test pyramid sources are used only for general QA/CI analogies.
