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

Evaluate selection as an end-to-end investment: candidate scoring/embedding,
selection, human review/labeling, storage and selected-data training all consume
budget. Compare against random selection and the available full-data alternative
under the same total resource budget and quality target. Report the selector's
overhead, marginal benefit and whether it merely displaced work to another owner.
Fewer labels or training examples alone is not a saving.

Protect rare, safety-critical and new-domain coverage floors while comparing
aggregate quality. Recheck the selection policy when the model, population or
annotation cost changes; a selector tuned on one model need not benefit its
successor. Keep final evaluation outside the selection feedback loop.

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
