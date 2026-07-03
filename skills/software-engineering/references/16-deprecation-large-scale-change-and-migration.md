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
