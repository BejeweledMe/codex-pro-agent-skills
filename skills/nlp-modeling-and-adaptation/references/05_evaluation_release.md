# Adaptation Evaluation And Release

## Compare A Release Bundle

Compare the baseline and candidate on the same versioned evaluation data. The bundle
includes base model, tokenizer, template, adapter or full weights, training data and
split, configuration/code revision, runtime, prompt/policy, and license decision.
Track target task quality plus format/schema correctness, language/domain slices,
general regression, safety/utility where relevant, latency/cost, and artifact
compatibility.

Use error buckets rather than only an aggregate score. Ask whether a gain comes from
better behavior, leakage, a memorized duplicate, changed preprocessing, or an easier
slice.

## Release Template

- Task, baseline, and candidate hypothesis:
- Data provenance, label/preference policy, and split:
- Model/tokenizer/template/adaptation configuration:
- Target, general, language, safety/utility, and format results:
- Training and runtime constraints:
- Compatibility checks and deployment route:
- Rollout, previous verified bundle, rollback signal, and owner:

Use `$agent-llm-evals` to turn this comparison into a repeatable harness and release
gate. Do not merge an adaptation merely because a training job completed.
