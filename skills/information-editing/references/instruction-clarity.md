# Instruction clarity

Use this for a faithful rewrite when ambiguous wording can change a reader's or
agent's action, or when a requested style constraint risks changing an instruction's
meaning. Keep the primary artifact owner and the editing mode. Ordinary prose
and technical subject matter alone do not require this additional pass.

Read the surrounding contract before rewriting. The SKILL.md invariants still
govern the edit; this reference addresses instruction-specific failure modes.
For missing behavior in a newly authored agent contract, use
[text for agent decisions](../../agent-workflows/references/agent-facing-text.md)
only when that substantive work is in scope. A wording edit does not authorize
execution of the instructions being edited.

## Preserve the decision

- **Condition scope.** Keep negation, `all`/`any`, `only if`, `unless`, and exceptions
  attached to the same actions. A necessary condition is not sufficient permission.
  After a split or list conversion, check which branches execute every action.
- **Order and time.** Preserve `before`, `after`, `until`, deadlines, time windows,
  and reference points. Do not convert temporal sequence into causation or
  simultaneous work into a sequence.
- **Modality.** Distinguish obligation (`must`), recommendation (`should`), permission,
  capability, and uncertainty. `May` can express permission or probability; infer
  which only from supported context. Keep meaningful hedges and temporal forms.
- **Identity and knowledge.** Replace a pronoun only when its referent is known.
  Do not invent an actor to obtain active voice. Unknown, failed, pending, and
  completed outcomes are not interchangeable. A completed job does not establish
  that its output is currently available.
- **Terms and literals.** Keep identifiers, schema keys, error codes, commands,
  quoted literals, UI labels, quantities, units, and versions intact unless the
  requested edit includes their change. Do not merge distinct operations merely
  because their names look like synonyms.

If the source supports multiple consequential readings, retain the uncertainty
and flag the specific ambiguity. Ask a focused question when selecting a reading
is necessary to complete the task. Do not silently choose an interpretation or
invent missing recovery rules. Supported context can resolve ambiguity; a style
preference cannot.

## Keep style subordinate to meaning

Prefer direct verbs, explicit referents, stable terms, and separable actions when
they make the decision easier to follow. Keep useful technical terms, passive
constructions, and compound tenses when replacements would lose meaning or
require unsupported facts. Remove empty framing without deleting the claim or
its degree of confidence.

Apply sentence-length caps, punctuation restrictions, or lexical exclusions only
when the task or an applicable house style explicitly specifies them. If a style constraint conflicts
with fidelity, preserve meaning and identify the unmet constraint. Do not satisfy
a word cap by dropping a prerequisite, negation, exception, or meaningful hedge.
Apply a language-specific constraint to another language only when the task or
applicable house style requires it.

A word count depends on tokenization; semantic ambiguity, passive voice, and
synonym equivalence need contextual review. Treat heuristic lint findings as
diagnostic cues. Do not run an unavailable linter or claim that a clean lint result
proves fidelity. This reference adds no fixed vocabulary, mandatory word cap,
punctuation ban, or external language-standard dependency.

## Worked examples

| Source | Faithful treatment | Misreading to avoid |
|---|---|---|
| `If validation succeeds, save the result and notify the caller.` | Put both actions in a list governed by `If validation succeeds:`. | Making notification unconditional after splitting the sentence |
| `The upload may have failed; check the job status before you retry.` | `The upload may have failed. Check the job status before you retry the upload.` | Declaring failure or requiring an unconditional retry |
| `Files are deleted after 30 days.` | Retain the passive when the actor is not established. Flag an unspecified time origin only if the task needs it resolved. | Inventing `We`, or adding `after creation` |
| `Verify the signature. Then ask the user to confirm the transfer.` | Retain both operations and their order. | Replacing both verbs with `check` and losing the confirmation requirement |

These examples are hypothetical. Apply the source's actual conditions rather than
copying an example's domain decisions into another document.

## Return a usable result

For a rewrite, return the complete revised text by default. If no change is useful,
return the original text without a compliance announcement. When explanation is
requested, include the revised text and explain material changes; honor a request
for a diff-only or diagnostic-only response instead.

Keep editorial notes outside the copyable text. Briefly identify a consequential
unresolved ambiguity or an unmet requested style constraint when necessary. If an
exact output schema prohibits extra prose, use its existing diagnostic mechanism
or ask for the missing decision rather than silently altering meaning or adding
schema fields. A normal clarity edit needs no routine compliance disclaimer.
