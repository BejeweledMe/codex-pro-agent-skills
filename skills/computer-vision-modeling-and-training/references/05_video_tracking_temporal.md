# Video, Tracking, And Temporal Models

Use this reference when ordering, motion, identity, or events over time affect the
answer.

## Establish A Frame Baseline

Start with controlled decode and sampling plus a per-frame model and simple temporal
aggregation when that can express the task. Record codec, resolution, nominal and
actual timing, timestamps, sampling stride, clip/window length, and spatial transforms.
Random neighboring frames are not independent evidence.

Escalate to temporal fusion, 3D/factorized convolution, video transformers, temporal
self-supervision, audio, pose, flow, or multiview inputs only when the baseline exposes
a missing temporal capability.

## Tracking

Tracking combines observations with association and state; detector quality alone is
not tracking quality. Define detection inputs, motion model, assignment, identity/Re-ID
features, occlusion behavior, track birth/death, re-entry, camera-motion compensation,
class/state smoothing, and recovery after dropped or reordered frames.

Classical motion and assignment can coexist with learned detection and embeddings. Add
a signal only when it improves association on fixed cases; an unstable categorical or
VLM attribute can increase identity fragmentation.

## Action And Event Recognition

Define action boundaries, label granularity, lead time, clip sampling, overlapping
events, background/negative policy, and whether RGB, pose, trajectories, audio, or other
sensors carry the decisive evidence. Split by subject, session, scene, and time as the
deployed generalization contract requires.

## Evaluation And Runtime Handoffs

Use CV evaluation for clip/event metrics and tracking measures that separate detection
from association, plus identity-switch and hard-slice analysis. Use CV inference for
codec/decode, FPS/PTS, buffering, ordering, stateful capacity, and overload. Report
results with the actual temporal sampling and hardware rather than portable FPS claims.
