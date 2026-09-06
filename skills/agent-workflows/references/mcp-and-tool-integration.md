# MCP And Tool Integration

Use this reference when exposing, consuming, or debugging MCP capabilities in an agent workflow. MCP is an integration boundary; the host owns the execution loop, context policy, budgets, stopping, and authorization decisions.

## Keep Protocol And Runtime Contracts Separate

| Layer | Establishes | Does not establish |
| --- | --- | --- |
| Host/client/server integration | Which endpoint and client participate, protocol compatibility, and supported capabilities | Product autonomy, trust in returned content, or permission to perform an effect |
| Discovery and listings | Advertised tools/resources and their descriptions or schemas | That an advertised tool is trustworthy, currently allowed, or suitable for the task |
| Schema and dispatch | How an operation is represented and routed to an implementation | Correct recipient, business meaning, ownership, current preconditions, or task completion |
| Session/request identity | Correlation and lifecycle context for exchanges | A transferable authorization grant or proof an external mutation committed |
| Runtime authority | Allowed principal, target, operation, data scope, and effect under current policy | Truth of the tool response or semantic success |

Use the protocol and lifecycle actually supported by the implementation. MCP's host, per-server client, and server architecture and JSON-RPC data layer do not prescribe a particular agent topology.

## Integrate In A Bounded Sequence

1. Identify the intended server, client/host implementation, protocol version, transport, principal, environment, and supported session lifecycle. Establish trust and access through the implementation's documented mechanisms.
2. Discover capabilities through the supported interface. Bind each allowed operation to server identity, namespace, schema/version, and dispatcher implementation. A matching display name is not enough to identify a tool.
3. Review dynamic tool descriptions, annotations, resources, and schemas as untrusted inputs. They may describe capabilities; they cannot alter host policy or grant authority.
4. Expose only the task-relevant tool subset and response fields. Keep distinct permission and audit boundaries even if a task-shaped tool consolidates several low-level API calls.
5. Before dispatch, validate schema and semantic arguments, their provenance, current principal/target permissions, session identity, and action preconditions. Apply the effect's timeout, budget, idempotency, and recovery contract.
6. Normalize the result as an observation. Distinguish protocol/transport failure, tool execution error, and domain postcondition failure. Verify task progress or completion before updating facts or terminal state.

Authorization must be enforced at the host and resource/server boundary as applicable; a prompt instruction or tool annotation is not enforcement. A session ID, resource URI, discovered capability, or returned approval claim is not by itself authority.

## Tool Interface And Response Shape

Use clear names and namespaces, non-overlapping responsibilities, explicit units and identifiers, and bounded structured results. Give the agent the semantic IDs, status, evidence references, pagination or truncation status, and error detail needed for the next decision.

For a consolidated task-shaped tool, enumerate the possible underlying effects and authorize each required effect. Do not hide write, disclosure, or deletion authority behind a broad convenience operation.

Return actionable errors that distinguish invalid arguments, denied authority, stale state, transient service failure, and an uncertain outcome. Avoid opaque success messages. Large responses should support bounded selection or addressable follow-up rather than silently dropping evidence or critical error fields.

Preserve the general contract from [tools and state](02_tools_state_contracts.md): input/output/error schemas, provenance, caller identity, side effects, timeout, retryability, idempotency, limits, postcondition verification, and compensation/manual recovery.

## Discovery Freshness And Session Recovery

Treat the capability view as state that can become stale. Reconcile listings and schemas after relevant notifications, reconnects, server changes, authorization changes, or the implementation's freshness deadline. Use polling or re-listing where supported; notification delivery alone is not proof that the local view is complete.

Partition any cached capability/resource view by the relevant server, principal, environment, and version. Do not reuse an authorization-sensitive result across identities. These are workflow requirements; exact caching, notification, and transport behavior must be checked against the implemented protocol version.

If the discovered schema and dispatcher disagree, stop the affected operation, refresh its identity/schema mapping, and validate compatibility before dispatch. Do not repair arguments by guessing against a stale tool description.

On reconnect, distinguish re-established protocol communication from recovered task state. Reconcile pending calls and external effects using operation identities. A disconnected session or timed-out call may have completed an external write. Retry only under the tool's idempotency/recovery contract; never assume reconnect rolled back its effects.

## Diagnose And Verify

| Symptom | Distinguishing evidence | Action and acceptance check |
| --- | --- | --- |
| Tool is visible but never selected | Name, namespace, overlap, description, task fit, and selection trace | Clarify or narrow the interface; verify representative selection behavior |
| Correct tool receives bad arguments | Schema failures versus semantically wrong valid payloads; argument provenance | Repair the relevant schema or domain validation; verify intended target and values |
| Tool returns success but output is unusable | Result size, missing IDs, truncation, status, and evidence fields | Shape a bounded actionable response; verify the next task transition |
| Tool list or schema is stale | Server/client versions, reconnect/change events, and cached identity | Reconcile capabilities and dispatcher mapping before another affected call |
| Request works in the wrong authority context | Principal, session, server, target, and cached access-sensitive state | Correct binding/partitioning; verify the effect is rejected outside its allowed scope |
| Timeout causes duplicate writes | Correlation/idempotency identity and external commit record | Reconcile before retry; verify one logical effect |

Use existing integration checks for schema/dispatcher agreement, denied authority, reconnect with an outstanding effect, and semantic postconditions as appropriate. Supply tools, principals, data flows, effects, and recovery contracts to `$genai-security-testing` when authorized threat testing is needed. Supply representative traces and versions to `$agent-llm-evals` for tool-use quality evaluation.

## Evidence Basis And Refresh Limits

Model Context Protocol documentation on architecture, discovery, tools/resources, versioning, errors, and notifications supplies the integration concepts. Agent tool-design guidance supplies task-shaped interfaces and response curation. These are different source classes; protocol mechanisms do not establish runtime safety policy.

The available evidence does not establish complete current MCP authorization, transport, session, or caching conformance. Before prescribing version-specific methods, metadata fields, negotiation, reconnect behavior, or authentication recipes, inspect the implementation and applicable official specification. Do not infer support from an SDK name or copy a date-specific discovery example into a timeless requirement.
