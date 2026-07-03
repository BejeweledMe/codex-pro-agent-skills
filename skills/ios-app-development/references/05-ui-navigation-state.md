# UI, Navigation, And State

Use when: проектируешь screen flow, state ownership, navigation, View/ViewModel boundaries or declarative UI behavior.

## Core Ideas

- Flutter and SwiftUI are declarative: UI is a function/description of state. Change state, let UI update; do not imperatively mutate child views as the primary model.
- Separate ephemeral UI state from app/domain state.
- Local UI state belongs close to the view. Shared state belongs in a clear owner: ViewModel, repository/session store, observable model, provider, actor or store.
- Navigation state should describe where the user is, not secretly store business data.
- View code should call commands/actions; it should not know how data is fetched, cached, retried or persisted.

## Flutter Notes

- Use `setState` for truly local ephemeral state.
- Use Provider/Riverpod/BLoC/ValueNotifier/ChangeNotifier/etc. when state must be shared, tested or retained across view boundaries.
- `Consumer` or equivalent selectors help limit rebuild scope.
- Dispose controllers, focus nodes, animation controllers and streams when widget lifecycle owns them.
- `go_router` or declarative routing helps when route state, deep links and nested navigation matter.

## Swift / Native Notes

- Use SwiftUI state tools according to ownership: local view state, binding from parent, environment/context, observable model or query-backed data.
- Keep SwiftUI views small enough that state ownership remains visible.
- Do not treat `@State` as a storage layer. If state must survive app launches, move it to persistence/repository.
- Keep UIKit interop wrappers narrow and explicit when bridging older APIs into SwiftUI.

## Agent Checklist

- What state is local, shared, persisted or derived?
- Who owns mutation?
- Are loading/error/empty/success states represented?
- Are navigation params validated before use?
- Are text/editing/animation controllers disposed?
- Does state survive exactly as long as intended?

## Anti-Patterns

- One global `AppState` object with every mutable concern.
- Force-unwrapping route params or assuming deep links are valid.
- Business logic inside widget build methods or SwiftUI `body`.
- Fetching network data directly from view construction.
- Rebuilding a huge subtree for a single rating/field update.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): View/ViewModel and repository relationships.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui): official SwiftUI learning path for views, data flow and navigation concepts.

## Cross-Links

- [02-flutter-ios-architecture.md](02-flutter-ios-architecture.md)
- [08-concurrency-lifecycle.md](08-concurrency-lifecycle.md)
- [11-testing-debugging-observability.md](11-testing-debugging-observability.md)
