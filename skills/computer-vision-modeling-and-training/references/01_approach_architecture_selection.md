# Approach And Architecture Selection

Use this reference to choose a modeling family after the visual task is defined.

## Establish The Ladder

Compare only credible steps:

1. deterministic geometry, templates, quality filters, motion/assignment, or local
   feature descriptors;
2. a pretrained embedding plus linear/head-only model or exact retrieval;
3. a task-specific CNN, vision transformer, or hybrid model;
4. a foundation, open-vocabulary, or multimodal model;
5. a staged combination when stages isolate different sources of error.

Escalate when the measured baseline cannot represent the task or fails target slices,
not because a newer family exists. Evaluate data demand, label type, open/closed set,
small-object or boundary precision, spatial/temporal context, domain shift, explainable
controls, runtime placement, artifact size, licensing, and maintenance.

## Decompose The Learned Model

Identify the feature extractor/backbone, optional multi-scale or fusion neck, task head,
objective, input representation, and postprocessing. This decomposition makes transfer,
freezing, multi-scale reasoning, and stage failures explicit without prescribing a
particular named model.

- Classification/regression: decide global versus local evidence and unknown behavior.
- Detection/dense tasks: decide required scales, assignment/matching, localization,
  boundary precision, and high-resolution path.
- Retrieval: decide embedding contract, normalization, training pairs/groups, and exact
  search anchor before index tuning.
- OCR/documents: decide staged detection/recognition/layout versus generative parsing.
- Video: decide whether per-frame features suffice and how temporal context/state enters.

## Selection Record

For each candidate record the capability it adds, data and compute it needs, binding
constraint, likely failure, integration cost, rejected alternatives, and experiment that
would change the decision. Do not claim a current best model without fresh authoritative
evidence and a target-workload comparison.
