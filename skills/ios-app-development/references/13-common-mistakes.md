# Common Mistakes

Use when: reviewing a project quickly, debugging a broken delivery path, or training an agent to avoid predictable iOS/Flutter/Swift errors.

## Architecture Mistakes

- Business logic in Flutter widgets or SwiftUI views.
  - Fix: move logic to ViewModel/domain/repository/service boundary.
- Repository as a thin DAO with no source-of-truth policy.
  - Fix: define cache, retry, refresh, error and domain transformation behavior.
- Domain/use-case layer added everywhere without complexity.
  - Fix: add it only for reuse, multi-repository logic or complex business rules.
- One global state object for every feature.
  - Fix: split state by ownership, lifecycle and mutation boundary.

## Flutter Mistakes

- Assuming `async` makes CPU-heavy work safe for UI.
  - Fix: use isolates or move work off the main path.
- Plugin selected without checking iOS support, SwiftPM/CocoaPods path and permissions.
  - Fix: audit plugin iOS setup before adoption.
- Controllers/subscriptions not disposed.
  - Fix: lifecycle owners dispose resources.
- Route params force-unwrapped.
  - Fix: validate route input and handle invalid/deep-link cases.
- Treating Packt/demo patterns as production best practice.
  - Fix: use demos as examples, official docs and project constraints as authority.

## Swift / Native Mistakes

- Force unwraps in normal app flow.
  - Fix: model optionality and failure paths.
- Class-first data model.
  - Fix: prefer structs/enums unless identity/reference semantics are needed.
- Strong closure captures causing leaks.
  - Fix: reason about ownership and use capture lists where appropriate.
- `SwiftUI = MVVM` as a universal mandate.
  - Fix: choose the simplest state/architecture pattern that preserves testability and lifecycle correctness.
- Ignoring actor/main-actor boundaries.
  - Fix: make isolation explicit and test async behavior.

## Release Mistakes

- Signing not rehearsed before release week.
- Build number not incremented.
- App Store privacy labels and permission strings not reviewed.
- Simulator-only QA.
- Error reporting not validated in a release-like build.
- CocoaPods/SwiftPM issue discovered only at archive time.

## Agent Checklist

- Is the mistake architectural, lifecycle, platform, release or testing related?
- Which file in this knowledge base explains the correct boundary?
- What is the smallest fix that restores ownership/testability/release confidence?

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide)
- [Flutter SwiftPM docs](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Flutter iOS release docs](https://docs.flutter.dev/deployment/ios)
- The Swift Programming Language (Swift 6.3)
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition)

## Cross-Links

- [02-flutter-ios-architecture.md](02-flutter-ios-architecture.md)
- [05-ui-navigation-state.md](05-ui-navigation-state.md)
- [08-concurrency-lifecycle.md](08-concurrency-lifecycle.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
