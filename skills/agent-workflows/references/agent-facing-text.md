# Text for agent decisions

Use this when authoring or substantively revising tool descriptions, errors, system
instructions, or handoffs whose wording affects an agent's next action. Use only
the parts relevant to the artifact. An ordinary README, PR, or human status report
does not require this pass merely because it contains technical language.

## Establish the content before wording

Use the existing tool, state, permission, and recovery contracts as the source of
truth. Distinguish confirmed behavior, a proposed design, and an unresolved input.
When authoring, you can propose a missing decision, but do not present it as an
existing guarantee. Treat a revision that changes behavior as authoring: distinguish
verified behavior from proposed changes. When faithfully rewriting, preserve the established behavior;
use [instruction clarity](../../information-editing/references/instruction-clarity.md)
if the wording needs a separate semantic check.

HTTP-level errors and idempotency guarantees remain with `api-contract-engineering`. Product
prompt architecture remains with `llm-system-design`; technical documentation
keeps its artifact owner. Text can explain these contracts but does not enforce
permissions, validate arguments, or establish completion.

## Make the next decision explicit

| Artifact | Include when it changes the next decision |
|---|---|
| Tool description | What the tool does; when to choose it; a consequential exclusion or distinction from a similar tool; required inputs and their source; relevant effect or result |
| Error | The failed observation or operation; whether the external effect is known; the applicable recovery or replay rule; the next supported action |
| Instruction or handoff | Responsible actor; target; governing conditions; dependencies and order; completion evidence; output contract and stopping condition |

Do not turn this table into mandatory boilerplate for every string. Reference an
existing schema or recovery rule when it already communicates the needed detail.
Preserve its identifiers and enum values. Do not add fields or enum members during
a wording-only change; identify a necessary schema change separately.

A timeout establishes a missing response, not necessarily a failed external
effect. If the outcome or retryability is unknown, say so instead of inventing a
Boolean value. Follow [tools and state](02_tools_state_contracts.md) for
reconciliation and protected replay. Do not require a status lookup when the
established idempotency contract already permits safe replay.

## Express the decision without changing it

- Use stable names for the same object. Keep different names for actions with
  different semantics, such as signature verification and user confirmation.
- Put a governing condition where it remains visible with each dependent action.
  Lists can keep a shared condition together. Preserve whether requirements are
  cumulative, alternative, necessary, or sufficient.
- Separate actions when this clarifies order or responsibility. Keep simultaneous
  actions and shared conditions connected; splitting is not an end in itself.
- State required, optional, and prohibited behavior distinctly. Preserve the
  difference between permission, capability, and uncertainty.
- Name actors and referents when the contract identifies them. If it does not,
  expose the missing decision instead of guessing.
- Describe observable completion separately from request acceptance or a tool's
  self-report. Do not infer output availability from a completed verb tense.

## Small examples

These are hypothetical contracts, not instructions to operate a real system.

**Tool selection.** Given a read-only `get_job(job_id)` and a `start_job(spec)` that
creates a new job, describe `get_job` as: "Read the status of an existing job. Use
the ID of an existing job. This tool does not start or retry a job."
The exclusion is useful because it distinguishes two available operations; do not
invent that distinction when their actual behavior is unknown.

**Unknown outcome.** Given a timeout and an authoritative read-only lookup by
`operation_id`, an error can say: "No response arrived before the timeout. The
operation outcome is unknown. Read its status with `lookup_operation(operation_id)`."
Whether replay is permitted must come from the separate recovery contract. A
wording change cannot add "retry with a new ID".

**Handoff.** Given a review-only assignment, say: "Inspect the supplied diff.
Return findings with file locations. Finish after returning the findings."
Do not turn that assignment into authorization to edit files or deploy a fix.

## Check the result

Walk one realistic next decision against the actual contract: correct tool,
arguments, condition, recovery, and terminal state. Include a case where the
action is inapplicable or the outcome is unknown when that is a material risk.
Use `agent-llm-evals` for a broader evaluation; a clear sentence or a schema-valid
payload alone does not prove correct agent behavior.

These checks support instruction design; they do not by themselves establish
measured improvement in agent behavior.
