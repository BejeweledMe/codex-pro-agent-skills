# Evals Foundations

Use when: building or reviewing any LLM feature where output quality, correctness, safety or workflow success varies across runs.

## Core Ideas

- Generative AI is variable. Traditional deterministic tests are necessary but insufficient.
- An eval is a structured test of model or system performance against task-specific criteria.
- Evals should measure your application behavior, not just benchmark a model in isolation.
- Numerical scores are not enough. Combine metrics with human judgment and transcript review.
- Evaluation is continuous: build early, run often, mine logs, add real failures and recalibrate.

## Eval Workflow

1. Define objective: what must the system do well, and what must it avoid?
2. Collect dataset: production logs, historical data, domain expert cases, synthetic edge cases, human-curated examples, incident cases.
3. Define metrics and graders: exact match, executable check, state check, rubric, LLM-as-judge, human review.
4. Run and compare: evaluate versions, prompts, models, tools and workflows.
5. Continuously evaluate: run on changes, monitor production, expand datasets as new nondeterminism appears.

## Dataset Quality

Good eval datasets include:

- Realistic happy paths.
- Edge cases from production.
- Adversarial and safety cases.
- Negative cases where a behavior should not trigger.
- Examples across languages, formats, modalities or context complexity if the product supports them.
- Regression cases from incidents and user reports.

Avoid one-sided evals. If testing whether an agent should search, include cases where it should search and cases where it should not.

## Metrics

Pick metrics by task:

- Extraction/classification: accuracy, precision, recall, confusion matrix.
- RAG/Q&A: answer correctness, groundedness, context recall/precision, citation support, user satisfaction.
- Summarization: relevance, factuality, coverage, coherence, reference comparison.
- Tool use: tool selection, argument precision, state mutation correctness, permission safety.
- Agent workflow: task completion, turns, tool count, token/cost/latency, guardrail behavior, handoff accuracy.
- Safety: blocked disallowed behavior, allowed benign behavior, jailbreak resistance, refusal correctness.

Use product thresholds, not arbitrary academic metrics alone.

## Discriminative Evaluation Design

When possible, structure evals as comparisons, classification, pass/fail checks or scoring against explicit criteria. OpenAI notes that LLMs are often more reliable at discriminating between options than at judging unconstrained open-ended generation. This does not mean every task must become multiple choice; it means the grader should have clear criteria and evidence rather than a vague "is this good?" prompt.

## Eval-Driven Development

Use evals before the feature fully works:

- Define expected capability as test cases.
- Let early pass rate be low for capability evals.
- Iterate prompt, tools, architecture and product requirements.
- Promote stable high-pass capability cases into regression suites.

This prevents teams from discovering after launch that the requirement was never concrete.

## Anti-Patterns

- Vibe-based evals.
- Waiting until after launch to build evals.
- Using only generic metrics such as BLEU/perplexity when they do not reflect the task.
- Dataset that does not resemble production usage.
- Ignoring human feedback when calibrating automated metrics.
- Treating the eval score as truth without reading failures.
- Building around deprecated vendor-specific surfaces instead of durable eval principles.

## Checklist

- Is the eval objective tied to product or user success?
- Does the dataset include real and representative cases?
- Are edge, adversarial and negative examples included?
- Is the grader appropriate for the task?
- Is human calibration planned for subjective or high-risk dimensions?
- Can failures be traced back to prompt, model, tool, data, harness or grader?
- Will new production failures become new eval cases?

## Sources

- [OpenAI Evaluation best practices](https://developers.openai.com/api/docs/guides/evaluation-best-practices)
- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)

## Source Scope Note

OpenAI's Evaluation best practices page currently includes both durable eval methodology and legacy Evals platform references. Use its objective/dataset/metric/continuous-evaluation guidance as methodology; check current OpenAI docs before relying on any Evals API/dashboard workflow.

## Cross-Links

- [02-agent-eval-design.md](02-agent-eval-design.md)
- [03-graders-rubrics-human-calibration.md](03-graders-rubrics-human-calibration.md)
- [04-traces-transcripts-observability.md](04-traces-transcripts-observability.md)
- [05-capability-regression-release.md](05-capability-regression-release.md)
