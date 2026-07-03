# Testing, Debugging, And Observability

Use when: planning test strategy, reviewing coverage, debugging Flutter/native behavior, preparing TestFlight or production support.

## Core Ideas

- Test the cheapest stable boundary that catches the risk.
- Clean architecture boundaries make testing cheaper: ViewModels, repositories, services and pure domain logic should be testable without UI.
- Flutter test pyramid: many unit tests, focused widget tests, fewer integration tests for critical flows and plugin/platform behavior.
- Native iOS test pyramid: unit tests for model/domain/services, UI tests for critical journeys, integration/manual device QA for platform capabilities.
- Observability is part of release readiness: crashes, errors, logs, analytics events and build/version metadata.

## Flutter Notes

- Use `flutter_test` for unit/widget tests.
- Widget tests can pump widgets, tap, scroll and assert UI state.
- Integration tests are important for plugin behavior, navigation flows, permissions and real-device constraints.
- `flutter_lints` helps maintain baseline quality but is not a test strategy.
- Error reporting SDKs must be configured per environment and validated before release.

## Swift / Native Notes

- Use XCTest for unit tests and XCUITest for UI automation where appropriate.
- Prefer testing state/view models/services over brittle pixel/UI tests.
- Symbolication and build metadata matter for production crash diagnosis.
- Swift concurrency tests should account for cancellation, actor isolation and deterministic scheduling where possible.

## Agent Checklist

- What risks are covered by unit, widget/UI, integration and manual device tests?
- Are repository/service contracts tested with failures, retries and empty states?
- Do tests cover permissions denied, network failure and stale cache?
- Are lints/analyzers run in CI?
- Are crashes/errors reported with environment, app version and build number?
- Does TestFlight build use production-like signing and release configuration?

## Anti-Patterns

- Only happy-path UI tests.
- Mocking so much that contracts are no longer tested.
- No integration tests for native plugins.
- No real-device QA before TestFlight.
- Error reporting added but never triggered in staging/test build.
- Tests that depend on real network by default.

## Source / Provenance

- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): `flutter_test`, calculator tests, widget smoke test, lint config.
- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): boundaries that support testing.
- [Flutter iOS release](https://docs.flutter.dev/deployment/ios): TestFlight/App Store release flow.

## Cross-Links

- [02-flutter-ios-architecture.md](02-flutter-ios-architecture.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
- [14-production-checklist.md](14-production-checklist.md)
