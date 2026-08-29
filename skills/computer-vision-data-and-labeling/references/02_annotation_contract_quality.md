# Annotation Contract And Quality

Use this reference for label design, calibration, and quality control.

## Specify The Label Unit

For each class, score, box, oriented box, polygon, mask, keypoint, text span, relation,
track, or temporal event, define:

- inclusion and exclusion rules;
- coordinate and ordering conventions;
- partially visible, truncated, overlapping, uncertain, absent, illegible, empty, and
  multiple-object cases;
- parent/child or instance relationships;
- examples of correct and incorrect labels;
- escalation and adjudication for genuine ambiguity.

Version this living specification and bind every annotation batch to a version. If a
rule change alters label meaning, plan migration or isolate incompatible versions.

## Calibrate Before Scaling

Use a small representative calibration set with difficult cases. Compare annotators
and an expert/golden reference where appropriate, discuss disagreements, refine the
specification, and estimate time and error types. Agreement is evidence about clarity,
not proof that the ontology matches the product need.

## Layer Quality Checks

- Deterministic: file/schema validity, allowed classes, coordinate bounds, polygon or
  track consistency, required fields, and image-label dimensions.
- Sampling: random and risk-weighted visual audits across annotators, sources, classes,
  small/occluded objects, negative cases, and long sequences.
- Agreement/adjudication: overlap or categorical agreement appropriate to the label,
  disagreement taxonomy, correction owner, and feedback to the guide.
- Model-assisted: inspect confident and uncertain predictions, label-model conflicts,
  missing objects, and changed-domain samples without treating the model as authority.

Keep original, proposed, corrected, adjudicated, and final annotations traceable. A
quality score without examples, owner, sampling method, and correction action is not an
annotation-quality system.
