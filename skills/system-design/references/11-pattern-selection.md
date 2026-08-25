# Pattern Selection

Use this reference to compare options, not to choose by keyword.

## Architecture Shape

| Choice | Prefer when | Main costs and checks |
| --- | --- | --- |
| Modular monolith | One team or tightly coupled domain, shared transactions, moderate scale | Preserve internal boundaries; avoid a single unowned code mass |
| Independent services | Different owners, scaling, release, isolation, or security needs justify a network boundary | Distributed failure, contracts, data ownership, observability, deployment, on-call |
| Managed service | Capability is not differentiating and provider meets guarantees and constraints | Quotas, lock-in, data control, cost curve, outage dependency, exit plan |
| Self-operated component | Control, customization, residency, or economics justify ownership | Staffing, upgrades, security, backups, recovery, capacity, 24/7 operation |

## Communication

| Choice | Prefer when | Main costs and checks |
| --- | --- | --- |
| Synchronous request | Caller needs immediate result and dependency fits deadline | Temporal coupling, tail latency, timeout, retry, partial completion |
| Work queue | Each item should be processed by one worker group | Deduplication, retries, poison items, lag, backpressure |
| Event stream or log | Multiple consumers, ordered history, retention, or replay matter | Schema evolution, partition ordering, storage, replay side effects |
| Publish-subscribe notification | Consumers need independent notification without shared history requirements | Delivery gaps, slow consumers, subscription ownership |
| Batch | Throughput and efficiency matter more than freshness | Large failure scope, late feedback, restart and partial completion |
| Streaming | Low freshness latency and continuous processing justify it | Ordering, state, replay, late data, operational complexity |

## Data And Consistency

| Choice | Prefer when | Main costs and checks |
| --- | --- | --- |
| Relational model | Constraints, transactions, joins, and evolving queries matter | Schema and index discipline, connection and write scaling |
| Key-oriented model | Access paths are predictable and key-based at high scale | Denormalization, secondary access, cross-key transactions |
| Strong consistency | Stale or conflicting state violates an invariant | Coordination latency, reduced availability during partitions |
| Bounded or eventual consistency | Temporary staleness is acceptable and conflict behavior is defined | User confusion, reconciliation, lag visibility, read-your-writes |
| Replication | Availability, durability, or read scale requires copies | Lag, conflicts, failover, correlated failure, cost |
| Partitioning | One authority cannot meet storage or throughput needs | Key choice, hot spots, cross-partition work, rebalancing |
| Search or derived index | Query capability exceeds the source store's access path | Staleness, rebuild, synchronization, extra storage |

## Performance

| Choice | Prefer when | Main costs and checks |
| --- | --- | --- |
| Vertical scale | Current architecture fits one stronger node and simplicity has value | Hardware ceiling, failover size, stepwise cost |
| Horizontal scale | Work or state can be partitioned safely and elasticity matters | Coordination, load balance, state, skew, downstream ceiling |
| Cache | Repeated reads or computation dominate and staleness can be bounded | Invalidation, stampede, cold start, security, source overload |
| Precomputation | Reads dominate and derived results can lag or rebuild | Write amplification, freshness, storage, invalidation |
| Compute on read | Requests are infrequent, variable, or require current state | Tail latency, repeated cost, query limits |

## Availability And Geography

| Choice | Prefer when | Main costs and checks |
| --- | --- | --- |
| Single zone with restore | Low criticality and cost dominate | Zone outage recovery and tested restore |
| Multi-zone | Zone failure must not stop the journey | Surviving capacity, quorum, network, correlated deploys |
| Single region plus standby | Regional recovery target allows failover delay | Replication lag, promotion, routing, failback drills |
| Active in multiple regions | Latency or regional availability justifies simultaneous traffic | Conflict, authority, split brain, data residency, much higher operations |

## Decision Method

For each meaningful choice state:

1. Requirement or risk that drives the decision.
2. Recommended option and why it fits now.
3. Rejected alternative and the condition under which it would become preferable.
4. New failure modes and operational obligations introduced.
5. Validation evidence needed before commitment.

Avoid combinations that merely accumulate fashionable patterns. Each added mechanism should retire a specific risk or satisfy a measurable constraint.
