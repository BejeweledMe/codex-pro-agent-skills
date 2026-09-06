# Registry compatibility and fleet rollout

Use this reference when registering, deploying, changing, recovering, or retiring a model fleet. A registry is the dependency graph needed to reproduce a decision and restore compatible behavior, not just a location for model weights.

## Represent the semantic release unit

For the affected release, identify model/artifact, preprocessing/postprocessing, features and freshness assumptions, tokenizer/template, adapters, prompts/policies, thresholds/validators, runtime/build/precision, scheduler/cache/limits, routes and access policy, evaluation evidence, owners, consumers, and compatible state. Include only applicable members, but do not omit a behavior-changing member because another team stores it.

Store immutable identities or resolvable versions and compatibility edges. A mutable model alias alone is inadequate incident evidence. For each upstream change discover direct and transitive consumers: a shared embedding, feature transform, or tokenizer may affect multiple models and regions despite unchanged API schemas. Ask the model/data owner for the semantic comparison and affected slices; platform schema validation cannot supply it.

Distinguish training provenance, deployable runtime representation, release policy, and actual deployment observations. Artifact signing/provenance and trusted deployment admission help establish identity and origin; they do not prove model quality or complete dependency compatibility. Generic signing/build mechanisms belong to platform DevOps and component trust policy to the security owner.

## Plan exposure according to the question

| Method | Useful evidence | Limitation and platform obligation |
| --- | --- | --- |
| Shadow | Output/runtime divergence on representative input | Isolate side effects and data access; extra shadow load can interfere; delayed outcomes remain unresolved |
| Canary | Severe operational or behavioral regressions under bounded live exposure | Define population, stop condition, and rollback capacity; traffic percentage does not establish statistical power |
| Staged rollout | Compatibility across regions, hardware/runtime tiers, tenants, dependency versions | Widen heterogeneity deliberately and observe common causes; one healthy cohort does not certify others |
| Soak | Leaks, cache/state growth, thermal drift, periodic load, slow degradation | Duration must cover the mechanism being evaluated; short success is insufficient for time-dependent claims |

For statistical quality claims consume the evaluation owner’s sample/duration plan, effect definition, randomization unit, delayed-label handling, clustering, and multiple-comparison assumptions. A canary is not automatically a causal A/B experiment. Do not fabricate an acceptance threshold or sample count from a rollout percentage.

Use the same workload and decision contract when comparing candidate and baseline. Keep quality, latency, errors/rejections, resource/state pressure, and cost evidence attributable to the exact bundle and population. For a small compatible change, bounded checks of the affected dependency and recovery path can be sufficient; all four exposure methods are not compulsory.

## Make rollback executable

Before expanding a consequential release, establish the prior compatible bundle, artifact availability, state/cache/session compatibility, feature/schema dependencies, routes, access policy, and enough ready or loadable capacity to restore the service. Assign the stop decision and expected recovery window.

When a gate fails, stop widening exposure, identify affected consumers/domains, and activate the authorized recovery path. Route new work to the compatible target; handle in-flight work with its drain/session-version contract. Restore or invalidate state only according to declared compatibility. Rollback must preserve current authorization, deletion, retention, and revocation obligations. Compatibility with an older behavior bundle does not authorize restoring its historical access policy or resurrecting deleted data/state. Validate the recovery target against current authority; if incompatible, choose a compliant fallback or forward repair with the responsible owner.

Multi-region rollback has propagation and acknowledgement delay. Track desired versus observed bundle and route state by domain, bound allowed version skew, and define what happens to disconnected/stale controllers and pinned sessions. Do not promise instantaneous global rollback. Confirm convergence with actual serving identity and representative output/protocol checks, not just controller success status.

A weights-only rollback fails if the old transform, adapter, runtime, or state is unavailable. If recovery requires a data/schema migration, record the compatible transition order and forward-repair option before exposure. Escalate an irreversible compatibility gap to its decision owner; do not assume a generic redeploy can reverse it.

## Observe fleet semantics and common causes

Connect user journey/business outcome → portfolio/domain correlation → model/release semantics → service/infrastructure diagnosis. Include data freshness, output validity, slice behavior, baseline divergence, bundle coverage, route/version skew, and runtime/infrastructure state as applicable. The model/evaluation owners define meaningful semantic signals and delayed-outcome interpretation.

When many models degrade together, inspect shared feature/data/embedding/runtime/artifact/region changes and dependency edges before restarting or retraining individual models. When one model fails semantically while latency and HTTP health remain green, stop its rollout and pass the exact semantic evidence to its model/data owner. When one physical domain is slow across bundles, inspect capacity and hardware evidence.

For actionable signals identify a threshold or decision criterion, owner, authority, response, and revalidation condition. Coordinate incident containment with SRE. Preserve useful attribution without collecting unnecessary raw inputs, prompts, or protected data.

## Retire without breaking consumers or recovery

Discover active routes, pinned clients/sessions, downstream consumers, edge/offline populations, retained state, and remaining rollback obligations. Stop new selection, migrate or notify consumers through the authorized workflow, drain usage, and confirm observed absence over a window appropriate to the workload. A low traffic average may hide periodic batch consumers.

Then remove deployment capacity and retire registry aliases/artifacts according to retention, audit, and deletion obligations. Keep required provenance and evidence through the responsible data/security process. Before routine retirement removes a still-required rollback target, establish another compatible recovery path. If deletion or revocation makes the old target impermissible, retire its recovery eligibility and resolve the remaining availability risk; recovery convenience does not override current obligations. Treat retirement as a versioned transition with an owner and observed result.

For a consequential release, rollback or incident handoff, retain the relevant record: impact/population; current and target bundle; dependency and consumer map; deployment/route state by domain; runtime and semantic evidence; stop/rollback authority; compatible state/capacity; mitigation and remaining risk. Scale detail to the affected change and revalidate after dependency, policy, runtime, topology, or population changes.
