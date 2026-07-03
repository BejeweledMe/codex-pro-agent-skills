# Overview: Flutter, SwiftUI, Native, Mixed

Use when: нужно выбрать стек, оценить tradeoffs или быстро понять карту iOS-разработки.

## Core Ideas

- Стек выбирается не по вкусу, а по продуктовым ограничениям: платформы, сроки, доступ к Apple APIs, команда, UX bar, offline/security/performance требования и release cadence.
- Flutter подходит, когда важны iOS+Android parity, общий UI/business code, быстрые итерации и единая команда.
- SwiftUI/native подходит, когда продукт Apple-only или iOS-first, нужен максимальный platform fit, новые Apple APIs, SwiftData, widgets, App Intents, Live Activities, watchOS/visionOS или минимум abstraction gap.
- Mixed approach нужен, когда основная поверхность Flutter, но отдельные capabilities требуют native bridge/plugin, или когда existing native app постепенно получает Flutter screens.
- iOS platform work остается в любом варианте: Bundle ID, provisioning, signing, permissions, entitlements, privacy labels, TestFlight, App Review, real-device QA.

## Decision Criteria

- Выбирай Flutter, если Android parity является hard requirement и большая часть продукта - обычный app UI, формы, списки, auth, API, offline/cache, payments через стабильные plugins.
- Выбирай SwiftUI/native, если ключевая сложность - first-party Apple frameworks, latest iOS behavior, platform-specific UX, native persistence, background modes, widgets или tight integration with system features.
- Выбирай mixed, если уже есть native app, но новая feature surface автономна, или если Flutter app нуждается в точечно написанных native modules.
- Не выбирай Flutter только ради "одной кодовой базы", если 80% сложности в native APIs и App Store edge cases.
- Не выбирай SwiftUI только ради "нативности", если бизнесу критично выпустить Android почти одновременно.

## Agent Checklist

- Какой стек сейчас: Flutter, Swift/native, mixed?
- Какие платформы обязательны на ближайшие 3-6 месяцев?
- Какие iOS-only capabilities нужны: push, camera, photos, location, biometrics, IAP, widgets, background tasks, HealthKit, App Intents?
- Есть ли требования к offline, secure storage, sync, observability, crash reporting?
- Цель релиза: prototype, internal TestFlight, external TestFlight, App Store production?
- Есть ли Mac/Xcode/signing/Apple Developer Program/real device/CI?

## Anti-Patterns

- Считать Flutter "не требующим iOS знаний".
- Считать SwiftUI tutorial app production architecture.
- Смешивать Flutter DI, native singletons и global state без ownership model.
- Откладывать signing, permissions, App Store metadata и device QA до дня релиза.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): Flutter UI/data/domain architecture baseline.
- [Flutter iOS release](https://docs.flutter.dev/deployment/ios): iOS release flow, App Store Connect, TestFlight.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui): official learning path for SwiftUI concepts.
- [SwiftData docs](https://developer.apple.com/documentation/swiftdata): first-party persistence framework facts.

## Cross-Links

- [02-flutter-ios-architecture.md](02-flutter-ios-architecture.md)
- [03-swift-native-architecture.md](03-swift-native-architecture.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
- [14-production-checklist.md](14-production-checklist.md)
