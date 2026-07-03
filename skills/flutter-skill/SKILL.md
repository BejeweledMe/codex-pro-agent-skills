---
name: flutter-skill
description: Use when designing, reviewing, validating, debugging, implementing, or releasing Flutter applications, especially production Flutter apps targeting iOS. Trigger for Flutter app architecture, MVVM/ViewModel/repository/service layers, Dart async and isolates, Flutter state management, widgets/navigation, platform plugins and channels, Swift Package Manager/CocoaPods iOS dependencies, Flutter persistence/cache/offline design, permissions/privacy, performance/jank/memory, testing/debugging/observability, TestFlight/App Store signing and release readiness, and long-term Flutter app maintenance.
---

# Flutter Skill

Use this skill to design, review, validate, debug, implement, or release production Flutter applications, with special attention to iOS delivery. Treat Flutter as a cross-platform product stack that still has platform-specific iOS constraints: native plugins, signing, privacy, device QA, App Store review, and release operations.

## Core Rule

Do not assume Flutter removes iOS work. First clarify target platforms, target iOS versions, release target, native plugins/capabilities, state/data ownership, persistence/offline needs, privacy/security constraints, performance budget, testing depth, signing/CI setup, and ownership.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/01-flutter-architecture.md` for broad Flutter design or review.
- For iOS platform constraints, Xcode, SwiftPM, CocoaPods, deployment targets, native plugin setup, signing, TestFlight, and App Store, read `references/02-flutter-ios-platform-dependencies-release.md`.
- For widgets, declarative UI, View/ViewModel boundaries, local/shared state, routing, controllers, and navigation, read `references/03-flutter-ui-state-navigation.md`.
- For repositories, services, networking, source of truth, local storage, cache, offline and sync behavior, read `references/04-flutter-data-persistence-offline.md`.
- For platform channels/plugins, permissions, privacy manifests, SDK signatures, Keychain/backend trust boundaries, and native iOS capabilities, read `references/05-flutter-platform-integration-security.md`.
- For Dart `Future`/`Stream`/isolates, lifecycle, cancellation, performance, jank, memory, testing, debugging, crash reporting, and production checklist, read `references/06-flutter-concurrency-testing-performance.md`.

## Workflow

1. Classify the request:
   - New Flutter app/feature design: read `01`, `03`, `04`, then `02`, `05`, `06` as needed.
   - Architecture or code review: read `01`, `03`, `04`, and `06`.
   - Native plugin/platform work: read `02` and `05`.
   - Persistence/offline work: read `04`, then `06` for async/lifecycle risks.
   - Performance/debugging/testing: read `06`, then the relevant architecture/state/data reference.
   - TestFlight/App Store release: read `02`, `05`, and the release checklist in `06`.
2. Ask only for blocking details; otherwise state assumptions and proceed.
3. Keep Flutter layers explicit: UI, ViewModel/state holder, optional domain/use case, repository, service/platform adapter.
4. Validate recommendations against iOS-specific native dependencies, permissions, privacy, real-device behavior, signing/release, and observability.
5. Mark ideas not grounded in the references as `external extension`.

## Output For Design

Include stack/platform assumptions, UI/state/navigation model, ViewModel/repository/service boundaries, data/source-of-truth plan, plugin/native integration plan, async/lifecycle plan, privacy/security checks, testing/observability plan, iOS release/signing plan, risks, and next steps.

## Output For Review

Lead with risks: Flutter architecture gaps, business logic in widgets, state ownership problems, repository/source-of-truth gaps, plugin/native dependency risks, iOS privacy/signing blockers, performance/testing gaps, and concrete fixes.

## Fact-Check Guardrails

- Say `as of Flutter 3.44` for SwiftPM default support unless current Flutter docs have been rechecked.
- Do not say CocoaPods is removed or stops working. Say Flutter supports CocoaPods in maintenance/fallback mode and cite current docs.
- Treat Packt examples as educational snapshots, not production authority.
- Do not call an app production-ready without real-device QA, privacy checks, tests, observability, signing/release plan, and App Store/TestFlight readiness.
- Do not treat `async/await` as parallel CPU execution; use isolates for CPU-heavy work.
- Do not treat the mobile client as a trusted security boundary.

## Quality Bar

- Prefer simple Flutter UI/data/domain boundaries before adding extra architecture.
- Keep native/plugin code isolated behind services or adapters.
- Represent loading, error, empty, stale and success states explicitly.
- Tie performance advice to measurement on release/profile builds and real devices.
- Keep recommendations scoped to the user's Flutter version, target iOS versions, plugin set, release target, and team constraints.
