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
