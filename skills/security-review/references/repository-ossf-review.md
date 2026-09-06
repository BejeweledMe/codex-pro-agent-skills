# Repository, OSS and supplier review

## Assess a specific use and release

Pin repository/project, source or release/artifact, relevant platform, dependency role, privileges, data access and support horizon. Build dependencies can influence shipped software without appearing in runtime packages. Include transitives where relevant and the consumer's ability to isolate, update, replace or remove the component.

Choose OSPS edition and maturity before claiming baseline coverage. Inspect the applicable control, event predicate, actor and expected evidence. Tailoring must preserve actual wording; a framework crosswalk is an evidence lead, not proof of equivalent requirements. Read [source versions and refresh](source-versions-and-refresh.md) before a current-compliance claim.

## Interpret automated signals in context

Use Scorecard check-level results to prioritize investigation. Retain run date, version or known snapshot, repository state, coverage and underlying reason. Inaccessible settings or unsupported repository features may make a result inconclusive. Inspect actual check semantics; names, count and tiers are not permanent.

A high aggregate score, badge or popularity does not establish acceptable security for the intended use. A failing or unavailable check is a lead. Determine whether it exposes a relevant contributor, maintainer, dependency or CI path to harmful influence; keep uncertainty when the underlying evidence is unavailable. Do not invent a Scorecard release cutoff.

| Area | Inspect | Diagnostic action |
|---|---|---|
| Repository/release authority | Required checks/reviews where applicable, actual enforcement and merge history, bypass actors and release privileges | Distinguish policy from enforcement; assess bypasses against the control and approved exceptions |
| CI execution | Workflow input handling, untrusted contribution paths, effective tokens, credential exposure, input identity and build/release separation | Locate paths from untrusted code to privileged effects rather than relying on pipeline success |
| Analysis gates | SCA/SAST target and coverage, blocking policy, actual failure behavior, suppressions and triage | Identify exclusions or bypasses explaining green results before claiming absence of vulnerabilities |
| Release verification | Artifact identity, signature/hash verification instructions as appropriate, provenance and inventory correspondence | Determine whether consumers can verify the claimed release independently of producer assurances |
| Reporting/support | Security contact, disclosure handling, ownership, advisories, supported versions and EOL, delivered fixes | Separate declared response channels from demonstrated capability and installed remediation |
| Supplier duties | Who produces evidence, fixes, integrates, deploys, communicates and supports exit | Assign gaps to an actor able to act, or record the unsupported dependency |

Apply the selected baseline and use-specific harm; not every project needs every example artifact. An unsigned artifact or manual bypass is not automatically a vulnerability. Identify the violated requirement or concrete lost protection, including approved alternatives and residual uncertainty. A new project's absence of past reports is not proof its reporting channel fails.

## Suppressions, SBOM and VEX

An SBOM is a component inventory for an identified subject within generation coverage. Verify release/build/runtime correspondence and transitives where needed; presence alone proves neither origin nor absence of malicious behavior. Stale inventory can hide affected consumers.

A suppression is a disposition of an analysis result. Distinguish false positive, component absent, vulnerable code unreachable under stated conditions, compensating mitigation and accepted exposure. Inspect affected component/version, rule or vulnerability, configuration/reachability evidence, approval authority, expiry or refresh condition and correspondence to the assessed artifact.

VEX is a scoped vulnerability-status assertion about a product/version, with rationale. It is not universal risk acceptance or proof about other releases. Reopen or condition the disposition when binding fails, assumptions change, rationale is unsupported or a suppression hides an actual reachable path. Recheck affected assumptions on relevant dependency/configuration changes rather than silently carrying exceptions forward.

## Supplier evidence and disposition

When a producer claims SSDF alignment, use its named edition and actual practices as the basis. Ask for outcomes and evidence, not literal adoption of every example. Trace relevant responsibilities across producer, tenant, contractor and consumer; a signed self-attestation is not independent technical validation.

For consequential supplier claims, inspect available response history: intake, affected versions/products, trusted mitigation/fix, advisory and consumer handoff, remaining installed exposure, root-cause and related-defect follow-up. Missing history limits confidence without proving incapacity. Evidence custody matters when the authority producing records could alter the behavior being assessed.

Conclude on suitability for the named use, strengths and weaknesses supported by evidence, gaps, support/update constraints and practical conditions. Options can include constrained use, isolation, further assessment, replacement or postponement. Explain what would change the recommendation. The same component's role can alter its risk substantially; build-time use is not inherently safer than runtime use.

Consumer/product owners accept dependency risk. AppSec owns component/supplier policy and vulnerability remediation direction; platform implements repository/build/release controls; maintainers own project communications and releases; deployment/support owners close field exposure.

Sources: [OSPS v2025-10-10](https://baseline.openssf.org/versions/2025-10-10.html), [OpenSSF Scorecard](https://scorecard.dev/) and [NIST SSDF v1.1](https://csrc.nist.gov/pubs/sp/800/218/final). Their evidence supports distinct claims, not a combined certification or blanket release verdict.
