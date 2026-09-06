# Credential and Recovery Controls

## Keep four decisions separate

Authentication establishes the actor and relevant assurance; session validation establishes continuing use of a session; token/protocol validation establishes acceptance for a particular receiver and purpose; domain authorization decides the permitted action, object, field, tenant and state. Evidence for one does not establish the others.

Inventory enrollment, ordinary and alternate login, federation, support, password reset, lost factors, account re-binding and administrative paths. Select the required assurance for the protected operation and make the enabled paths meet it or explicitly constrain what a weaker path can do. A strong primary login cannot compensate for an unrestricted weaker reset.

Use established identity and session facilities appropriate to the application. Password verification, password-derived encryption keys and random lookup secrets have different storage requirements. Refresh current primary guidance before choosing algorithms, entropy or work factors; do not transplant a numeric threshold between these uses. Retain password-manager/paste support and avoid silent truncation or transformations of credentials.

For an ASVS 5.0.0 target, preserve the selected assurance conditions: L2 reset must not bypass enabled MFA and lost-factor recovery must match enrollment proofing strength. Its L2 MFA-or-combined-single-factor alternative is not permission to invent admissible combinations; L3 adds hardware-based phishing resistance and user intent. Phone/SMS at L2 needs a validated number, a stronger alternative and risk disclosure; it is not an L3 option. Email's L3 factor restriction must not be mislabeled as an all-level numbered prohibition.

When a protected operation depends on authentication strength or recency, inspect available assurance signals and the documented minimum-strength fallback if signals are absent. That fallback does not establish stronger assurance. Distinguish password verification, lookup/OOB secrets, TOTP seeds and reference-session tokens when selecting entropy, storage and expiry; their edition-specific conditions are not interchangeable.

Rate limiting must address account and resource abuse without creating an easy attacker-triggered lockout. Inspect enabled routes, shared counters, responses and resource costs rather than declaring a limiter effective from its configuration alone.

## Lifecycle transitions and evidence

| Event | Control and scope | Verification and recovery consequence |
| --- | --- | --- |
| Authentication or re-authentication | Issue the intended new session and terminate the replaced token under the adopted session policy | Confirm the new session works and the replaced token fails at every relevant validator; cookie replacement alone is insufficient |
| Logout or expiry | Enforce backend termination, including effective blocking for self-contained sessions; clear authenticated client data separately | Check reuse and disconnected client cleanup; do not describe a deleted cookie as server revocation |
| Account disable/delete | Terminate account sessions and implement the documented federation responsibilities | Check surviving service/RP sessions and asynchronous work; repair propagation gaps before declaring termination complete |
| Factor change/reset/recovery | Protect the change with required proof and offer or enforce termination according to the chosen policy | ASVS 5.0.0 distinguishes offering termination of other sessions from automatic termination; preserve that distinction in claims |
| Recovery-affecting email/phone/MFA change | Require the selected re-authentication and securely bind the replacement attribute | A stolen session changing recovery data shows a separate control gap; notify and restore legitimate access through a trusted route |
| Entitlement or delegated authority change | Make enforcement match the promised effective time, including cached decisions and existing sessions | Measure where old authority still works; do not assume expiration alone satisfies immediate-change requirements |

The session table records distinct transitions, not one universal revocation event. In ASVS 5.0.0, fresh authentication/current-token replacement, logout/expiry and account-disable termination are L1 obligations; offering termination of other sessions after factor changes is L2. Recovery-affecting attribute changes require full re-authentication at L2, while the L3 highly-sensitive-transaction clause uses additional authentication or secondary verification; neither supplies an invented all-enrolled-factors definition. The administrator-reset password restriction is L3. Local policy may be stronger, but do not silently re-level the source.

Bind recovery to an independently usable trust basis. An administrator initiating a reset does not thereby gain authority to choose or learn the new credential, impersonate the user, or bypass MFA. Include proofing strength, factor revocation, safe user communication and legitimate-access restoration. Avoid relying exclusively on the compromised account or device to authorize its own repair.

## OAuth/OIDC role contract

Identify the client, authorization server (AS), resource server (RS), relying party (RP) and OpenID provider (OP), even when one product serves several roles. Record issuer trust, registration, client class, grant/response choices, redirect URIs, token recipients and the selected protocol profile. ASVS levels and protocol requirements are distinct authorities; reconcile the applicable clauses rather than blending them into one universal checklist.

- Client: bind responses to the initiating user-agent session and transaction, use PKCE as required by client/profile, and implement the applicable CSRF and multi-issuer mix-up defenses. Do not assume PKCE universally replaces state or OIDC nonce. Bind the expected issuer before sending codes or credentials.
- AS: enforce exact registered client-specific redirect matching, supported grants, client authentication where required, the chosen PKCE rules, single-use codes and refresh-token replay policy. Atomic redemption matters under concurrency. A code reuse response may require revoking tokens derived from that code; merely rejecting the second exchange is incomplete under ASVS 5.0.0.
- RS: validate access-token recipient and profile, derive a non-reassignable identity within the issuer namespace, apply delegated scope/claims together with application authorization, and validate sender proof when sender-constrained tokens are used. Issuing a constrained token does not prove the RS checks its proof.
- RP/OP: apply the selected OIDC issuer, audience, nonce, session and logout rules in addition to relevant OAuth duties. An ID Token is intended for its initiating client; an access token for an RS and a refresh token for the AS are not interchangeable.

