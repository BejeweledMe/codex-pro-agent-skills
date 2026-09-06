# Release identity and deployment admission

Use when implementing protected builds, workflow identity, signing/provenance, artifact promotion, release verification or admission controls. Platform implements the enforcement path. Application security engineering supplies application/component/supplier policy and remediation requirements; security review assesses the evidence independently.

## Keep the claims separate

- Artifact integrity is correspondence to the expected bytes, normally identified by digest.
- Provenance is a statement about origin and production history: source, inputs, builder and process, subject to its schema and trust basis.
- A signature authenticates a statement or artifact binding under a trusted identity; it does not establish authorized release or absence of vulnerabilities.
- OIDC supplies federated workload identity claims; the receiving provider's trust and permissions decide authority.
- Admission applies release policy at a deployment boundary. SLSA assurance claims require the applicable specification's requirements and evidence, not a count of installed tools.

An SBOM inventories components and VEX communicates vulnerability applicability; AppSec owns the component/exposure policy. Platform preserves correspondence to the actual artifact and distributes policy inputs. Neither inventory nor applicability statement substitutes for build provenance or deployed-state verification.

## Protect the complete path

Trace reviewed source/configuration through orchestration, restricted build execution, artifact/provenance creation, storage, deployment admission and post-deployment observation. Identify who can change each input, mint credentials, write artifacts, sign statements, change policy, bypass admission or alter evidence. Keep signing keys, deployment credentials and evidence-authorizing authority outside untrusted build steps' reach. Generate trusted provenance from the protected orchestration boundary so build commands cannot freely invent their own accepted history. Separate authority and isolation are the requirements; a particular two-runner topology is only one implementation. Configuration belongs in the controlled chain; secret values do not belong in ordinary source or evidence output.

Bind the candidate to source identifiers, immutable dependency/input versions, build configuration and meaningful parameters, builder identity, schema and subject digest as the selected provenance format supports. Preserve artifacts and evidence long enough to support the local release/response needs with protected access. A trusted builder's signature is not independent reproducible-build verification.

Maintain acceptance expectations in a protected location rather than deriving them from the submitted attestation. For the target artifact, compare expected source/ref or reachability, build configuration, parameters, builder, issuer/signer identity and digest. A cryptographically valid artifact from an unauthorized workflow is still a rejection under a policy requiring the protected release workflow.

## Implement identity and enforcement

For CI OIDC, inspect actual token claims and provider-side trust predicates, including repository/source, workflow, ref/environment and audience where applicable to that provider. Scope the resulting permissions to the stage and target. Removing a standing secret does not fix an overly broad trust predicate. Refresh current issuer/subject formats for the deployment, including hosted versus enterprise variants; do not copy an old subject template blindly.

For signature/attestation verification, enforce signer identity, issuer and subject binding as well as cryptographic validity. In keyless verification these identity constraints are material. Do not disable claim checks to make an unexpected signature pass. Cosign flags and trust mechanisms are version-sensitive; derive an executable invocation from the chosen version's authoritative documentation.

Put acceptance at an unavoidable deployment choke point and enumerate alternate routes: direct API access, another controller, artifact substitution, mutable tags, emergency credentials or policy modification. Decide unavailable-verifier and exception behavior with the policy owner, including the security floor that recovery must preserve. There is no universal fail-open/fail-closed choice. Test accepted and rejected cases in the authorized environment before increasing enforcement; a dry-run report does not establish a blocking control.

After deployment, compare running artifact/configuration identity and target with the admitted candidate and decision evidence. Preserve the policy version, relevant identity, reason and exception owner without recording raw credentials. An admission decision about one digest cannot establish what a later mutable reference actually launched.

## Failure evidence and recovery

| Failure | Distinguishing evidence | Platform action |
|---|---|---|
| Valid signature from wrong workflow accepted | Signer/issuer and protected source/build expectations | Tighten acceptance predicates; verify the rejected counterexample and valid release |
| Short-lived identity has broad cloud access | Provider trust predicates and effective permissions | Narrow trust and grants; verify required operation works and unrelated target access fails |
| Provenance exists but cannot locate exposed deployments | Artifact/component/source-to-deployment correspondence | Repair evidence linkage; provide affected release/target inventory to AppSec response |
| Admission bypassed | Actual deployment actor/route and control-point coverage | Close or govern the alternate route; verify deployed-state correspondence |
| Previously valid rollback now unsafe | Security policy version, revoked identity, vulnerable artifact or incompatible data | Select a policy-permitted recovery with application/data/SRE owners; do not restore old authority merely because bytes are available |
| Evidence could be rewritten by the actor it audits | Evidence-store write authority and retention history | Separate relevant authority and protect records; report the remaining assurance limit to security review |

For suspected compromised build/release identity, coordinate containment and evidence preservation with incident/security owners. Restore trustworthy source/build authority, rotate/revoke affected credentials through the supported path, verify old authority no longer works, rebuild and reverify affected artifacts as required by the incident scope. Platform provides implementation and correspondence evidence; AppSec decides component remediation and security review assesses remaining uncertainty.

For security-sensitive recovery, consider the policy owner's minimum security version, persistent deny list outside the rollback artifact, or overlapping signing-key rotation where those mechanisms fit the system. They address distinct failure modes and are not a complete recovery architecture. Preserve required access/admission policy through workload rollback; do not accidentally restore broader authority with an old deployment bundle.

Enumerate relevant credential acceptors, caches and offline paths. Verify revocation reaches them and the old credential is refused; new-key issuance alone is incomplete rotation. For recovery-critical checks, examine dependence on a failing central lookup or unreliable clock. Include inactive/fallback images, trusted keys, boot configuration and backups in intended-state verification when they can reactivate unsafe authority.

Exceptions need a policy owner, bounded scope, review/expiry or retirement condition and an observable disposition. Apply these controls to the actual exposure; a limited admission control still has value, but its evidence cannot establish coverage of routes it does not govern.

## Standards and handoff limits

[NIST SP 800-218, SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final) treats tools, environments, evidence and release integrity as part of secure development. Tailor applicable outcomes into the existing delivery workflow. PO/PS/PW/RV groupings describe preparation, protection, production and response, not a mandatory sequential pipeline. Vulnerability findings should feed back into build controls and regression evidence with named owners.

Do not assert SSDF conformance, SLSA level, supplier trust or release safety merely because provenance, OIDC and signing are present. Pin the requested standards edition and retrieve normative requirements for such a claim; a complete level mapping or conformance protocol is outside this reference's evidence. [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/) supports end-to-end controlled change, not a current SLSA/Cosign implementation recipe.

Handoff to AppSec/review includes protected requirement, policy edition/version, exact artifact/source/build/deployment identities, relevant effective authority, verification and negative-test results, exceptions, untested routes and acceptance owner. Keep this evidence distinct from the implementer's own confidence statement.
