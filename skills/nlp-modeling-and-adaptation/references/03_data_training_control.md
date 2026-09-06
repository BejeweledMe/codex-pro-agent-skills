# Data And Training Control

## Dataset Before Method

For every sample, preserve origin/permission, processing version, task/label policy,
language/domain segment, timestamp where relevant, deduplication decision, and split
membership. Split by the unit that could leak in production: user, document,
conversation, source, organization, time, or near-duplicate group rather than an
arbitrary row.

Inspect examples before training. A perfect training loop cannot repair contradictory
labels, copied answers in validation, unavailable inference-time context, or a data
policy that does not match intended behavior.

## Tokenizer And Template Are Contracts

Measure token expansion and truncation by language and task slice. Version tokenizer,
special tokens, normalization, chat template, packing/preprocessing, maximum lengths,
and target formatting with the model. An evaluation using a different template or
stop-token behavior does not identify the model change it claims to measure.

## Training Diagnostics

Track data counts after each filter, sequence lengths/truncation, class or preference
balance, training/validation loss, gradient/optimization health, memory, step time,
and checkpoint behavior. Treat curves as evidence for hypotheses such as underfit,
overfit, bad data, or a broken pipeline; do not optimize them independently of the
task metric.

Use `$ml-system-design` for reproducible generic pipeline, feature, validation, and
production lifecycle design. This skill adds the text/model-specific contract.

## Training-System Handoff

Use `$neural-training-systems` when the unresolved problem is memory fit, step
throughput, distributed updates or coherent restart. Supply the objective and
quality floor; tokenizer/template; sequence-length and packing distribution;
trainable/frozen parameters; effective batch and accumulation; sampling and
stochastic assumptions; precision constraints; and the attributable model/data
bundle. A hardware-friendly packing or batch change must not silently change
which tokens contribute to the objective or the intended update semantics.

Receive the executable configuration, measured time-to-quality and resource cost,
plus evidence that optimizer/scheduler/scaler, RNG and data position recover
consistently—not just a loadable weights file. Keep adaptation-method selection
and language/task quality evaluation here.

For adapters or distillation, identify the actual deployable representation,
base-model/tokenizer compatibility and required runtime support. A smaller stored
artifact does not establish faster serving. Pass the exported bundle to the
appropriate inference owner for real operator-path, latency and quality checks.
