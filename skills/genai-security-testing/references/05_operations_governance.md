# Operations And Governance

## Observability

Log redacted policy decisions, denied and approved tool calls, access-filter outcomes, capability use, budget/rate events, version bundle, and terminal outcome. Security telemetry is a signal class, not harmless noise. Protect logs as a data store with their own access and retention policy.

## Incident Path

Define detection, capability disablement, credential revocation, evidence preservation, impact assessment, owner escalation, remediation, and recovery validation. Route a live reliability event to `$sre-reliability-engineering`; this skill supplies the GenAI-specific trust-boundary context.

## Governance

Assign owners for policy, model/prompt/index/tool changes, test authorization, data classification, release decision, monitoring, and incident recovery. Maintain an inventory of active models, configurations, corpora, tools, capabilities, identities, and dependencies. Changes that expand authority, data reach, or egress require review before release.

## Versioned Verification Overlay

When using OWASP LLMSVS or ASVS, identify the exact available edition, requirement
or category, applicability and original qualifier before mapping it to this
system's control and evidence. Keep the protected outcome, implementation,
verification method, observed result, limitation and acceptance owner linked.
Categories, a documentation page or a scanner result do not prove the requirement
was tested; a model-generated mapping does not supply missing normative text.

Distinguish not applicable, not assessed, missing evidence, failed control and
explicitly accepted residual risk. Do not invent IDs, levels or complete coverage
from a partial source. Use `$application-security-engineering` for general
control/requirement implementation and `$security-review` for independent
assessment; preserve the GenAI authorization, benign utility and observed-effect
evidence alongside the standards mapping.
