---
name: neural-training-systems
description: "Diagnose, optimize, scale, or recover neural training runs: OOM, slow steps, mixed precision, gradient accumulation, DDP/FSDP, collectives, and checkpoint consistency. Owns training execution; model/objective choices belong to modeling skills and serving execution to inference skills."
---

# Neural Training Systems

Make an identified neural training run advance correctly toward its agreed quality
target within memory, time, cost and recovery constraints. Choose the smallest
intervention supported by the observed failure or bottleneck.

## Start With The Relevant Contract

Reuse the established model/data/objective, trainable state, transforms or
tokenizer/packing, optimizer/schedule, precision, shapes and batch/update semantics.
Capture the target runtime/hardware and numerical/quality tolerance needed for the
decision. Recovery work also needs the last trustworthy state and tolerated lost
progress. Resolve missing details only when they could change the next action.

For a local OOM, slow loader or numerical regression, inspect the affected update,
ledger or trace, change one causal lever and remeasure. Do not require a fleet review
or a complete handoff record. For a model too large for one device, use component
correctness checks and the smallest viable full-model baseline.

## Reference Routing

Read only the reference needed by the current decision:

- Broken update, unexplained memory, OOM or input/compute stalls:
  [correctness, memory and step profile](references/correctness-memory-and-step-profile.md).
- A known local capacity or performance constraint:
  [precision, batching, recompute and compilation](references/precision-batching-recompute-and-compilation.md).
- Distributed fit, slowdown, hang or layout choice:
  [parallelism, collectives and topology](references/parallelism-collectives-and-topology.md).
- Failed resume, checkpoint design, preemption or resize:
  [checkpoint consistency and recovery](references/checkpoint-consistency-and-recovery.md).
- Time/cost comparison or an agreed training transformation:
  [training performance and compression](references/training-performance-and-compression.md).

The [index](references/00_README.md) explains source coverage and targeted refresh.
A failure can start at any reference; this is not a mandatory five-stage procedure.

## Ownership And Handoffs

| Unresolved decision | Owner and exchange |
| --- | --- |
| Model family, objective, augmentation, adaptation, distillation or learning policy | `$computer-vision-modeling-and-training` or `$nlp-modeling-and-adaptation` supplies model/data/objective and quality assumptions; return execution constraints, proposed semantic changes and time-to-quality evidence. |
| Product metric, splits, experiment/release acceptance | `$ml-system-design` and the applicable modality evaluation owner, including `$computer-vision-evaluation`; consume their comparison and quality floors. |
| Source pipelines and maintained transformations | `$data-engineering` owns mechanics; ML/CV/NLP data owners define feature/label/sampling meaning. Training owns faithful input consumption, feed performance and restart position. |
| Quota, inventory, gang admission, placement, preemption implementation or shared controllers | `$ai-platform-llmops` receives viable group shape, per-rank resources, traffic/locality, checkpoint durability and exit/recovery requirements. |
| Exported serving execution and target dispatch | `$computer-vision-inference-optimization` or `$llm-inference-optimization` receives the materialized representation, input envelope and quality evidence; returns actual dispatch, fallback, memory and performance evidence. Generic predictive serving uses `$ml-system-design`. |
| Active incident coordination | `$sre-reliability-engineering` receives failure class/domain, trustworthy run/checkpoint identity, lost-progress bounds and validated recovery options. |

These are optional named handoffs for another decision, not compulsory skill chains.

## Verification And Result

Keep a known-good configuration and state. Verify the affected update, numerical
behavior, fit, performance and recovery obligations in proportion to the change.
Changing batch, precision, synchronization, membership or data order may change
optimization semantics; report and revalidate that change with the modeling owner.

Return the observed constraint, discriminating evidence, intervention and displaced
cost, before/after result, and remaining uncertainty. Report measured results,
estimates and unperformed checks distinctly. A faster step, smaller file, successful
save or busy accelerator does not establish time-to-quality or correct resume.
Stop or revert the experiment at its resource budget or numerical/quality failure
condition; do not stack further changes on an unexplained regression.
