# Compatibility and Consumer Matrix

Use for API evolution, description upgrades, schema relocation, validation hardening, and generator changes. Compatibility is a relation between concrete producers and consumers under a profile, not a property of a version label.

## Classify the Change

Inspect independent axes: OAS feature line; dialect/vocabularies/assertion policy; reference identity and base; parameter serialization; media and stream mode; method/status/precondition/validator/retry behavior; error identity; security profile; generated artifact and runtime decoder configuration.

Mark each affected axis as unchanged, compatible under named assumptions, breaking for identified consumers, or unknown. “Additive” describes an edit, not its consequences.

| Change | Why compatibility can fail | Distinguishing evidence |
| --- | --- | --- |
| New required request field | Existing clients omit it | Old request fixtures against the new provider |
| New optional request field | New clients send it to old providers that reject or ignore it | New-client behavior against old-provider validation and effect semantics |
| Added response field or enum value | Closed decoders or exhaustive dispatch reject it | Old runtime consumers reading new responses |
| Response field becomes optional | Clients require its presence | Responses with the field absent through existing decoders |
| Annotation becomes enforced | Previously accepted values are rejected without a shape change | Same instances under both enforcement profiles |
| Schema moves or is bundled | Base, target, dialect, or implicit scope changes | Resolved-reference comparison plus discriminating instances |
| Media/status/stream behavior changes | Parser or dispatch changes despite stable model types | Exact exchange through runtime consumers |
| Problem extension or localization changes | Client branches on prose or rejects unknown members | Old error adapter with changed extension/text |
| Validator or retry behavior changes | Replay, concurrent writes, or intermediary reuse changes | Conditional and lost-response cases with observed effects |
| Security profile tightens | Previously accepted integrations are rejected | Security-owner evidence plus consumer remediation status |

Preserve field meaning, omission/default behavior, and observable errors even when a structural diff reports no break. Unknown consumers remain a limit on the verdict.

## Build the Directional Matrix

A consumer both sends requests and receives responses. Check both directions within each applicable pairing.

| Provider | Consumer | Purpose |
| --- | --- | --- |
| Old | Old | Establish the observed baseline |
| New | Old | Prove existing clients survive provider rollout |
| Old | New | Prove client-first rollout or provider rollback remains usable |
| New | New | Prove the intended contract works together |

For each relevant cell, identify the operation/media, provider version, consumer artifact/runtime, resolver/validator profile, intermediary configuration, fixture, and result. Use pass, fail with cause, untested, or not applicable with a reason.

Do not multiply every combination mechanically. Exercise combinations that will coexist or are part of recovery, and explain exclusions. Add a gateway/cache dimension when its behavior can change the result.

Discover real consumers from available client code, dependency declarations, access evidence, and owner records. A generated SDK repository alone is not the consumer population.

## Compare Generated and Runtime Consumption

Treat generation as compilation: identify source documents, resolver/bundler behavior, generator version/options, and validation profile. Preserve these inputs when explaining an output change.

Inspect this pipeline at the first disagreement:

`description → reference/dialect resolution → request serialization → HTTP exchange → response dispatch → decode → runtime validation → application projection`

Keep originating method, actual status, matched response entry, selected media, and whole-content/per-item mode available until the relevant processing completes. In the declared OAS response map, an explicit status entry takes precedence over a matching range entry; retain any applicable `default` mapping separately from HTTP class fallback. A response description selects documented body interpretation; class fallback supplies generic HTTP semantics. If tools compose these differently, reproduce that exact dispatch case rather than infer precedence from a generated union.

Distinguish at least:

- Transport failure with no usable response.
- Valid HTTP response without a documented typed mapping.
- Unsupported or mismatched media.
- Body decoding failure.
- Schema/profile rejection after decoding.
- Security rejection.
- Successful typed consumption.

An unknown status needs class-aware handling, but class fallback does not supply an undocumented body schema. Retain enough raw context for a generic outcome without silently casting the body to a success type.

In frameworks with type providers, inspect inference, request validation, and response serialization as separate configured layers. A custom body parser can succeed without the expected schema validator running; a serializer may transform or omit fields without proving every schema assertion. Compare actual media routing, validator invocation, and emitted bytes before changing generated types. Do not infer runtime validation from a compiler or serializer name. Framework setup and lifecycle fixes belong to the backend or frontend owner.

Defaults also need separate evidence: a schema default does not by itself instruct a client to insert that value into outbound requests. Check the declared omission behavior and actual provider behavior; distinguish it from a server-variable default used to construct a URL.

## Stage the Migration

1. Capture baseline behavior and the affected consumer matrix.
2. Introduce the compatible shape or adapter where possible. Determine rollout order from the matrix rather than assuming provider-first or client-first is always safe.
3. Verify required mixed-version cells before moving traffic or consumers to the candidate.
4. Observe adoption and contract failures by operation and consumer version: undocumented statuses, media/decode/schema failures, changed error dispatch, precondition outcomes, and duplicate effects where relevant.
5. Stop rollout on the specified incompatible outcome. Restore the compatible artifact/profile or use a prepared forward correction.
6. Remove old fields, endpoints, adapters, or tolerant paths only after the agreed support window and consumer evidence justify cleanup. Assign the remaining migration owner.

Rollback must account for new clients still deployed and requests already accepted. Restoring an old description does not undo effects or make an old provider understand new requests. If a rollback cell fails, retain the compatibility layer or choose a forward repair with the execution owner.

For security hardening, let the security owner define acceptable enforcement and recovery. Compatibility work supplies affected clients and remediation evidence; it must not silently weaken controls to turn a matrix cell green.

## Example: Rename a Response Field

Replacing `displayName` with `name` keeps both values as strings but can break old decoders and callers. First characterize existing consumers’ behavior on unknown and missing fields. If they tolerate the new field, a provider that emits both names can support the old consumer while the new consumer reads `name` with a `displayName` fallback. Verify that fallback against the old provider so rollback remains possible. If an old consumer rejects the added field, dual emission is already breaking and needs a different version or adapter strategy.

Only remove `displayName` after the support window and consumer evidence allow it; only remove the new consumer’s fallback when provider rollback no longer needs it. This is an engineering example: the actual matrix decides whether the staged shape is usable.

## Report the Verdict

State the concrete change, affected consumers and axes, checked combinations, observed failures, rollout/recovery constraints, and unresolved evidence. Separate contract correctness from tool support and consumer compatibility. Do not infer service or SDK compatibility from an OAS patch version or unchanged generated code.
