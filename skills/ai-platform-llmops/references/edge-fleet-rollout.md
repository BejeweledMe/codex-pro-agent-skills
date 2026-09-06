# Edge fleet rollout

Use this reference for deploying and recovering model/policy bundles across device cohorts, including the operational envelope for local adaptation and federated participation. Product/model owners decide why edge execution is needed and what quality/locality/degradation is acceptable. Target-runtime owners supply sustained device evidence and training owners supply adaptation execution semantics.

## Establish cohorts and executable compatibility

Group devices by meaningful differences: runtime/operator support, memory and storage, device/accelerator tier, sustained thermal/battery behavior, connectivity, region/policy, and current bundle/local-state version. Average fleet performance hides tiers that cannot load, sustain, or roll back the candidate.

Obtain target-device or hardware-in-the-loop evidence for load, peak and sustained memory, inference latency/quality, battery and thermal behavior, and local adaptation when used. A small inference artifact does not prove adaptation fits; training adds mutable state and different peak resources. Use $computer-vision-inference-optimization for sustained visual-runtime evidence where applicable.

Deploy a signed/versioned policy-model bundle through the supported update mechanism: base model, tier selection, preprocessing/tokenizer where relevant, adaptation rules/artifact, runtime configuration, local-state compatibility, eligibility conditions, and rollback target. Verify integrity and signer identity through the device’s configured trust mechanism, then check whether that signer and exact bundle/version are currently authorized for this cohort. A valid signature does not by itself establish release approval, freshness, compatibility, quality, or privacy.

## Roll out under disconnection and version skew

Track offered, downloaded, verified, activated, healthy, rolled-back, and unreachable states as the implementation supports them. Do not count dispatch or download as active healthy deployment. Preserve compatible prior artifacts and a frozen known-good fallback where the operating contract needs offline recovery.

Keep server compatibility explicit for supported older bundles and update formats. For unsupported or revoked versions define restricted operation, safe fallback, or required update according to current product/security policy; indefinite compatibility with every offline device is not assumed.

Choose cohorts to expose meaningful device/runtime/connectivity variation and cap the initial impact. Use the model owner’s quality gates and the device/runtime owner’s sustained resource limits. Observe propagation and acknowledgement by cohort, plus version skew and local-state versions. Define when a device can remain on an older compatible version and how it resumes safely after reconnecting.

A partial or failed download should leave a usable bundle through the update system’s staged validation/activation or equivalent recoverable behavior. Verify space for update plus fallback, compatibility of local state, and interruption recovery before broadening a consequential release. Do not assume server rollback can immediately reach disconnected devices.

If rollback is needed, freeze further exposure, direct reachable cohorts to the compatible policy-model target, and enforce the existing local fallback rules on disconnected devices. Observe actual activation and recovery, not just a server command. Specify whether local adapted state can migrate, must be quarantined, or must be discarded; the model/training owner supplies that semantic decision.

## Keep foreground work within the device envelope

Give the product’s foreground inference/user experience priority over opportunistic adaptation. Eligibility can depend on idle state, charging/battery, thermal condition, connectivity, storage, and available memory, but thresholds come from measured devices and product requirements. Suspend, defer, or recover adaptation through its declared execution contract when the envelope changes.

Test foreground contention and sustained operation, not only an isolated warm benchmark. An adaptation job that is cheap on a cool charging device may cause latency or battery regressions in real use. Compare policy changes by useful outcomes per cohort, failed/suspended work, thermal/battery effects, and recovery cost.

Monitor shadow divergence from the frozen baseline where feasible, but do not treat agreement as ground truth or immediate proof of benefit. Delayed labels and rare failures still need model/evaluation evidence. Harmful or incompatible local adaptation should trigger its defined containment and fallback path, preserving the evidence and privacy boundary.

## Operate federated participation without overstating privacy

When federated work is in scope, record eligible, selected, started, completed, dropped, and accepted participants by round/cohort, with the base/update versions and expiration rules required by the aggregation owner. Explain missingness: connectivity, battery, compute eligibility, and dropout can change which population contributes. Report that selection evidence to the model owner before claiming representative improvement.

Budget model download and update upload, rounds, retransmissions, failed attempts, device energy, and aggregation/storage overhead. Comparing one raw-data upload with one gradient/update omits the operational lifecycle. Check network and participation tails and recovery after intermittent connectivity.

Raw-data locality is not a privacy guarantee. Updates, model downloads, identifiers, and participation metadata remain exposed surfaces. Secure aggregation, differential privacy accounting, poisoning defenses, authentication, and retention address different threats. Obtain specialist evidence for the chosen protocol, privacy unit/accounting/composition, and acceptable utility; this reference does not invent secure aggregation or DP recipes.

Keep telemetry and retained local/federated state within the approved data boundary. Bundle rollout must preserve access and retention policy through downgrade or recovery. Route deletion/influence and detailed privacy requirements to their data/model/security owners.

## Failure evidence and completion

| Failure | Distinguishing observation | Next step and proof |
| --- | --- | --- |
| Candidate healthy on average, one tier regresses | Cohort runtime/operator support, sustained memory/thermal/latency and version | Halt that cohort, restore compatible target, remeasure the affected device path |
| Rollback command sent, devices still fail | Reachability, downloaded versus active version, local-state compatibility | Apply reachable recovery and local fallback policy; track remaining skew/unreachable exposure |
| Foreground latency rises during adaptation | Concurrent state/CPU/device load, thermal/battery trajectory | Tighten measured eligibility or suspend adaptation; confirm foreground recovery |
| Federated improvement hides poor cohort coverage | Eligibility/selection/dropout/accepted-update distribution | Adjust operational participation with model-owner evaluation; avoid extrapolating aggregate quality |

Completion evidence includes affected cohorts and versions, target-device compatibility, rollout/rollback convergence, disconnected-device behavior, fallback and local-state compatibility, foreground protection, and unresolved privacy/participation limits. Use the scope appropriate to the requested change; ordinary edge deployment does not automatically require federated training.
