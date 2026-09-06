---
name: platform-devops-engineering
description: "Provision, deliver, debug, or recover infrastructure through Terraform/OpenTofu state transitions, container builds, Kubernetes, GitOps reconciliation, CI identity, and deployment admission. Own apply mechanisms; application behavior and live reliability acceptance stay with their engineering owners."
---

# Platform DevOps Engineering

Own the executable path from infrastructure intent to observed workload capability: assemble an identifiable candidate, construct target desired state, preview the transition, apply or reconcile, verify consumers, then recover or retire resources. A successful build, plan, signature, apply or sync establishes only that stage's bounded result.

## Working method

Start with the requested outcome and the failing or changing contract: build, image, runtime, cluster, state identity, deployment, reconciliation or release verification. Inspect the existing definitions, target identity, relevant versions and current observations before choosing a mechanism. For a small change, use its existing path and proportionate checks; do not invent a platform program.

For material changes, make the following concrete in the existing implementation or change record:

- Capability and consumer: owner, supported inputs/outputs, environment and isolation requirements, observed acceptance condition.
- Identity: source and dependencies, tool versions, artifact digest, target account/cluster/stack, configuration and secret references, state mapping. Record secret locations by role, never secret values.
- Transition: plausible starting versions, replacements, coexistence, data/write compatibility, ordering, authority and retriable stages.
- Control: preview and policy checks, health gates, correction bounds, pause, rollback or forward recovery, and evidence of the final consumer outcome.

Keep lasting corrections in versioned intent. Distinguish intended changes from unexplained drift before reconciling. Shared infrastructure needs one recorded apply authority: a supported state lock serializes cooperating state writers but does not select the correct candidate or fence direct provider actors. Do not treat code refactoring as proof of safe live identity migration.

## Read the relevant mechanism

- For stack/module boundaries, dependency wiring, environment variation or infrastructure tests, read [components-state-and-environments.md](references/components-state-and-environments.md).
- For image/build/runtime boundaries, cluster readiness, rollout, effective privilege or tenancy, read [containers-kubernetes-lifecycle.md](references/containers-kubernetes-lifecycle.md).
- For live renames, imports, stack splits, replacement, backend changes or drift involving identity, read [opentofu-safe-transitions.md](references/opentofu-safe-transitions.md).
- For shared apply, GitOps, controller loops, staged rollout, pause or infrastructure recovery, read [gitops-apply-and-recovery.md](references/gitops-apply-and-recovery.md).
- For protected builders, CI identity, signing/provenance, artifact promotion or admission enforcement, read [provenance-and-deployment-admission.md](references/provenance-and-deployment-admission.md).
- [Reference guide](references/00_README.md) records evidence and refresh boundaries. Read its limits when selecting current product behavior or standards claims.

## Ownership and completion

Software engineering owns source/candidate lifecycle, test policy, broken-mainline restoration and code migration governance. Platform executes infrastructure delivery and consumer migration with sufficient capacity and authority. System design owns workload topology, authoritative data and cross-service invariants; application and database owners supply runtime behavior, schema/write compatibility and recovery requirements.

SRE owns user-facing reliability objectives, live incidents and recovery judgment. Retain its practical probe, resource, PDB, HPA and shutdown diagnosis; platform implements the resulting runtime/control-plane changes and provides evidence for SRE to judge. During live harm, pass recent changes, identities, rollout/controller state, pause/recovery controls and surviving dependencies to the incident owner while completing authorized platform work.

Application security engineering owns dependency/supplier policy and application security requirements. Platform owns protected build/release identities and enforcement points; security review independently assesses controls, release evidence and exceptions. AI platform owns predictive and GenAI registry compatibility, shared training-job topology/gang/preemption/recovery capacity, serving controllers and supported edge/fleet rollout. It passes workload placement, readiness and recovery requirements here; platform returns infrastructure identity, capacity and observed delivery state. Generic IaC, images, Kubernetes and CI mechanisms remain here.

Finish with what changed or what explains the failure, exact affected scope, observed validation, remaining uncertainty and the owner of any unresolved acceptance decision. A started rollout is not a completed rollout: identify outstanding target instances and cleanup. Report a preview as a preview and a recovery plan as unexercised until observed evidence exists.
