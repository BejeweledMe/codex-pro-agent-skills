# Threat Model And Boundaries

## Inventory

List assets (data, credentials, funds, records, reputation), actors, caller identities, tenants, models/configurations, corpora, tools, external dependencies, and recovery owners. Track versions and capabilities so a new tool, source, or integration triggers threat-model review.

## Trust Boundaries

Mark where user text, retrieved documents, web/tool output, or agent messages cross into trusted state, private data, privileged tools, or external effects. A document may be trusted as a source of facts but still untrusted as a source of commands.

## High-Consequence Intersection

Prioritize paths that combine untrusted content, private data, and a side-effecting capability. Reduce the intersection: remove unnecessary data/tool reach, require deterministic validation or approval, and ensure an operator can halt/revoke the path.

## Data Flow Matters

Review both control flow and argument provenance. A model can select an allowed tool while a value from untrusted content changes the target, destination, scope, or amount. The policy decision must receive tool identity, normalized arguments, caller/tenant, provenance, and intended effect.

## Durable State And Recovery

Include promotion from a document, tool result or generated summary into durable
memory. Repetition, storage or summarization does not turn untrusted content into
an authorized instruction or verified fact. Track who can propose, validate,
commit, supersede and revoke remembered claims and permissions, including the
source and sensitivity of each value.

Model rollback, index restore and controller recovery as trust-boundary
transitions. An old otherwise functional bundle may reintroduce deleted content,
revoked access or compromised tool routes. Recovery must preserve current security
state and validate the surviving basis of trust; restoring availability alone is
not proof of safe operation.
