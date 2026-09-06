---
name: software-engineering
description: "Design and review long-lived software changes: maintainability, code health, Hyrum's Law, tests, review, builds, dependencies, static analysis, CI, deprecation, migrations, and release evidence. Owns cross-cutting change lifecycle; framework/runtime implementation belongs to the language or frontend owner."
---

# Software Engineering

Use this skill to design or review software systems that must survive time, scale,
team growth, changing dependencies, and production reality. Treat code as an ongoing
maintenance obligation, not only as the implementation of today's feature.

## Core Rule

Establish expected lifetime, reuse surface, owners, and change risk from the task
and repository context. Scale tests, review, documentation, compatibility, and
recovery work to blast radius and reversibility. A routine local change may need
only a focused diff and relevant verification; a durable shared contract needs
consumer evidence and an owned migration path.

## Hierarchy And Handoffs

This skill owns the engineering lifecycle of a chosen product or service boundary:
code health, change design, compatibility, tests as a development practice, builds,
dependencies, migration, review, and release controls. Start with `$system-design`
when the unresolved question is service topology, data ownership, distributed
contracts, or capacity; then use this skill to make that design changeable in code.

Use `$qa-testing` when the primary deliverable is a risk-based classic QA or test-suite
strategy. Use `$sre-reliability-engineering` when the primary deliverable is an SLO,
observability, incident, on-call, or operational reliability system. Those skills
complement, rather than replace, software ownership and delivery discipline.

Use `$python-backend-engineering`, `$node-typescript-backend-engineering`, or
`$web-frontend-engineering` when the unresolved decision is framework, runtime,
or browser implementation. Keep cross-cutting code health, test policy, review,
build/dependency, migration, and release obligations here; generic local code
changes need only proportionate guidance, not an obligatory specialist chain.

Use `$platform-devops-engineering` for infrastructure provisioning, CI platform,
artifact promotion, deployment, and reconciliation mechanics. This skill retains
source/candidate lifecycle, test policy, mainline restoration, and migration
obligations. Pass candidate/configuration identity, transition and rollback
constraints, observations, and the responsible owner.

Use `$api-contract-engineering` for observable OAS/HTTP/wire and consumer
compatibility. Supply affected operations, versions, consumers, and observed
mismatches; retain application changes, migration coordination, and release evidence.
Use `$application-security-engineering` for security controls and component policy,
and `$security-review` for independent assurance. Integrate their accepted
requirements into delivery without treating routine code review as security assurance.

Use `$technical-writing` for document form, cross-API structure, or broad-audience
clarity. Engineering retains factual accuracy and freshness; pass the verified
behavior and limits described in `references/08-documentation-as-code.md`.

## Reference Routing

Read only the references needed for the current task.

- For the topic map and reference index, read `references/00_README.md`.
- For broad engineering work or decisions about process and architectural proportionality, start with `references/19-swe-agent-operating-model.md`.
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
- For integrating accepted security requirements, release evidence, and vulnerability feedback into delivery, read `references/20-secure-development-lifecycle-hooks.md`.

## Workflow

1. Identify the unresolved engineering decision and use Reference Routing to load
   only the relevant depth. Add another reference or specialist when evidence
   exposes a distinct decision; the reference list is not a mandatory reading sequence.
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
