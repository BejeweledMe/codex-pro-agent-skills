# Version Control Branching And One Version

Use when: evaluating repository strategy, branch policy, release branches, dependency
versions, or whether a workflow supports scalable change.

## Core Ideas

- Version control is the source of truth for code, history, review, and coordination.
- Ambiguity about the authoritative version creates coordination failure.
- Long-lived branches defer integration cost and make conflicts, testing, and ownership harder.
- Trunk-based development and frequent integration reduce the distance between work-in-progress and the shared system.
- The one-version rule reduces the problem of choosing among many incompatible versions inside an organization.
- Monorepo is an implementation strategy, not the universal lesson. The deeper lesson is reducing coordination and version choice where possible.
- Release branches can be useful, but they should not become a parallel development universe.

## Practices

- Keep one clear source of truth for active development.
- Integrate small changes frequently rather than accumulating large branch divergence.
- Use release branches for controlled release needs, not for ongoing feature development.
- Prefer a single supported version of internal dependencies when the organization can make that work.
- Make ownership and review history visible in version control.
- Design workflows so code search, build, CI, and large-scale changes can reason about the current head.
- For multi-repo environments, use tooling or policy to approximate a coherent virtual head when possible.

## Anti-Patterns

- Long-lived development branches that require periodic merge meetings.
- Multiple active versions with unclear ownership and compatibility promises.
- Treating branch isolation as a substitute for small changes and tests.
- Letting release branches become places where fixes disappear from mainline.
- Choosing monorepo or polyrepo for fashion rather than coordination economics.
- Assuming distributed VCS alone solves dependency coordination.

## Agent Checklist

- What is the source of truth?
- How far can work diverge before integration?
- Are release branches short-lived and disciplined?
- Is the team managing dependency versions intentionally or by accident?
- Can CI and code search reason about the code state being changed?
- Does the workflow make large-scale cleanup easier or harder?

## Cross-Links

- [01-engineering-over-time-and-scale.md](01-engineering-over-time-and-scale.md)
- [14-builds-and-dependency-management.md](14-builds-and-dependency-management.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
