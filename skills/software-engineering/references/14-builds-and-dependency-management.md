# Builds And Dependency Management

Use when: designing build systems, evaluating reproducibility, importing dependencies,
choosing versioning policy, or reviewing dependency risk.

## Core Ideas

- A build system is not just a compiler wrapper; it models dependencies, artifacts, tools, environments, and reproducibility.
- Task-based scripts break down at scale because hidden dependencies, mutable environments, and sequential assumptions are hard to parallelize and cache.
- Artifact-based builds make inputs and outputs explicit, enabling incremental builds, remote caching, remote execution, and reproducibility.
- Fine-grained modules and limited visibility reduce accidental coupling.
- A dependency is an ongoing contract, not a one-time import.
- Semantic versioning is a human risk signal, not proof of compatibility.
- SemVer can be suitable at limited scale; the problem is treating it as high-fidelity compatibility evidence as dependency networks grow.
- Testing and CI provide stronger evidence about compatibility than version numbers alone.

## Practices

- Make dependencies explicit, including tools and generated artifacts.
- Prefer hermetic or isolated build environments where practical.
- Use fine-grained targets and visibility boundaries to keep dependency graphs understandable.
- Avoid relying on ambient machine state, shell scripts, or "latest" dependencies.
- Review external dependencies for maintenance, compatibility, security, licensing, and transitive cost.
- Prefer well-maintained dependencies for long-lived systems.
- Use CI to verify dependency updates instead of trusting version constraints blindly.
- Consider minimum-version-style update strategies where they fit the ecosystem, while still validating with tests.
- When exporting a dependency, be clear about compatibility promises and support expectations.

## Build Properties And Evidence Continuity

Keep distinct claims separate: a hermetic build constrains undeclared inputs;
reproducibility concerns obtaining the same output from the specified inputs;
integrity and provenance evidence help verify which output came from which
source and build process. None alone proves functional correctness or safe release.

When a dependency or build change alters output unexpectedly, compare declared
inputs, toolchain, dependency resolution, environment, and artifact identity.
Repair hidden inputs or invalid cache assumptions before accepting new evidence.
Use the candidate contract in
[17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
to attach results to the actual output. Infrastructure execution and promotion
mechanics belong to `$platform-devops-engineering`.

For accepted security requirements on dependencies, builders, and evidence stores,
use [20-secure-development-lifecycle-hooks.md](20-secure-development-lifecycle-hooks.md).
Security policy belongs to `$application-security-engineering`; ordinary dependency
updates still require engineering compatibility and maintenance evidence.

One-version and live-at-head practices depend on repository shape, ownership,
build capacity, and migration tooling. Minimum-version selection, dependency
isolation such as shading, and bounded compatibility windows solve different
coordination problems; none is a universal maturity level. The book does not
establish live-at-head across large external ecosystems as a proven default.

Source basis: *Software Engineering at Google*, Build Systems, Dependency Management,
and Continuous Delivery; *Building Secure and Reliable Systems*, change integrity.

## Anti-Patterns

- Build scripts whose true inputs are undocumented.
- Manual dependency management that makes correctness depend on developer memory.
- Pulling in a dependency without budgeting ongoing maintenance and security work.
- Treating SemVer ranges as a substitute for testing.
- Overexposing module internals and then depending on accidental details.
- Caching build results without understanding dependency invalidation and external risk.

## Agent Checklist

- Are build inputs, tools, and environment explicit?
- Can the build be reproduced by another machine or CI?
- Are module boundaries and visibility tight enough?
- What is the ongoing cost of each imported dependency?
- What compatibility promise is being made or consumed?
- Are dependency updates tested in realistic combinations?

## Cross-Links

- [13-version-control-branching-and-one-version.md](13-version-control-branching-and-one-version.md)
- [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
