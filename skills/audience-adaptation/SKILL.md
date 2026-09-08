---
name: audience-adaptation
description: Adapt a primary informational artifact for technical, nontechnical, executive, or execution readers. Use alongside the skill that owns the source, research, explanation, decision, edit, or deliverable; it is a reader-model companion rather than a primary content operation.
---

# Audience Adaptation

Use this skill when the intended reader changes what information, depth, evidence, or next action the writing must emphasize.

## Hierarchy And Handoffs

This is a reader-model companion, not the default owner of a content operation. First
choose what the text must do with `information-writing` or its specialized routes;
then use this skill to select depth, evidence, structure, and emphasis for the reader.

For a new artifact whose only specified condition is its audience,
`information-writing` remains primary and this skill sets the reader model. When
supplied prose must change for a new reader, `information-editing` remains primary and
this skill is its companion. Do not use audience type to change the source boundary,
invent missing evidence, or replace the operation-specific requirements of a summary,
research, decision, edit, or technical/execution/presentation deliverable.

## Choose the reader model

An explicitly named audience and desired reader action take precedence. For a direct response without a named audience, use the user's demonstrated fluency in the conversation and task, not job-title stereotypes. Do not infer sensitive attributes or make the profile visible in the answer.

Choose one dominant mode. A user may be technical in one subject and nontechnical in another, so recalibrate when the subject changes.

When the broad mode is insufficient, use [Reader preparation and consumption](references/reader-preparation-and-consumption.md). It helps distinguish what readers can already do, which questions they need answered, and whether they can pause, reread, or follow a visual reference. Use known context; a routine edit does not require a new audience brief.

## Technical reader

Optimize for precision, causal understanding, constraints, and implementation relevance. Include interfaces, contracts, component interactions, assumptions, invariants, dependencies, mechanisms, failure modes, scale, metrics with conditions, validation, and trade-offs when they change the result.

Use standard terminology directly. Define only uncommon, overloaded, or project-specific terms. Avoid tutorial explanations of fundamentals, vague adjectives without conditions, and detail that does not affect a decision, design, or action.

## Nontechnical reader

Prefer:

`practical meaning -> why it matters -> simple mechanism -> consequence -> necessary nuance`

Use plain language when it preserves meaning. When a technical term is necessary, name it, define it briefly, and continue using it consistently. Translate implementation detail into observable consequences, but retain evidence that changes a decision or explains a limitation. Use one bounded example or analogy only when it removes abstraction without distortion.

## Executive reader

Optimize for decision velocity. Put the conclusion, required decision, or action early. Prioritize impact, cost, time, scale, alternatives, material risks, and confidence in the evidence. Translate technical findings into consequences while retaining the minimum evidence needed to support a choice.

State risks concretely: condition or uncertainty, impact, mitigation, and whether the risk blocks the decision. Omit chronology and low-level detail unless they materially change the decision.

## Execution reader

Optimize for reliable follow-through. Make the current state, intended outcome, scope, owner, dependency, decision point, and next action easy to find. Include observable acceptance or verification conditions when they determine completion.

Surface blockers, handoffs, sequencing, deadlines, and risks only when known or necessary; do not invent owners, dates, or confidence. Distinguish confirmed work from proposals, assumptions, and unresolved questions.
