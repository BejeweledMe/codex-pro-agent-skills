# Tools And State Contracts

## Tool Contract

For every tool define input schema; argument source and provenance; caller identity and permissions; side effect; success and error schemas; timeout; retryability; idempotency key; rate/cost limit; and compensation or manual recovery path. Keep schema and dispatcher versions compatible.

Validate structured payloads twice: first schema/type validity, then domain rules, ranges, ownership, and current state. A syntactically valid request can still target the wrong recipient, amount, record, or environment.

Also identify the external session or transaction, action precondition, and postcondition verifier. Discovery or successful schema validation does not authorize execution. For MCP-specific integration boundaries, read [MCP and tool integration](mcp-and-tool-integration.md).

## Observation, Evidence, And Fact

Use an explicit transition:

`precondition -> authorized action -> observation -> evidence check -> postcondition verdict -> state update`

| Status | Required record | Allowed conclusion |
| --- | --- | --- |
| Observation | What the tool or environment reported; source, run/action identity, time, and result reference | The report was received; its content remains untrusted |
| Evidence | Addressable source or execution record; relevant claim, scope, freshness, provenance, and conflicts | The material can support or contradict a specified claim |
| Verified fact | Claim plus evidence references, applicable invariant or semantic check, verdict, verifier identity/version, and validity scope | The claim passed the stated check within that scope |

Evidence may be weak, conflicting, or insufficient. Preserve those statuses instead of promoting every normalized result. A model inference stays distinguishable from an extracted source statement; repeated summaries and model agreement do not create corroboration. Check important claims against the strongest available task-relevant evidence.

For example, an API's `200` response reports success under that endpoint's HTTP contract; it does not alone establish the user's intended outcome. Completion of an update additionally requires evidence that the intended record, recipient, and values satisfy the requested postcondition. If the service accepted asynchronous work, record a pending state until completion is observed.

## State

Name a durable owner for task state. Store correlation IDs, step status, input/output references, artifact and policy versions, retry count, and terminal reason. Define checkpoint boundaries and replay semantics before execution.

For stateful or long-running work, maintain a task-state ledger in the existing state store or task artifact. Keep the applicable fields recoverable outside the prompt:

- Goal, acceptance criteria, prohibited effects, completed subgoals, and blockers.
- Verified facts, open hypotheses, conflicting evidence, and addressable source/artifact references.
- Current context projection and its source versions; canonical artifact and checkpoint identities.
- Remaining steps, tokens, cost, time, retry allowance, and any required review budget.
- Risk, reversibility, permission scope and authority source, effect status, and recovery owner.

The ledger records decisions and evidence, not private reasoning transcripts. Its authority fields point to the current permission source; a stored grant or remembered preference is not itself a renewed grant. Its storage and updates must themselves be within authorized scope. Use a compact record for a simple task; do not create a new persistence system merely to satisfy the field list.

Useful terminal states include `success`, `failed`, `needs_human_review`, `timeout`, and `cancelled`; add domain states only when they change recovery behavior.

Use `success` only after acceptance verification. Useful additional terminals are `insufficient_evidence`, `missing_authority`, `no_releasable_candidate`, and `budget_exhausted`. A partial result must identify which criteria passed and which remain unmet. Distinguish failed acceptance from a failed or unavailable verifier; neither supports a success claim. A blocking terminal may later start a resumed run after its missing input or authority arrives.

Compaction and checkpointing have different contracts. Read [durable memory and context lifecycle](durable-memory-and-context-lifecycle.md) when work spans context windows or sessions, or when facts/preferences will be retained for later tasks.

## Retry And Compensation

Retry only errors that are known transient and only inside deadline/budget limits. Never repeat a non-idempotent side effect without confirmation that it did not already succeed. If atomic rollback is impossible, specify the compensating operation and the owner who can perform it.

A timeout or lost response can leave the external outcome unknown. Use authoritative reconciliation by operation identity, or retry under an established destination-enforced idempotency contract. Protected replay preserves the same logical identity and payload, stays within the contract's scope and deduplication lifetime, and respects deadline and retry limits; a new key can create a duplicate. Authoritative lookup is not a prerequisite for that replay. If neither route is safe, stop blind resubmission and route to the defined recovery owner. Keep dependent work blocked until its required outcome is established. Compensation is another effect requiring authority, and its observed result must be verified.
