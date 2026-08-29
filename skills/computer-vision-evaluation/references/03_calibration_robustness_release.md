# Calibration, Robustness, And Release

Use this reference for confidence, distribution shift, and release evidence.

## Calibration And Uncertainty

Check whether predicted scores correspond to empirical correctness on the target
population and important slices. Use reliability curves or calibration error measures
appropriate to the task, and compare operating decisions before and after any calibration
method. Calibration can drift after model, class, source, or preprocessing changes.

Ensembles, test-time augmentation, or stochastic inference may provide uncertainty
signals, but they also change cost and latency. Validate whether they improve the actual
abstention, review, or selection decision rather than assuming more variation is better.

## Robustness And OOD

Build tests from plausible deployment variation: blur, noise, compression, exposure,
lighting, weather, occlusion, scale, crop, orientation, camera/source changes, document
distortions, frame drops, and timing changes. Separate graceful degradation, explicit
rejection/abstention, and silent confident failure.

An OOD score or one favorable experiment does not establish universal novelty detection.
Measure known in-domain, hard in-domain, known-shift, and unknown/negative examples with
the intended operating policy. Use production drift signals to trigger investigation,
not automatic retraining without label and release controls.

Authorized adversarial testing must define ownership, environment, data handling,
allowed tests, rate/cost limits, stop conditions, containment, and rollback. Without
that scope, provide a defensive plan only and do not supply bypass procedures.

## Release Gate

Require the versioned data/split and serving bundle; target and regression slices;
component and end-to-end quality; calibration/threshold evidence; robustness checks;
latency/cost compatibility; human-review load; known failures; monitoring; canary or
shadow plan; rollback triggers; and owners. Retain the previous verified bundle.
