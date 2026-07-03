# Equity And User Harm

Use when: designing user-facing systems, evaluating product risk, reviewing data
coverage, or checking whether velocity is hiding harm to some users.

## Core Ideas

- Bias is the default unless a team actively designs against it.
- Diversity and inclusion affect engineering quality because products serve diverse users and can fail unevenly across groups.
- A product can appear correct for the majority case while causing serious harm to underrepresented users.
- Engineering for equity requires challenging established processes, not only stating good values.
- Product velocity should be weighed against the risk of releasing something harmful or exclusionary.
- "Average user" thinking can hide edge cases that are not edge cases for affected people.
- Outcomes matter more than intent.

## Practices

- Ask who could be harmed by the system, model, UI, data pipeline, policy, or default.
- Include affected perspectives early enough to change requirements and tests.
- Review training/evaluation data, accessibility, language, cultural assumptions, and failure modes where relevant.
- Treat harmful false positives, false negatives, labels, and defaults as product quality issues.
- Slow down release when the system may cause asymmetric user harm.
- Measure outcomes where possible instead of relying only on stated values.

## Anti-Patterns

- Treating equity as separate from engineering quality.
- Shipping because the main path works for the majority.
- Assuming good intent prevents product harm.
- Asking for feedback only after design and launch decisions are effectively fixed.
- Using one singular approach for all communities and contexts.
- Ignoring failures that are rare globally but severe locally.

## Agent Checklist

- Which users are most likely to be missed by this design?
- What harm happens if the system is wrong for a minority group?
- Are test data, examples, and docs representative enough for the intended users?
- Is there a release gate for known harmful behavior?
- Are values tied to measurable outcomes or concrete process changes?
- Should this review involve people with different context before implementation?

## Cross-Links

- [03-team-culture-and-knowledge-sharing.md](03-team-culture-and-knowledge-sharing.md)
- [12-larger-tests-and-system-behavior.md](12-larger-tests-and-system-behavior.md)
- [17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md)
