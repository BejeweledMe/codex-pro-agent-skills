# Code Search Static Analysis And Tooling

Use when: improving developer tools, choosing static analysis checks, designing code
search, or deciding how tooling should enter the engineering workflow.

## Core Ideas

- Developer tools scale understanding and quality when they are integrated into daily work.
- Code search is infrastructure for answering where, what, how, why, who, and when across a codebase.
- Search quality depends on freshness, ranking, latency, completeness trade-offs, and integration with surrounding tools.
- Static analysis succeeds when it is useful, scalable, and accepted by developers.
- Low false positives and actionable suggested fixes matter because developer attention is scarce.
- Static analysis should appear at the right points: editor, code browser, review, presubmit, compiler, and CI.
- Tooling works best when domain experts can contribute checks and improvements.

## Practices

- Make code search fast enough to be part of routine exploration.
- Favor tool results that link directly to context, owners, examples, docs, and review history.
- Add static analysis checks that catch real issues and provide clear remediation.
- Provide suggested fixes where possible.
- Use presubmit for checks that are reliable enough to block changes.
- Let teams customize checks when local context matters, while preserving shared standards.
- Measure tool adoption and friction through developer behavior and feedback.

## Effective False-Positive Economics

Evaluate whether a diagnostic is useful at the point where it interrupts work.
A technically correct report can still be an effective false positive when it is
irrelevant to the project, unactionable by the recipient, or offers too little
benefit for the required change.

Before widening enforcement, sample findings and inspect dismissals, suppressions,
fixes, configuration, and developer feedback. Distinguish:

- An analyzer defect: repair the check.
- A project-context mismatch: narrow or correct configuration.
- A valid but low-value interruption: change placement or retire the check.
- A useful finding with an unclear remedy: improve the diagnostic or suggested fix.

Suppression rate alone does not prove a check is bad; inspect reasons. Track useful
findings alongside investigation time and blocked-change cost. The analyzer owner
should state which result will justify expansion, repair, demotion, or retirement
and when that decision will be revisited.

Introduce a check in an advisory stage, validate its remedy, and resolve existing
findings in the intended enforcement scope before blocking new violations there.
For formatting rules, establish a working formatter and clean baseline first.
Build-breaking checks need an expectation of near-zero effective false positives;
use local evidence, not a copied historical percentage.

Provide an owned, explained exception path for legitimate cases. A rising rate of
false blocks calls for analyzer/configuration repair or narrower enforcement.
Verify closure through sampled outcomes and reduced interruption cost, not merely
fewer displayed findings.

Source basis: *Software Engineering at Google*, Style Guides and Rules and Static
Analysis. Historical adoption thresholds describe their setting, not universal gates.

## Anti-Patterns

- Tools that live outside the main workflow and require extra ceremony.
- Static analysis with high false positives and vague messages.
- Blocking builds on checks that developers cannot understand or fix.
- Search that is stale, incomplete in surprising ways, or too slow for exploration.
- Treating tooling as a replacement for ownership and review.
- Central teams owning every check without a path for domain experts to contribute.

## Agent Checklist

- Where in the workflow should this tool surface feedback?
- Is the feedback actionable at the moment it appears?
- What is the false-positive cost?
- Can the tool suggest or automate the fix?
- Does code search reveal enough context for safe change?
- Can local experts contribute without fragmenting standards?

## Cross-Links

- [06-style-guides-rules-and-consistency.md](06-style-guides-rules-and-consistency.md)
- [07-code-review-and-change-history.md](07-code-review-and-change-history.md)
- [08-documentation-as-code.md](08-documentation-as-code.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
