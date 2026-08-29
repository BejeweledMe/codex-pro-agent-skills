# Metrics And Thresholds

Use this reference to connect the deployed decision to component and end-to-end metrics.

## Build A Metric Tree

Start with the user or operational outcome, then define end-to-end success, stage
metrics, guardrails, and resource metrics. State sampling unit, aggregation, exclusions,
confidence intervals or repeated-run variance where material, and the action a failed
gate triggers.

## Task Families

- Classification/multilabel: confusion matrix, per-class precision/recall/F-score,
  ranking or top-k when appropriate, calibration, and cost-weighted operating point.
- Regression/keypoints: error distribution and tolerance-based success on relevant
  scales/coordinates, not mean error alone.
- Detection: precision/recall and AP across relevant overlap thresholds plus localization,
  class, object-size, density, and duplicate/miss slices.
- Segmentation: overlap metrics such as IoU/Dice plus boundary or distance evidence,
  empty-mask rules, per-class results, and visual inspection.
- Retrieval/verification: P@K/R@K/MRR or verification tradeoffs such as false-match and
  false-non-match at declared operating points; compare with exact search.
- OCR/documents: character/word error where transcription is the contract; exact or
  normalized field correctness, relation/layout/table structure, and end-to-end action
  correctness where extraction or parsing is the contract.
- Tracking/video: measure detections and identity association separately, identity
  switches/fragmentation and event/clip outcomes; report temporal sampling.

Metric names do not define the contract by themselves. Document class averaging,
matching and overlap rules, ignored regions, empty cases, normalization, gallery/query
construction, and postprocessing.

## Threshold Selection

Choose thresholds on validation data from error costs, review capacity, desired recall
or precision, abstention/no-match policy, and calibration evidence. Plot or tabulate the
tradeoff across target slices. Do not tune thresholds on the final test set or publish a
single threshold as universal across domains, versions, or operating conditions.
