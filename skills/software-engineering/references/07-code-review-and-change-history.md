# Code Review And Change History

Use when: authoring a change, reviewing code, designing review policy, or deciding
what belongs in automation versus human review.

## Core Ideas

- Code review is a socio-technical process: it improves correctness, comprehension, consistency, ownership, knowledge sharing, and historical traceability.
- Code is a liability as well as an asset. Review should ask whether the added code is worth future maintenance.
- Small, focused changes are easier to review, test, rollback, and understand later.
- Review comments should be professional, specific, and grounded in project goals or standards.
- Human reviewers should focus on judgment; machines should handle formatting, simple checks, and repeatable policy.
- Good change descriptions explain what changed and why, giving future maintainers context.
- Review tooling matters because it shapes attention, communication, and how easily reviewers see code, tests, analysis results, and discussion state.

## Practices

- Self-review before sending a change: remove noise, explain intent, check tests and docs.
- Keep changes small enough that a reviewer can understand risk and behavior.
- Include a clear description: problem, approach, user/maintenance impact, testing, rollout or rollback where relevant.
- Minimize reviewer count while including owners or experts whose judgment is needed.
- Distinguish blocking correctness issues from optional improvements.
- Use review to spread knowledge: mention patterns, links, and local conventions when they help future work.
- Let automated tools report style, formatting, and known static analysis issues.
- Treat the review thread as durable context for why a change was accepted.

## Anti-Patterns

- Using review as a manual linter.
- Sending huge mixed-purpose changes that combine behavior, formatting, refactoring, and migration.
- Blocking on personal preference when the code is acceptable under local rules.
- Being polite in wording but vague in substance.
- Treating approval as ownership transfer from author to reviewer.
- Ignoring tests, docs, operational signals, or future migration because the code compiles.

## Agent Checklist

- Is the change small and focused?
- Does the description explain why the change exists?
- Are tests, docs, and rollout considerations appropriate to the risk?
- Are review comments grounded in correctness, readability, consistency, or maintainability?
- Should a comment be automated instead of repeated manually?
- Does the final review leave enough history for a future maintainer?

## Cross-Links

- [06-style-guides-rules-and-consistency.md](06-style-guides-rules-and-consistency.md)
- [08-documentation-as-code.md](08-documentation-as-code.md)
- [10-unit-tests-and-maintainability.md](10-unit-tests-and-maintainability.md)
- [15-code-search-static-analysis-and-tooling.md](15-code-search-static-analysis-and-tooling.md)
