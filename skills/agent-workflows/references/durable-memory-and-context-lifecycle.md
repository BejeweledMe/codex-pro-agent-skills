# Durable Memory And Context Lifecycle

Use this reference when work spans sessions or context windows, when a summary will guide resumed execution, or when facts/preferences may persist into future tasks. Durable agent-memory promotion is an authorized workflow effect owned here. Corpus ingestion and retrieval mechanics belong to `$rag-engineering`.

## Separate The State Classes

| State | Purpose | Boundary |
| --- | --- | --- |
| Event record | Observed messages, actions, and results | Records what occurred or was reported; does not certify its truth |
| Task ledger | Goal, acceptance, facts, hypotheses, blockers, authority, budget, and progress | Canonical task state with an explicit owner |
| Durable facts/preferences | Approved information used across sessions | Requires evidence, scope, write authority, conflict handling, and validity rules |
| Knowledge references | Addressable sources and versioned artifacts | Retrieval returns evidence under current access rights |
| Context/summary | Small working projection for the next decision | Derived navigation; never a new authority source |
| Checkpoint | State and effect record sufficient for defined recovery | Must support restoration or explicit reconciliation |

Preserve the observation/evidence/verified-fact distinction from [tools and state](02_tools_state_contracts.md). A saved hypothesis remains a hypothesis. A remembered preference can be verified as an attributable user statement without claiming it is timeless or universally applicable.

## Assemble And Compact Context

Preload stable task constraints and the minimum state needed for the next decision. Retrieve detailed evidence just in time. Keep authority, acceptance criteria, blockers, pending effects, and remaining budget visible; reference large artifacts by identity and locator.

When compacting, retain:

- The current goal, accepted changes to scope, and unmet acceptance criteria.
- Verified facts separately from hypotheses, conflicts, and unresolved questions.
- Exact evidence and artifact pointers, relevant versions, and verification verdicts.
- Completed and pending effects, operation identities, blockers, and the next permitted transition.
- Current permission scope, remaining budget, and checkpoint identity.

Check the summary against its canonical inputs. If a critical locator, constraint, or effect status was lost, rebuild that portion from the source before acting. Do not infer success, permission, or a settled conflict from compressed prose. No universal token threshold determines when to compact or reset.

## Checkpoint And Resume Contract

A summary helps orientation. A recoverable checkpoint identifies the ledger version, canonical artifacts, workflow/tool/policy versions, completed stages, retry/deduplication identities, outstanding effects, remaining budgets, and relevant external session or transaction state. Record what can be restored and what must be reconciled.

Use existing task artifacts and state storage where adequate. Checkpoint writes require authority for their destination and content; persistence is not automatically authorized by a need for continuity.

Before a side effect, make its intent and logical operation identity recoverable where the workflow's durability contract requires it. After execution, record the observation and verified outcome. A crash between external success and local recording leaves an uncertain outcome; a checkpoint must not falsely label that effect failed or safe to repeat.

On resume:

