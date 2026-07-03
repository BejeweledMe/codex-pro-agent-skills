# iOS Platform Model

Use when: нужно проверить, учитывает ли дизайн реальные ограничения iOS, App Store и device lifecycle.

## Core Ideas

- iOS app - sandboxed bundle с Bundle ID, entitlements, permissions, resources, executable code и platform metadata.
- App Store Connect и signing являются частью architecture surface, потому что они определяют, что можно поставить на устройство, протестировать и выпустить.
- Simulator полезен для быстрой проверки UI, но production confidence требует real devices: camera, push, biometric auth, performance, memory pressure, permissions и App Store-like signing behavior.
- Background execution ограничен platform policies. Любой long-running workflow должен проектироваться с учетом lifecycle interruptions, cancellation и retries.
- Privacy strings, entitlements и usage descriptions - не декоративные поля. Они должны соответствовать фактическому поведению приложения.

## Flutter Notes

- Flutter app на iOS включает generated/native iOS project, `Runner`, `Info.plist`, Xcode project/schemes, plugin registration и Flutter engine/runtime integration.
- Flutter UI не освобождает от iOS release tasks: icons, launch screen, bundle id, code signing, provisioning profiles, IPA, upload, TestFlight/App Store review.
- Platform plugins могут повышать minimum deployment target или требовать native setup в Xcode/Info.plist/entitlements.

## Swift / Native Notes

- SwiftUI app structure строится вокруг app entry point, scenes и views, но deployment, capabilities, signing и privacy остаются Xcode/App Store concerns.
- Swift language safety не заменяет platform safety: Keychain, permissions, ATS, App Review и background modes проектируются отдельно.
- Native stack ближе к Apple APIs, но из-за этого быстрее поднимает platform-specific вопросы, которые нельзя скрыть за cross-platform abstraction.

## Agent Checklist

- Указан ли target iOS version и проверена ли совместимость dependencies/plugins?
- Какие capabilities/entitlements реально нужны?
- Какие permission prompts появятся и соответствуют ли они пользовательскому сценарию?
- Какие части приложения должны переживать background/foreground transitions?
- Есть ли real-device QA plan?

## Anti-Patterns

- Проектировать мобильное приложение как web SPA с бесконечным foreground runtime.
- Считать simulator-прохождение достаточным для camera, push, biometrics, performance или signing.
- Добавлять permissions "на будущее".
- Игнорировать App Store review constraints до финальной недели.

## Source / Provenance

- [Flutter iOS release](https://docs.flutter.dev/deployment/ios): release prerequisites and App Store/TestFlight flow.
- [Packt repo iOS Runner](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): generated Flutter iOS project shape.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui): official SwiftUI learning path.

## Cross-Links

- [04-project-setup-dependencies.md](04-project-setup-dependencies.md)
- [06-platform-integration-plugins.md](06-platform-integration-plugins.md)
- [09-permissions-privacy-security.md](09-permissions-privacy-security.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
