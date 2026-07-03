# Flutter Concurrency, Testing, Performance, And Checklist

Use when: reviewing Dart async, isolates, lifecycle, performance, tests, debugging, observability or production readiness.

## Concurrency / Lifecycle

- `Future` represents one async result; `Stream` represents a sequence.
- `async`/`await` improves readability but does not make CPU-heavy work parallel.
- Use isolates for CPU-heavy parsing, image/data processing or other work that would block the main isolate.
- Cancel subscriptions and dispose controllers when owner lifecycle ends.
- Represent async result as explicit state: loading, success, empty, error, refreshing, stale.

## Performance

- Measure before optimizing; debug-build conclusions are weak.
- Avoid heavy work in `build`.
- Keep rebuild scopes small with selectors/Consumers or state partitioning.
- Use list virtualization for long lists.
- Size/cache images deliberately and profile memory.

## Testing / Observability

- Use many unit tests for pure logic, ViewModels and repositories.
- Use widget tests for UI contracts.
- Use integration/device tests for native plugins, permissions and critical flows.
- Run lints/analyzers in CI.
- Configure crash/error reporting with environment, app version and build number.

## Production Checklist

- [ ] UI/data/domain boundaries are explicit.
- [ ] Native plugins, SwiftPM/CocoaPods path and iOS target are checked.
- [ ] Permissions, privacy manifests, SDK signatures and privacy labels are reviewed.
- [ ] Real-device QA covers critical plugin behavior.
- [ ] Release/profile performance is checked.
- [ ] Tests and observability are in place.
- [ ] Signing, App Store Connect, IPA and TestFlight/App Store path are ready.

## Source / Provenance

- Packt Flutter repo: educational Dart async/isolate, testing, widget and plugin examples.
- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide)
- [Flutter iOS deployment](https://docs.flutter.dev/deployment/ios)
