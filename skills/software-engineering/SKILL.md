---
name: software-engineering
description: Use when designing, reviewing, validating, refactoring, testing, documenting, migrating, or operating long-lived software systems through Google-style software engineering practices. Trigger for maintainability, code health, API compatibility, Hyrum's Law, tradeoff analysis, team knowledge sharing, engineering productivity metrics, style guides, code review, documentation, unit tests, test doubles, larger tests, version control, branching, build systems, dependency management, code search, static analysis, deprecation, large-scale changes, CI/CD, release safety, managed compute, and production-facing software design.
---

# Software Engineering

Use this skill to design or review software systems that must survive time, scale,
team growth, changing dependencies, and production reality. Treat code as an ongoing
maintenance obligation, not only as the implementation of today's feature.

## Core Rule

Do not start from a local code preference. First clarify expected lifetime, users,
owners, dependencies, public contracts, change risk, tests, docs, review path,
rollback or migration path, and how the system will remain understandable over time.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- Always start with `references/19-swe-agent-operating-model.md` for broad design, review, implementation, migration, or production-facing work.
- For the core thesis of software engineering over time and scale, read `references/01-engineering-over-time-and-scale.md`.
- For tradeoff analysis, reversible decisions, and productivity measurement, read `references/02-decision-making-and-productivity-measurement.md`.
- For teamwork, HRT, psychological safety, bus factor, and knowledge sharing, read `references/03-team-culture-and-knowledge-sharing.md`.
- For leadership, ownership, delegation, and scaling teams, read `references/04-leadership-ownership-and-delegation.md`.
- For bias, inclusive product quality, and user harm, read `references/05-equity-and-user-harm.md`.
- For style guides, rules, consistency, and automated formatting/enforcement, read `references/06-style-guides-rules-and-consistency.md`.
- For code review, small changes, review descriptions, reviewer behavior, and change history, read `references/07-code-review-and-change-history.md`.
- For documentation, design docs, reference docs, tutorials, ownership, and doc freshness, read `references/08-documentation-as-code.md`.
- For test strategy, test size/scope, flakiness, coverage limits, and confidence, read `references/09-testing-strategy-and-confidence.md`.
- For unit tests, behavior testing, public APIs, clear tests, and DAMP over DRY, read `references/10-unit-tests-and-maintainability.md`.
- For real implementations, fakes, stubs, mocks, and interaction testing, read `references/11-test-doubles-fakes-and-mocks.md`.
- For integration/system/larger tests, fidelity, load, configuration, and production-like validation, read `references/12-larger-tests-and-system-behavior.md`.
- For source of truth, trunk-based development, branch risk, and one-version thinking, read `references/13-version-control-branching-and-one-version.md`.
- For artifact-based builds, hermeticity, module boundaries, dependency contracts, SemVer limits, and external dependency risk, read `references/14-builds-and-dependency-management.md`.
- For code search, review tooling, static analysis, suggested fixes, and developer workflow integration, read `references/15-code-search-static-analysis-and-tooling.md`.
- For deprecation, migration, backsliding prevention, and large-scale changes, read `references/16-deprecation-large-scale-change-and-migration.md`.
- For CI, CD, presubmit/post-submit split, feature flags, release trains, staged rollout, and release safety, read `references/17-ci-cd-release-and-production-safety.md`.
- For managed compute, containerized production environments, state, retries, platform abstractions, and runtime failure assumptions, read `references/18-managed-compute-and-production-abstractions.md`.

## Workflow

1. Classify the request:
   - New software system design: read `19`, then `01`, `02`, `03`, `06`, `08`, `09`, `13`, `14`, `17`, and topic-specific files.
   - Architecture or design review: read `19`, `01`, `02`, `08`, `09`, `13`, `14`, `16`, and `17`.
   - Code review or implementation guidance: read `06`, `07`, `09`, `10`, `11`, and `15`.
   - Testing work: read `09`, then `10`, `11`, `12`, and `17` as needed.
   - Documentation or knowledge-sharing work: read `03`, `08`, and `07`.
   - API compatibility, dependency, or migration work: read `01`, `14`, `16`, and `13`.
   - CI/CD, release, or production-facing software work: read `09`, `12`, `17`, and `18`; combine with the SRE skill when SLOs, incident response, alerting, or on-call are central.
   - Engineering culture, leadership, or productivity work: read `02`, `03`, `04`, and `05` as applicable.
2. Identify blocking unknowns. Ask only when the missing data changes the recommendation; otherwise state assumptions.
3. Tie recommendations to lifetime, scale, users, owners, maintainability, validation, migration, and rollback.
4. Avoid presenting Google-specific implementations as universal rules. Extract the principle and adapt it to the local organization.
5. Mark any ideas not grounded in the references as `external extension` if you add them.

## Output For New System Design

Include:

- Expected lifetime, users, owners, and maintainability constraints.
- Goals, antigoals, tradeoffs, and decision assumptions.
- Public contracts, APIs, compatibility expectations, and Hyrum's Law risks.
- Code organization, style/rule expectations, and review workflow.
- Documentation plan: design docs, reference docs, tutorials, and ownership.
- Testing strategy: unit, doubles, larger tests, CI placement, flakiness policy.
- Build, dependency, version-control, and release strategy.
- Migration, deprecation, rollback, and cleanup plan.
- Production-facing assumptions: configuration, runtime environment, rollout, and operational signals.
- Risks, open questions, and next validation steps.

## Output For Review

Lead with risks and missing decisions:

- Lifetime and scale assumptions that are missing or weak.
- API compatibility, dependency, or migration risks.
- Code health, style, review, and documentation gaps.
- Testing strategy gaps, brittle tests, over-mocking, or flaky CI risk.
- Build reproducibility, dependency, branch, or source-of-truth risks.
- CI/CD, rollout, production configuration, or rollback gaps.
- Concrete fixes, validation steps, and owner assumptions.

## Output For Code Review

Prioritize:

1. Correctness and user-visible behavior.
2. Maintainability over time.
3. Simplicity, readability, and consistency with local rules.
4. Test quality and confidence level.
5. API compatibility and migration impact.
6. Documentation, review description, and future history.
7. Automation opportunities for repeated feedback.

## Quality Bar

- Do not call code maintainable without tests, docs or discoverable context, clear ownership, and a plausible future-change path.
- Prefer small, reviewable, reversible changes over large mixed-purpose changes.
- Prefer behavior-focused tests over implementation-coupled tests.
- Prefer real implementations and fakes over broad mocking when practical.
- Treat SemVer and version ranges as risk signals, not proof of compatibility.
- Treat CI/CD speed as safety only when paired with small changes, actionable feedback, flags, staged rollout, and rollback.
- Treat deprecation and large-scale change as owned migrations, not announcements.
