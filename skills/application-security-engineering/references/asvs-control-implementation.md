# ASVS Control Implementation

Use this track when adopting requirements or repairing a mapped control. ASVS 5.0.0 is a versioned verification baseline, not a complete threat model or proof about the deployed system. A threat may justify stronger local controls; label those local decisions without changing a requirement's level or wording.

## Select and interpret the requirement

Establish application scope, relevant interfaces/dependencies, selected edition and assurance target. Levels are cumulative over applicable requirements; choosing an isolated higher-level control does not establish whole-level conformance. Include an intermediary when it performs relevant application functions, even if platform operates it.

For each affected requirement, read the complete primary row and relevant supporting text. Preserve its actor, technology gate, base level, embedded conditions, modal language, alternatives and exceptions. Do not infer exact IDs, wording or levels from a family heading, adjacent row or migration number. Quote IDs with a complete version only after verifying the mapping.

The available 5.0.0 basis has unresolved wording in parts of authentication and uneven detailed coverage of secure architecture, logging and WebRTC. Preserve family-level control reasoning, but acquire the exact row before scoring it or prescribing its specific obligation. Do not turn those gaps into a claim that the standard lacks those subjects.

Distinguish required behavior, supporting guidance and local engineering choice. A documented risk decision cannot waive an explicit requirement unless that requirement permits the alternative. Non-applicable, not examined, failed, and risk-accepted are different states.

## Translate into an implementation obligation

Pair the application-specific decision with its enforcement point and evidence. Use the team's existing records; a separate document for every control is unnecessary.

| Decision | Implementation/evidence partner |
| --- | --- |
| Expected inputs, related-value rules and business limits | Trusted validation, actual aggregate limits and correct final transaction state |
| Authentication/recovery paths and required assurance | Every enabled path and its proofing, re-binding and protected-action behavior |
| Session lifetime and termination policy | Issuance and each validator's expiry/revocation behavior, including federation |
| Function/object/field/context permissions | Originating-subject decisions at reachable trusted paths, including tenant/state transitions |
| Crypto/key-use policy | Actual holders and permitted operations, current parameters, rotation/replacement and re-encryption capability |
| Data class, recipients, retention and log policy | Actual data flows, copies, output fields, cleanup and event-store access |
| Dependency remediation policy | Corresponding deployed versions and installed remediation within the chosen window |
| External resource limits and secure degradation | Enforced concurrency/timeouts/retries, resource release and behavior on failed security checks |

A document can match an unsafe decision; correct implementation of it alone does not establish adequacy. Conversely, one successful sample cannot establish that the complete documented policy is implemented.

## Crypto, transport and configuration mechanisms

Select the required property before the API: confidentiality, ciphertext integrity, message authentication, peer identity, randomness and custody need different evidence. Use reviewed libraries with constrained choices; do not implement primitives or select algorithms from a dated appendix. Cryptographic-use details and key recovery are also routed through [credential and recovery controls](credential-and-recovery-controls.md).

Preserve these ASVS 5.0.0 distinctions when the corresponding requirements are selected:

- Approved cipher/mode selection at L1 is not a mandate for AES-GCM specifically. Ciphertext integrity is a distinct L2 obligation; L3 nonce/IV uniqueness and encrypt-then-MAC conditions are separate. Establish algorithm-specific nonce behavior under concurrency and restore; approval of an algorithm does not prove correct composition.
- Password hashing and deriving an encryption key from a password are different KDF contexts. Refresh the current parameters for that use. Entropy, key size, hash-output length, strength and approval status cannot substitute for one another.
- L2 replacement/reconfiguration and re-encryption capability extends to existing data and consumers. L3 constant-time behavior and safe crypto-module errors address additional side channels; they do not imply a universal FIPS-only implementation requirement.
- L1 external-facing TLS/no-insecure-fallback and L2 inbound/outbound encrypted protocols and consumer certificate validation describe different scopes. Inspect actual clients, including monitoring, management, database, partner and internal calls. Trust specific internal CAs or specific self-signed certificates; accepting arbitrary certificates defeats the identity claim. Validate mTLS certificates before using their identity.
- Forward-secrecy-only cipher suites are an embedded L3 condition. Current recommended TLS versions and suites require a current primary source; a source-era version list cannot satisfy “latest.” A service mesh is one possible mechanism, not mandatory architecture.
- L2 secret lifecycle management and absence from source/build artifacts are distinct from L3 hardware-backed custody and confinement of all cryptographic operations so keys do not leave the isolated module. A vault or HSM inventory does not prove confinement. L3 data-in-use memory protection is also different from disk encryption; feasibility and deployed evidence remain necessary.
- L1 source-control metadata must be absent or inaccessible externally and to the application itself. L2 production-debug, directory-listing, TRACE and unintended internal/monitoring/documentation exposure controls need inspection of the running surface, preserving explicit intended-use exceptions where supplied. Hiding backend versions is a separate L3 measure and does not substitute for patching.

