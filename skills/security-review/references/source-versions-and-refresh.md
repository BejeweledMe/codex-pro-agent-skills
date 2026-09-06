# Source versions and refresh

Read relevant authoritative material when conclusions depend on exact wording, identifiers, levels, protocol actors, tool semantics, provider duties or what is current. Record version/date. If unavailable, continue unaffected assessment and bound the unresolved claim rather than reconstructing the missing text.

| Source basis | Supported use and limits |
|---|---|
| [OWASP ASVS 5.0.0](https://owasp.org/www-project-application-security-verification-standard/), May 2025 | Application verification model and selected control semantics. Obtain full authoritative rows for exact scoring, levels, exceptions and migration; this reference is not a complete catalog |
| [OSPS v2025-10-10](https://baseline.openssf.org/versions/2025-10-10.html) | Detailed historical OSS baseline basis. A captured [landing page](https://baseline.openssf.org/) reported 2026.08.28, but that neither supplies its detailed controls nor establishes what is current at review time |
| [OpenSSF Scorecard](https://scorecard.dev/) | Check-level investigation leads. Check names, counts, tiers, configuration and repository support change; inspect the actual run and semantics |
| [NIST SP 800-218, SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final), February 2022 | Secure-development outcomes and producer/acquirer responsibilities. Examples and crosswalks are not universal mandates or equivalent attestation requirements |
| [SP 800-218 Rev.1 / SSDF v1.2 initial public draft](https://csrc.nist.gov/pubs/sp/800/218/r1/ipd), landing page dated 2025-12-17 | Draft/version discovery context only. Landing-page evidence supplies no detailed practice corpus; verify status and full text before normative use |
| *Security Engineering*, Third Edition | Authority, composition, incentives, assurance and lifetime support mechanisms. Circa-2020 examples do not establish current prevalence, law or platform behavior |
| [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/) | Change integrity, organizational and recovery mechanisms. Experience-based examples do not mandate staffing counts, thresholds, current provenance-framework levels or signing tools |

## ASVS precision and provider boundaries

Known limits include missing or disputed authentication rows (including exact 6.2.2/6.2.3 separation and 6.7.1), parts of V15–V17 text/levels, admissible MFA combinations, native-client confidentiality, re-authentication wording, OIDC logout members and response-type/flow/mode terminology. Do not generate exact findings or executable protocol schemas from unresolved wording; inspect the affected authoritative requirement and protocol specification.

Keep entropy, key length, effective strength, hash output, algorithm status, nonce use and integrity separate. Dated cryptographic accounts have unresolved status/minimum/wording tensions; do not merge numbers into a universal floor or invent errata. ASVS Appendix D is non-mandatory. A stronger local recommendation is distinct from a standard failure.

Provider ownership or an SDK-only exclusion does not establish provider security. State actual provider/tenant responsibilities, evidence access and residual gaps. For WebRTC, distinguish SDK use from operating TURN, media or signaling infrastructure and assess only duties supported for that role. An exclusion does not automatically require a vendor audit. Current browser, identity-provider, crypto-library, cloud/build and signing behavior requires evidence for the actual version.

Using these sources does not confer OWASP, NIST or OpenSSF certification or endorsement. Legal, contractual or normative claims need the relevant current authority; scoped technical review supplies evidence and limitations.

## Revisit affected conclusions

Refresh when changed source/configuration/dependencies, trust or recovery paths, build/signing identity, deployment, support channels, baseline/check semantics, incidents, contrary evidence, fixes or expired exceptions invalidate supporting assumptions. Changed populations, scope, methods, access or reviewer conflicts can also affect assurance.

State which prior evidence lost correspondence, which claims remain supported and the next owner/action. Do not repeat unaffected review merely because a new reviewer is available. Source or model agreement never substitutes for evidence about the assessed system.
