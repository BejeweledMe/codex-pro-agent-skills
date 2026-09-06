# Search, Selection, And Verification

Use when evaluating repeated sampling, candidate ranking, critique/revision,
workflow-scaffold changes, persistent memory, or long-horizon agent reliability.
Use only the stages present in the product. A single-response task does not need
a search harness, and a schema change may need only a narrow deterministic check.

## Establish The Evaluation Contract

Obtain the task outcome, acceptable alternatives, required path constraints,
allowed effects, terminal states, and recovery expectations from the workflow
and domain owners. Define what evidence can establish each requirement before
choosing metrics.

This skill owns the cases, isolation, graders, calibration, repeated trials, and
release gates. `$agent-workflows` owns runtime and state semantics;
`$rag-engineering` owns corpus, retrieval, and evidence contracts;
`$genai-security-testing` owns threat scope and authorized adversarial work.
`$qa-testing` owns classic deterministic testing strategy, and
`$sre-reliability-engineering` owns production response. A measured capability
does not change permissions or remove an approval requirement.

Keep outcome grading as the default. Add path checks when permission, identity,
required evidence, tool behavior, or handoff is contractual. Partial credit
localizes failure; it cannot compensate for a failed mandatory requirement.

## Stage Metrics And Diagnostic Actions

Use independent acceptance labels for correctness metrics. Record counts,
denominators, case slices, trial budgets, and unresolved evidence. Do not collapse
the following measurements into a single agent score.

| Stage | Measurement and evidence | Diagnosis and next action |
| --- | --- | --- |
| Generator | Pass@1, invalid-output rate, and task-relevant candidate diversity. | Repeated invalid or equivalent proposals suggest a generation, representation, or context problem. Compare the smallest relevant change under the same task and budget. |
| Candidate pool | Pass@K / coverage@K: fraction of pools containing at least one acceptable candidate. Retain independently labeled candidates. | Low coverage limits what selection can achieve. Inspect missing context, task ambiguity, generator behavior, and tool evidence before increasing K. |
| Selector | Selected@K, selection accuracy conditional on an acceptable candidate being available, and fixed-pool oracle gap. | High coverage with low selected success identifies lost selection opportunity. Replay selectors on the same pools and inspect rejected good candidates before buying more samples. |
| Verifier | False accepts among incorrect candidates; false rejects among correct candidates; unknown rate and calibration by relevant slice. | Inspect evidence omissions, rubric ambiguity, score exploitation, and distribution shift. Recalibrate on independently labeled current proposals and recheck the affected severe cases. |
| Revision | Correct-to-incorrect rate among initially correct candidates; incorrect-to-correct rate among initially incorrect candidates; stagnation. | A rising critique score can hide damaged answers. Compare paired artifacts against independent evidence and verify that the proposed revision policy preserves already-correct behavior. |
| Tool effects | Schema and semantic argument validity, preconditions, execution outcome, postconditions, and duplicate effects. | A valid call or success response can accompany a wrong state transition. Inspect execution records and state; send tool-contract defects to the workflow owner and re-evaluate observed effects. |
| Memory/state | Write precision against supported authorized facts, recall of required stored facts, stale/conflicting records, retained constraints, and restore integrity. | Compare retrieved summaries and resumed state with canonical artifacts. Reproduce the relevant compaction, expiry, conflict, or resume case before accepting a memory-policy change. |
| Terminal workflow | Independently verified terminal success, false completion claims, handoff accuracy, recovery, and required versus observed abstention/escalation. | Fluent completion text or budget exhaustion is insufficient. Check final state, unresolved obligations, and the actual handoff or stop event. |
| Release failures | Severe errors, missed required escalation, irreversible-action failures, and critical-slice regressions. | Keep these separate from average quality. Apply the owner-defined block, investigation, rollout-stop, or rollback action and retain the case as regression evidence. |
| Economics | End-to-end latency and tails, generation/retrieval/tool/verification cost, human review, redo, and cost per verified success. | A larger pool may improve coverage while increasing selection and correction burden. Compare delivered outcomes under matched budgets and include failed attempts. |

For verifier error rates, distinguish “accepted among incorrect candidates” from
“incorrect among accepted candidates.” Both can matter, but their denominators
answer different questions. Track `Unknown` separately and state how it routes
to abstention, further evidence, or review; do not silently count it as success.

