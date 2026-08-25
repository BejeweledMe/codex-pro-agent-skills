# Requirements And Capacity

## Frame The Problem

Capture:

- Primary users and critical user journeys.
- Trigger, input, output, and visible success for each journey.
- Correctness invariants that must never be violated.
- Cost of unavailability, latency, stale data, lost work, duplicates, and unauthorized access.
- Goals, non-goals, deadline, budget, team capability, existing systems, and regulatory constraints.
- Expected lifetime and likely changes in users, scale, geography, and product behavior.

Do not turn every preference into a hard requirement. Separate:

- `must`: violation makes the system unacceptable;
- `target`: optimize toward it with explicit cost;
- `nice to have`: defer unless cheap;
- `unknown`: needs measurement or product decision.

## Nonfunctional Requirements

Define them per journey, not only for the system as a whole:

- Availability and successful outcome definition.
- Latency percentile and end-to-end deadline.
- Throughput and peak duration.
- Freshness or acceptable staleness.
- Durability and acceptable data loss.
- Recovery time and recovery point.
- Consistency and isolation.
- Security, privacy, audit, residency, and retention.
- Cost ceiling and operational staffing.

Avoid unsupported precision. A proposed target must have a user or business rationale and an observable indicator.

## Capacity Estimation

Use explicit units and show the arithmetic.

```text
average_requests_per_second = requests_per_day / 86,400
peak_requests_per_second = average_requests_per_second * peak_factor
write_bandwidth = writes_per_second * average_write_bytes
read_bandwidth = reads_per_second * average_response_bytes
daily_storage_growth = writes_per_day * stored_bytes_per_write * replication_factor
retained_storage = daily_storage_growth * retention_days
concurrency ~= throughput_per_second * average_latency_seconds
```

For queues:

```text
backlog_growth_per_second = arrival_rate - service_rate
drain_time = backlog_size / (service_rate - arrival_rate)
```

For cache sizing:

```text
working_set_bytes = active_keys * average_entry_bytes * overhead_factor
origin_rps = total_read_rps * (1 - cache_hit_ratio)
```

Estimate separately by operation, payload class, tenant, region, and read/write mix when skew matters. Include metadata, indexes, tombstones, logs, backups, and temporary migration headroom rather than counting only primary rows.

## Sensitivity And Bottlenecks

- Use low, expected, and high scenarios.
- Test at least one plausible peak factor and one growth horizon.
- Identify the first constrained resource: CPU, memory, storage IOPS, network, connections, workers, queue throughput, partition throughput, or external quota.
- Check downstream capacity. Scaling the entry tier can amplify pressure on a fixed database or provider.
- Account for retry amplification, background jobs, backfills, replays, failover traffic, and cache cold starts.
- Separate provisioned capacity from tested capacity and safe operating capacity.

## SLO And Error Budget

Use an indicator tied to the protected journey:

```text
SLI = good_events / valid_events
error_budget = 1 - SLO
```

Availability alone may be insufficient. Add latency, quality, or freshness where a technically successful response can still fail the user. Define where the indicator is measured and how retries, cancellations, test traffic, and low-volume periods are handled.

## Validation Questions

- Which number most changes the architecture?
- Which estimate comes from telemetry and which from a guess?
- What peak shape matters: brief burst, daily plateau, seasonal event, or permanent growth?
- What happens when one tenant or key owns most traffic?
- Is the design sized for failover with a region, zone, or replica unavailable?
- What load test, benchmark, trace, or production sample will replace the weakest assumption?
