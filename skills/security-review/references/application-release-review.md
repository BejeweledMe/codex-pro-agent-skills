# Application and release review

## Use a versioned verification contract

For ASVS assessment, select application scope and assurance level from the requested decision and risk context. ASVS 5.0.0 levels are cumulative: L2 includes applicable L1/L2 obligations; L3 includes all applicable levels. Selected higher-level checks do not establish whole-level conformance.

Obtain the authoritative text for scored requirements. Bind identifiers to the full edition, for example `v5.0.0-7.4.3`. Preserve actors, applicability, base and embedded levels, modal language, alternatives and exceptions. Do not reconstruct absent rows, infer a level from neighbors or assume renumbering preserves meaning. [Source versions and refresh](source-versions-and-refresh.md) identifies known limits.

Where documentation is required, distinguish whether the decision is assessable, whether it is appropriate and whether implementation follows it. An assessable common-library rule may embody a decision; an opaque library or permissive document cannot establish adequacy. Do not require separate prose for every control or invent universal timeouts, retention periods and limits.

Record checked requirements, methods, evidence, applicability and exclusions at the depth needed for the claim. Relevant HTTP intermediaries stay in scope for their serving, caching, validation, limiting or connection behavior regardless of ownership. DNS, external backups, hosting, development/build operations and SIEM correlation can require complementary assurance beyond ASVS scoring. Exclusion provides no assurance of that dependency. Scanners or black-box-only results do not establish complete application coverage or OWASP certification.

## Follow changed behavior

Select paths from protected outcomes; the following are diagnostic leads, not an unversioned checklist or presumed findings.

| Surface | Evidence that distinguishes protection from appearance | Follow-up |
|---|---|---|
| Parsing, validation, files and rendering | Representation changes to final interpreter, accepted content, extraction limits and paths, delivery/execution behavior | Trace later decoding or unsafe sinks; request whole-path remediation |
| Authentication, support and recovery | Enabled-path proofing, session state at actual validators, disablement and outstanding authority | Separate strong login from fallback and trigger-specific invalidation |
| Authorization and federation | Subject/action/object/field/tenant/context, current policy, token audience and protocol actor duties | Check originating-subject restrictions across privileged intermediaries |
| Proxies and alternate origins | Framing/canonicalization assumptions, header provenance, caches and reachable bypass paths | Coordinate application and platform evidence across relevant hops |
| Crypto, transport and secrets | Needed property, parameters/use, trusted keys, peer checks, custody and old-key rejection | Separate algorithm/vault presence from correct composition and lifecycle |
| Data and logs | Classification across relevant copies, actual fields, access/retention and cleanup, including errors | Separate overcollection, disclosure and retention defects |
| Failure, retry and restore | Protected state after failure, bounded work, restored revocation/ACL/replay state | Verify recovery preserves authority as well as availability |

## Preserve actual ASVS qualifiers

These selected 5.0.0 examples illustrate distinctions that change a verdict. Check the actual row before scoring; they are not a complete requirement catalog.

- `v5.0.0-7.4.3` at L2 offers termination of other active sessions after factor change/reset/recovery or MFA configuration changes. An offer is not automatic termination. Logout/expiry and account disable/delete have distinct L1 obligations in `v5.0.0-7.4.1` and `v5.0.0-7.4.2`; UI cookie deletion does not establish backend invalidation.
- `v5.0.0-10.4.5` concerns public-client refresh replay. Its rotation alternative applies at L1/L2: invalidate on use and, on reuse, revoke all refresh tokens for that authorization. Do not extend the alternative to L3 or infer automatic revocation of every access token, application session or account authorization.
- Client PKCE-or-state under `v5.0.0-10.2.1` does not waive authorization-server PKCE and rejection of plain under `v5.0.0-10.4.6`. Sender-constrained issuance and resource-server proof verification are separate duties; a correct client does not prove the server roles conform.
- `v5.0.0-6.8.4` and `v5.0.0-10.3.4` retain if-present assurance-signal checks and documented minimum-strength fallback. Missing assurance signals do not prove higher assurance or inevitable fail-open behavior; inspect the protected action's actual policy.
- `v5.0.0-6.3.3` includes a reported L2 MFA-or-combination alternative, an embedded L3 hardware phishing-resistance/user-intent condition and a documented relaxation clause. Exact admissible combinations remain unresolved here. Do not simplify it into universal phishing resistance or reconstruct a permitted combination.

Likewise preserve conditional CSRF/preflight and file-path alternatives, in-row higher-level clauses and per-resource documented alternatives when those controls are selected. Outcome language does not erase specified mechanisms. A locally stronger safeguard is risk advice unless the chosen requirement mandates it. ASVS Appendix D recommendations remain non-mandatory; classification protection levels are not ASVS levels.

## Review release integrity as connected claims

Follow reviewed source/configuration → orchestration and build execution → artifact/storage → deployment admission → observed runtime or installed identity. Inspect the boundaries relevant to the release claim and identify where inputs, workflow, credentials, artifact or deployment can be replaced. This is an investigation model, not a mandate to add every artifact type to every release.

- **Correspondence:** reviewed source/configuration matches actual build inputs, including generated inputs and dependencies; changes after review remain visible.
- **Build authority:** trusted orchestration limits untrusted build code's access to release/signing credentials and controls workflow inputs and effective permissions.
- **Origin and binding:** provenance records claims about the artifact's source, inputs and build context. Verify subject, builder and meaningful input/environment/schema details needed for the specific claim. A signature authenticates a bound statement under a key/trust policy; it does not prove the builder was uncompromised or the code safe.
- **Admission:** the policy determines authorized artifacts, and actual deployment paths enforce it. Identify dry-run, fail-open, administrator or lower-level bypasses; assess whether they violate the claimed protection.
- **Runtime and repair:** compare running artifact/configuration/component inventory to the assessed release. Preserve revocations through rollback and verify distribution to affected consumers where the conclusion claims installed remediation.

Authenticity, origin, integrity, deployment authorization, component inventory, vulnerability exposure and installed remediation are separate conclusions. A trusted signature is not independent reproducible-build evidence. Platform owns gate/build/deployment fixes; AppSec owns application component policy and remediation; incident owners handle compromised trust and operational recovery. Recommend release with stated conditions, or explain why evidence does not support it, while leaving the decision with its authorized owner.

Sources: [OWASP ASVS 5.0.0](https://owasp.org/www-project-application-security-verification-standard/), verification model and selected requirements; [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/), change integrity and recovery; [NIST SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final), secure-development outcomes.
