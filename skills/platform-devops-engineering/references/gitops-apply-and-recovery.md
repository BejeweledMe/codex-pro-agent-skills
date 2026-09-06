# Apply authority, GitOps and recovery

Use for infrastructure delivery paths, shared applies, controller integration, drift loops and recovery. Treat automation as an operated production system with bounded authority and an observable stop mechanism.

## Make each stage's contract explicit

| Stage | Input and output | What success does not prove |
|---|---|---|
| Assemble | Source plus dependencies becomes a retrievable candidate | Correct target configuration or safe live transition |
| Compile | Candidate plus configuration, secret references and state context becomes desired state | Provider acceptance or live behavior |
| Preview/apply | Desired state compared with the target, then executed under known authority | Consumer health, data correctness or security acceptance |
| Verify/promote | Observations support exposure to additional targets | All targets completed or future drift prevented |

Preserve an immutable candidate through promotion where practical; if a toolchain rebuilds, pin and compare inputs and record resulting identity. General-purpose IaC code may execute while constructing desired state, before provider mutation. A compile failure and an apply failure require different evidence.

For shared targets, use one recorded route that selects the candidate, authenticates, supplies configuration, orders dependencies, publishes outputs and retains results. It may be a pipeline or deployment service; isolated personal environments need not adopt enterprise infrastructure. Define trigger, target scope, permissions, output identity, health gate, retry and recovery for each material stage. Keep the normal path usable for urgent repair.

## Treat each reconciler as a distinct loop

GitOps combines declarative desired state, versioned immutable history, automatic pull and continuous reconciliation. Argo CD reconciles Kubernetes resources; OpenTofu manages its own infrastructure/state contract. Using both requires an explicit local integration design, not an assumed reference architecture.

Give each resource one intended controller/authority. At a cross-system boundary publish readiness and output identity, define which stage waits for which condition, and keep credential/bootstrap/recovery dependencies visible. An Argo sync wave is not arbitrary orchestration of an external infrastructure apply. Avoid circular dependence in which the control plane needed to recover infrastructure exists only inside that broken infrastructure without an alternate path.

For Argo, inspect Applications, AppProjects, destination/repository permissions and namespace scope. Check effective default RBAC grants: the documented `policy.default` grant exception matters when interpreting deny rules. Within a sync, inspect phase/wave and health rather than assuming order implies readiness. Selective sync can skip hooks; pruning reverses wave order; unhealthy early waves can block later ones; deletion hooks can block deletion. Verify these semantics for the deployed version before changing configuration.

## Diagnose and bound correction

| Symptom | Evidence | Response |
|---|---|---|
| Successive applies revert each other | Candidate/actor timeline, lock behavior and authority routes | Resolve candidate selection and competing authorities; more locking alone will not fix it |
| Repeated apply/revert or endless drift | Desired/live diff, source trigger, controller events and correction count | Pause the affected loop, identify competing control or invalid desired state, correct the source, then re-enter bounded reconciliation |
| Healthy sync but failed workload | Observed runtime readiness and consumer transaction, not just object status | Repair runtime/configuration contract and its health gate |
| Emergency fix disappears | Source versus manual change and reconciler behavior | Preserve authorized mitigation in source and complete the governed path |
| Repair automation undoes containment | Quarantine intent and controller scope | Preserve the current authorized containment intent; when authorized recovery changes it, update desired state and controller scope before resuming correction |

Expose trigger provenance, selected candidate, target, observed generation/status, errors, recent corrections and pause state. Bound retry/change rate and target scope according to failure impact. A correction that deletes capacity, increases cost or can be induced by an attacker may be less safe than detection or prevention.

## Pause, recover and resume

A pause must stop the relevant mutation authority, not merely silence its alert. Identify subordinate or competing controllers that could continue applying. Preserve observations needed to understand partial changes. Under active user impact SRE owns incident priorities and recovery acceptance; platform supplies the operable controls and carries out authorized infrastructure actions.

Choose rollback, forward repair or restore from actual artifact availability, state identity, data compatibility and security constraints. A formerly healthy revision may now be disallowed or incompatible. A drift loop must not treat deliberate quarantine as accidental drift. An authorized recovery may lift or replace quarantine: establish the updated intent, preserve required evidence, verify the affected capacity and effective authority, then reconcile that intent within its scope. Do not reintroduce known-compromised credentials. Exercise access to source, artifacts, state, keys, provider API, monitoring and responder identity under the failure being recovered; ordinary redundancy can share the same broken authority.

When an emergency route is necessary, constrain its authority/scope, preserve original actor attribution and action evidence, and give it an owner and retirement condition. Frequent bypass use is evidence the normal path needs improvement. Do not introduce a second untested recovery system merely to appear independent.

Resume with corrected source and known candidate, bounded scope, observable consumer outcome and explicit remaining targets. Validate drift stabilizes, affected consumers recover, and temporary grants/resources are retired. Track loop/pause events, conflicting applies, restore success and rollout lag; no universal canary fraction or recovery-time guarantee follows from GitOps.

Sources: *Infrastructure as Code, Third Edition*, Chapters 14–21; [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/), controlled change and recovery; Argo CD [Declarative Setup](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/), [RBAC Configuration](https://argo-cd.readthedocs.io/en/stable/operator-manual/rbac/) and [Sync Phases and Waves](https://argo-cd.readthedocs.io/en/stable/user-guide/sync-waves/). Stable-channel documentation and controller integration require version-specific confirmation.
