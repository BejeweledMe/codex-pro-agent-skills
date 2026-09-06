# API Contract Reference Index

Choose the reference by the unresolved decision.

| Task | Read | Useful result |
| --- | --- | --- |
| Author an operation or diagnose OpenAPI tool disagreement | [Contract identity and OpenAPI context](contract-identity-and-openapi-context.md) | Operation definition, effective dialect/profile, reference context, and portability decision |
| Fix serialization, status handling, errors, duplicate retries, or request-dependent responses | [HTTP, media, errors, and retries](http-media-errors-and-retries.md) | Explicit wire behavior and a fixture distinguishing the failure |
| Decide whether a change can ship across existing consumers | [Compatibility and consumer matrix](compatibility-consumer-matrix.md) | Directional verdict, rollout order, and recovery conditions |
| Select evidence or investigate a validator/generator/runtime discrepancy | [Validation, tooling, and targeted refresh](validation-tooling-and-targeted-refresh.md) | Minimal reproduction, first disagreeing layer, correction, and verification limit |

These references cover HTTP contract engineering, not a complete JSON Schema evaluator, cache implementation, OAuth/JWT implementation, or SDK language manual.

## Source Orientation

The source basis is selected sections of the [OpenAPI Specification 3.2.0](https://spec.openapis.org/oas/v3.2.0.html) on documents, Schema Objects, references, media, and discriminators; [RFC 9110, HTTP Semantics](https://www.rfc-editor.org/rfc/rfc9110.html) on methods, status, fields, and conditions; [RFC 9111, HTTP Caching](https://www.rfc-editor.org/rfc/rfc9111.html) on intermediary and partial-response correspondence; and [RFC 9457, Problem Details for HTTP APIs](https://www.rfc-editor.org/rfc/rfc9457.html), especially sections 3 and 4, on members, identity, and extensions.

[RFC 9700, Best Current Practice for OAuth 2.0 Security](https://www.rfc-editor.org/rfc/rfc9700.html), and [RFC 8725, JSON Web Token Best Current Practices](https://www.rfc-editor.org/rfc/rfc8725.html), establish why declared security schemes, token acceptance, and authorization need separate evidence. Detailed control choices belong to application security.

The workflows and compatibility tables are engineering guidance, not a standards certification suite. Apply clauses for the declared specification edition and actual tool profile. Detailed limits and refresh triggers are in [validation and targeted refresh](validation-tooling-and-targeted-refresh.md).
