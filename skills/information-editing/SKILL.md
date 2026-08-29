---
name: information-editing
description: Edit existing informational text through copyediting, faithful rewrite, audience adaptation, restructuring, or compression.
---

# Information Editing

Edit an existing text without accidentally replacing its facts, intent, or commitments. Establish explicit invariants before changing the prose: facts and claims, scope, required terminology, constraints, tone, and any wording that must remain unchanged.

## Hierarchy And Handoffs

This is the primary skill whenever supplied prose must be changed and no other skill
owns an artifact-specific contract. Its operation is editing, not research or source
summarization: preserve the agreed invariants unless the user explicitly changes the
evidence or fact boundary.

Use `audience-adaptation` when the new reader changes emphasis or depth. Use
`information-source-summary` or `information-research-synthesis` first only when the
task separately requires a faithful evidence treatment before the edited artifact is
written. For a technical document, execution artifact, or presentation, let
`technical-writing`, `execution-writing`, or `information-presentation` own a
substantive revision; use this skill only for a local copyedit, faithful rewrite, or
compression that leaves that artifact contract intact.

## Editing modes

Choose the requested mode and keep its boundary clear:

- **Copyediting**: correct grammar, consistency, punctuation, and local clarity without changing meaning or structure.
- **Meaning-preserving rewrite**: change wording and sentence construction while preserving the same assertions, intent, and level of certainty.
- **Audience adaptation**: preserve the core message while changing vocabulary, evidence detail, context, and emphasis for a new reader.
- **Restructuring**: change grouping, sequence, and hierarchy so the reader can find the main point and follow the logic.
- **Compression**: produce the shortest form that preserves the reader's needed confidence and action.

## Method

For existing text, work bottom-up after preserving invariants:

`wording -> sentences -> paragraphs -> structure`

Remove repetition and verbal noise first. Simplify difficult syntax, then repair paragraph focus and transitions. Change structure only when the requested mode requires it or the current order prevents understanding. Do not rewrite a clear sentence merely to make it different.

For compression, remove repeated ideas, low-value framing, redundant examples, and reader-irrelevant detail before removing evidence, conditions, limitations, or causal links.

## Final check

Re-read the result against the invariants. It should be easier to use, no less accurate, and appropriate for the requested language and reader.
