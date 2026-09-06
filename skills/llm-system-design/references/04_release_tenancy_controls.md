# Release, Tenancy, And Controls

## Release Bundle

Attribute a release to a complete tuple: provider/model identifier, tokenizer or chat
template where relevant, prompt and policy versions, context/index version, tool and
routing configuration, limits, validator, evaluation report, and rollback target.
Changing any member can alter behavior. Store enough provenance to compare an
incident or regression with its predecessor.

## Tenant Boundary

Resolve tenant and authorization before data retrieval, prompt construction, tool
selection, cache lookup, and audit logging. Make per-tenant configuration explicit:
models/routes allowed, quotas, data sources, retention, and approval rules. Do not
rely on an LLM instruction to separate tenants.

Use `$genai-security-testing` for the threat model, enforcement design, and
authorized boundary testing. Use `$agent-llm-evals` for the repeated harness,
graders, calibration, and release gate.

## Rollout Controls

Use bounded traffic, shadow comparison, feature flags, or a limited tenant set when
the change can affect behavior, cost, privacy, or tool actions. Define the owner,
stop condition, and rollback route before starting. A successful HTTP response is
not enough evidence for a successful LLM release.

## Compatible Recovery

Check compatibility across the model, tokenizer/template, prompt, policy, tools,
retrieval state and runtime—not only whether each component starts. Keep a small
set of representative semantic outputs and permitted-effect cases so a technically
healthy rollback cannot silently change the product contract.

Restoring an older model or index must not restore revoked permissions, deleted
content, compromised credentials or a prohibited tool route. Separate recoverable
behavior/artifact state from current authorization and deletion obligations.
When the old bundle cannot meet today's security policy, choose a verified degraded
path or repair forward; neither unrestricted rollback nor a blanket ban on rollback
is a sufficient recovery design.

The product owner defines permitted autonomy, quality, failure behavior and human
authority. Use `$ai-platform-llmops` for shared registry, capacity, placement,
controller scaling and fleet rollout; pass the compatible bundle, workload envelope,
semantic gates, stop conditions and recovery constraints. Use
`$llm-inference-optimization` for request-path performance. Training execution,
collectives and coherent training-state recovery belong to `$neural-training-systems`,
while model/adaptation choice stays with its modeling owner. Load a companion only
when that unresolved decision is part of the task.
