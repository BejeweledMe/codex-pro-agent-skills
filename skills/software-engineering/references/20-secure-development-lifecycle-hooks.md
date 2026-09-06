# Secure Development Lifecycle Hooks

Use when integrating accepted security requirements into engineering delivery,
repairing missing release evidence, or preventing recurrence after a vulnerability.
Apply only the hooks relevant to the task and risk through existing workflows.

## Ownership And Evidence

`$application-security-engineering` defines applicable controls, component policy,
protected outcomes, and security response priorities. `$security-review`
independently assesses evidence and reports assurance limits.
`$platform-devops-engineering` implements build/deploy identity and infrastructure
enforcement. Software engineering owns the corresponding code changes, reviews,
tests, release records, and recurrence fixes.

Receive a versioned requirement, its policy or contractual authority, applicability,
implementation owner, required evidence, and exception/acceptance owner. Do not
invent a control mandate because a development task touches security.

Integrity evidence supports artifact authenticity or tamper detection; provenance
records origin and build history. Neither establishes that an artifact is authorized,
functionally correct, or safe. Keep these distinctions when passing evidence to
platform or security owners.

## Integrate Through Existing Lifecycle Stages

NIST SSDF v1.1 describes a lifecycle overlay, not a compulsory stage sequence:

| Practice group | Engineering integration | Evidence and response to a gap |
| --- | --- | --- |
| PO — Prepare the Organization | Place accepted requirements, roles, toolchain expectations, and evidence ownership in existing planning and review | Resolve unclear applicability or authority with AppSec before claiming a requirement is met |
| PS — Protect the Software | Preserve source/release identity and accessible release evidence with platform | Missing or mismatched identity breaks the evidence chain; recover attributable evidence or qualify a new candidate |
| PW — Produce Well-Secured Software | Connect accepted requirements to design, dependency decisions, code review, build configuration, and relevant tests | Show implementation and observed behavior; a configured tool alone is insufficient |
| RV — Respond to Vulnerabilities | Carry remediation and root-cause lessons into code, tests, tools, requirements, and practices | Verify the repair and the recurrence mechanism, not only ticket closure |

Treat developer tooling, CI/build systems, artifact repositories, release channels,
and evidence stores as dependencies whose compromise can invalidate delivery
evidence. AppSec chooses protection requirements; platform implements infrastructure
controls. Engineering identifies affected candidates and avoids relying on evidence
whose trust basis is unresolved.

Bind applicable evidence to the candidate described in
[17-ci-cd-release-and-production-safety.md](17-ci-cd-release-and-production-safety.md).
Retain it under the agreed access, retention, and ownership rules so reviewers and
responders can interpret it later. Keep secrets out of ordinary release records.

## Close The Vulnerability Feedback Loop

After the security owner confirms and prioritizes a vulnerability:

1. Use available release/dependency provenance to identify affected versions and exposure limits.
2. Deliver the owned remediation through the normal trusted release path; use SRE for live recovery decisions.
3. Investigate the failure class and search for related instances within the agreed scope.
4. Add or repair the relevant regression check, detector, requirement, or engineering practice.
5. Verify corrected behavior and route remaining uncertainty to the security acceptance owner.

AppSec owns vulnerability policy and security communication decisions; this
reference does not authorize external advisories or publication.
If evidence is missing, report the unresolved exposure explicitly and establish
the evidence needed for the next release. A signature, scanner result, or SSDF
label does not close the gap by itself.

## Source And Refresh Limits

Source basis: NIST SP 800-218, *Secure Software Development Framework (SSDF)
Version 1.1* (February 2022), PO/PS/PW/RV practices; *Building Secure and Reliable
Systems*, change integrity and organizational mechanisms.

This guidance does not establish that SSDF v1.1 is the current revision or provide
a conformance/attestation protocol. Confirm the applicable edition and authority
with the security owner when a standard, procurement obligation, or compliance
claim matters. Book-era build/signing examples are not current platform recipes.
Refresh affected details when toolchain, provenance, storage, admission controls,
or policy changes; preserve the lifecycle feedback and ownership obligations.
