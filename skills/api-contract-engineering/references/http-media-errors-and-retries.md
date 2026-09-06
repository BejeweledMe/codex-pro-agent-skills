# HTTP, Media, Errors, and Retries

Use when the payload appears correct but the exchange, consumer interpretation, or replay behavior is wrong.

## Define the Exchange

For the affected operation, connect method and target to permitted effects, success and failure statuses, headers, representation media, body presence, conditions, and replay behavior. OpenAPI describes this exchange; it cannot redefine HTTP.

| Decision | Mechanism and failure | Evidence and action |
| --- | --- | --- |
| Method safety | Mutation exposed through GET/HEAD can be triggered by crawlers or prefetchers | Trace the effect and remove unsafe execution from safe methods; verify no mutation occurs |
| Response context | Response-only dispatch can try to decode HEAD as an empty JSON GET | Retain originating method; verify HEAD handling without content decoding |
| Status | A closed status enum can discard an otherwise valid response | Retain the actual code and class; use a generic class outcome for an unknown valid code without inventing a typed body |
| Preconditions | Checking after mutation defeats concurrency protection | Verify the condition is evaluated before effects and that rejection leaves state unchanged |
| Media | A generic JSON decoder can misread an alternate representation | Compare actual `Content-Type`, matched description entry, parser choice, and bytes |
| Intermediaries | A gateway can change headers, errors, retries, or representation handling | Compare origin and client observations through the affected deployed path |

HEAD has no response content. Other body restrictions also depend on method/status; consult the applicable HTTP rule before invoking a decoder. Unknown valid statuses retain their class semantics. Values outside 100–599 should take a protocol-error/server-failure path while retaining the received value for diagnosis.

For applicable `If-None-Match`, a false condition yields 304 for GET/HEAD and 412 for other methods. Do not generalize this to every precondition. Identify what a validator represents and whether its strength meets the concurrency, revalidation, or range use case.

## Separate Serialization from Schema

Build a small fixture containing the logical value, parameter location or body media, exact encoded request, selected parser, and decoded value.

- Inspect parameter `style`/`explode` and applicable location rules. Query, cookie, form, multipart, and JSON are distinct representations.
- Form-urlencoded body content does not include the query-leading `?`.
- Do not indiscriminately apply URI percent-encoding to multipart data.
- Select the intended media type explicitly; do not default to sniffing or generic coercion. For OAS matching, the most specific matching media range wins; do not assume a framework parser uses the same matching algorithm.
- Avoid conflicting media declarations. In the evidenced OAS Encoding Object context, `contentType` takes precedence over Schema `contentMediaType`.
- An empty Request Body `content` map is implementation-defined in the selected OAS rules, not a portable way to say “no body.”

Check bytes at the adapter boundary, not only object equality before serialization. A framework can parse a media type without applying the validator intended for it.

For sequential media, distinguish complete-content `schema` from per-item `itemSchema` in OAS versions supporting the latter. Whole-content validation of an unbounded stream can wait indefinitely or accumulate memory. Specify framing, item failure behavior, completion, and bounds; verify that an early item reaches the consumer before stream completion. Do not add `itemSchema` to a toolchain that does not support its feature line.

## Design Problem Details When Adopted

Problem Details is optional. Preserve an existing error protocol unless changing it serves the task.

For RFC 9457 responses:

- Use the resolved `type` URI as the machine identity. Prefer absolute identifiers so meaning does not vary with the request URI.
- At the origin, if emitting body `status`, derive it from the same outcome as the HTTP status and ensure they match. The received HTTP status governs generic HTTP behavior. If an intermediary changed it, retain the advisory body value as evidence of the generator’s original status; do not automatically diagnose the origin as faulty or let the body override HTTP dispatch.
- `title` summarizes the problem type and should remain stable between occurrences apart from localization; `detail` explains the particular occurrence and may help a person correct the problem. Do not branch program behavior on either prose field. Put machine-needed information in documented extensions with defined types and meaning.
- Ignore unknown extensions. Treat incorrectly typed known members as absent according to Problem Details rules.
- Prefer absolute `instance` URIs where an instance identifier is supplied. Production clients should not automatically fetch `type` documentation.

Use the declared Problem Details media type, such as `application/problem+json` for its JSON representation; a JSON-looking body alone does not select that protocol. For evolution, add extensions without repurposing an established `type`. Exercise an old consumer with an added extension, changed localization, and malformed known members. Verify that dispatch and recovery remain stable. A generic error fallback must remain available when no recognized problem type is usable.

This tolerance does not make arbitrary business schemas open, and it does not permit accepting an invalid token. Problem Details alone also does not define heterogeneous batch-result semantics.

## Diagnose and Bound Retries

Before recommending a retry, establish:

1. Who retries: application client, generated client, transport, proxy, or authentication-recovery path.
2. Method semantics and the operation's promised effect.
3. Whether the request body and relevant conditions can be replayed.
4. Failure stage and evidence about the first attempt: known unapplied, known applied, or uncertain.
5. Any application idempotency identity: scope, reuse behavior, conflict handling, and retention promise.
6. Remaining deadline and the existing attempt/overload policy.

A lost response is not evidence that the operation failed to execute. An authentication refresh does not independently establish replay safety. A proxy must not automatically retry a non-idempotent request; idempotency also does not grant unlimited retries.

For duplicate writes, correlate attempts with the durable effect using redacted identifiers. Reproduce a lost-response case in the authorized test environment and verify the effect count, response behavior, and identity reuse. The backend owns durable deduplication and transaction execution; `system-design` owns broader deadline, retry-budget, and overload decisions.

If the first effect is uncertain and no supported recovery or replay mechanism exists, stop automatic replay and surface the uncertain outcome. Use an existing status lookup or reconciliation path where available. Do not invent an idempotency header or assume it is durably enforced.

## Keep Intermediary Obligations Visible

GET alone does not authorize cache storage or reuse. Record cache intent, selected representation, negotiation dimensions, validator correspondence, and the intermediary path when they affect the contract.

Incomplete content must remain identified as incomplete and must not become a complete 200 response. Combining stored ranges requires appropriate strong-validator correspondence and other applicable requirements. HEAD updates to stored GET responses also require correspondence checks.

Preserve field multiplicity and ordering where HTTP requires them; a generic unordered single-value map is inadequate. Keep distinct field names distinct and trailers separate from headers. Use bounded parsing for protocol lengths, ranges, and freshness arithmetic. Detailed freshness, authenticated caching, `Cache-Control`, and `Vary` policies require the relevant RFC 9111 clauses and actual cache behavior.

When changing the transport or generated adapter, verify that existing URI-origin/TLS identity checks and parser bounds survive the change. A successful type projection or token parse cannot establish those protections; transport configuration and control design stay with their implementation and security owners.

## Source Basis

[RFC 9110, HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110.html): methods, status classes, fields, conditional requests, and representations. [RFC 9457, Problem Details for HTTP APIs](https://www.rfc-editor.org/rfc/rfc9457.html): section 3 on members/media and section 4 on defining types; sections 3.1.2–3.1.4 distinguish origin status, title, and occurrence detail. [OpenAPI Specification 3.2.0](https://spec.openapis.org/oas/v3.2.0.html): Media Type and Encoding Objects and sequential content. [RFC 9111, HTTP Caching](https://www.rfc-editor.org/rfc/rfc9111.html): selected partial-content and stored-response correspondence rules.
