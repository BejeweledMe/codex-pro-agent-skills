# Transfer, Adaptation, And Experiment Control

Use this reference for training and model-change decisions.

## Adaptation Ladder

Consider, in increasing change and operational coupling:

- frozen pretrained representation with a rule, nearest-neighbor baseline, or new head;
- partial unfreezing or discriminative learning rates;
- parameter-efficient adapters where the architecture/runtime supports them;
- full fine-tuning;
- domain self-supervised or multimodal pretraining when abundant unlabeled data and a
  measured representation gap justify its cost;
- training from scratch only when transfer is unsuitable and the data/compute case is
  explicit.

Select from target-domain gap, label volume and quality, distribution shift, artifact
and serving constraints, catastrophic-regression risk, and the need to maintain multiple
variants. Do not assume PEFT, full tuning, SSL, or from-scratch training wins by default.

## Objective And Sampling

Choose the loss and sampling scheme from the output and failure costs. Inspect positive
and negative construction, class/instance imbalance, hard-negative mining, small-object
or boundary emphasis, empty targets, and batch composition. For metric learning, verify
that the batch contains meaningful relations and that the split supports the intended
closed- or open-set claim.

For SSL, validate that paired views preserve downstream semantics and do not expose a
shortcut. Judge representations with downstream linear/KNN evaluation, fine-tuning, and
target slices rather than pretext loss alone.

## Attributable Experiment Bundle

Version data/split, transforms, code, architecture, initialization, frozen/trainable
parameters, objective, sampler, optimizer/schedule, precision, seed policy, hardware,
checkpoint, and metrics. Change one causal branch at a time when the goal is to learn
what caused the result.

Use overfit-on-a-small-clean-slice, learning curves, gradient/activation checks, label
and transform visualization, and fixed failure cases to distinguish pipeline bugs,
underfitting, overfitting, optimization failure, and data mismatch.

## Execution And Recovery Boundary

Use `$neural-training-systems` for full training-memory accounting, step critical
path, parallelism/collectives and consistent checkpoint/restart. Supply the visual
task/objective, shapes and augmentation, sampler and effective batch, trainable
parameters, precision constraints, quality/slice floors and experiment identity.
Keep model-family, objective, adaptation and interpretation decisions here.

Accept execution changes only with preserved update semantics and target quality,
measured time-to-quality/resource evidence, and coherent recovery of training
state and data position. More devices or higher utilization alone is not progress.

## Compression Must Produce An Executable Artifact

For QAT, pruning or distillation, identify the resulting representation and target
runtime support before investing in training. Zeros in a dense tensor are not an
executable sparse path; a low-rank factorization helps only if the deployed
operators use its factors. Record masks/layout, scales/metadata, conversion and
fallback requirements with the artifact, then verify the relevant visual slices.

Hand exported execution, memory/latency, actual kernel dispatch and postprocessing
compatibility to `$computer-vision-inference-optimization`. Retain training and
task-quality acceptance here; neither parameter-count reduction nor successful
conversion proves a production speedup.
