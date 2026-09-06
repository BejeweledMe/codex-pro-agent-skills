# Documentation As Code

Use when: writing docs, reviewing design docs, deciding what to document, or checking
whether a system can be understood and maintained by people beyond its authors.

## Core Ideas

- Documentation scales knowledge across time, teams, and turnover.
- Documentation is part of software engineering work, not a separate afterthought.
- Good documentation has an audience, a purpose, freshness expectations, and ownership.
- Docs need maintenance like code: source control, review, deprecation, and discoverability.
- Different doc types serve different needs: reference, design docs, tutorials, conceptual docs, and landing pages should not be mixed casually.
- Documentation is less mature and more fragile than testing in many organizations, so process and ownership matter.
- A stale or ambiguous document can be worse than no document when it becomes a false source of truth.

## Practices

- Start with audience and task: who is reading, what are they trying to do, and what should they know after reading?
- Put durable docs in source control or another canonical, searchable location.
- Review docs as part of code review when behavior, API, operations, or design changes.
- Use design docs to capture goals, alternatives, trade-offs, risks, and decisions before implementation hardens.
- Keep reference docs close to API contracts and examples.
- Write tutorials as step-by-step paths for a specific reader, not as architecture dumps.
- Deprecate old docs: mark, redirect, archive, or delete them so stale knowledge does not compete with current truth.

## Technical-Writing Handoff

Use `$technical-writing` when the difficult decision is document form, information
structure, or clarity across APIs or audiences. Engineering remains responsible
for technical truth and for updating it when behavior changes.

Pass the smallest useful evidence packet:

- Reader and task, document purpose, canonical location, and factual owner.
- Verified behavior, relevant state transitions and invariants, and who has authority to change state.
- Preconditions, rejection and failure behavior, recovery limits, and observable success signals.
- Applicable versions/configuration, evidence links, reproducible examples, and explicit unknowns.
- For a defect or runbook: reproduction conditions, expected versus observed behavior, diagnostic evidence, and verified recovery steps.
- The change or release that should trigger the next factual review.

The writer returns a usable document with claims traceable to that packet.
Engineering checks examples and operational claims against the stated version
before treating it as authoritative. Missing evidence remains an identified gap;
document polish cannot establish behavior. A small local documentation fix does
not require a separate handoff or packet.

Give readers arriving through search enough orientation to identify applicability;
give readers seeking a known task consistent names and structure. Separate
consumer-facing and operator-facing information when their tasks, access, or
update triggers differ.

Source basis: *Software Engineering at Google*, documentation audiences, ownership,
and freshness. The packet operationalizes the engineering-to-writing boundary.

## Anti-Patterns

- Treating a wiki as a dumping ground with no owner.
- Writing for "everyone" and therefore serving no reader well.
- Mixing reference, tutorial, design rationale, and operations notes into one unfocused page.
- Leaving docs outside normal review and release workflow.
- Documenting implementation trivia while omitting why a decision was made.
- Creating docs that cannot be discovered from code, tooling, or canonical indexes.

## Agent Checklist

- What kind of document is needed: reference, design, tutorial, conceptual, landing page, or operational procedure?
- Who is the primary audience?
- What decision or task should the document support?
- Where is the canonical source and owner?
- Does the change require docs to be updated or deprecated?
- Is the document accurate enough to be trusted by a future maintainer?

## Cross-Links

- [03-team-culture-and-knowledge-sharing.md](03-team-culture-and-knowledge-sharing.md)
- [07-code-review-and-change-history.md](07-code-review-and-change-history.md)
- [16-deprecation-large-scale-change-and-migration.md](16-deprecation-large-scale-change-and-migration.md)
