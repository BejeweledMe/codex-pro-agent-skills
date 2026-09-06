# State identity and safe infrastructure transitions

Use for OpenTofu/Terraform renames, stack splits, import/adoption, backend changes, replacement or unexpected drift. The durable reasoning applies to stateful IaC; commands and migration support depend on the actual tool, version, provider and backend.

## Establish correspondence before mutation

State maps configuration instances to remote object identities. Source code, state and live infrastructure describe different things; none can substitute for the other two during migration. Record the current and target address, live provider identity, owner stack, backend and dependencies for affected objects. Pin candidate/configuration, tool/provider versions, target account/region and the last known deployment.

Check the backend's actual locking and recovery behavior. A supported backend lock coordinates cooperating state writers; it does not exclude direct API mutation, other controllers or stale actors using a different authority route, and does not choose the authorized version. For a transfer, account for every route that can change the affected objects and quiesce or constrain conflicting actors. Do not disable locking or unlock another writer to make progress; establish whether the operation/lock is active and use the supported recovery procedure. State and plans may contain sensitive material. Encryption at rest does not prevent loss, replay, corruption or visibility to an authorized tool operator. Protect backups and keys and verify recovery compatibility.

## Choose the transition from its live effects

| Change | Evidence needed | Applicable approach |
|---|---|---|
| Address rename without intended object change | Same remote identity, documented remap scope and plan without unintended replacement | Tool-native identity remap within its supported scope |
| Stack split or ownership transfer | Current/target state mapping, dependency wiring, coordination between authorities, adoption support | A version-verified transfer/adoption procedure, or Expand and Contract when identity cannot safely be preserved |
| Resource replacement | Data owner, dependents, parallel capacity, compatible old/new behavior | Build/validate new path, migrate consumers/data, cut over, observe and retire old path |
| Backend or state protection change | Locking, encryption/key compatibility, state version and recoverable backup | Supported backend migration with authority held to one route and post-migration identity verification |
| Unexplained drift | Source/last apply/live differences, actor evidence, legitimate emergency change or possible compromise | Classify first; encode authorized intent or restore desired state with bounded correction |

Do not generalize an in-stack `moved` example to cross-state migration. Import support does not by itself define correct configuration or data semantics. Raw state editing is exceptional surgery, not the routine solution to a refactor; obtain exact supported procedures and a tested recovery route before proposing it.

## Transfer a stack's ownership

For an identity-preserving split, map each source address to its intended target owner and the same remote identity; capture recoverable state for both sides and the data owner's relevant backup contract. Coordinate source and target apply routes before changing ownership. Choose a documented transfer/adoption mechanism for these exact versions; removal from management and adoption are separate actions with an unmanaged or competing-ownership window to control.

Preview both stacks after each material stage. For a pure identity refactor, expect no unintended live changes: investigate creates, replacements, destroys or orphaned objects against the mapping. A literal zero-diff requirement is inappropriate when the authorized transition includes other changes; explain each planned effect instead. Switch consumer outputs only after the provider identity and capability are verified. Retire old ownership routes and permissions after consumer, recovery and retention conditions hold.

## Carry a transition contract

For a material change, establish plausible starting versions, intermediate ownership, replacement/orphan risks, retries, health gates and rollback limits. Preserve state backups and the data owner's backup/replication contract before the hazardous transition. Review the actual plan for destruction, recreation and unexpected dependency changes. A plan is a risk signal, not proof that provider execution or consumer behavior will succeed.

For Expand and Contract, add the new capability, support coexistence, switch/migrate consumers, verify outcome, then remove the old path in a later bounded step. Software and data owners must define mixed-version behavior, writes during transfer, validation and when the old path ceases to be a valid rollback. Rolling, blue-green and canary patterns reduce exposure only under their continuity assumptions; they do not supply write compatibility.

After interruption or partial apply, inspect live objects and current state before retrying. Determine which stages actually completed and whether an external action succeeded despite a timeout. Re-preview the remaining transition with the intended candidate and authority. Do not restore an old state snapshot blindly over changed live infrastructure: it may recreate an incorrect ownership map. Recovery must reconcile both identity and live effects.

## Prove completion and recovery

Verify affected objects correspond to the intended state owner, consumers use the new supported outputs, no unintended object is orphaned, and repeated preview/reconciliation does not propose unexplained work. Check workload/data outcomes separately. Confirm backup/key access and the recovery path under the failures this transition could cause. Retire old state routes and resources only after ownership, consumer and retention conditions hold.

If safe execution depends on unknown provider behavior, provide the concrete identity/transition analysis and identify the exact missing documentation or experiment. Continue nonmutating preparation; do not invent a universal shell sequence.

Basis: *Infrastructure as Code, Third Edition*, Chapters 19–21. Refresh OpenTofu/Terraform state formats, locking, encryption compatibility, import/move scope, and provider replacement semantics for the target versions before commands. There is no universal backend matrix or generic state-repair guarantee in this guidance.
