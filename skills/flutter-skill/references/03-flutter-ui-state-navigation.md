# Flutter UI, State, And Navigation

Use when: designing or reviewing Flutter widgets, UI state, ViewModel state, routing, controllers or navigation.

## Core Ideas

- Flutter UI is declarative: widgets describe UI from state. Change state and rebuild; do not imperatively mutate child widgets as the primary model.
- Separate ephemeral UI state from app/domain state.
- Local state can live near the widget; shared or persistent state needs a clear owner.
- Navigation state should describe location, not secretly store business data.
- View code should call actions/commands; it should not know how data is fetched, cached or persisted.

## Practices

- Use `setState` only for local ephemeral state.
- Use Provider/Riverpod/BLoC/ValueNotifier/ChangeNotifier/etc. when state crosses widget boundaries, needs testing or outlives a local widget.
- Use selectors/Consumers to keep rebuild scope small.
- Dispose `TextEditingController`, focus nodes, animation controllers, streams and subscriptions when the widget owns them.
- Validate route params and deep-link inputs before use.

## Anti-Patterns

- Business logic in `build`.
- One global `AppState` for every feature.
- Force-unwrapped route params.
- Network/persistence fetches directly from widget construction.
- Rebuilding a huge subtree for one field/rating update.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): View/ViewModel and repository boundaries.
- Packt Flutter repo: educational examples for Provider, GetIt, `go_router`, controllers and widget tests.
