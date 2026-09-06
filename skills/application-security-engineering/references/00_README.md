# Application Security References

Read a reference when its decision surface is in scope. These files provide control reasoning and evidence expectations; they are not a complete standard, attack catalog, or authorization to run security tests.

| Reference | Decision it supports |
| --- | --- |
| [Threat models and effective authority](threat-models-and-effective-authority.md) | Select an invariant and enforce it across actors, state changes, delegation and recovery |
| [Web and API controls](web-api-controls.md) | Preserve meaning and authority across interpreters, browsers, messages, files and outbound requests |
| [Credential and recovery controls](credential-and-recovery-controls.md) | Bind identity and protocol evidence to purpose, session lifetime and revocable authority |
| [ASVS control implementation](asvs-control-implementation.md) | Translate versioned requirements into implementation and evidence; protect data copies and security events |
| [Secure development and vulnerability feedback](secure-development-and-vulnerability-feedback.md) | Choose components and track security decisions through delivered remediation |

## Source basis and refresh

- [OWASP Application Security Verification Standard](https://owasp.org/www-project-application-security-verification-standard/), version 5.0.0: requirement applicability, documented decisions, enforcement and verification. Consult the complete selected requirement before assigning an ID, level or conformance result.
- *Security Engineering, Third Edition*: policy, mechanism, assurance and incentives; effective authority; composition; recovery and lifetime support. Its approximately 2020 examples do not establish current algorithm or product behavior.
- [Building Secure and Reliable Systems](https://google.github.io/building-secure-and-reliable-systems/): least privilege, resilience, recovery, testing, incident preparation and recovery. Its operational examples support mechanisms, not a universal staffing model or configuration recipe.
- [NIST SP 800-218, SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final): Prepare the Organization, Protect the Software, Produce Well-Secured Software, Respond to Vulnerabilities. The February 2022 edition is the basis here; later status and task wording require verification.
- OWASP [Threat Modeling](https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html), [Secure Code Review](https://cheatsheetseries.owasp.org/cheatsheets/Secure_Code_Review_Cheat_Sheet.html), and [Software Supply Chain Security](https://cheatsheetseries.owasp.org/cheatsheets/Software_Supply_Chain_Security_Cheat_Sheet.html) cheat sheets: practical workflow and implementation references. An index or linked topic is not the procedure itself.

Before prescribing exact crypto/KDF parameters, token claims and protocol profiles, browser policies, framework defaults, supply-chain standards, or legal duties, consult the applicable current primary authority and deployed versions. If those facts cannot be established, make the design decision that is supported and identify the missing implementation detail; do not fill gaps with a supposed universal default. Acquisition limits belong with the affected claim and do not prohibit ordinary application-security work.
