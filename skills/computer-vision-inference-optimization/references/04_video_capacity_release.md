# Video, Capacity, And Release

Use this reference for streams, temporal state, capacity, and production rollout.

## Video Timing Contract

Do not assume container FPS equals actual presentation timing. Record codec, keyframe
behavior, timestamps/PTS, variable versus constant rate, sampling policy, clip/window
construction, frame drops, reordering, camera/source clock, and acceptable event delay.
Test corrupt streams, reconnects, discontinuities, missing frames, and changed resolution.

Stateful tracking or temporal inference needs state ownership, partition key, expiry,
checkpoint/reset behavior, version compatibility, and migration during rollout. Batching
or parallel processing must preserve the ordering guarantees the algorithm needs.

## Capacity And Overload

Estimate per-route service demand from stage measurements, arrival rate, concurrency,
media duration/resolution, batch policy, and device capacity. Include CPU decode and
postprocessing, accelerator memory, transfer, storage/index, and downstream limits.

Define admission, queue bounds and age, deadlines, cancellation, fairness, frame/clip
sampling or dropping policy, backpressure, graceful degradation, and recovery. Dropping
work may be acceptable for live monitoring and unacceptable for evidence/archive paths;
make the choice explicit.

## Release And Operations

Canary the complete serving bundle on representative streams and devices. Compare
quality, latency tails, throughput, memory, drop/error rates, state continuity, and cost.
Monitor input/source shifts, stage timings, queue age, invalid/empty outputs, output
cardinality, model/threshold versions, and downstream acceptance.

Use `$sre-reliability-engineering` to turn these signals into SLOs, alerts, incident
response, and on-call. Retain compatible state/fallback behavior and a previous verified
bundle; define rollback and state-reset consequences before rollout.
