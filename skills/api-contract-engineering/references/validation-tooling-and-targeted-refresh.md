# Validation, Tooling, and Targeted Refresh

Use to select the smallest useful evidence, diagnose disagreement, and resolve version-sensitive claims.

## Establish Evidence by Layer

Prefer existing project tools and authorized environments for focused checks. Add tooling only when it is necessary to deliver the requested outcome; a contract review alone does not require a new framework.

| Layer | Focused check | What success does not prove |
| --- | --- | --- |
| OAS structure and prose | Parse the exact document; inspect applicable prose constraints | Runtime implementation or full conformance |
| References and dialect | Resolve from the actual entry; compare bases, targets, dialects, and supported vocabularies | Correct serialization |
| Assertion profile | Valid and invalid instances under the configured validator and direction | Media routing or domain execution |
| Serialization | Logical values against exact request/response bytes by location and media | HTTP outcome or retry safety |
| HTTP/intermediaries | Method/status/body rules, conditions, fields, and affected proxy/cache behavior | All consumer projections |
| Problem Details | Stable type dispatch, origin status agreement, intermediary differences, unknown extensions, wrong-typed members, localization | Authentication or authorization correctness |
| Runtime/generated client | Dispatch, decode, validation, fallback, and streaming behavior | Untested client versions |
| Migration | Relevant old/new provider-consumer combinations | Unknown consumers or complete standards certification |

Select checks for the changed behavior and credible failure modes. The general QA portfolio and gate placement remain with `qa-testing`.

## Compare the Relevant Tool Capabilities

For each tool involved in the discrepancy, capture its exact version/configuration, supported OAS line and schema dialect, enabled vocabularies, annotation enforcement, reference-loading policy, and bundling behavior. Record implementation-defined choices only for features the contract uses.

Feed the same affected entry document and discriminating instances through the competing paths. Compare resolved targets, effective schema profiles, accepted/rejected instances, serialization, and generated output as separate observations. A normative feature that a tool does not support is a tool capability gap; an undefined dependency is a contract defect. Documented implementation-defined behavior is usable only while the relevant participants are verified to agree.

Choose the correction from that distinction: repair an invalid document, preserve a supported representation, align the intended profile, or deliberately change a participating tool. Then repeat the formerly disagreeing case; silent fallback is not agreement.

## Create a Minimal Reproduction

Capture the affected entry document and referenced resources, exact tool versions/configuration, method/target, status and relevant headers, redacted payload or synthetic bytes, expected behavior, and observed behavior.

Reduce the case without removing base URI, `$id`, dialect, parameter location, request method, or intermediary context that could cause the failure. Record stage-specific outcomes instead of one “decode error.”

| Symptom | First discriminating check | Correction and verification |
| --- | --- | --- |
| Meta-schema passes; gateway rejects | Applicable OAS prose versus gateway feature support | Correct the artifact or choose supported syntax; repeat both checks |
| Same instance passes one validator | Effective dialect, vocabularies, annotation enforcement | Align the intended profile; repeat positive and negative instances |
| Bundling changes validation | Original/candidate targets and resource contexts | Restore semantic identity or layout; repeat reference and runtime fixtures |
| Types unchanged; runtime breaks | Media, serialization, reference context, profile, generator inputs | Repair the first changed layer; repeat the affected matrix cells |
| HEAD produces JSON parse failure | Whether originating method survived dispatch | Fix the adapter's body decision; verify HEAD separately from GET |
| Streaming buffers until completion | Whole-content versus per-item validation and framing | Use supported bounded processing; verify early delivery and bounded behavior |
| Added error member breaks clients | Unknown-field policy and problem-type dispatch | Restore RFC 9457 tolerance in the consumer; verify old/new error cases |
| Error body and received status disagree | Origin status/body pair versus intermediary response | Fix the stage that changed the outcome incorrectly; verify origin and client paths without overriding HTTP dispatch |
| Duplicate effect after retry | Retrying actor, first-attempt outcome, identity reuse | Correct replay policy or durable effect handling; verify lost-response behavior |
| Wrong media bypasses validation | Parser routing versus validator coverage | Align the contract and adapter; verify supported and rejected media |
| Valid signature grants wrong access | Token purpose/profile and authorization decision | Hand to AppSec with the accepted request and rejection gap; verify the corrected control there |

Keep credentials, cookies, bearer material, and unnecessary personal data out of fixtures and diagnostics. External reference loading is a trust boundary; use controlled inputs and the project's permitted resolver behavior.

After correction, repeat the failing fixture and the neighboring behavior that could regress. If the source or environment needed to decide is unavailable, state the exact missing evidence and a bounded next check; do not label an assumption as a pass.

For a rollout, track the signals that distinguish its risk: undocumented status handling, media/decode/profile failures, problem-type dispatch, precondition results, duplicate effects, or partial/variant failures. Segment by affected operation and consumer version where useful; identify the observation window and traffic/fixture denominator. A zero count without the relevant traffic is not evidence of compatibility. Consumer adoption and cleanup evidence close the migration.

## Targeted Refresh

Start with the project's declared versions, local configuration, and available authoritative documentation. When external lookup is permitted and needed, retrieve the exact standard section or official tool documentation for the disputed mechanism. Record the version, clause or behavior, and distinguishing fixture. If lookup is unavailable, preserve the uncertainty and complete the supported work.

| Trigger | Refresh precisely |
| --- | --- |
| OAS feature-line upgrade or cross-tool disagreement | Relevant OpenAPI prose, feature availability, and parser/gateway/generator support |
| Dialect/vocabulary change or schema relocation | Schema resource/base rules and the exact constructs used; general `$dynamicRef`, `unevaluated*`, applicator, and bundling behavior is not established here |
| `format`, content, or directional annotation starts rejecting data | Validator vocabulary and enforcement settings, including framework-specific behavior |
| Stream or new media type is introduced | OAS feature support, media framing, parser dispatch, incremental validation, and failure behavior |
| Range, cache, or proxy behavior determines correctness | Relevant RFC 9110/9111 clauses and actual intermediary configuration; include storage/reuse predicates, authenticated caching, freshness, or `Vary` only as needed |
| Successful PUT validator behavior matters | The complete applicable HTTP condition; do not infer it from a partial rule |
| Authentication status/challenge policy changes | Complete applicable HTTP and security-profile requirements; no universal 401/403 recipe is supplied here |
| OAuth/JWT hardening affects clients | Security-owner guidance for the selected client/token profile, including any required lifetime, claims, discovery, rotation, or revocation rules |
| Generator output changes unexpectedly | Actual generator/resolver/configuration changes and runtime evidence; language typing, packaging, and SDK semver require their own sources |
| Problem member or intermediary behavior changes | Exact RFC 9457 member and security-consideration clauses, plus origin/client evidence; the title/detail distinction here does not establish every Problem Details profile |

## Coverage Limits

These references provide selected OpenAPI and HTTP mechanisms and partial caching, Problem Details, and security-boundary guidance. They do not establish exhaustive Draft 2020-12 semantics, RFC 9111 conformance, OAuth/JWT profiles, TypeScript semantics, or current vendor support.

A standards edition and an implementation's support for it are separate facts. Examples using OAS 3.2 features are not evidence that every deployed tool supports them. A passing fixture proves the observed case under its recorded configuration, not the whole protocol.
