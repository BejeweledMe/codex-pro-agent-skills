# Deprecation Large Scale Change And Migration

Use when: removing old APIs, migrating users, running refactors across many owners,
or deciding whether an obsolete technical choice can be changed safely.

## Core Ideas

- Removing and replacing old systems is harder than adding new ones because users, dependencies, and implicit contracts accumulate.
- Deprecation should be designed, owned, communicated, tooled, and tracked.
- Advisory deprecation warns; compulsory deprecation requires migration by a deadline or enforcement mechanism.
- Warnings, discovery, migration tools, and backsliding prevention are part of the product.
- Large-scale changes require more than a refactoring script: authorization, sharding, testing, review, submission, and cleanup.
- A mature organization can revisit old technical decisions because it has process and tooling for safe change.
- Making large-scale changes is a habit; capability grows when teams practice it regularly.

## Practices

- During API design, ask how the API could be replaced or removed later.
- Assign a process owner for each deprecation.
- Identify affected users with code search, static analysis, build data, and dependency graphs.
- Provide migration instructions, automated fixes, compatibility layers, and clear milestones.
- Prevent backsliding by blocking new usage after the replacement path exists.
- For LSCs, split changes into reviewable shards while preserving consistent intent.
- Use CI and targeted tests to validate broad changes.
- Complete cleanup; do not leave old and new paths indefinitely.

## Compulsory Migration Requires Capacity And Authority

Before promising compulsory removal, identify the provider/removal owner, funded
engineering capacity, deadline, enforcement authority, and a replacement that
affected consumers can actually use. Discover the last critical consumer and who
can resolve its blocker or authorize an exception. A deadline without these
conditions does not make the migration executable.

For advisory migration, put actionable warnings on new or changed uses where the
recipient can act. Avoid flooding unrelated edits with transitive warnings.
Whole-graph enforcement belongs to a resourced compulsory migration with support
for affected owners.

Combine static discovery with available runtime usage evidence: generated code,
dynamic loading, infrequent jobs, or external consumers may be absent from the
build graph. State the observation window and remaining blind spots. Deliberate
outages or temporary renames are production changes; use them only within an
authorized, bounded exercise with service owners, abort signals, and recovery.
SRE owns live reliability judgment.

The owner changing a shared facility supplies migration tooling, staffing,
sequencing, and support. Local consumers contribute behavior evidence and review;
they should not inherit an unsupported transformation project.

## Execute And Close Large-Scale Changes

Pilot the transformation on a representative slice, then divide it into reviewable
shards with common intent and appropriate local checks. Keep behavioral changes
separate from mechanical changes where possible. Handle frozen code, special gates,
and weak tests with the local owner: establish enough safety evidence before
automation, or record a bounded exception and its resolution path. Isolate
unrelated inherited failures with the owned containment rules in
[09-testing-strategy-and-confidence.md](09-testing-strategy-and-confidence.md)
so healthy shards can progress without concealing the transformation's risks.

Track remaining consumers, new uses, blocked shards, and exception age. If progress
stalls, distinguish missing discovery, replacement capability, staffing, authority,
or unreliable checks; assign the fix to that cause. Increasing warning volume is
not a substitute for migration capacity.

Close only when supported consumers have migrated, new usage is prevented, the
compatibility window has ended under the agreed policy, and obsolete code,
configuration, flags, and docs are removed. Verify the new path still works after
cleanup and that recovery does not silently reintroduce unsupported dependencies.

## Compatibility Evidence During Transition

Have the contract owner enumerate supported old/new readers and writers across
rollout and rollback. Cover request and response directions, stored data, and
republishing paths as applicable. A server-first assumption is valid only when
deployment authority actually excludes other combinations.

For paths that must preserve unknown fields, check the complete
decode → object mapping → bridge → re-encode → republish path. A serializer's
feature claim does not establish preservation through application code. Preserve
semantic meaning as well as shape: unchanged field types can hide a breaking
meaning change. Where a format uses stable field identifiers, do not reuse a
retired identifier for a different meaning; confirm the format's version rules.

If a changed operation can time out after producing an effect, preserve its
operation identity across retries and carry the effect owner's deduplication,
reconciliation, and late-result contract into migration tests. A timeout is not
evidence of non-execution.

`$api-contract-engineering` owns observable OAS/wire and consumer compatibility.
Pass operation identity, supported versions, consumers, transformation path, and
observed mismatch; use its compatibility conclusions in rollout and cleanup.
`$database-engineering` proves engine changes; `$data-engineering` owns replay and
derived-state recovery; `$system-design` resolves cross-system effect guarantees.
This skill retains application evolution, coordination, and release evidence.

Source basis: *Software Engineering at Google*, Deprecation and Large-Scale Changes;
*Designing Data-Intensive Applications*, second edition, encoding/dataflow evolution
and end-to-end identity. Refresh product-specific serialization and database
behavior for the actual supported versions.

## Anti-Patterns

- Announcing deprecation without owner, deadline, migration path, or enforcement.
- Treating consumers as the only responsible party when providers created the migration burden.
- Leaving deprecated APIs usable forever because removal is uncomfortable.
- Running mass refactors without testing and review infrastructure.
- Mixing high-risk behavior changes into mechanical migrations.
- Creating compatibility layers that become permanent hidden complexity.

## Agent Checklist

- What is being deprecated and why?
- Who owns the migration and who is affected?
- How will users discover the warning and the replacement?
- What tooling supports discovery, migration, and preventing new usage?
- Is the change mechanical, behavioral, or both?
- How are shards reviewed, tested, submitted, and cleaned up?

## Cross-Links

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md)
- [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md)
- [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md)
- [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md)