1. Load the canonical ledger and checkpoint, then compare artifact, workflow, and external-state identities.
2. Resolve outstanding effects through authoritative reconciliation or protected idempotent replay under the [retry contract](02_tools_state_contracts.md#retry-and-compensation). Preserve the same logical identity and payload within the destination contract's scope and deduplication lifetime, deadline, and retry limits. If neither route is safe, stop blind resubmission and route to the recovery owner. Keep dependent actions blocked until their required outcome is established.
3. Recheck current authority, evidence freshness, expired or superseded memory, and remaining budget. A resumed run does not silently renew limits or permissions. Resolve permission from the current governing instructions or runtime policy, not from a memory entry claiming an earlier approval. Existing authorization remains valid where its scope and conditions still hold.
4. Rebuild working context and verify the next transition's preconditions.
5. Continue, restore an eligible known-good state, or return a blocking terminal with the unresolved recovery condition.

Text replay cannot restore an external session. When restoration is impossible, preserve the uncertainty and route to compensation, manual recovery, or a safe fallback. `$system-design` owns generic transaction, storage, and delivery mechanics; supply the required agent-state and external-effect semantics.

## Durable Write Lifecycle

`extract candidate -> classify -> attach evidence -> check authority and conflict -> propose -> commit, supersede, or reject -> expire or revalidate`

Extraction may remain in working context. Persisting even a candidate or summary is a write effect requiring the appropriate scope.

| Stage | Contract | Failure response |
| --- | --- | --- |
| Extract | State the exact claim or preference; separate quotation/extraction from model inference; identify subject and task scope | Keep ambiguous content as a hypothesis or omit it |
| Classify | Identify fact, preference, procedure, episode result, or summary; record sensitivity and intended audience/destination | Minimize unnecessary retention; reject an unsuitable destination |
| Evidence | Attach source identity, locator, version/time, supported claim, verifier/verdict, scope, and freshness | Keep unsupported claims unverified; do not promote confident self-report |
| Authority | Identify who or what authorizes this operation, destination, subject, audience, and duration | Use `missing_authority` or prepare a reviewable proposal without persisting it outside scope |
| Conflict | Compare relevant current records and sources; distinguish changed facts, different scopes, and unresolved disagreement | Preserve conflicting evidence and route unresolved authority decisions to the named owner |
| Propose | Name the exact insert/update/supersession, expected current version, evidence, validity, and recovery path | A proposal is not a committed memory |
| Commit | Recheck current state and authority; perform one authorized logical write; verify stored content, status, and resulting version | Resolve uncertain outcomes by authoritative reconciliation or protected replay under the resume contract above; do not report an unverified write as complete |
| Supersede | Link the new record to the old one and record reason, evidence, effective scope/time, and authorization | Prevent the old record from continuing as current; preserve required provenance under retention/access policy |
| Expire/revalidate | Define expiry or a revalidation trigger and owner appropriate to the claim | Mark stale records ineligible as current facts until revalidated; do not silently renew them |

An evidence source's authority to support a claim differs from authority to store, disclose, delete, or promote that claim. Reading a source does not grant any of those effects. Existing user instructions or an established workflow policy may already authorize the write; do not require repeated confirmation when the exact effect is covered.

Resolve conflicts using attributable source authority, scope, effective time, and direct evidence. Newer text alone does not win, and multiple copies of the same source do not create independent support. Do not let a model resolve a policy or ownership dispute by confidence. A user preference update may supersede an older preference within its stated scope; a disputed external fact remains contested until adequate evidence resolves it.

For retryable commits, preserve the logical write identity and expected version. Concurrent changes require reconciliation rather than overwriting a newer record. The storage owner implements the needed concurrency mechanism; the agent workflow specifies the accepted result and verifies it.

## Supersession, Expiry, And Recovery

Retain enough authorized provenance to explain why a record is current, superseded, rejected, or stale. Do not retain prohibited content merely for audit convenience. Authorized deletion, disclosure, and retention changes have their own effect contracts.

Invalidate or recheck dependent summaries when their source record changes. Retrieval and context assembly must respect current access and lifecycle status. Rolling back a workflow or loading an old checkpoint must not silently revive superseded facts, expired preferences, deleted content, or revoked authority.

Expiry may be time-based or triggered by a source, artifact, policy, or environment change. Choose it from the information's volatility and consequence of error, not a universal TTL. A revalidated record needs new evidence and a recorded validity decision; reading it again is not revalidation.

## Diagnose And Verify

| Symptom | First evidence | Action and verification |
| --- | --- | --- |
| Resume follows the wrong task | Ledger goal versus summary and artifact versions | Rebuild context; verify the next action against current acceptance |
| Memory turns speculation into fact | Original observation, extraction, and verification status | Reclassify or reject the record; repair dependent summaries |
| Old preference overrides a current instruction | Source authority, scope, supersession, and effective time | Apply current scoped authority; supersede memory only if authorized |
| Commit is duplicated after interruption | Write identity, expected version, and storage record | Reconcile one logical effect before retrying |
| Stale content returns after rollback | Lifecycle status and restored checkpoint dependencies | Exclude it from current context and verify reconstruction |
| A summary leaks beyond its permitted audience | Destination/access scope and retained content | Stop disclosure, invoke authorized recovery, and route threat testing to `$genai-security-testing` |

For a persistent workflow, verify interrupted-write recovery, conflict handling, supersession/expiry behavior, and resume from canonical evidence using existing checks appropriate to the change. Send redacted cases and traces to `$agent-llm-evals` for memory quality, state integrity, and recovery evaluation. This does not require a new harness for a routine task.

## Evidence Basis And Limits

Stanford CS329A selected readings on memory, including MemGPT, and agent context/long-running harness guidance motivate external state, context projection, and recoverable progress. The explicit authority/conflict/commit lifecycle is engineering guidance, not a complete storage protocol or universal vendor memory API. Refresh implementation-specific persistence, access, session, and context behavior when those details affect correctness.
