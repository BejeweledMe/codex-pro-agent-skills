# Splits, Leakage, And Augmentation

Use this reference before training or comparing candidates.

## Split By The Correlation Unit

Group correlated samples before assigning train, validation, and test. Common grouping
keys include subject/identity, physical item, scene, event, video or temporal block,
camera/site/source, document template, acquisition session, and synthetic seed/source.
The correct key is the one that prevents the model from seeing an easier proxy for the
deployed generalization problem.

Audit exact and near duplicates after preprocessing as well as before it. Crops,
re-encodes, adjacent frames, restored documents, or multiple views can evade file-hash
checks. For retrieval and Re-ID, state whether identities/items are closed set or open
set and design gallery/query splits accordingly.

Keep the final test boundary immutable. Tune preprocessing, thresholds, augmentations,
and model selection on training/validation evidence, then record every intentional test
access.

## Validate Augmentations Semantically

An augmentation must model plausible production variation without changing the target.
Apply geometric transforms consistently to boxes, masks, polygons, keypoints, text
regions, tracks, and camera geometry. For video, preserve or deliberately transform
temporal order and timestamps.

Inspect transformed examples by class and task. Check whether cropping deletes the
target, flipping changes semantics, rescaling erases small objects or text, compression
creates a shortcut, or color/lighting transforms invalidate the label. Add one policy
change at a time when attribution matters.

## Leakage Review Output

Report grouping keys and rationale, duplicate method and thresholds as experiment
parameters, split counts by important slices, source/time boundary, preprocessing before
duplicate detection, known unavoidable correlations, and the likely direction of bias.
