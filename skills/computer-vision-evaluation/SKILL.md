---
name: computer-vision-evaluation
description: Use when designing, reviewing, validating, or debugging computer-vision evaluation. Trigger for product-linked and task metrics, thresholds, calibration, class/scale/source slices, visual error analysis, imbalance, robustness, corruptions and OOD, regression suites, human review, and release gates. Not for training procedure, annotation operations, or generic LLM and agent evals.
---

# Computer Vision Evaluation

Build evidence that a visual system works for the target decision, population, and
operating point. Evaluate components and the end-to-end path, then inspect the images,
regions, documents, and clips behind aggregate scores.

## Core Rules

- Derive task metrics and operating thresholds from product outcomes and error costs.
- Keep a fixed, leakage-controlled test boundary and version every model, transform,
  postprocess, index, threshold, and dataset slice that affects the result.
- Report slices by class, source, scene, camera, scale, position, input quality, and
  relevant groups; a global average can hide the deployed failure.
- Pair scalar metrics with a visual error atlas and stage-level diagnosis.
- Treat confidence as an uncalibrated score until evidence supports its interpretation.
- Re-evaluate quality, calibration, compatibility, and hard slices after export,
  quantization, compression, resizing, tiling, or postprocessing changes.

## Boundaries And Handoffs

This skill owns CV task metrics, thresholds, calibration, slices, visual error analysis,
robustness/OOD evidence, regression sets, and model release gates. Dataset labeling and
split construction belong to `$computer-vision-data-and-labeling`; training changes to
`$computer-vision-modeling-and-training`; runtime changes to
`$computer-vision-inference-optimization`.

Use `$qa-testing` for deterministic code, contract, integration, and end-to-end software
tests. Use `$agent-llm-evals` only when generative VLM/agent outputs require graders or
trace evaluation. Defensive adversarial work must be authorized, bounded, and designed
for a system the user controls; ordinary corruption and distribution-shift tests do not
justify attack recipes.

## Reference Routing

- Read [metrics and thresholds](references/01_metrics_thresholds.md) for the task and
  end-to-end quality contract.
- Read [slices and visual error analysis](references/02_slices_visual_errors.md) for
  imbalance, taxonomy, stage localization, and regression cases.
- Read [calibration, robustness, and release](references/03_calibration_robustness_release.md)
  for confidence, corruptions, OOD, drift, human review, and release gates.

## Workflow

1. Define the deployed decision, error costs, sampling unit, and evaluation population.
2. Select component and end-to-end metrics plus an operating-threshold protocol.
3. Audit split integrity and create target, hard, negative, and robustness slices.
4. Inspect visual failures, localize the first broken stage, and turn representative
   production failures into fixed regression cases.
5. Compare candidates with uncertainty, runtime, cost, and human-review evidence.
6. Set release, rollback, monitoring, and feedback criteria with explicit owners.

## Output

Include decision and metric contract; dataset/split version; task and end-to-end
metrics; threshold selection; slice matrix; calibration evidence; visual error atlas;
robustness/OOD results; comparison uncertainty; release/rollback gates; production
signals, owners, risks, and next discriminating test.

## Quality Bar

- Do not use accuracy alone for localized, ranked, imbalanced, open-set, or temporal
  tasks.
- Do not infer good masks, boxes, OCR structure, or tracks from one aggregate score.
- Do not tune on the final test set or mix correlated identities/scenes across splits.
- Do not call a model robust from a single corruption, OOD detector, or demonstration.
