# Threat Models and Effective Authority

## Model the changed path

For a bounded feature, start with its input, protected state, output and side effect. For a new service or significant trust change, add actors, identities, tenants, data stores, external dependencies, administrative and recovery routes. A data-flow diagram or STRIDE pass can reveal missed interfaces; neither proves that threats are complete.

Write the invariant in domain terms: for example, only a currently authorized member of the owning tenant can export the permitted fields of a record. This implies separate membership, ownership, field, state and export checks. A successful login answers only one preliminary question.

Trace who can acquire, delegate, exercise, change, revoke and restore authority. Include service identities, queues, support resets, operators, cached decisions, existing sessions, signing and update powers. An internal network location or configured role list does not establish all effective access.

## Choose enforceable controls

| Condition | Mechanism and preconditions | Failure evidence and corrective action |
| --- | --- | --- |
| Many callers need the same permission rule | Centralize understandable policy or a safe application abstraction, with enforcement on every reachable trusted path | Compare UI/API/job/admin routes; a missing check or overpowered internal caller requires closing that path, not only repairing the UI |
| A backend acts for a user | Carry authenticated originating subject and tenant separately from service identity; authorize the intended action at the receiving service | A trace showing only the service principal explains confused-deputy risk; bind accepted context to trusted ingress and prevent caller substitution |
| Shared tenant resources | Scope object lookup, field access, cache keys, jobs, quotas, exports and idempotency records to validated tenant context | Compare subject/object tenants at each hop; repair lost context or key collisions and inspect already produced copies |
| A policy changes while work is running | Define when the change takes effect at each validator and how cached or delegated authority is invalidated | Old credentials or queued work succeeding after the promised cutoff disproves revocation; fix propagation, cancellation or reauthorization at execution |
| A transaction spends a limited resource | Bind permission to the actual object/state; enforce quantity and transition rules atomically at the state authority | Concurrent successful operations that violate the aggregate invariant need a transaction/constraint/locking fix; route engine mechanics to the database owner |
| High-consequence approval is required | Present the actual target, amount, recipient and effect; bind approval to that immutable intent and current authority | An approved summary differing from execution requires intent binding and freshness checks; two approvers sharing one compromise path do not prove independence |
| A security dependency is unavailable | Choose permitted degraded operations in advance, bound work, and preserve the security floor and responder access | A timeout causing unrestricted reads/writes requires denying or deferring those operations; resource starvation needs separate capacity/timeout controls |

Do not make all stale authority acceptable through a generic cache TTL. Decide the exposure tolerated for the operation, including disclosure that cannot be reversed, and reconcile it with any selected requirement demanding immediate change. If the architecture cannot meet the requirement, surface the gap.

## Failure, compromise, change and reversal

For a material control, distinguish its behavior when unavailable; the authority exposed if compromised; who can change policy or configuration; and how it is revoked, quarantined, repaired or rebuilt. Keep the selected security floor enforceable and reserve a viable responder path. Scope automation so it cannot silently undo a human quarantine or reacquire compromised capacity.

Separate prevention from detection, staffed response, trusted recovery and affected-person remedy. A detector needs visibility, acceptable false-action costs and enough response capacity to intervene within the harm window. More alerts can make intervention worse. Human approval needs time, context and authority; for safety-sensitive account or household flows, consider whether notification or forced credential change exposes a person to coercion and involve the relevant product/support owner.

## Follow abuse and failure through exceptional states

Inspect normal, retry, partial-commit, overload, support, migration, restore and retirement paths. Ask whether an attacker can deliberately induce a rare condition. A safe ordinary path can be bypassed by compatibility mode, an administrator API, or an old signing key restored from backup.

Remove unnecessary privileges first. Where containment is needed, identify what actually separates identities, data, credentials, trust roots, administrators, configuration and recovery. Two replicas sharing all those dependencies increase availability without establishing independent security containment.

For an observed failure, collect the smallest evidence that distinguishes causes: the effective subject and tenant, requested operation and object/state, policy version, enforcement result, and resulting state or disclosure. Protect the evidence as sensitive data. A denial log without the final effect cannot prove enforcement.

## Recover the invariant

Identify which surviving authority can disable the path, revoke credentials, restore current policy, reconcile state and recover legitimate access. Coordinate live action with the incident owner. Recovery must not restore obsolete permissions, replayable transactions, compromised keys or previously deleted data. A successful rollback or healthy service is insufficient until prohibited access still fails and valid work remains possible.

If disclosure already occurred, reversal of the write or withdrawal of permission cannot recall the data. Pass exposure and affected-party support needs to the authorized risk/incident owner. Keep detection, containment, recovery and remedy as separate claims.

## Compact claim record

Use existing issue or design records. For a material control, retain: protected outcome and people; operation/invariant; target and environment; actors/effective authority; normal and exceptional paths; selected mechanism and assumptions; applicable source/version; implementation and behavior evidence; known limits and residual harm; engineering, action and acceptance owners; recovery basis; refresh trigger.

Refresh after a new authority, tenant boundary, parser, integration, support path, dependency, restore path, bypass or incident invalidates an assumption. Repeated breakglass or unsafe-API exceptions should lead to a usable safe path, rather than a growing list of permanent exceptions.

Source basis: *Security Engineering, Third Edition*, policy/assurance, access control, composition and lifetime support; *Building Secure and Reliable Systems*, least privilege, resilience and recovery; ASVS 5.0.0 authorization and business-logic families; OWASP Threat Modeling Cheat Sheet.