For RAG tasks, obtain retrieval labels and stage semantics from `$rag-engineering`.
Generator coverage cannot replace retrieval recall, citation support, or access
checks. Apply the existing RAG and security protocol in
[09-rag-and-security-eval-protocols.md](09-rag-and-security-eval-protocols.md).

If selected success falls below the matched first-sample baseline, inspect
selection and rejection on those same trials. A simpler fallback is a candidate
policy to evaluate against the same acceptance and permission requirements;
the score comparison alone does not authorize changing deployed behavior.

## Fixed-Pool Coverage Versus Selected Success

For each task trial, freeze a pool of K candidates and label them using the same
acceptance criterion. Grade the selector's chosen candidate with those labels.
If the selector abstains, record abstention separately from selected success.

- `Pass@K` is the fraction of pools with at least one passing candidate.
- `Selected@K` is the fraction of pools whose chosen candidate passes.
- `Oracle gap = Pass@K - Selected@K`.
- Conditional selection accuracy is the fraction of pools with a passing
  candidate in which the selector chooses one.

For these same fixed pools, `Selected@K <= Pass@K`. For example, if 80 of 100 pools
contain a passing candidate and the selector chooses a passing candidate in 50
pools, coverage is 80%, selected success is 50%, and the oracle gap is 30
percentage points. Conditional selection accuracy is 50/80 = 62.5%. This is an
illustration, not a release threshold.

Do not apply the bound across different pools, graders, environments, budgets,
or acceptance criteria. If selection includes repair, new generation, or stateful
interaction, report the resulting process separately. Its output may never have
been in the original pool.

Use a fixed-pool comparison to isolate ranking and rejection behavior, then run
the complete changed system to measure actual proposals, execution effects, and
terminal outcomes. Higher coverage with flat Selected@K calls for selector or
verifier diagnosis. If both are low, first check task/harness validity and then
the generation/context/tool bottleneck.

`pass^k` remains a different measurement: success on all k repeated trials.
Preserve the repeated-trial guidance in
[05-capability-regression-release.md](05-capability-regression-release.md).
Report shared-state or common-cause dependencies rather than assuming that more
samples establish reliable repeated delivery.

## Two Evidence Channels For Acceptance

Separate the roles even when one implementation performs several of them:

1. The search-time scorer guides generation, ranking, critique, or revision.
2. The acceptance channel checks the shortlisted result against evidence that
   does not merely reproduce the optimized score.
3. The release decision combines acceptance, mandatory constraints, regression
   evidence, and the existing authority contract.

The second channel can use held-out execution checks, an independently specified
invariant, primary-source evidence, external execution records, or an expert
rubric calibrated on separate labels. Choose the basis that addresses what the
search score misses. A permission decision can establish authorization while
leaving correctness unproven.

A different model label is neither necessary nor sufficient for independence.
Two models can repeat the same mistaken premise. A model checking an actual
execution record can have a different evidence basis from a generator's
self-assessment. Document that basis and its uncovered requirements.

Keep release holdouts, grader configuration, and authoritative execution records
outside the evaluated candidate's permitted mutation space. Unauthorized changes
to those controls invalidate the affected run as evidence and require inspection
of what was altered. An authorized evaluator-maintenance task needs separately
protected acceptance evidence for its own change. Generated tests and critiques
are useful search feedback, but can share the generator's false assumptions.
They should not be the only acceptance evidence.

When release-check feedback is used to tune the candidate, those exposed cases
have become development evidence. Retain them for regression and obtain
unexposed acceptance evidence for the next release claim. Do not turn repeated
holdout tuning into an apparent independent result.

If the search score improves while acceptance does not, inspect proxy
exploitation, incomplete checks, leakage, and changed evidence distribution.
Repair the scorer or acceptance coverage according to the observed defect, then
repeat the affected comparison. Do not accept a result with missing evidence
solely because the candidate or another judge expresses confidence.

## Revision And Coupled Generator/Verifier Changes

Retain the original candidate and each proposed revision with their lineage.
Apply the same independent acceptance criteria to both. Report repairs and
regressions separately; their average can hide damage to an important slice.
Where the workflow preserves a known-good candidate, verify that failed
revisions cannot displace it under the current task contract.

Evaluate generator and verifier as a coupled versioned unit. Changes to the
model, prompt, decoding or search policy, selector, workflow scaffold, tools,
corpus/index, memory policy, trajectory format, or execution environment can
change the evidence the verifier receives even when its model is unchanged.

Keep these identities with the existing evaluation results, together with
dataset, rubric, thresholds, and acceptance-check versions. No particular
manifest, vendor, or harness is required.

