# Dataset Iteration And Feedback

Use this reference when improving an existing dataset or scaling annotation.

## Diagnose Before Collecting More

Join model failures to source/camera/scene, class, scale, position, quality, occlusion,
template, time, and annotation provenance. Distinguish missing coverage, label ambiguity,
incorrect labels, duplicate dominance, harmful transforms, domain shift, and a model
capacity/optimization failure. More samples of the dominant easy cases may not help.

## Active And Assisted Selection

Candidate-selection signals can include uncertainty, disagreement, diversity, novelty,
representativeness, error clusters, rare slices, and production impact. Confidence-only
selection can miss confidently wrong or novel samples, so combine signals and retain a
random audit stream.

For auto-labeling:

- version the proposing model, prompt/configuration, threshold, and postprocessing;
- preserve proposal and human-corrected versions;
- audit positive, negative, confident, uncertain, and new-domain cases;
- prevent accepted pseudo-labels from entering evaluation ground truth unnoticed.

## Synthetic Data

Use synthetic data to test coverage hypotheses, rare conditions, or controlled scene
variation only when it resembles the relevant signal and does not create generator
shortcuts. Track generator/version/seed or source, balance, duplicates, and synthetic
share per split. Validate on real held-out data and sensitive slices.

Synthetic media can reduce use of some sensitive originals, but it is not automatically
private, representative, licensed, or safe. Do not claim anonymization without separate
evidence and policy review.

## Feedback Loop

Define which production examples may be retained, how consent/access/redaction apply,
how drift or failure clusters create labeling candidates, who adjudicates changes, how
the immutable test set is protected, and which data/model release consumes the update.
