# Components, state and environments

Use when selecting infrastructure boundaries, changing platform interfaces, assembling environments or choosing validation for an infrastructure change.

## Define the capability before the abstraction

Describe what the workload needs: scheduling, connectivity, storage, identity, locality, isolation, scale, continuity and recovery. A platform capability needs an owner, supported interface, self-service path and recovery responsibility whether it is self-hosted, managed or SaaS. Provider management moves some lifecycle work; it does not remove integration, permissions or recovery ownership.

Keep these units distinct:

| Unit | Its contract | Failure caused by confusing it |
|---|---|---|
| Resource | A provider-managed object with live identity | A rename is mistaken for harmless source cleanup |
| Library/module | Reused source knowledge or construction logic | More directories are mistaken for independent deployment |
| Stack instance | A bounded unit that can be created, changed, tested and recovered | One apply affects unrelated environments or consumers |
| Composition | Configuration, discovery and ordering across stack contracts | Hidden dependencies require the whole estate for every test |
| Shared live instance | Deliberately shared runtime capacity or service | Code reuse silently creates shared availability and authority |

Start with a cohesive stack. Split when ownership, lifecycle, co-change, permissions, risk or feedback diverge enough to justify additional orchestration. Separating durable data from replaceable compute often narrows recovery risk. Do not split by arbitrary resource count or wrap every provider field. Reuse domain knowledge and supported defaults; a module with many flags that add unrelated subsystems often hides several distinct stacks.

For each dependency, publish an owner and capability-level output: meaning, compatibility, availability and change responsibility. Resolve name/tag matching, remote-state lookup or registry discovery in composition/delivery logic and inject ordinary values into consumers. That permits fixtures and avoids embedding tool/state-format coupling in every stack. Keep provider-to-consumer dependencies directional and acyclic. If a registry is introduced, account for its namespace, authority, backup and availability as a new dependency.

## Preserve identity and legitimate variation

Inventory versioned definitions and dependencies, per-instance configuration, secret references, generated desired state, state/identity mappings, live resources, runtime data and deployment records. Rebuilding definitions cannot reconstruct user data or an identity mapping that was never preserved.

Use a reusable definition with separately managed instances for environments. Distinguish required consistency from necessary differences in capacity, access, locality or naming. Environment branches and copied projects create drift; major structural differences may warrant separate definitions or delivery paths. Environment is a logical grouping, not a synonym for account, namespace, region or delivery stage.

Choose isolation against the actual contamination or authority path. Shared namespaces, runtimes or clusters may share control planes, administrators, upgrades, storage or capacity. Account/project boundaries can constrain provider API authority that a network boundary does not. Record accepted coupling and verify the provider's actual hierarchy rather than relying on cloud analogies.

## Construct replaceable runtime capacity

Separate installed software, managed configuration and runtime data. Bake stable software into known images and inject instance-specific configuration when useful; the choice depends on rebuild time, variation and authority. A pull bootstrap needs a trusted artifact/identity path; a push path needs bounded privileged connectivity and an explicit readiness handoff.

Where replacement fits the workload, build a new instance, validate it, admit traffic, observe, drain and retire the old one. Immutability describes managed software/configuration, not logs, caches or user data. Do not rely on cloning unexplained live state as a reproducible build. Managed or serverless runtimes still require ownership of bindings, identities, storage, limits and recovery. Choose shared versus separate clusters from actual isolation, control-plane failure and fleet-operation costs.

## Validate the consumer outcome

Map the material risk to the cheapest credible observation:

| Risk | Useful early evidence | Evidence requiring a live environment |
|---|---|---|
| Invalid construction or forbidden resource | Syntax/type checks, generated-model tests, policy evaluation | Provider acceptance and actual enforcement |
| Replacement, destruction or wrong target | Plan against the intended state/target and identity inventory | Post-apply identity and dependent behavior |
| Broken output or dependency contract | Inject provider fixtures; validate documented output shape | Lightweight consumer connects and performs the supported operation |
| Isolation or privilege regression | Policy diff and effective-authority reasoning | Authorized allowed/denied access checks at the claimed boundary |
| Continuity or recovery failure | Compatibility and transition review | Readiness, drain, cutover, rebuild/restore behavior under controlled conditions |

Do not assert the same resource declaration hundreds of times. Test variants and interactions that could fail independently of syntax. A preview describes intended operations; it cannot establish workload health. An official fake needs an owner and evidence that it matches the real provider contract; a private imitation can drift silently.

Choose persistent, ephemeral, periodic-rebuild or reset environments from feedback time, cost, contamination, wedge rate and cleanup reliability. Give leaked resources and failed asynchronous cleanup a visible owner; a green foreground test does not prove cleanup. When every test needs every upstream service, revisit dependencies before adding more infrastructure.

## Evolve and retire a platform capability

Discover actual consumers, including runtime/configuration references, and agree compatibility windows. Platform migration needs owned transformations, capacity, staged execution and support for frozen consumers; announcing a deadline alone does not perform the migration. Software engineering owns the broader migration/change policy, while platform carries the infrastructure transition and consumer evidence. Preserve backward compatibility when feasible; otherwise publish actionable migration steps and the authority for compulsory change.

Verify the last affected consumer and target instance before retiring old resources, credentials or discovery outputs. Apply data retention and recovery decisions from the data owner. Measure remaining version spread, consumer failures, drift age and cleanup failures rather than claiming completion at the first successful deployment.

Basis: *Infrastructure as Code, Third Edition*, Chapters 5–18 and 20; *Software Engineering at Google*, testing and large-scale change. Current provider/interface behavior needs target-specific documentation.
