# Flutter iOS Architecture

Use when: проектируешь или ревьюишь Flutter app, Flutter feature, Flutter module inside iOS app, state/data boundaries.

## Core Ideas

- Flutter docs describe a practical architecture around UI layer, data layer and optional domain layer. Treat it as a recommended guide, not a mandatory law.
- UI layer contains views and view models. Views render state and send user actions to ViewModels; ViewModels hold UI logic, commands and UI-ready state.
- Data layer contains repositories and services. Repositories are source of truth for model data; services wrap external sources like REST, platform APIs or files.
- Services in the Flutter guide are lowest-level wrappers, expose async results such as `Future`/`Stream`, isolate data loading and hold no state.
- Domain/use-case layer is optional. Add it only when business logic is complex, reused or combines multiple repositories.
- Repositories should not depend on each other in the default guide. If data from multiple repositories must be combined, use a ViewModel or domain/use-case layer.

## Practices

- Keep one ViewModel scoped to a screen/flow/use case. Avoid turning it into a global service.
- Keep repository interfaces expressed in domain models, not raw API DTOs or database rows.
- Keep service objects focused on one data source: REST API, file storage, platform plugin, local database.
- Add use cases when they remove real duplication or isolate complex business rules.
- Use dependency injection or service locator deliberately. Mixed access patterns are acceptable in examples, but production code needs one ownership story.

## Packt Repo Observations

- The repo is useful as a learning snapshot: Dart basics, widgets, forms, navigation, state, plugins, animations and tests.
- `pubspec.yaml` includes `go_router`, `provider`, `get_it`, `mobile_scanner`, `sentry_flutter`, `flutter_lints` and `flutter_test`.
- `ios/Runner/AppDelegate.swift` shows the standard plugin registration pattern through `GeneratedPluginRegistrant.register`.
- Treat Packt examples as educational, not as production prescriptions. For current Flutter/iOS rules, prefer official Flutter docs.

## Agent Checklist

- Is business logic outside widgets/views?
- Are network, file, plugin and database calls behind services/repositories?
- Does each repository own one data area and expose domain models?
- Is domain layer justified by complexity/reuse/multi-repository logic?
- Are loading/error/empty states explicit in ViewModel state?
- Can unit tests exercise ViewModels/repositories without launching Flutter UI?

## Anti-Patterns

- Calling REST, SQLite, Firebase or native plugins directly from UI.
- Adding use-case classes for every trivial getter before complexity exists.
- Making repositories aware of each other by default.
- Treating `GetIt`, Provider, Riverpod or BLoC as architecture instead of state/DI tools.
- Hiding business state in navigation stack or widget lifecycle callbacks.

## Source / Provenance

- [Flutter - Guide to app architecture](https://docs.flutter.dev/app-architecture/guide): UI/data/domain layers, repositories, services, optional use cases. Flutter docs reflect Flutter 3.44.0 and page updated 2026-05-05.
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): educational code examples for state, routing, plugins and tests.

## Cross-Links

- [05-ui-navigation-state.md](05-ui-navigation-state.md)
- [07-networking-storage-persistence.md](07-networking-storage-persistence.md)
- [11-testing-debugging-observability.md](11-testing-debugging-observability.md)