For refresh rotation, define invalidation on use, concurrent/retry behavior, and what family is revoked on reuse. ASVS 5.0.0's public-client replay rule permits the rotation alternative at L1/L2; reuse revokes all refresh tokens for that authorization. Do not extend that alternative to L3, substitute it for access-token sender constraint, or call it revocation of every access token or account session. Refresh absolute expiry, consent withdrawal and RP logout also require their own effects and evidence.

Keep normative roles distinct. The selected API best-current-practice account requires PKCE for public clients and recommends it for confidential clients; ASVS 5.0.0's L2 AS code-grant duty requires PKCE and rejects plain. A client-side state alternative does not waive that AS duty. At L3, access-token sender constraint requires both AS issuance and RS proof verification; the AS's confidential-client and strong public-key/replay-resistant authentication conditions are cumulative. Dynamic registration alone does not establish native-client confidentiality.

At an RP, bind the ID Token to the expected issuer, client audience and initiating nonce under the selected profile. Logout-token type, purpose, event semantics and absence of nonce require their own validation; obtain authoritative claim names before writing the schema. At the OP, a permitted assured-client consent-prompt exception does not waive the separate consent or explicit-action condition for session creation.

Before implementation, refresh the exact role/profile requirements, claims and parameters from primary protocol and provider documentation. Record compatibility exceptions and migration owners. Do not construct executable OIDC logout schemas or response-parameter allowlists from disputed summaries.

## JWT acceptance boundary

Define token purpose, trusted issuer/key sources, acceptable algorithms, recipients and required claims from application policy and the selected profile. Structural parsing for validation does not authorize trusting unverified claims. Do not let a token select arbitrary key locations or expand its acceptable algorithms.

Validate the cryptographic operation against the configured algorithm and key type; reject unsigned modes for security-bearing tokens under the application policy. Validate every required nested layer, token type/purpose, audience and applicable validity/issuer/profile conditions. Reject on any required-check failure. No generic claim list establishes every JWT profile: a claim being optional in one account does not make it optional in the selected protocol.

Evidence should distinguish malformed structure, key/issuer failure, algorithm confusion, wrong purpose/audience, time failure and application denial, without storing raw tokens. Check that rejected tokens cause no protected side effect. A correctly signed wrong-purpose token must not reach domain authorization as an accepted identity.

## Service secrets, cryptographic use and trusted recovery

Use distinct least-privilege service identities and appropriately scoped, renewable credentials. Inventory each secret/key's purpose, holder, allowed use, storage, distribution, rotation, revocation and dependent data. Keep secret material out of source, build artifacts, logs and errors. A vault's presence does not prove these boundaries or that keys remain confined during operations.

Choose the required property before its mechanism: encryption does not alone supply integrity; a signature does not establish intent; key length does not establish entropy. Use reviewed libraries and constrained interfaces. Establish algorithm-specific nonce/IV and key-use rules, including concurrency and restore behavior; do not invent a universal nonce recipe. For transport, verify the intended peer and trust anchors at each client before relying on its identity, including internal connections and failure paths.

For routine rotation, define the intended overlap and completion condition. Verify new credentials work and old credentials cease to work after the declared cutoff at every relevant consumer. For compromise, coordinate containment and trusted re-enrollment with the incident owner; a spare secret in the same compromised storage is not independent recovery material. Crypto migration may require re-encrypting existing data and updating verifiers, not only changing the algorithm for new writes.

Restore must reconcile current authorization, revocation/replay state, key versions and trusted configuration. Validate that a backup or rollback does not revive removed authority. An unresolved compromise of the recovery foundation needs specialist and incident ownership, not an unsupported assertion of a clean restore.

## Application recovery handoff

When compromise is plausible, preserve relevant evidence before avoidable changes and identify what authority and communications may be affected. Altered logs, hidden artifacts or unexplained coordinated anomalies justify investigation; they do not establish attribution. SRE/incident owners coordinate containment and restore operations, including the risk of attacker reaction to shutdown, lockout or new instrumentation.

Supply the surviving credential/trust basis, authoritative current policy, revocation and replay state, compatible artifact/configuration identities, affected data copies and a way to restore legitimate access. Verify that old authority fails after reconciliation and authorized operations still work. Coordinate safe communication and remedy with the authorized owners; confidential data already copied cannot reliably be recalled. Feed the incident into the control, its regression evidence and the vulnerability feedback loop.

Source basis: ASVS 5.0.0 authentication, session, authorization, token, federation, crypto, communication and configuration families; *Security Engineering, Third Edition*, protocols/access/recovery; *Building Secure and Reliable Systems*, credentials, least privilege and trusted recovery. Exact parameters and profiles require refresh.
