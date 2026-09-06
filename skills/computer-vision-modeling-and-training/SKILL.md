---
name: computer-vision-modeling-and-training
description: Use when choosing, training, adapting, or debugging computer-vision models for image classification, metric learning and retrieval, detection, segmentation, OCR and documents, multimodal vision, or video and tracking. Covers classical feature-based baselines, deep and foundation models, transfer learning, fine-tuning, PEFT, self-supervised learning, objectives, and reproducible experiments. Not for dataset governance, release metrics, or serving optimization.
---

# Computer Vision Modeling And Training

Choose the smallest visual approach that can close a measured capability gap, then
change data, architecture, objective, or adaptation mode through attributable and
reproducible experiments.

## Core Rules

- Begin with the task/output contract, data regime, failure costs, baseline, target
  slices, and runtime constraints; do not begin from a named architecture.
- Compare useful deterministic or feature-based methods, pretrained representations,
  task-specific deep models, and foundation/VLM routes when they are credible.
- Treat input transforms, backbone, optional neck, head, objective, postprocessing,
  checkpoint, and training configuration as one versioned model bundle.
- Change one causal branch at a time when learning which intervention matters.
- Measure transfer, head-only training, partial/full fine-tuning, PEFT, metric learning,
  and SSL on the same downstream contract; none is a universal winner.
- Training or pretext loss is diagnostic evidence, not product or release quality.

## Boundaries And Handoffs

This skill owns CV approach and architecture selection, objectives, adaptation,
model/experiment controls, and data/objective/optimization/quality diagnosis. Dataset governance belongs to
`$computer-vision-data-and-labeling`; task metrics, thresholds, robustness, and release
evidence belong to `$computer-vision-evaluation`; runtime export, precision, batching,
and measured serving bottlenecks belong to `$computer-vision-inference-optimization`.

Use `$neural-training-systems` for execution memory, step profiling, precision
mechanics, collectives, and coherent optimizer/data-state restart. Keep model and
adaptation choices, visual failure analysis, and target quality here.

Use `$nlp-modeling-and-adaptation` for a text model or tokenizer inside an OCR/VLM
system, and `$llm-system-design` when prompt/RAG/agent composition is the primary
decision. Use `$ml-system-design` for generic MLOps and product-lifecycle concerns.

## Reference Routing

- Read [approach and architecture selection](references/01_approach_architecture_selection.md)
  for baselines, model families, and escalation criteria.
- Read [transfer, adaptation, and experiment control](references/02_transfer_adaptation_experiments.md)
  for fine-tuning, PEFT, SSL, objectives, and reproducibility.
- Read [image tasks and retrieval](references/03_image_tasks_retrieval.md) for
  classification, metric learning, detection, segmentation, and high resolution.
- Read [documents, OCR, and multimodal vision](references/04_documents_ocr_multimodal.md)
  for staged OCR, layout, VLM tradeoffs, and the language-model boundary.
- Read [video, tracking, and temporal models](references/05_video_tracking_temporal.md)
  for frame/clip modeling, tracking, association, Re-ID, and action recognition.

## Workflow

1. Freeze the task, split, metric, target slices, data version, and baseline.
2. Select the least complex family that can express the output under the constraints.
3. Name the observed failure and the smallest data/model/objective hypothesis that
   distinguishes plausible causes.
4. Run an attributable experiment and inspect learning curves plus visual failures.
5. Compare downstream quality, robustness, runtime compatibility, complexity, and
   regression risk before selecting a candidate.
6. Version the model bundle and hand release evidence and serving work to their owners.

## Output

Include task and model contract; simple/classical and learned baselines; chosen family
and rejected alternatives; data/split assumptions; architecture and objective;
adaptation and training plan; experiment record; diagnostic evidence; artifact bundle;
handoffs for evaluation, serving, release, rollback, risks, and next experiment.

## Quality Bar

- Do not promote a model from a generic benchmark, training loss, or one favorable run.
- Do not copy training sizes, learning rates, ranks, thresholds, or hardware recipes as
  universal defaults.
- Do not use a foundation model merely because it can accept the modality.
- Do not change data and model simultaneously when the experiment is intended to
  attribute the gain.
