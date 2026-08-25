# Security And Multitenancy

## Start With Assets And Trust Boundaries

Identify:

- Sensitive assets, critical operations, identities, tenants, and administrators.
- Entry points, trust boundaries, third parties, and data flows.
- Likely attacker goals and abuse cases.
- Required confidentiality, integrity, availability, audit, residency, and deletion behavior.
- Who can grant access, rotate credentials, inspect audit records, and respond to compromise.

Apply controls according to risk. A checklist without a threat model can miss the most important path.

## Identity And Authorization

- Authenticate users, services, jobs, and operators with distinct identities.
- Authorize every sensitive action at the trusted boundary; do not rely only on hidden UI controls.
- Prefer least privilege, short-lived credentials, scoped tokens, and explicit service-to-service policy.
- Separate authentication from authorization and business policy.
- Make tenant and subject context explicit through every internal hop.
- Audit privileged and high-impact actions with tamper-resistant retention.
- Design emergency access with approval, expiry, logging, and review.

## Data Protection

- Encrypt sensitive data in transit and at rest where the threat model requires it.
- Keep secrets out of source, images, logs, traces, and user-visible errors.
- Use managed rotation or a documented rotation path; test that rotation does not require downtime.
- Minimize collected data and retain it only as long as needed.
- Classify fields and enforce masking, access, export, deletion, and residency rules.
- Protect backups, replicas, caches, search indexes, exports, and observability data to the same standard as the source.

## Tenant Isolation

Choose the isolation level deliberately:

- Shared tables with tenant keys are efficient but demand pervasive authorization and indexing discipline.
- Separate schemas or databases increase isolation while adding provisioning and migration cost.
- Separate accounts or clusters provide stronger blast-radius and regulatory isolation at higher operational cost.

For every shared resource enforce tenant-aware keys, queries, cache keys, quotas, encryption context, logs, metrics, jobs, exports, and backups. Test cross-tenant access as an invariant, not as an ordinary feature case.

## Input, Output, And Abuse Controls

- Validate type, size, range, encoding, and schema at trust boundaries.
- Bound decompression, parsing, recursion, fan-out, query complexity, file processing, and generated work.
- Use rate limits, quotas, concurrency limits, and cost controls per identity and tenant.
- Protect idempotency and replay tokens from guessing or cross-tenant reuse.
- Avoid exposing internal identifiers, stack traces, credentials, or sensitive existence checks.
- Treat webhooks, callbacks, redirects, uploads, and server-side fetches as explicit trust boundaries.

## Supply Chain And Operations

- Minimize and inventory dependencies; verify origin, update path, licensing, and vulnerability response.
- Build reproducibly and protect artifact integrity and deployment authority.
- Separate production access from ordinary development access.
- Log security-relevant changes and monitor authentication, authorization failures, privilege changes, secret use, and unusual data access.
- Include security rollback, key revocation, credential rotation, and evidence preservation in incident plans.

## Review Questions

- What is the most valuable asset and shortest path to it?
- Where is authorization enforced, and can any internal caller bypass it?
- Can tenant context be lost in a queue, cache, batch job, or administrative path?
- Which data copies escape retention or deletion?
- Can one request create unbounded work or cost?
- Can credentials and keys be rotated during an incident?
- Are recovery systems and operator tools protected as strongly as the primary path?
