# Browser Behavior and Performance Evidence

Use the repository's existing supported runners and tools. `qa-testing` owns the general risk-to-test strategy; frontend owns focused browser mechanics and local diagnosis.

## Check the Behavior at the Necessary Fidelity

Use a small state/adapter check for pure transitions or response mapping. Use DOM/browser checks when the risk concerns rendered state, native behavior, focus, hydration, layout, navigation, or actual delivery.

- Interact through user-visible contracts with resilient role/name/label locators where suitable.
- Assert eventual visible/operable outcomes using supported web-first assertions; avoid arbitrary sleeps.
- Isolate storage, cookies, sessions, and mutable test data. Control response ordering when reproducing races.
- Stub uncontrolled third parties for deterministic local checks while retaining separate integration evidence for the real boundary.
- Prefer observable state over internal component structure or counts of implementation calls.

| Change | Representative evidence |
| --- | --- |
| Record identity or derived state | Edit, switch identity during pending work, and verify draft/reset policy and late-result rejection. |
| Hydration/deferred interaction | Delay code/data, activate early through keyboard and pointer, then verify successful action or truthful fallback and focus. |
| Mutation/error handling | Supported success, validation failure, uncertain timeout, repeated activation, and recovery without accidental duplicate effects. |
| Streaming boundary | Useful deployed shell paint before slow completion, plus coherent late failure behavior. |
| Virtualized collection | Range changes, recycled identity, focused/selected item behavior, and required non-scroll workflows. |

A UI test with mocked responses does not prove provider compatibility, authorization, or transaction behavior. Keep those claims tied to appropriate adapter, integration, or authorized security evidence.

## Diagnose Failures

Capture a bounded trace with reproduction steps, route/component identity, browser/runtime, relevant network timing, console errors, and expected versus observed state. Add focus/semantic observations or screenshots when they distinguish the failure.

Classify a failure as product behavior, fixture/isolation, selector/assertion, timing, environment, or integration before changing retries or timeouts. Redact credentials, private form values, response contents, and message payloads.

## Performance Experiment

1. Name the milestone and suspected cost. Record the build, route/data, device/browser, network, and cache/navigation conditions.
2. Inspect production chunks and traces. Development instrumentation and bundling may distort the result.
3. Compare one attributable change under repeated representative conditions, including cold/warm and first/repeat use where relevant.
4. Check behavior and accessibility alongside latency, bytes, CPU, layout shifts, and memory as appropriate.
5. Keep the change only when evidence supports the intended outcome; record regressions and a usable recovery/revert path.

Use current definitions for LCP, INP, CLS, and any other reported metric. Do not substitute first byte or first paint for first successful action, or a laboratory main-thread proxy for field interaction behavior.

For field reporting, state population, time window, route/device segmentation, sample count, eligibility, and metric definition. Compute percentiles from the relevant distribution; do not average cohort percentiles.

Core Web Vitals guidance uses the 75th percentile and distinguishes mobile and desktop populations, with all required metrics meeting their thresholds for a passing assessment. Verify the current definitions, eligibility, aggregation, and thresholds before reporting a pass. This reporting convention is not a universal acceptance rule for every application metric or a requirement to acquire field data before a focused local fix.

Lab results explain mechanisms under controlled conditions. Field distributions and task success establish how representative users are affected. First-party measurements can help attribute route, region, and dependency costs when aggregate field data cannot. Do not infer field improvement from a single lab score.

If browser execution or field data is unavailable, report exactly what was inspected and which behavior or performance claim remains unverified.
