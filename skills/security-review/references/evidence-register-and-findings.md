# Evidence register and findings

## Match evidence to the proposition

For material claims retain the target, protected property, relevant condition/actor, enforcement point, method, evidence location/date, result and limits. Add versioned requirement and applicability for standards assessment. Use the existing report or tracker; create a register only when it improves traceability.

| Evidence | Can support | Does not establish alone |
|---|---|---|
| Policy, design or self-attestation | Intended decision and declared responsibility | Adequacy, enforcement or current runtime state |
| Source/configuration inspection | Control behavior under inspected assumptions | Deployed identity or all runtime outcomes |
| Behavior and state trace | Observed result for named case, actor and target | Untested paths or full baseline coverage |
| Scanner/check report | A configured predicate on scanned inputs | Complete vulnerability absence or contextual exploitability |
| Verified signature/provenance | Artifact binding and authenticated origin claims under the trust policy | Builder integrity, deployment authorization or safe contents |
| Operational record | Observed events subject to collection, custody and access limits | Unobserved events, independent truth or adequate response capacity |

Use methods that could disconfirm the claim. Combine them when one leaves a material blind spot, especially for high-consequence paths; no minimum method count establishes sufficiency. Record tool/check version, configuration and coverage when they affect interpretation. Resolve contradictory observations before preferring the intended design.

## Separate evidence, risk decisions and remediation

- **Supported within scope:** evidence supports the exact checked claim under stated assumptions.
- **Observed failure:** behavior or inspected artifacts contradict the property on the named target.
- **Hypothesis:** plausible weakness remains unestablished; identify a discriminating check.
- **Missing evidence:** needed artifact/access is unavailable; describe the consequence of uncertainty.
- **Not checked / unassessed:** the scope or method did not examine it; report the uncovered surface.
- **Not applicable:** the actual applicability predicate excludes it; record rationale and revisit trigger.

Separately record risk disposition, such as open, mitigation planned or accepted by a named authorized owner. Accepted failure remains a failed applicable requirement. Track remediation as proposed, implemented but unverified, verified on an identified target or reopened. Mark superseded evidence when a changed target or requirement breaks correspondence, while retaining its history.

## Make findings actionable

A useful finding explains the failed property; target and affected route/actor; expected versus observed behavior with redacted evidence; preconditions and plausible harm; confidence and limitations; owner and remediation direction; and what observation on the fixed target would close it. Present this compactly for a simple defect. Do not fabricate exploitation or numerical likelihood to fill a template.

Use the organization's severity scheme when supplied and explain the consequence/reachability rationale. Severity and evidential confidence differ: serious plausible harm can have low confidence, while a confirmed configuration defect may have limited demonstrated impact. Keep blocking defects, optional strengthening and evidence requests distinguishable.

Example: a data policy prohibits raw customer content in logs, but a bounded error trace contains it. Cite that trace and target, identify the logger and affected path, and request verification of the corrected error behavior plus useful allowed diagnostics. A protected destination does not fix overcollection; one redacted sample does not prove all paths safe. Do not infer exposure of every customer.

## Retest and exceptions

Pass the failed property, evidence, constraints, priority rationale and retest criteria to the implementation owner. Suggest related-route investigation when a shared component could carry the same defect. Remediation is not automatically authorized by a review request.

Verify the identified fixed revision/configuration using a suitable repeat of the failing condition or equivalent inspection, within existing authority. Check the protected state or side effect and a relevant legitimate path/regression where needed. An author's closure assertion or green build alone does not establish remediation. Additional independent retest should address material conflicts or evidence weaknesses, not impose a universal staffing rule. Report source verification separately when deployment or installed exposure remains unknown.

For an exception retain the failed/uncertain property, affected scope, compensating measures and their evidence, acceptance authority, expiry or concrete revisit condition and fallback if conditions fail. A requirement's explicit alternative can be assessed; ordinary documentation cannot waive an unconditional requirement.

| Problem | Discriminating evidence | Next action |
|---|---|---|
| Policy and enforcement disagree | Configuration/source plus behavior or history on the target | Report the contradicted property and enforcement owner |
| Suppression closes an uncertain result | Subject/version, reachability or false-positive rationale, approval and refresh condition | Reopen or condition the disposition if the rationale fails |
| Evidence describes another release | Source, artifact, configuration and deployment correspondence | Bound the conclusion and request the missing link |
| Finding cannot be reproduced | Original target, assumptions, trace and expected/actual behavior | Retain uncertainty; investigate rather than invent closure or continued exploitation |
| Fix exists but consumers remain affected | Installed versions, update channel and support coverage | Track field exposure with deployment/support owners |

When useful, report scoped claims by evidence status, findings by consequence/confidence and age, exceptions by revisit condition, and fixes by retest/installed state. State denominators for quantitative coverage; do not turn these into a security score. Keep sensitive reproduction detail in restricted evidence rather than public reports.
