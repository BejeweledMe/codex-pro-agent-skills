# Web and API Controls

## Representation, meaning and safe sinks

Trace the actual bytes through decoding, parser, validation, storage and final interpreter. Decode expected encodings once at the defined boundary; reject ambiguous or malformed representations rather than repeatedly normalizing until accepted. Validate type, shape, size, range, allowed fields and related-value rules at the trusted service. Select parsers from supported media types and explicit encodings.

Use parameterized data interfaces and context-appropriate final output encoding. Binding SQL values does not protect a caller-controlled column or sort expression: select structural choices from trusted mappings. Avoid building commands, templates or dynamic code from untrusted strings. Render plain text with text APIs; when rich content is required, use a maintained sanitizer for the actual language and downstream rendering context. Sanitizing HTML does not establish SVG, URL, script or spreadsheet safety.

For XML and object deserialization, disable unnecessary external resolution and unsafe type construction; restrict supported types and parser work. Where multiple components parse the same input, compare their accepted representation and boundaries. A front validator succeeding does not prove that a later parser reads the same message.

Failure evidence should show the representation at each boundary and the final sink, using safe synthetic values when possible. Fix the unsafe interface or parser configuration, then verify the permitted content and the rejected ambiguity. Preserve useful original data according to its storage contract; avoid storing context-escaped values that are later reused in a different interpreter.

## Browser authority

A browser-facing API retains browser-origin, cookie and CSRF concerns even when it returns JSON. Establish which origins may invoke or read each sensitive function, how credentials travel, and whether the operation changes state or consumes consequential resources.

| Surface | Engineering decision | Evidence and failure response |
| --- | --- | --- |
| Session cookies | Set transport, script-access, host/domain and cross-site behavior for the session's purpose; use supported framework mechanisms | Inspect actual cookie scope and browser transmission; excessive sharing requires narrower scope and a compatible session migration |
| CORS and CSRF | Validate allowed origins; choose and implement the applicable anti-forgery design. CORS response access alone is not authorization | If relying on preflight, ensure sensitive execution cannot also occur through a request that avoids it; otherwise enforce the selected token/header defense |
| State-changing endpoints | Choose methods consistent with side effects and maintain CSRF enforcement | Trace crawlers/prefetch or simple requests reaching mutation; correct both the method contract and the enforcement path |
| Rendering and embedding | Use content type, context-safe rendering, CSP and framing controls appropriate to actual content; define required-feature fallback | Inspect served responses and browser behavior, including missing features; tighten policy without silently breaking required login or embedded flows |
| Cross-window messaging and redirects | Validate message origin and structure; constrain external redirect destinations | A trusted page relaying unchecked data or a user-controlled destination requires validation before the effect, not a warning after navigation |

Refresh exact browser/header syntax and supported behavior before executable configuration. Policy presence or report-only output does not demonstrate blocking. Stage compatibility-sensitive policy changes with observable failure and a scoped rollback that preserves the essential security boundary.

When applying ASVS 5.0.0 specifically, retain the selected requirement's alternatives and levels: its L1 CSRF controls distinguish a non-preflight token/header defense from a design where sensitive execution always triggers preflight. Sensitive-method selection also has a strict fetch-metadata alternative; neither method choice nor SameSite alone establishes the complete defense. Browser requirements exclude genuine machine-to-machine systems, not browser-facing APIs. An L3 documented per-resource security decision for external client assets is an explicit alternative, not a waiver for unrelated controls. Read the exact requirement before implementing its cookie prefixes, CSP, framing or header obligations.

## HTTP, proxies, caches and long-lived channels

Inventory every reachable ingress, including direct origin routes. End users must not be able to forge trusted forwarding or identity headers. Make proxy and origin framing agree using the supported protocol stack; do not implement an ad hoc request-smuggling parser from a summary. Keep method, status, media type, variants, validators and partial-content state intact across intermediaries. Route detailed protocol contracts to `api-contract-engineering` and edge configuration to platform while retaining the application security claim.

