# Engineering Over Time And Scale

Use when: designing, reviewing, or changing code that may live long enough to face
new requirements, dependencies, users, platforms, and maintainers.

## Core Ideas

- Software engineering is programming plus responsibility for useful life span: code must remain understandable, changeable, buildable, testable, and removable over time.
- Sustainability means the team remains capable of responding to change. Choosing not to change is different from being unable to change.
- Short-lived scripts and long-lived systems need different practices. Applying the same process everywhere either overloads temporary work or under-protects durable systems.
- Scale changes the economics of engineering. A process that needs repeated human judgment for every file, user, or dependency eventually becomes a bottleneck.
- Hyrum's Law is a design constraint: sufficiently used APIs accumulate dependencies on observable behavior, even behavior outside the documented contract.
- Policies, automation, tests, and conventions are useful when they make repeated work scale sublinearly with humans.
- Technical debt is not just ugly code; it is the gap between the current system and the system the organization needs to keep changing safely.

## Practices

- Ask for expected maintenance life span before choosing process weight, tests, docs, API guarantees, and migration strategy.
- Prefer designs that can evolve incrementally: clear interfaces, small changes, compatibility windows, automated tests, and migration paths.
- Treat public behavior, output formats, errors, ordering, and timing as potential contracts once users can observe them.
- Build scalable policies: style rules, code review expectations, CI gates, dependency checks, and automated refactorings.
- Revisit old decisions when data, scale, team size, or ecosystem constraints change.
- Move quality checks earlier in the workflow when repeated late discovery is expensive.

## Anti-Patterns

- Assuming "it works today" is enough for code that will be maintained for years.
- Depending on undocumented behavior and then treating breakage as somebody else's problem.
- Making every engineering decision by local preference instead of lifetime cost.
- Creating policies that require linear human effort as the organization grows.
- Freezing a system to avoid change and calling that reliability.
- Treating mistakes or reversals as failure instead of expected results of learning under uncertainty.

## Agent Checklist

- What is the expected life span of this code or API?
- What future changes are likely: dependencies, users, scale, product direction, platform, security?
- Which observable behaviors could downstream users depend on?
- What makes this change reversible or migratable?
- Which repeated manual tasks should become policy, tooling, or tests?
- Is this advice calibrated to the team's scale, not blindly copied from Google?

## Cross-Links

- [02-decision-making-and-productivity-measurement.md](02-decision-making-and-productivity-measurement.md)
- [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md)
- [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
