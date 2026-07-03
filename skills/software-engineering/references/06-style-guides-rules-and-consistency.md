# Style Guides Rules And Consistency

Use when: writing or reviewing code style, adding lint rules, designing conventions,
or deciding whether a rule should be policy, guidance, or automated tooling.

## Core Ideas

- Rules exist to support time and scale, not to win taste arguments.
- Consistency reduces cognitive load, makes code easier to search and modify, and lets tools operate across a large codebase.
- A rule must pull its weight: the benefit should justify the learning, enforcement, exception, and migration cost.
- Optimize for the reader. Code is read and changed more often than it is written.
- Not everything belongs in a style guide. Some topics need guidance, examples, or local judgment.
- Rules need process: owners, rationale, exception handling, change mechanism, and data when possible.
- Automated formatters and error checkers are preferred when they remove routine debate from human review.

## Practices

- Separate mandatory rules from advisory guidance.
- Document why a rule exists and what cost it avoids.
- Prefer automated formatting for mechanical consistency.
- Use static checks for error-prone or surprising constructs when false positives are low enough.
- Let exceptions exist, but require a clear reason and a path back to consistency when possible.
- Revisit rules when language, tools, or usage patterns change.
- Apply rules through developer workflow: editor, formatter, presubmit, CI, and review.

## Anti-Patterns

- Creating rules because a senior engineer prefers a style.
- Forcing reviewers to debate mechanical formatting manually.
- Adding too many rules for engineers to remember without tooling support.
- Treating consistency as aesthetics rather than maintainability.
- Keeping rules forever after the original reason disappears.
- Applying one rule blindly to all contexts without considering practical costs.

## Agent Checklist

- Is this a correctness, readability, consistency, or taste issue?
- Should it be a rule, guidance, formatter behavior, lint check, or local choice?
- What cost does the rule avoid over time?
- Can enforcement be automated?
- Is the rule calibrated to the language and project context?
- Are exceptions and migration handled explicitly?

## Cross-Links

- [07-code-review-and-change-history.md](07-code-review-and-change-history.md)
- [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