When cache and origin behavior differ, collect per-hop request/response metadata, effective identity/tenant, cache key and variant, status and validator correspondence. Fix the inconsistent key or enforcement boundary, and invalidate affected stored responses under the service's change procedure. Authorization at cache fill time alone may not protect later reuse.

For GraphQL, bound query work using suitable depth, amount, allowlist or cost controls and enforce object/field authorization through nested resolvers. For WebSocket, protect the handshake transport and allowed origins, then enforce message authorization and session lifecycle over the connection. A valid handshake does not give unlimited lasting authority. Under the ASVS 5.0.0 L2 condition, dedicated connection tokens apply if standard session management cannot be used; obtain and validate them through the previously authenticated HTTPS session and preserve the required session lifecycle. For GraphQL's L2 production-introspection rule, the other-party API exception does not waive authorization.

## Outbound requests

Treat user-supplied URLs, callbacks, redirects and remote schema/reference resolution as outbound-request capabilities. Define allowed schemes, destinations, ports and resource classes, data allowed to leave, credentials attached, redirect policy, response bounds and timeout/retry budget. Reject deceptive or unsupported URI forms. Enforce restrictions at application, infrastructure, or combined layers that the request cannot bypass.

Inspect the actual destination and each redirect or resolution step rather than only the first input string. Coordinate address-resolution and internal-network controls with platform for the deployed runtime; a hostname allowlist alone is not evidence against every address-change or redirect path. Bound parsing, response size, decompression, concurrent fetches and total work. A blocked fetch must release resources without falling back to unrestricted access or disclosing credentials in errors.

## Upload, extraction, processing and delivery

1. Establish accepted file purposes/types, size and count quotas, processing budget, safe download behavior, and malicious-file response. Check content using suitable type detection or specialized parsers as well as expected extensions; include entries inside archives.
2. Before decompression, reject entries that violate declared uncompressed size/count policy; also enforce limits while streaming because metadata can be false. Bound total output bytes, entry count, recursion where supported, processing time and image dimensions. Release resources on limit failure.
3. Generate storage paths internally. Prevent path traversal and extraction outside the destination. Reject symlinks unless the feature requires them and the allowed targets and extraction semantics are established. Do not trust archive-provided paths or allow later processing to reinterpret them unsafely.
4. Keep untrusted files from executing as server code. Isolate risky processing with the minimum data, credentials and network authority. Apply scanning when required by the chosen policy or requirement; a clean scan does not prove parser or browser safety.
5. Authorize retrieval independently, use accurate content type and safe disposition/filename handling, and select attachment or isolated rendering where the threat demands it. Remove or govern sensitive metadata and copies under the data policy.
6. On rejection, prevent publication of partial or unverified output, clean up temporary resources according to the evidence-retention policy, and record a redacted reason and owner-action signal. After a fix, verify both extraction containment and actual browser delivery; extension checks alone cannot close the defect.

Under ASVS 5.0.0, the L2 upload-policy document is distinct from L1 acceptance checks; L2 broadens content checks to all accepted files, including archive contents. Pre-decompression uncompressed-size and file-count checks are L2; per-user quotas/file counts, symlink restrictions and image pixel bounds are L3. Local risk may justify applying them at a lower assurance target, but does not change their printed scoring levels. Its L1 path rule permits internally generated/trusted paths or strict validation and sanitization; the separate L3 processing rule ignores supplied paths. The L2 antivirus obligation for files from untrusted sources remains applicable even though a clean scan proves neither parser nor browser safety. These edition-specific scopes do not prohibit stronger local controls and do not establish conformance without the complete selected text.

For an application operating WebRTC infrastructure, identify owned TURN, media and signaling functions separately. A third-party SDK or browser-to-browser media path does not remove duties for TURN or signaling that the application still operates, and outsourcing does not prove provider security. The available WebRTC account is incomplete; obtain the applicable primary procedure before prescribing detailed checks.

Source basis: ASVS 5.0.0 representation, browser, API/message and file families; OWASP secure implementation and review guidance. Exact HTTP, browser and runtime behavior requires the primary specification and deployed-stack evidence; this is not a complete test procedure.
