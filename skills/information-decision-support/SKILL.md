---
name: information-decision-support
description: Compare realistic alternatives under constraints and produce a defensible recommendation with trade-offs and next steps.
---

# Information Decision Support

The objective is a defensible choice, not an exhaustive option catalog.

## Hierarchy And Handoffs

This is the primary operation when the requested outcome is a recommendation among
realistic alternatives. Use `information-research-synthesis` when new evidence must
be gathered before comparing options, and `information-source-summary` when the
analysis must remain bounded to supplied material. Use `execution-writing` when the
chosen analysis must be packaged as a formal decision memo.

## Decision method

State the decision, hard constraints, success criteria, and decision owner when known. Separate must-haves from preferences. Identify realistic options and remove invalid or clearly dominated choices early.

Compare the remaining options using the same criteria. Select criteria from the actual decision, such as quality, cost, latency, time to value, engineering effort, operational risk, maintainability, compliance, or reversibility. Do not compare one option with marketing claims and another with measured evidence without making the asymmetry explicit.

Distinguish hard blockers, measured disadvantages, uncertainty, and subjective preferences. Recommend one option when the evidence supports it, state the meaningful trade-offs, and say what condition would change the recommendation.

## Output

Prefer this order when it fits:

`recommendation -> rationale -> alternatives -> trade-offs and risks -> next action`

Ask one question only if missing information could materially reverse the choice. Otherwise use a minimal, explicit assumption and identify it as such.
