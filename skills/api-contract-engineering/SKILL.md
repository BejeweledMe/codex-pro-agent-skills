---
name: api-contract-engineering
description: "Author, diagnose, and evolve HTTP API contracts: OpenAPI, schema/reference context, serialization, HTTP outcomes, errors, and provider/consumer compatibility. Use for contract artifacts and observable interoperability; system-design owns service boundaries."
---

# API Contract Engineering

Make the description, HTTP exchange, runtime validation, and consumers agree. A valid OpenAPI document, a successful request, and a compiling generated client establish different things.

## Working Approach

1. Identify the operation, intended observable behavior, affected consumers, and authoritative artifacts. Record the relevant contract and tool versions; distinguish intended behavior from observed behavior.
2. Establish the OpenAPI feature line, effective schema dialect and enforcement profile, and reference-resolution context. Do this before interpreting a schema change or normalizing documents.
3. Specify or inspect methods, statuses, media and serialization, error identity, preconditions, and retry behavior. Preserve originating request context when interpreting responses.
4. Compare the description, provider, intermediaries, runtime consumer, and generated projection. For a failure, locate the first layer that disagrees and repair that layer.
5. Evaluate compatibility in the deployment directions that matter. Deliver the concrete contract change or diagnosis, supporting evidence, unresolved combinations, and any migration or recovery steps. A proposed change needs an artifact diff; a diagnosis needs the first mismatch and a reproducing exchange; a compatibility verdict needs the relevant consumer evidence.

For a small operation edit, inspect the affected path and use focused fixtures. A broad inventory or migration matrix is justified when versions, consumers, reference layout, or tool behavior can diverge; it is not mandatory ceremony for every correction.

## References

Read only the material needed for the task.

- [Contract identity and OpenAPI context](references/contract-identity-and-openapi-context.md): authoring, dialect disagreement, annotations, references, relocation, and tool portability.
- [HTTP, media, errors, and retries](references/http-media-errors-and-retries.md): wire behavior, serialization, response dispatch, Problem Details, preconditions, retries, and intermediary seams.
- [Compatibility and consumer matrix](references/compatibility-consumer-matrix.md): directional compatibility, generated/runtime consumers, rollout order, deprecation, and recovery.
- [Validation, tooling, and targeted refresh](references/validation-tooling-and-targeted-refresh.md): minimal reproductions, layer-specific evidence, failure diagnosis, and version-sensitive questions.
- [Reference index](references/00_README.md): task routes and source coverage.

## Ownership

This skill owns HTTP contract artifacts and their observable compatibility, including selecting focused checks that establish agreement.

- `system-design` owns why a service boundary exists, domain promises, events, distributed guarantees, and general deadline/backoff/overload design. Pass operation identity, invariants, and the HTTP precondition/retry contract.
- `python-backend-engineering` and `node-typescript-backend-engineering` own handlers, domain execution, transactions, durable effects, and framework adapters. `web-frontend-engineering` owns browser adapters and UI behavior. Pass exact request/response fixtures, media and validation profiles, and the first observed mismatch.
- `application-security-engineering` owns OAuth/JWT and authorization control implementation. Security declarations describe an interface; they do not prove enforcement. Pass the declared security profile, affected consumers, and rejection or acceptance evidence.
- `qa-testing` owns the general test portfolio, environments, and quality gates. Supply the contract risks, relevant version combinations, fixtures, and expected observable outcomes.
- `platform-devops-engineering` owns gateway, proxy, and CDN configuration and apply. Pass origin semantics, representation/validator correspondence, header fidelity, and the observed intermediary change.
- `software-engineering` owns broader codebase migration and release discipline; `technical-writing` owns documentation structure when the technical behavior is already established.
- Data-product shape, quality, freshness, and lineage belong to `data-engineering`; the word “contract” alone does not route them here.

Use named handoffs only when another decision is needed. This skill does not require loading every adjacent owner.

## Evidence Bar

- Do not certify runtime compatibility from meta-schema validation, generated-code stability, or version numbering.
- Distinguish standard requirements, implementation-defined behavior, local policy, and observed tool behavior.
- Preserve protocol tolerance where specified without weakening business validation or security controls.
- State what was checked and what remains unknown. An untested consumer or unsupported feature is not a passing result.
