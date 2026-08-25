# Scalability, Performance, And Cost

## Find The Limiting Resource

Scale is workload-specific. Identify whether growth pressures CPU, memory, network, storage capacity, IOPS, database connections, lock contention, queue throughput, partition throughput, external quota, or operator attention.

Use measurement to distinguish:

- Throughput saturation from latency amplification.
- Uniform growth from skew and hot spots.
- Stateless compute limits from stateful dependency limits.
- Normal operation from cache-cold, failover, replay, and migration load.
- Resource cost from coordination and operational complexity.

## Scaling Sequence

Prefer a measured progression:

1. Remove accidental inefficiency and unbounded work.
2. Tune data access, indexes, batching, payloads, and connection reuse.
3. Scale the current component vertically when it remains simple and economical.
4. Add stateless replicas and load distribution.
5. Move noncritical work off the synchronous path.
6. Cache expensive repeatable reads with explicit correctness rules.
7. Partition state or work only when a concrete bottleneck requires it.
8. Introduce specialized stores or regional topology only when their value pays for synchronization and operations.

## Latency Budget

Allocate an end-to-end percentile target across network hops, application work, queueing, storage, and safety margin. A chain's tail latency is not the sum of median component latency.

- Measure percentiles by operation and payload class.
- Avoid averaging percentiles across instances.
- Control fan-out; the slowest of many parallel calls often determines completion time.
- Bound result sets, batch sizes, recursion, and request complexity.
- Prefer fewer critical-path hops and colocate chatty components.
- Protect latency under load with admission control, bounded concurrency, and degradation.

## Caching

Choose cache placement and pattern from the consistency requirement:

- Cache-aside for read-heavy data where misses can query the source.
- Read-through or write-through when centralized cache behavior reduces client complexity.
- Write-behind only when delayed durability and recovery semantics are acceptable.
- Request, process, distributed, edge, and client caches have different trust and invalidation boundaries.

Define:

- Cache key, tenant scope, version, and authorization context.
- TTL and maximum acceptable staleness.
- Invalidation or version-bump mechanism.
- Behavior on cache failure and source failure.
- Stampede prevention through request coalescing, jittered expiry, or bounded refresh.
- Negative caching and its safe lifetime.
- Eviction policy, memory headroom, hit ratio, and origin load.
- Warm-up and cold-start behavior during deployment or failover.

Never let cached authorization or sensitive data cross tenant or permission boundaries.

## Load Distribution And Hot Spots

- Use load balancing that matches connection lifetime and workload cost, not only request count.
- Avoid sticky state unless affinity is a requirement with explicit recovery behavior.
- Detect hot keys, partitions, tenants, endpoints, and expensive query shapes.
- Consider key salting, adaptive partitioning, per-tenant quotas, work splitting, or dedicated capacity for outliers.
- Plan autoscaling around startup time, queueing delay, cooldown, dependency headroom, and scale-down safety.
- Reserve enough capacity for a failure domain to disappear without cascading overload.

## Precomputation And Asynchrony

Precompute when reads are much more frequent than writes, the derived result can be rebuilt, and freshness requirements tolerate update delay. Keep computation on demand when queries are rare, highly personalized, or cannot tolerate stale results.

Batching improves throughput but increases latency and failure scope. Define maximum batch size, wait time, partial failure, retry, and deduplication behavior.

## Cost Model

Compare total lifetime cost:

- Compute, memory, storage, network transfer, requests, licenses, and reserved capacity.
- Replication, backups, observability, test environments, and migration overlap.
- Engineering, on-call, incident, compliance, and vendor-management effort.
- Lock-in and exit cost.
- Cost of underprovisioning and lost user outcomes.

A cheaper unit price can be more expensive if it creates high operational or migration cost.

## Validation

- Benchmark the actual access pattern and payload distribution.
- Load-test normal, peak, skew, cold-cache, dependency-slow, and failover conditions.
- Record saturation point, tail latency, error rate, queue growth, and recovery time.
- Verify the system returns to baseline after load drops.
- Reconcile predicted capacity with observed results and update assumptions.
