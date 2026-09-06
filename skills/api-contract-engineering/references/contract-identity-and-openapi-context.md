# Contract Identity and OpenAPI Context

Use for new operations, description upgrades, schema interpretation, multi-document contracts, and resolver or generator disagreement.

## Establish the Identity

Record the affected portion of this identity in the existing task notes or review; a new manifest is unnecessary.

| Dimension | Capture | Why it changes the decision |
| --- | --- | --- |
| Operation | Provider, consumers, server/target URI, method/path, operation identifier, intended effect | Similar payloads can represent different obligations |
| Description | Exact document revision, `openapi`, `info.version`, entry document | Specification feature selection and API version are different |
| Schema | Resource roots, `$schema`, `jsonSchemaDialect`, vocabularies, enforcement settings | Identical keywords can be interpreted or enforced differently |
| References | Containing document, document base, `$self` where supported, nearest `$id`, expected target object | Relocation can change the resolved resource |
| Wire | Parameter locations, serialization, media types, content encoding, whole-content or per-item mode | Schema shape alone does not select a parser or serializer |
| Execution | Provider, gateway, parser, resolver, bundler, validator, generator and configuration versions | Different participants can accept different subsets |
| Consumers | Runtime decoder, generated artifact, fallback behavior, deployed versions | Compilation does not prove runtime acceptance |

Keep credentials and private payload contents out of this record.

## Author the Operation

Start from the intended effect and observable outcomes. Define its path and method, parameter locations, body media, success/error responses, and applicable security declarations. Carry existing pagination, limits, defaults, and concurrency promises into the artifact when they affect this operation.

Check the declared OpenAPI edition's prose as well as its structural schema:

- `openapi` selects specification features; `info.version` does not configure a parser.
- Concrete paths take precedence over templated paths. Do not declare equivalent templates distinguished only by variable names.
- Match path expressions to path parameters, accounting for the specification's permitted empty Path Item exception.
- Distinguish a server-variable default inserted into a URL from a schema default describing receiver behavior. A schema annotation alone does not establish runtime insertion.
- Check that referenced operations and objects resolve unambiguously in their actual document context. Where a Link Object identifies an operation, use the edition’s `operationRef`/`operationId` rule and resolve the target uniquely; an explicit reference can avoid ambiguous implicit names.
- Make examples agree with both the schema and the encoded representation. An in-memory object is not evidence for its query or multipart encoding.

OpenAPI prose takes precedence over its informational hosted JSON Schema. A structural pass can miss prose constraints; a tool rejection can also reflect unsupported features rather than an invalid contract.

## Resolve Dialect and Enforcement

For OAS 3.1+ Schema Object contexts, determine the effective dialect from the schema resource's root `$schema`, then the applicable document's `jsonSchemaDialect`, then that OAS edition's dialect fallback. Track this per resource. Do not silently apply these rules to an older OAS schema model.

Record required vocabulary support separately from the dialect URI. A tool that silently substitutes its preferred dialect has changed the contract.

In the evidenced OAS default context, `format`, `contentMediaType`, `contentEncoding`, `contentSchema`, `readOnly`, and `writeOnly` are annotations rather than universal rejection rules. Identify whether each is documentation, generator input, or explicitly enforced runtime policy, including request/response direction. If an invalid format passes, inspect the enforcement profile before weakening or rewriting the schema.

A discriminator assists processing; it does not change which instances satisfy the schema. Verify the complete schema independently of dispatch; a mapped subtype passing does not prove the enclosing composition passes. In the selected OAS 3.2 rules an optional discriminating property requires `defaultMapping`. That feature needs its declared feature line and participating tool support; do not backport it by assumption.

Classify a disputed construct as:

- **Portable within the supported profile:** the applicable standard defines the behavior and the required tools demonstrate it.
- **Implementation-defined:** each participating implementation's choice is documented and verified. This may work in a controlled toolchain while remaining unsuitable for unknown consumers.
- **Specified but unsupported:** the document can be valid while a required tool lacks the feature. Choose a supported representation, deliberately change the toolchain, or leave that compatibility claim unresolved.
- **Undefined:** there is no specified behavior to rely on. Remove the dependency on undefined behavior; several tools agreeing does not make it portable.

For implementation-defined constructs, document the relevant choices of each participating tool and verify agreement. Unknown behavior on an unrelated feature is not a reason to reject the whole toolchain.

## Preserve Reference Meaning

Do not parse a referenced fragment as a standalone document and discard its ancestors. OAS 3.1+ interpretation depends on document context, and schema references can depend on base-changing keywords.

For relocation, bundling, or inlining:

1. Resolve references from the original entry and containing documents. Record the effective base, nearest `$id`, dialect, and expected OAS object type at the affected edges.
2. Resolve the candidate from its real entry document using the same explicit tool profile.
3. Compare target resources and meaning, not merely pointer strings or generated type names. Check implicit component, security-scheme, discriminator, and tag connections when multi-document scope changes.
4. Exercise instances through the original and candidate resolution paths. Preserve a negative instance that distinguishes plausible alternative targets.
5. If meaning changes unintentionally, restore the context or identity, revise the relocation, or retain the original layout. Repeat the affected reference and runtime checks.

For example, moving a schema that contains `$ref: "./money.json"` beneath a different base can select a different resource even if both targets generate the same type name. Compare the resolved absolute targets and validation outcomes. Rewriting the text to “look local” is insufficient.

`$self` is feature-line dependent, and OAS Reference Objects and Schema Objects must be interpreted according to their respective rules. This procedure identifies context changes; it is not a general JSON Schema bundling algorithm. Refresh exact applicator, `$dynamicRef`, or compound-schema semantics when they determine the result.

## Source Basis

[OpenAPI Specification 3.2.0](https://spec.openapis.org/oas/v3.2.0.html): OpenAPI Object, Paths and Parameter Objects, Schema Object dialects, Discriminator Object, and relative-reference/document-context rules. Apply the declared edition; the deeper feature examples here use the 3.2 context.