For an affected change:

1. Check task references, reset behavior, dependencies, and graders before
   attributing failures to the agent.
2. Where possible, replay old and new selectors/verifiers on the same labeled
   pools to isolate acceptance and ranking changes.
3. Evaluate fresh proposals from the changed generator and environment.
   Recalibrate false accepts/rejects and inspect stop decisions.
4. Compare capability and regression cases with repeated trials appropriate to
   the task, including revision, state, and severe failure slices.
5. Promote only with independent acceptance evidence and defined rollout
   criteria; retain the existing fallback where product risk requires it.

Useful slices include task family and difficulty, short/long horizon, adequate
and missing context, reversible and irreversible effects, clean and disrupted
environments, stable and changed retrieval evidence, and model/scaffold pair.
Choose slices that test the proposed change rather than requiring every
combination for every task.

## Long-Horizon State And Terminal Evidence

Preserve intended history within a trial while isolating separate trials.
Exercise relevant interruptions, compaction, conflicting or stale memory,
checkpoint restoration, retries, and handoffs against controlled state.

Compare resumed artifacts, permissions, pending obligations, and observed
effects with canonical records. Check whether recovery repeats an already
completed effect, loses a constraint, or promotes an unsupported memory claim
into a fact. A replayed transcript or coherent summary does not prove that the
external state was restored.

Grade terminal outcomes explicitly: completed, abstained for insufficient
evidence, escalated for required authority or review, failed, or budget-exhausted,
using the workflow owner's actual states. Correct abstention can satisfy a case
whose contract requires it; report it separately from autonomous task completion.

Include both cases requiring escalation and cases permitting completion. Measure
missed required escalation, unnecessary escalation, and whether the handoff
delivers the evidence and state needed by its recipient. This prevents a system
from appearing reliable merely by refusing all work.

For irreversible-action cases, evaluate permitted effects and failure handling
in the authorized controlled environment. Report actual forbidden or duplicate
effects separately from attempted actions and missing evidence. Count severe
failures and relevant action opportunities; sparse observations do not establish
a zero failure probability.

An apparently correct final answer does not erase a required identity check
that was skipped or an unauthorized state mutation. Conversely, do not require
one golden trajectory when several paths satisfy the contract.

Report the observed reliability envelope: task family, required context,
model/scaffold, horizon, measured success and uncertainty, verifier errors,
verification method, reversibility, recovery, oversight, and known exclusions. A benchmark completion horizon is not permission for an
equally long unattended deployment.

## Economics And Release Evidence

Measure from task start to verified completion, including selection, retrieval,
tool execution, verification, waiting for review, correction, and redo. Report
human effort and elapsed latency separately, with tails for slow or difficult
cases.

For cost per verified success, divide the total measured cost across the
evaluated attempts, including failed attempts and redo, by the number of
verified successful tasks. State whether human-assisted completions are
included and report them separately from autonomous completions. With no
verified successes, report the cost and zero successes rather than inventing a
finite success cost.

Keep resource units when conversion to money is unsupported. State any labor
or expected-harm assumptions; a speculative monetary value must not offset a
mandatory permission or severe-error gate.

Before increasing K or adding critique passes, compare selected and terminal
success against the additional verification, review, and redo burden. Preserve
separate evidence for outcome, consistency, evidence quality, state integrity,
recovery, and severe failures.

Use the existing staged gates in
[08-continuous-evaluation-gates.md](08-continuous-evaluation-gates.md). Carry the
same failure slices into bounded rollout, identify the response owner, and turn
confirmed production failures into redacted regression cases. Record delayed or
unavailable outcome labels so that unresolved results are not reported as passes.

## Sources And Limits

- Stanford CS329A, Autumn 2025: readings on test-time compute, verification,
  software agents, memory, and evaluation; especially the evaluation and
  verification spine, autonomy evidence boundaries, and evaluation blueprint.
  Stage separation, two-channel acceptance, coupled evaluation, and reliability
  envelopes here are engineering synthesis, not course-published standards.
- [Anthropic, Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents):
  task-shaped evaluation, outcome/path grading, repeated trials, trace review,
  and grader calibration.

The available course material is partial; some readings provide narrow
benchmark evidence or incomplete public lecture coverage. It does not establish
universal gains from sampling or revision, autonomy horizons, suite sizes, or
release thresholds. Refresh affected provider APIs, model behavior, costs, and
environment details when an implementation decision depends on them.
