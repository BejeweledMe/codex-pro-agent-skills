---
name: ios-app-development
description: Use when designing, reviewing, validating, debugging, implementing, or releasing production iOS applications built with Flutter, SwiftUI, UIKit, or mixed Flutter/native code. Trigger for iOS app architecture, Flutter MVVM/ViewModel/repository/service design, Swift/native architecture, SwiftUI state and navigation, platform plugins and channels, Swift Package Manager/CocoaPods dependency issues, SwiftData and local persistence, async/concurrency/lifecycle, permissions/privacy/security, performance/memory/battery, testing/debugging/observability, TestFlight/App Store signing and release readiness, and long-term iOS app maintenance.
---

# iOS App Development

Use this skill to design, review, validate, debug, implement, or release iOS applications across Flutter, SwiftUI/native, and mixed stacks. Treat iOS quality as the product of architecture, platform constraints, state/data ownership, native integration, privacy, testing, signing/release, observability, and maintenance.

## Core Rule

Do not start from framework preference. First clarify stack, target iOS versions, product/platform goals, native capabilities, data/offline needs, privacy/security constraints, performance budget, testing depth, release target, signing/CI setup, and long-term ownership.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/00-overview.md` for broad design, review, stack choice, or unclear requests.
- For iOS platform constraints, lifecycle, sandbox, App Store gate, device QA, and product/platform assumptions, read `references/01-ios-platform-model.md`.
- For Flutter architecture, View/ViewModel, repositories, services, optional domain/use-case layer, and Flutter data boundaries, read `references/02-flutter-ios-architecture.md`.
- For Swift/native architecture, SwiftUI/native layering, value/reference semantics, ARC, protocols, modules, and ownership, read `references/03-swift-native-architecture.md`.
- For setup, Xcode, Flutter CLI, dependency managers, SwiftPM, CocoaPods, plugin dependency paths, and deployment target issues, read `references/04-project-setup-dependencies.md`.
- For declarative UI, navigation, local/shared/persisted state, ViewModel/state ownership, and route validation, read `references/05-ui-navigation-state.md`.
- For platform integration, native plugins, platform channels, AppDelegate/native setup, entitlements, camera, push, location, payments, biometrics, and Apple APIs, read `references/06-platform-integration-plugins.md`.
- For networking, repositories, source of truth, cache/offline behavior, local storage, SwiftData, migrations, and sync caveats, read `references/07-networking-storage-persistence.md`.
- For Dart async/isolates, Swift concurrency, actors, actor reentrancy, cancellation, lifecycle interruptions, and background work, read `references/08-concurrency-lifecycle.md`.
- For permissions, Info.plist strings, Apple privacy manifests, SDK signatures, required-reason APIs, Keychain, backend trust boundaries, and client-side security, read `references/09-permissions-privacy-security.md`.
- For startup, rendering, jank, memory pressure, ARC leaks, image/media costs, battery, Flutter DevTools, and Instruments-style profiling, read `references/10-performance-memory-battery.md`.
- For unit/widget/UI/integration tests, real-device QA, debugging, lints, crash reporting, logs, analytics, and production observability, read `references/11-testing-debugging-observability.md`.
- For signing, provisioning, Bundle ID, version/build numbers, IPA, App Store Connect, TestFlight, App Review, CI signing, and release gates, read `references/12-build-signing-release-app-store.md`.
- For quick reviews and common failure modes, read `references/13-common-mistakes.md`.
- For final production readiness or release reviews, read `references/14-production-checklist.md`.

## Workflow

1. Classify the request:
   - New app or feature design: read `00`, then stack-specific files `02` or `03`, plus `05`, `07`, `08`, `09`, `11`, and `12` as needed.
   - Flutter app architecture/review: read `02`, `05`, `07`, `08`, `11`, and `13`.
   - SwiftUI/native architecture/review: read `03`, `05`, `07`, `08`, `10`, and `13`.
   - Mixed Flutter/native or plugin work: read `04`, `06`, `09`, and stack-specific architecture files.
   - Persistence/offline/sync work: read `07`, then `08`, `09`, and the relevant stack file.
   - Concurrency/lifecycle/performance debugging: read `08`, `10`, and the relevant stack file.
   - Security/privacy review: read `09`, then `06`, `07`, `12`, and `14` if release is involved.
   - Test strategy or debugging: read `11`, then files matching the behavior under test.
   - TestFlight/App Store/release readiness: read `12`, `14`, `04`, `09`, and `11`.
2. Identify blocking unknowns. Ask only when the missing answer changes the design or release decision; otherwise state assumptions.
3. Preserve platform truth: distinguish Flutter abstractions, Swift/native behavior, and Apple ecosystem constraints.
4. Prefer the simplest architecture that preserves testability, lifecycle correctness, platform compliance, and maintainability.
5. Validate every recommendation against state ownership, source of truth, async/lifecycle behavior, privacy/security, testing, release, observability, and rollback/fallback.
6. Mark ideas not grounded in the references as `external extension` when adding them.

## Output For New App Or Feature Design

Include:

- Stack choice: Flutter, SwiftUI/native, UIKit/native, or mixed, with tradeoffs.
- Goals, anti-goals, target iOS versions, device assumptions, and release target.
- iOS platform constraints: capabilities, permissions, privacy, lifecycle, App Store risks.
- Architecture layers: UI, state/ViewModel, domain/use cases if needed, repositories, services/platform adapters.
- UI/navigation/state model and ownership boundaries.
- Data, networking, persistence, cache/offline, migration, and source-of-truth plan.
- Platform integration/plugin/native bridge plan.
- Concurrency/lifecycle/cancellation/background-work plan.
- Security/privacy plan, including Keychain/secrets/backend trust boundaries and Apple privacy checks.
- Testing, debugging, observability, crash/error reporting, and real-device QA plan.
- Build/dependencies/signing/TestFlight/App Store release plan.
- Risks, assumptions, validation steps, and next actions.

## Output For Review

Lead with risks and missing decisions:

- Critical release/platform blockers.
- Architecture and ownership problems.
- State/navigation/lifecycle/concurrency risks.
- Data/persistence/source-of-truth/security risks.
- Native plugin/dependency/signing/privacy risks.
- Testing, observability, and real-device QA gaps.
- Concrete fixes and verification steps.

## Output For Release Readiness

Prioritize:

1. Blocking App Store/TestFlight/signing issues.
2. Bundle ID, provisioning, certificates, version/build, IPA, and App Store Connect state.
3. Privacy labels, privacy manifests, SDK signatures, required-reason APIs, permissions, and entitlements.
4. Release-build device QA, crash/error reporting, and environment correctness.
5. Dependency manager state: SwiftPM/CocoaPods, deployment target, plugin native setup.
6. TestFlight or equivalent release-candidate validation when targeting App Store production.
7. Open risks, rollback/fallback options, owners, and follow-up checks.

## Fact-Check Guardrails

- Say `as of Flutter 3.44` for SwiftPM default support unless current Flutter docs have been rechecked.
- Do not say CocoaPods is removed or stops working. Say Flutter supports CocoaPods in maintenance/fallback mode and cite current docs.
- Do not use Packt repo examples as current production authority. Treat them as educational code snapshots.
- Do not claim SwiftUI tutorials define mandatory production architecture.
- Do not claim SwiftData replaces Core Data for every app or solves migrations/sync/availability without target-specific Apple docs.
- Do not conflate TestFlight with a mandatory App Store step; use it as a practical release-candidate validation gate for production.
- Do not call Swift actors atomic across `await`; account for actor reentrancy.
- Do not treat mobile client code as a trusted security boundary.

## Quality Bar

- Do not call an iOS app production-ready without real-device QA, explicit state/data ownership, privacy/security checks, tests, observability, signing/release plan, and App Store/TestFlight readiness.
- Prefer simple Flutter UI/data/domain boundaries before adding architecture layers.
- Prefer Swift value types for value-like domain state and classes only when identity/reference semantics are needed.
- Keep native integration isolated behind explicit adapters/services.
- Tie performance advice to measurement and release/profile builds on real devices.
- Keep recommendations scoped to the user's stack, target iOS versions, release target, and team constraints.
