# Slices And Visual Error Analysis

Use this reference to expose failures hidden by aggregate metrics.

## Slice Matrix

Select dimensions tied to the deployed signal and risk:

- class, negative/unknown, frequency, and error severity;
- source/site/device/camera/scene/time;
- object scale, position, density, occlusion, orientation, motion, and background;
- resolution, blur, glare, noise, compression, lighting, weather, and crop quality;
- document template, language/script, handwriting, page/layout/table complexity;
- video length, sampling, camera motion, crowding, identity duration, and event phase;
- relevant user or demographic groups only when collection, policy, and interpretation
  are legitimate and owned.

Report sample count and uncertainty alongside each slice. Sparse slices are collection
signals, not reliable rankings.

## Visual Error Atlas

For representative true/false positives and negatives, show input, ground truth,
prediction, confidence/score, relevant crop or mask, metadata, stage outputs, and a
short failure label. Useful labels include missing coverage, ambiguous/incorrect label,
input corruption, localization, classification, boundary, duplicate suppression,
retrieval candidate, OCR recognition, layout, association, postprocess, and threshold.

Inspect random successes as well as failures to find shortcuts and silent label errors.
An attention or saliency visualization is a diagnostic clue, not causal proof.

## Localize The First Broken Stage

In a cascade, ask where correct information first disappears. A recognition failure may
start with a crop; a RAG document failure may start with OCR; a track identity failure
may start with a missed detection; a retrieval miss may be absent from the candidate set
before reranking.

Turn confirmed production failures and high-risk synthetic/corruption cases into fixed,
versioned regression examples without leaking them into training unnoticed.
