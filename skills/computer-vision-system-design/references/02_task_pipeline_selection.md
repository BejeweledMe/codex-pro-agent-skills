# Task And Pipeline Selection

Use this reference to choose the output formulation and compose stages. Detailed
model-family selection belongs to `$computer-vision-modeling-and-training`.

## Decide Stage Semantics

For each required transformation, ask whether a deterministic contract can satisfy the
need or whether the stage requires learned perception. Examples of deterministic stages
include input/schema checks, known geometry, stable template rules, quality gates,
assignment, and bounded postprocessing. When a learned stage is required, specify its
input and output contract and hand feature-based, pretrained, task-specific deep, or
foundation model-family comparison to the modeling owner.

Compare single-stage and cascaded topology by observability, error isolation, label and
integration cost, end-to-end latency, fallback, and maintenance. Deterministic and
learned stages can coexist: geometry may normalize a document, a learned localizer may
create crops, and a tracker may combine learned observations with motion and assignment.

## Compose Only Needed Stages

A staged pipeline may include:

`capture -> input validation -> normalize/rectify -> localize -> quality gate ->
recognize/embed -> retrieve/associate -> postprocess -> review/fallback`

For each stage record input/output schema, threshold or deterministic rule, state,
latency budget, failure signal, observability, and owner. Measure both stage quality and
end-to-end outcomes: improving localization does not prove that ranking, extraction, or
user action improved.

## Task-Specific Questions

- Classification/anomaly: what is the unknown/negative policy and how do new classes
  enter the system?
- Detection/segmentation: are small objects or precise boundaries decision-critical,
  and will tiling or postprocessing change the contract?
- Retrieval: can the gallery change independently of the model, and what is the exact
  search quality/cost anchor before ANN?
- OCR/documents: is the need transcription, fields, relations, tables, or reasoning;
  can geometry and a staged recognizer meet it?
- Video: is time needed at all; if yes, what sampling window, identity persistence,
  camera motion, event latency, and state recovery matter?

## Stop Conditions

Close an approach branch when it fails a predeclared quality or resource gate, needs
unavailable data/rights/hardware, or adds complexity without closing the target failure.
Preserve the result so the next experiment starts from evidence rather than repetition.
