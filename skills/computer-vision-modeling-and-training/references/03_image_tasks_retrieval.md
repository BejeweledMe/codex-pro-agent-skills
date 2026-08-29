# Image Tasks And Retrieval

Use only the sections relevant to the selected output.

## Classification And Regression

Start with a rule or pretrained-feature baseline. Decide single-label, multilabel,
ordinal, regression, anomaly, or open-set behavior explicitly. Inspect whether the model
uses target evidence rather than background, source, border, text, or capture artifacts.
If localization matters to the decision, a global classifier may be the wrong contract.

## Metric Learning And Retrieval

Use embeddings when the item set changes, ranking is the output, open-set behavior is
needed, or similarity has product meaning. Compare a pretrained embedding and exact
search before changing the objective or ANN index.

Define positives/negatives, identity/item split, normalization, distance, gallery/query
updates, no-match behavior, and mining. A lower metric-learning loss does not prove that
ranking or verification improved. Hand P@K/R@K/MRR or FMR/FNMR selection to evaluation,
and ANN/quantization performance to inference.

## Detection

Choose among anchor-based, anchor-free, set/query-based, or open-vocabulary approaches
from object scale/density, class behavior, data, convergence, postprocessing, and runtime
constraints. Inspect matching/assignment, imbalance, localization objective, duplicate
suppression, crowded/overlapping cases, small objects, and empty images. Do not treat a
single detector family as the default for every scene.

## Segmentation And High Resolution

First decide semantic, instance, or panoptic output. Use a simple encoder-decoder
baseline where appropriate, then justify multi-scale, query-based, promptable, or
foundation approaches from the failure. High-resolution options include downscaling,
tiling with overlap/stitching, selective zoom, coarse-to-fine scanning, or a smaller
model on native input; each trades context, seams, small details, memory, and latency.

Inspect masks visually for holes, noise, boundary displacement, disconnected regions,
missed small structures, and empty-mask behavior. Use morphology or geometry only when
it corrects a diagnosed and stable error without hiding model failure.
