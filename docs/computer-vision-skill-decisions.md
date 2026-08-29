# Computer Vision Skill Decisions

Status: accepted for the first optional computer-vision package.

## Decision

Publish five primary owners:

- `computer-vision-system-design` for visual problem formulation, sensor/input
  contracts, task decomposition, and end-to-end pipeline topology.
- `computer-vision-data-and-labeling` for collection, annotation, provenance,
  grouped splits, leakage, augmentation, and dataset iteration.
- `computer-vision-modeling-and-training` for approach, architecture, transfer,
  adaptation, objectives, and reproducible training.
- `computer-vision-evaluation` for task metrics, thresholds, calibration, slices,
  visual error analysis, robustness, and release evidence.
- `computer-vision-inference-optimization` for measured decode-to-output latency,
  throughput, memory, cost, runtime compatibility, and capacity work.

Classification, retrieval, detection, segmentation, OCR/documents, and video are
progressively disclosed references, not top-level skills. They have distinct mechanics
but repeatedly cross the same data, modeling, evaluation, and inference boundaries.

## Alternatives Rejected

- One catch-all CV skill: too much unrelated context and no clear owner for common
  data, evaluation, or performance requests.
- Top-level skills per modality: duplicates lifecycle rules and turns OCR and video
  into new catch-alls.
- Separate modeling and training skills: model family, objective, adaptation mode,
  and experiment controls form one decision surface.
- A standalone CV security skill: the supplied evidence supports privacy constraints,
  corruption/OOD testing, and authorized defensive boundaries, but not a complete
  specialist security workflow.

## Package And Compatibility

CV remains outside `base` and `classic-ml`. Focused training and systems bundles plus
`computer-vision-all` provide opt-in installation. `ml-system-design` retains the
generic predictive-ML lifecycle; `system-design`, `qa-testing`, and
`sre-reliability-engineering` retain service topology, deterministic verification,
and production reliability.

## Evidence And Claim Boundary

The package preserves source-supported principles: start from task, signal, data, and
constraints; compare simple/classical and learned baselines; group correlated visual
samples before splitting; evaluate task and end-to-end behavior on visual slices;
profile the complete inference path; and revalidate quality after optimization.

It intentionally excludes current-model rankings, universal numeric defaults,
unverified performance claims, legal or biometric compliance prescriptions, attack
recipes, access-control bypasses, and claims that synthetic data is inherently private.
