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
