---
name: computer-vision-data-and-labeling
description: Use when designing, collecting, labeling, validating, versioning, or improving computer-vision datasets. Trigger for annotation schemas and QA, source/camera/scene coverage, class and object balance, duplicates, grouped splits, temporal or spatial leakage, augmentation, active learning, auto-labeling, synthetic data, provenance, and production data feedback. Not for choosing model architectures or declaring model quality.
---

# Computer Vision Data And Labeling

Build a visual dataset whose sampling unit, labels, lineage, and split structure match
the deployed task. Treat annotation guidance and collection policy as versioned model
inputs, not informal preparation work.

## Core Rules

- Define the production population and correlation unit before collecting or splitting:
  subject, object, scene, event, camera, source, template, site, or time window.
- Version the label ontology and guidance with edge cases, examples, adjudication,
  provenance, and the dataset versions they apply to.
- Audit class, source, camera, scale, position, quality, and missing-label coverage;
  an aggregate sample count is not coverage evidence.
- Transform every spatial or temporal label consistently with the input. Inspect the
  resulting image-box-mask-keypoint-track pairs, not only augmentation code.
- Keep manual, imported, auto-generated, and corrected annotations distinguishable.
  Confidence from an auto-labeler is not ground truth.

## Boundaries And Handoffs

This skill owns visual acquisition, dataset and annotation contracts, split integrity,
data quality, and the data-improvement loop. Use `$computer-vision-modeling-and-training`
for architecture and training decisions, and `$computer-vision-evaluation` for model
metrics, thresholds, robustness evidence, and release gates. Use `$ml-system-design`
for generic pipeline orchestration and lifecycle concerns.

Rights, consent, retention, access, deletion, tenant isolation, and audit policy are
system constraints; use `$system-design` for their technical enforcement and do not
invent legal conclusions. Security testing must remain authorized and defensive.

## Reference Routing

- Read [collection, lineage, and coverage](references/01_collection_lineage_coverage.md)
  for acquisition plans, metadata, sampling, and dataset acceptance.
- Read [annotation contract and quality](references/02_annotation_contract_quality.md)
  for labels, guidance, calibration, agreement, adjudication, and audits.
- Read [splits, leakage, and augmentation](references/03_splits_leakage_augmentation.md)
  for grouping, near-duplicates, temporal data, transforms, and immutable tests.
- Read [iteration and feedback](references/04_iteration_feedback.md) for imbalance,
  active learning, auto-labeling, synthetic data, and production feedback.

## Workflow

1. Define the target population, sampling unit, label unit, metadata, and exclusions.
2. Design the annotation contract and run a small calibration and adjudication pass.
3. Inspect coverage and correlations, then create grouped train/validation/test splits.
4. Establish a simple dataset and model baseline before scaling annotation automation.
5. Add augmentation, active learning, auto-labeling, or synthetic data only with
   provenance, fixed evaluation slices, and human or golden-set audits.
6. Version the resulting dataset manifest and record owners, known gaps, and the next
   collection decision.

## Output

Include population and capture plan; sampling and label units; ontology and guidance;
QA and adjudication; metadata and provenance; split and leakage controls; coverage and
imbalance analysis; transform policy; automation/synthetic-data controls; versioning,
rights/privacy owner, feedback loop, risks, and acceptance checks.

## Quality Bar

- Do not randomly split correlated frames, scenes, subjects, templates, or duplicates.
- Do not scale annotation before calibrating the specification on ambiguous cases.
- Do not use confidence-only sampling without checking calibration and diversity.
- Do not let a changing auto-labeler silently redefine the dataset.
