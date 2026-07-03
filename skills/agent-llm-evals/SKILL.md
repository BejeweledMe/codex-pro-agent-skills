---
name: agent-llm-evals
description: Use when designing, reviewing, validating, debugging, or improving LLM evals and agent workflow evals. Trigger for eval-driven development, task-specific eval datasets, graders, rubrics, LLM-as-judge, human calibration, traces, transcripts, tool-call evaluation, argument validation, guardrail evaluation, handoff evaluation, multi-turn agent tasks, capability evals, regression evals, pass@k/pass^k, model/prompt/tool upgrades, continuous evaluation, and production feedback loops for LLM or agent systems.
---

# Agent LLM Evals

Use this skill to design or review evaluation systems for LLM products and agent workflows. Treat evals as a quality and release-control system: define task-specific success, capture traces, choose graders, calibrate with humans, run repeated trials where needed, and feed production failures back into regression suites.

## Core Rule

Do not start from a vendor eval dashboard, benchmark, or generic metric. First clarify the product behavior, sources of nondeterminism, task boundaries, tool/state contracts, safety requirements, grader evidence, human calibration needs, CI/release stage, and production feedback loop.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- Always start with `references/01-evals-foundations.md` for broad LLM eval design.
- For agent workflow evals, multi-turn tasks, tool selection, tool arguments, environment state, handoffs, harnesses, and trial isolation, read `references/02-agent-eval-design.md`.
- For graders, rubrics, deterministic checks, LLM-as-judge, human calibration, partial credit, and outcome-vs-path grading, read `references/03-graders-rubrics-human-calibration.md`.
- For traces, transcripts, observability, production feedback, incident-to-regression loops, and workflow debugging, read `references/04-traces-transcripts-observability.md`.
- For capability evals, regression evals, pass@k/pass^k, model/prompt/tool changes, release readiness, and rollout criteria, read `references/05-capability-regression-release.md`.
- For reusable eval-case, grader, CI gate, and release templates, read `references/06-agent-eval-checklists-and-templates.md`.
- For eval pyramid and feedback-loop placement, read `references/07-eval-pyramid-and-feedback-loops.md`.
- For continuous evaluation gates, presubmit/post-submit/nightly/release/canary placement, and platform-scope caveats, read `references/08-continuous-evaluation-gates.md`.

## Workflow

1. Classify the request:
   - New LLM feature eval design: read `01`, then `03`, `04`, and `05`.
   - Agent workflow eval design: read `02`, then `03`, `04`, `05`, and `07`.
   - Tool-use or handoff eval: read `02`, `03`, and `04`.
   - Grader/rubric design: read `03`, then `06`.
   - Prompt/model/tool upgrade validation: read `05`, then `01`, `02`, `03`, and `04`.
   - Continuous eval or release gate design: read `08`, then `05` and `07`.
   - Production issue follow-up: read `04`, then `05` and the affected eval layer.
2. Identify blocking unknowns. Ask only when missing context changes the decision; otherwise state assumptions.
3. Map risks to eval layers: deterministic checks, task-specific evals, tool/state checks, trace grading, human review, release gates, and production monitoring.
4. Prefer deterministic or state-based grading where possible. Use LLM-as-judge only where nuance requires it and calibrate with human labels for important decisions.
5. Make every eval operational: case source, dataset shape, harness setup, allowed tools, grader, threshold, trace evidence, owner, CI/release stage, and failure action.
6. Mark any idea not grounded in the references as `external extension`.

## Output For Eval Strategy

Include:

- Product behavior and eval objective.
- Capability vs regression purpose.
- Dataset plan and case sources.
- Task definitions and reference solutions where applicable.
- Harness and environment isolation.
- Grader mix: deterministic, state-check, tool-call, LLM-as-judge, human review.
- Trace/transcript evidence requirements.
- Repeated-trial metric choice such as pass@1, pass@k, pass^k, variance, latency, tokens, and cost.
- CI/release placement and production monitoring path.
- Thresholds, rollback criteria, owner, risks, and open questions.

## Output For Review

Lead with risks and missing decisions:

- Weak or vague eval objective.
- Dataset not representative of production or missing negative/edge/adversarial cases.
- Ambiguous tasks or hidden grader expectations.
- Grader without rubric, examples, calibration, or outcome/path rationale.
- Harness state leakage, flaky tools, or missing trace evidence.
- Capability/regression/release-gate confusion.
- Release thresholds or production feedback loop missing.
- Concrete fixes and validation steps.

## Quality Bar

- Do not call an eval reliable without task-specific criteria, inspectable evidence, and a maintained dataset.
- Do not grade path when outcome is the product contract; do grade path when tool use, permission, safety, or handoff is itself the contract.
- Do not trust LLM-as-judge without clear rubric, examples, transcript sampling, and human calibration for important decisions.
- Do not use saturated evals as evidence of improvement; promote them to regression and add harder capability cases.
- Do not treat OpenAI or other vendor-specific eval surfaces as durable without checking current docs; keep methodology separate from platform status.
- Do not ship model, prompt, tool, or workflow changes without regression evals, rollout criteria, and production monitoring.
