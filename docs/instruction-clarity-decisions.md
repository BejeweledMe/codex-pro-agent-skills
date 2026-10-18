# Instruction Clarity Decisions

Status: accepted for the October 2026 instruction clarity update.

## Owner Mapping

Two references extend existing skills. They distinguish authoring an agent contract
from rewriting its wording while preserving the established behavior.

| Task | Existing owner | Guidance |
|---|---|---|
| Author or substantively revise tool descriptions, errors, system instructions, or handoffs that affect an agent's next action | `agent-workflows` | [Text for agent decisions](../skills/agent-workflows/references/agent-facing-text.md): express established contracts, label proposals, and make the next decision explicit |
| Faithfully rewrite an instruction whose wording can change an action | `information-editing` | [Instruction clarity](../skills/information-editing/references/instruction-clarity.md): preserve conditions, order, modality, referents, and literal tokens |
| Revise a procedure or technical error message | `technical-writing` | Use instruction clarity when needed; retain the document's technical contract |
| Draft instructions for an established agent workflow | `llm-system-design` | Use text for agent decisions when needed; retain prompt architecture ownership |
| Express established HTTP outcomes for an agent | `api-contract-engineering` | Use text for agent decisions when needed; retain HTTP error and replay semantics |
| Adjust the voice of technical prose | `humanize-text` | Preserve applicable style and meaning; technical subject matter alone does not impose word caps or punctuation restrictions |

## Boundaries

The runtime, schema, permission model, and recovery contract determine behavior.
Wording can explain them but cannot enforce them or add missing guarantees.
A timeout does not establish that an external effect failed. A rewrite must not
invent input provenance, retry permission, a schema field, or completion evidence.

Preserve shared conditions when splitting instructions. Keep distinct operations
distinct, including signature verification and user confirmation. Resolve missing
actors or ambiguous referents only from supported context. Preserve uncertainty
when the source does not establish a fact.

Apply word caps, punctuation restrictions, and lexical exclusions only when the
task or an applicable house style specifies them. Meaning takes priority when a
style constraint would remove a condition, exception, or meaningful hedge.
Ordinary prose does not require these additional checks merely because its subject
is technical.

## Validation And Installation

Check rewrites against semantic invariants, not just sentence length or lint output.
For agent text, walk the proposed next action against the actual contract. Include
unknown outcomes and inapplicable actions when they matter. Dry-run examples can
expose mistakes but do not establish measured improvement in runtime behavior.

The update adds two references and small routing or scope changes in six existing
skills. It adds no new skill, bundle, fixed vocabulary, or required linter.
References remain conditional. Use the existing [installation guide](../README.md#install-skills)
to update the relevant owners; use the [catalog](../CATALOG.md) to select them.
