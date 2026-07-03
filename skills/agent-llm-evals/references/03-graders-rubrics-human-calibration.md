# Graders Rubrics Human Calibration

Use when: choosing how to score model outputs, agent traces, tool calls, final state, research reports, conversations or workflow outcomes.

## Core Ideas

- A grader is part of the system under test infrastructure. It can be wrong, biased, brittle or incomplete.
- Use deterministic graders where possible.
- Use LLM graders where judgment, nuance, open-ended answers or language quality matter.
- Use human graders to define ground truth, calibrate rubrics and audit model-based graders.
- A score is not enough; inspect transcripts and failure examples.

## Grader Types

### Deterministic Or Code-Based

Use for:

- Exact match.
- Regex/string/fuzzy checks.
- JSON/schema validation.
- Executable tests.
- State checks in database/filesystem/UI.
- Tool call and argument validation.
- Static analysis, lint, type and security checks.

Strengths:

- Fast, cheap, reproducible, debuggable.

Weaknesses:

- Brittle for valid variations.
- Limited for subjective quality.

### Metric-Based

Use for:

- Quantitative comparisons, ranking and regression trends.
- Task-specific metrics such as function-call accuracy, precision/recall, latency, cost, token count.

Do not rely on generic metrics unless they correlate with the product task.

### LLM-As-Judge

Use for:

- Pairwise comparison.
- Reference-guided grading.
- Rubric-based scoring.
- Classification or scoring against explicit criteria.
- Groundedness and coverage checks.
- Communication quality, empathy, tone and completeness.

Risks:

- Non-determinism.
- Position bias.
- Verbosity bias.
- Hallucinated judgments.
- Rubric ambiguity.

Practices:

- Calibrate against human labels.
- Prefer pass/fail or pairwise judgments where reliable.
- Prefer discriminative tasks: comparison, classification or criteria-based scoring are usually easier to grade reliably than open-ended "is this good?" judgment.
- Use clear rubrics with examples of levels.
- Control response length when comparing answers.
- Let the judge return `Unknown` when evidence is insufficient.
- Split complex grading into separate dimensions rather than one broad judgment.

### Human Graders

Use for:

- Expert judgment.
- Rubric creation.
- Calibration of LLM graders.
- High-risk domains.
- Ambiguous product quality.

Practices:

- Use blinded/randomized review when comparing variants.
- Track inter-annotator disagreement.
- Provide examples of score levels.
- Use humans periodically after automation stabilizes.

## Outcome Versus Path

Default to outcome grading:

- Did the task complete?
- Is the final state correct?
- Is the answer grounded, accurate and useful?

Grade path only when path matters:

- Required safety tool.
- Required identity verification.
- Required permission check.
- Required handoff to a regulated specialist.
- Forbidden tool use or forbidden external call.

## Partial Credit

Binary pass/fail is simple, but complex tasks often need partial credit:

- Correct intent recognized.
- Correct tool selected.
- Correct arguments extracted.
- Correct state mutation completed.
- User-facing response is clear and safe.

Partial credit helps diagnose whether a change improved part of a workflow even if full task completion still fails.

## Anti-Patterns

- LLM judge with vague rubric and no human agreement check.
- One monolithic rubric for several unrelated quality dimensions.
- Rigid exact-match grader for naturally variable outputs.
- Grader expectations hidden from the task.
- Penalizing valid alternative solutions.
- Using only aggregate score without sampling transcripts.
- Failing to test the reference solution against the grader.

## Checklist

- Is the grader type appropriate for the output?
- Can a deterministic check replace a model judge?
- Is the rubric clear enough that two expert humans would usually agree?
- Are examples of score levels provided?
- Is there a pass/fail threshold in addition to numeric score?
- Has the grader been calibrated against human labels?
- Does the grader allow valid alternative solutions?
- Does the reference solution pass?
- Can the agent exploit loopholes to pass without solving the task?

## Sources

- [OpenAI Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices)
- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

## Source Scope Note

OpenAI's Evaluation best practices page includes legacy Evals platform references. The grader advice here uses the durable methodology from that page: metric-based evals, human evals, LLM-as-judge, clear rubrics and human calibration. Check current platform docs before implementing with any specific OpenAI Evals API/dashboard surface.

## Cross-Links

- [01-evals-foundations.md](01-evals-foundations.md)
- [02-agent-eval-design.md](02-agent-eval-design.md)
- [04-traces-transcripts-observability.md](04-traces-transcripts-observability.md)
- [06-agent-eval-checklists-and-templates.md](06-agent-eval-checklists-and-templates.md)