A compact diagnostic record can distinguish a wrong primitive/property from wrong use, wrong holder, wrong peer trust or a stale deployed configuration. For example, a good edge TLS result leaves internal client trust untested; a key rotation that changes new writes leaves old ciphertext and old verifiers untested. Route platform custody/PKI mechanics to their owner and retain application evidence of the intended effect.

## Follow meaning through every copy

Classify data by sensitivity, permitted purpose and recipient, not by whether it is encoded or encrypted. Base64 content, readable JWT claims, identifiers, relationships, file metadata and derived results can remain sensitive. For the changed feature, follow source records through caches, search indexes, queues, exports, third parties, browser state, backups, logs and traces.

For each relevant copy, identify allowed readers, minimum fields, transport and at-rest protection, retention/deletion behavior and an owner. Return only the fields authorized and needed for the operation. A response schema or mass-assignment allowlist should distinguish readable, writable and server-owned fields; an object's permission does not automatically permit every field transformation.

| Failure | Evidence that distinguishes it | Corrective action and verification |
| --- | --- | --- |
| Logs or trackers receive protected data | Actual fields and destinations, including query strings, error paths and analytics hooks | Remove or redact at the producing boundary; inspect downstream copies and apply authorized retention/cleanup actions |
| One user's response appears for another tenant | Effective caller, cache key, response variant and stored authorization assumptions | Repair tenant/identity scoping and cache admission; invalidate affected entries and verify isolated reuse |
| Logout leaves private information visible | DOM/browser storage and back-navigation behavior with server unavailable | Clear authenticated client state as part of termination; verify offline behavior separately from server invalidation |
| A retention job reports success but copies survive | Copy inventory, deletion propagation and restored backup behavior | Define and implement deletion across the applicable copies; reconcile after restore and report unavoidable limits |
| Supposed anonymization permits linkage | Combined releases, auxiliary information and allowed queries | Reduce release or use controlled analysis; route statistical disclosure to a qualified specialist |

Avoid transporting credentials or sensitive values in URLs that can enter browser history, referrers or intermediary logs. Browser anti-caching headers, storage restrictions and explicit client cleanup are separate controls. Retention duration, deletion exceptions, consent, residency and legal rights require the applicable product/privacy authority; this skill does not invent a lawful schedule.

Under ASVS 5.0.0, L2 classification and per-class documentation pair with implementation across every applicable copy. Classification labels are not ASVS levels. The L2 sensitive server-cache rule permits no caching or secure purge after use; its browser no-store and storage restrictions remain separate. The browser-store exception for session tokens does not make them non-sensitive or waive cleanup. Client-data clearing on termination, including offline behavior, is L1. L3 minimization/masking, scheduled deletion and file-metadata conditions add their own scope; record the actual retention/consent basis instead of deriving it from the level.

## Make security events actionable

Choose events tied to decisions: authentication and recovery, authorization outcomes appropriate to the requirement, privileged changes, secret use, control failures, abnormal resource limits and containment. Specify what event means, who acts, and within what harm window. Collect enough protected context to correlate actor, operation, target, time, policy/version and result without storing credentials or unnecessary payloads.

