# Flutter Architecture

Use when: designing or reviewing Flutter app structure, View/ViewModel boundaries, repositories, services, or domain/use-case layers.

## Core Ideas

- Flutter's official app architecture guide separates UI layer, data layer and optional domain layer. Treat it as a guideline, not a mandatory framework law.
- UI layer contains views and view models. Views render state and send user actions; ViewModels hold UI logic, commands and UI-ready state.
- Data layer contains repositories and services. Repositories are source of truth for model data; services wrap external sources like REST, platform APIs, local files or plugins.
- Services in the Flutter guide are lowest-level wrappers, expose async results such as `Future`/`Stream`, and hold no state.
- Add domain/use-case classes only when business logic is complex, reused, or combines multiple repositories.

## Practices

- Keep ViewModels scoped to a screen, flow or feature.
- Keep repositories expressed in domain models, not raw JSON, plugin DTOs or database rows.
- Keep platform/plugin calls behind services or adapters.
- Prefer explicit loading/error/empty/success state.
- Use DI/service locator/provider tools deliberately; they are not architecture by themselves.

## Anti-Patterns

- REST, SQLite, Firebase or plugin calls directly from widgets.
- Repositories depending on each other by default.
- Use-case classes for every trivial query.
- Global mutable app state with unrelated concerns.
- Treating educational examples as production architecture.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): UI/data/domain layers, repositories, services and optional use cases.
- Packt `Flutter for Beginners, Fourth Edition` repo: educational examples for Provider, GetIt, routing, plugins and tests.
