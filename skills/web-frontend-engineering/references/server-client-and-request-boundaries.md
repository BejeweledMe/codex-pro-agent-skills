# Server-Client and Request Boundaries

## Minimize What Crosses

Inspect actual browser-delivered data: initial payloads, Client Component props, action return values, and captured values crossing framework boundaries. Server-only module placement does not prove that its data remains private.

Construct the smallest deliberate data transfer object for the visible operation. Keep credentials, internal records, and unrelated fields server-side. Confirm supported serialization types against the installed framework rather than assuming every value is JSON or automatically safe.

Every reachable action must apply authentication, input validation, and object/operation authorization on the invoked server path. A hidden button, protected layout, or unguessable client reference is insufficient. Prefer a shared authorized data-access path when it prevents inconsistent checks.

Frontend implements the boundary and visible denial/recovery behavior. Application security owns control design; backend owners retain business invariants and transactions. For an exposure, inspect direct invocation and cross-object access within the authorized scope, then verify that permitted use still succeeds. Do not treat encryption, origin settings, or taint mechanisms as substitutes for authorization.

## Adapt Runtime Responses

Static types and generated clients do not validate external bytes. Use the project's adapter/validator to preserve the information needed to distinguish:

- Transport failure or cancellation.
- An HTTP response, including its actual status and selected media type.
- A supported success, empty result, or documented failure.
- Unexpected status/media, decode failure, or invalid response shape.

Do not collapse all outcomes into an empty collection or assume that a successful transport means a successful operation. Keep diagnostics separate from user-facing text; raw server errors and payloads may contain private data.

When the adapter disagrees with the contract, supply the operation, relevant versions, status/media, redacted payload shape, and observed mismatch to `api-contract-engineering`. Frontend retains the concrete parsing and UI mapping fix; the API owner decides wire and consumer compatibility.

## Forms and Submission Evidence

For a form or adapter defect, inspect the actual submission: active submitter, included controls, resolved action, method, encoding, and resulting request. Do not infer the method from the presence of a body. Trace whether an event handler intentionally replaces native behavior and whether it preserves keyboard submission and validation feedback.

Client validation improves interaction; the invoked server path still validates and enforces authority independently. Pending/disabled UI can prevent accidental repeat activation but does not establish server-side deduplication. Use an idempotency mechanism only under the API/backend contract, including its scope and retry semantics.

## Coordinate Requests with UI Lifetimes

For each affected operation, identify the triggering action, request identity, active record/route, and which response may commit.

| Situation | Frontend action | Recovery evidence |
| --- | --- | --- |
| Record or route changes during a read | Cancel supported work and reject obsolete completions at consumption | Late data never overwrites the active record. |
| Repeated activation while a mutation is pending | Apply the accepted duplicate policy and visible feedback | Repeated clicks/keys do not accidentally create extra operations. |
| Mutation times out after dispatch | Preserve an uncertain outcome when commit status is unknown | Resolve status or follow the agreed retry contract before reporting failure or replaying. |
| Optimistic update is rejected or superseded | Reconcile against authoritative results without erasing unrelated newer edits | Rejection, retry, and overlapping updates settle coherently. |
| Background refresh fails | Preserve valid stale content only when allowed and expose relevant freshness/recovery | Users can distinguish stale success from current confirmation. |

Cancellation of browser work is not proof that a server mutation was undone. Retry safety and idempotency guarantees come from the API/backend contract.

Represent meaningful states explicitly: idle, pending, success, empty, stale, failed, and uncertain where applicable. Keep independent regions usable during localized work when acceptance allows it. Show field errors with their controls, preserve recoverable input, and provide a retry path that does not silently duplicate side effects.

Keep synchronization cleanup, request cleanup, and event-handler failure handling explicit. Do not assume a rendering error boundary catches every asynchronous failure.
