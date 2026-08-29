---
name: computer-vision-system-design
description: Use when framing, designing, reviewing, or decomposing a computer-vision product or pipeline. Trigger for visual task formulation, sensor and input contracts, classification/detection/segmentation/retrieval/OCR/video decomposition, deterministic versus learned stage boundaries, end-to-end topology, hardware constraints, fallbacks, and build-versus-buy decisions. Route model-family selection, data, evaluation, and measured runtime work to the dedicated CV skills.
---

# Computer Vision System Design

Turn a real-world visual need into a testable signal, task contract, and maintainable
pipeline. The camera, document source, video stream, capture conditions, and human
fallback are parts of the system, not neutral inputs to a model.

## Core Rules

- Start with the user outcome, price of mistakes, scene, capture process, allowed
  inputs, output contract, constraints, and fallback before choosing a model.
- Decide whether each stage can be deterministic or needs learned perception; hand
  feature-based, pretrained, deep, or foundation model-family selection to the
  modeling owner.
- Choose the output representation deliberately: class, score, box, mask, keypoint,
  embedding/ranking, text/structure, track, or temporal event.
- Treat input validation, preprocessing, postprocessing, review, monitoring, and
  feedback as explicit stages with contracts and failure behavior.
- Separate known facts, estimates, assumptions, and decisions. Do not invent image
  quality, traffic, latency, accuracy, retention, or hardware targets.

## Boundaries And Handoffs

This skill owns visual problem framing, sensor/input assumptions, task decomposition,
pipeline stages, and end-to-end tradeoffs.

- Use `$computer-vision-data-and-labeling` for collection, annotations, provenance,
  split integrity, augmentation, active learning, or synthetic data.
- Use `$computer-vision-modeling-and-training` for model family, objective, transfer,
  fine-tuning, SSL, or training diagnosis.
- Use `$computer-vision-evaluation` for task metrics, operating thresholds, slices,
  robustness, error analysis, and release evidence.
- Use `$computer-vision-inference-optimization` after a representative workload
  exposes a latency, throughput, memory, cost, or device constraint.
- Use `$ml-system-design` for the generic predictive-ML lifecycle; `$system-design`
  for APIs, storage, queues, tenancy, and distributed capacity; `$product-design`
  when user value or experience remains the primary uncertainty; and
  `$sre-reliability-engineering` for SLOs, incidents, and on-call.

For a VLM-centered product, use `$llm-system-design` for prompt/RAG/agent/provider
composition and this skill for the visual signal and perception pipeline.

## Reference Routing

- Read [problem, sensor, and task contract](references/01_problem_sensor_task_contract.md)
  for every broad design or review.
- Read [task and pipeline selection](references/02_task_pipeline_selection.md) when
  choosing a CV formulation, stage boundary, cascade, or end-to-end topology.
- Read [architecture, release, and handoffs](references/03_architecture_release_handoffs.md)
  for system topology, failure paths, rollout, and output structure.

## Workflow

1. Define the real-world decision, signal source, users, error costs, and constraints.
2. Select the least expensive output contract that can solve the problem, decide which
   stages can remain deterministic, and hand learned-stage family selection to modeling.
3. Draw the minimal acquisition-to-output path with stage contracts and fallbacks.
4. Assign data, modeling, evaluation, inference, service, and operations decisions to
   their primary owners.
5. Pressure-test the design against coverage, leakage, failure cases, latency, cost,
   privacy, maintainability, rollout, and rollback.
6. End with the next smallest experiment that can invalidate the riskiest assumption.

## Output

Include problem and visual contract; scene/sensor assumptions; goals and non-goals;
candidate task/topology formulations and rejected alternatives; stages and interfaces;
data/model/evaluation/runtime handoffs; end-to-end quality and performance budgets;
fallback, monitoring, release, rollback, ownership, risks, and next experiment.

## Quality Bar

- Do not choose a detector, segmenter, VLM, or foundation model before the output and
  evaluation contracts are clear.
- Do not treat a model diagram as a system design without acquisition, pre/postprocess,
  failure, feedback, and operational paths.
- Do not call synthetic data private by default or infer rights to collect, retain, or
  process visual data.
- Keep security work defensive and scoped to systems the user is authorized to test.
