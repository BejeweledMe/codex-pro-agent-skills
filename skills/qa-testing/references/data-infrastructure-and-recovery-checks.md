# Data, Infrastructure, And Recovery Checks

Use when a change can break derived output, deployed workload behavior, database access, or recovery. Select the checks for the actual risk; this is not an additional mandatory suite for every change.

## Risk To Layer And Fixture

Identify the failed promise, smallest credible fixture, observable assertion, and fidelity gap. Pure transformation or configuration-generation checks belong near the code; real persistence, resource connectivity, and restart behavior need the corresponding integration environment. A preview can reveal a dangerous change but does not prove that the applied workload works.

For an infrastructure component, provide only the necessary upstream dependencies and a small consumer workload that exercises its outputs. Resource existence alone misses unusable connectivity or storage. Isolate fixtures, name environment and feature owners, and expose setup, reset, and teardown failures. A passing foreground test must not hide a failed background reset. Execute live or destructive recovery experiments only in the authorized environment and scope.

## Incremental Versus Full Output

Where a deterministic full rebuild exists, compare it with the incremental or cached path using the same authoritative inputs, code/configuration, and logical revision. Define meaningful equality first: values, ordering, geometry, or semantic state as appropriate. Normalize only differences known to be irrelevant; otherwise normalization can erase the defect.

Exercise relevant mutations, deletion, repeated invalidation, delayed completion, and replacement of the active input. Check that obsolete work cannot overwrite a newer result. On divergence, retain the smallest input sequence and the first differing intermediate artifact. Agreement detects inconsistency between paths, but shared defects still need independent invariants or an external oracle. Browser visual equality alone does not establish focus, input, or accessibility correctness.

## SQL And Adapter Regression

Preserve result correctness alongside query-count and work budgets on representative data volume, skew, and bind values. Capture generated SQL and projections so N+1 loads, excess columns, duplicate rows, and lost early termination can be diagnosed. Where a plan property is stable and meaningful, check it; avoid freezing the entire plan text or estimated cost across engine versions and statistics changes.

An index name is not a performance assertion. Inspect scanned/fetched versus returned rows and relevant sort or join work, then measure latency under stated load and cache conditions. Cover affected reads and writes when an index or projection changes. Give SQL, parameters, fixtures, plans, and observed work to `$database-engineering` for access-path decisions; backend owners retain adapter and transaction implementation.

## Restart State And Observable Effects

Choose a failure window around the state transition at risk, such as after an effect but before its acknowledgment or before progress is durably recorded. Record candidate/configuration, source position, persisted state or snapshot identity, and operation/effect identities. After restart or replay, verify the accepted domain invariants and observable output for missing, duplicated, or contradictory effects, not just process health.

Check that state and progress recover together within the claimed boundary. A framework checkpoint does not retract an external payment, email, or database effect; that boundary needs its own supported atomicity or durable deduplication evidence. Exercise only the failure model in scope and keep its limits explicit: formal models, observed histories, fault injection, and deterministic simulation test different surfaces, and no single one proves end-to-end correctness.

Pass reproducible failure and recovery evidence to the data, database, platform, or SRE owner responsible for repair and acceptance. Product/domain owners supply the acceptable outcome; QA verifies that outcome rather than silently choosing weaker semantics.
