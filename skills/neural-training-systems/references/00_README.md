# Neural Training Systems References

| Situation | Reference | Useful result |
| --- | --- | --- |
| Wrong updates, OOM, unexplained memory or input stalls | [Correctness, memory and step profile](correctness-memory-and-step-profile.md) | Controlled update, simultaneous allocation ledger and causal trace |
| Binding local resource is known | [Precision, batching, recompute and compilation](precision-batching-recompute-and-compilation.md) | Measured intervention with numerical/update checks |
| Distributed fit, scaling or synchronization | [Parallelism, collectives and topology](parallelism-collectives-and-topology.md) | Minimal partition, explicit update semantics and physical traffic evidence |
| Checkpoint, failed resume or membership change | [Checkpoint consistency and recovery](checkpoint-consistency-and-recovery.md) | Coherent state cut, durability and validated continuation |
| Performance claim or training transformation | [Training performance and compression](training-performance-and-compression.md) | Common-quality comparison and executable representation handoff |

For example, an optimizer-step OOM starts with its live-state peak; a four-node
slowdown starts with per-rank traces; changed sample order after resume starts with
the consumed-data boundary. Objective/augmentation choice remains with modeling;
quota-blocked gang placement remains with AI platform, supplied a viable training shape.

## Sources And Refresh

Mechanisms draw on *Machine Learning Systems, Volume I*, Neural Computation,
ML Frameworks, Model Training, Optimization Principles, Model Compression, Hardware
Acceleration and Benchmarking; and *Machine Learning Systems, Volume II*, Distributed
ML Principles, Distributed Training, Collective Communication, Fault Tolerance and
Fleet Orchestration. They establish conditional reasoning, not current commands or
universal hardware, batch, timeout, memory, checkpoint or speedup constants.

Inspect the pinned implementation and current primary documentation before relying
on exact mixed-precision, optimizer-state, launch/sharding, collective ordering,
compiler/kernel coverage, checkpoint-format, determinism or elastic-membership APIs.
Verify target dtype/sparsity support, effective interconnect behavior and dated cost
inputs when those affect the decision. A missing implementation detail is a targeted
refresh need, not a reason to refuse ordinary training work.

Revisit affected evidence after changes to shapes, optimizer, precision, data/sampler,
batch, compilation, parallel layout, physical placement, storage or failure exposure.
Do not re-run unrelated reviews merely because one field changed.