For an ASVS 5.0.0 implementation, preserve the L2 failed-authorization versus L3 all-authorization-event distinction, including sensitive access without recording the sensitive data itself. Several other logging/error-handling base levels are not established by the available account; do not infer them from this known clause. Per-layer event inventories, trustworthy timestamps with explicit time context and correlatable destinations support investigation, but do not establish a detection service.

Use structured encoding to prevent log injection; restrict read/write access and protect integrity. Where application compromise is in the threat model, use a logically separate evidence destination and identify which authority could still alter both. Log access, retention and authorized deletion remain data controls; tamper protection does not require keeping everything forever.

Failure policy matters. Decide what the application does when emission, storage, correlation or alert delivery fails. Bound queues and resource use, expose loss/backpressure to an owner, and preserve the operation's minimum security posture. Do not silently invent fail-open authorization to preserve availability, or assert that every logging outage must stop all functions.

To evaluate detection, follow an event to the staffed action, not just a dashboard. Inspect time quality, correlation, access, capacity, triage ownership and intervention latency. More alerts can reduce useful response under overload. Use denominators tied to relevant operations or high-consequence paths and the actual harm window; raw event or finding counts are not security outcomes.

## Incident and recovery handoff

Provide SRE/incident owners with event semantics, affected identities/data copies, preservation constraints, containment capabilities and the surviving recovery basis. They coordinate live response; application engineering repairs the control and verifies the resulting behavior. Separate containment of ongoing exposure, restoration of trusted state, and affected-party remedy. A restored service does not prove that evidence is trustworthy or disclosed information has been recalled.

Refresh protection and event choices when a new data destination, support path, detector capacity, incident or restore behavior changes the claim. Verify that the implemented data policy matches actual output; one redacted example cannot establish coverage of every error and copy.

## Evidence and remediation closure

Choose evidence that can disconfirm the specific claim. Source/configuration inspection establishes where enforcement is intended; an observed negative case establishes behavior for its tested conditions; deployment identity establishes which candidate those observations describe. Scans, screenshots, signatures, inventories and green pipelines each cover narrower properties.

For a defect, record the violating path, relevant authority/state, failed assumption and consequence. Fix the enforcement mechanism, preserve a regression that distinguishes the defect, and inspect related paths sharing that cause. Verify permitted behavior too, especially recovery and support routes that could otherwise lock out legitimate users. Execute only checks within the user's established scope and testing authorization.

Keep finding closure separate from broad release acceptance. For each material claim, retain requirement/version or threat, scope/applicability, implementation, method, observed result, evidence identity/age, limitations, owner and refresh trigger. Mark missing observations as unverified. Do not report a proposed procedure as an executed test or a self-check as independent corroboration.

Use `security-review` when a fresh assessment is requested. Pass the model, changed paths, evidence, exclusions, methods and unresolved harm; the reviewer challenges the claim and communicates its limits. AppSec remains responsible for the fix, and the designated product/risk authority accepts residual exposure. ASVS alignment does not confer OWASP certification or endorsement.

Source basis: [OWASP ASVS 5.0.0](https://owasp.org/www-project-application-security-verification-standard/), verification model, levels, applicability and documentation/enforcement requirements; OWASP Secure Code Review Cheat Sheet; *Security Engineering, Third Edition*, bounded assurance and lifetime maintenance.

## Edition limits and refresh triggers

The available 5.0.0 account does not independently verify every row. Authentication row splits and permitted single-factor combinations, some challenge-response wording, exact OIDC logout event names and response-choice terminology, and many secure-coding/logging/WebRTC row mappings remain incomplete or disputed. Its dated crypto appendix also has conflicting strength/output/status accounts and suspect references. Do not reconstruct missing rows, turn uncertain wording into executable schemas, or copy parameter tables.

Refresh only the affected primary requirement or implementation authority when the edition, protocol profile, browser/runtime, crypto guidance, supplier claim or legal context matters to the requested change. Preserve version, actor, technology gate, base level, embedded conditions and known alternatives in the resulting claim. A missing row limits exact scoring of that item; it does not discard supported control mechanisms or require reopening unrelated work.
