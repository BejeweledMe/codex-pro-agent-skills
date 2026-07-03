# Project Setup And Dependencies

Use when: создаешь проект, подключаешь plugins/packages, обновляешь Flutter/iOS toolchain или дебажишь Xcode dependency setup.

## Core Ideas

- Toolchain setup is part of production design: Flutter SDK/Dart SDK, Xcode, iOS SDK, simulator, real device, Apple Developer account and CI must agree.
- As of Flutter 3.44, Flutter uses Swift Package Manager for iOS/macOS native dependencies by default.
- Flutter still supports CocoaPods in maintenance mode and falls back to CocoaPods for dependencies that do not support SwiftPM.
- The CocoaPods registry read-only date in Flutter docs is 2026-12-02. Do not translate this into "CocoaPods stops working".
- Packt repo is a useful dependency snapshot, but official Flutter docs override it for current deployment targets and release constraints.
- In the research clone, Packt's iOS project has `IPHONEOS_DEPLOYMENT_TARGET = 12.0`; current Flutter deployment docs say Flutter supports iOS 13 and later. Use current official docs for target decisions.

## Flutter / iOS Dependency Notes

- Check `pubspec.yaml`, `pubspec.lock`, iOS generated files, Xcode package dependencies and plugin platform setup together.
- Native plugins can require Info.plist keys, entitlements, minimum iOS target changes, build scripts or manual Xcode settings.
- Flutter SwiftPM integration includes generated package dependency and a prepare script pre-action in Xcode.
- If a plugin requires higher iOS minimum, raise the target deliberately and document the product impact.
- Avoid manual Xcode project edits without understanding which parts Flutter regenerates or expects.

## Swift / Native Notes

- Prefer Swift Package Manager for first-party Swift dependencies when possible.
- Use CocoaPods only when project history or library support requires it.
- Keep package boundaries meaningful: modules can enforce access control, testing boundaries and build ownership.
- Do not add a dependency for a small function that can be implemented safely in-house; mobile dependency chains affect app size, security and release stability.

## Agent Checklist

- Which Flutter/Xcode/iOS SDK versions are assumed?
- Does every plugin support the required iOS target and dependency manager path?
- Are there CocoaPods fallback dependencies?
- Are generated files modified manually?
- Can a new developer reproduce setup from clean clone?
- Does CI use the same toolchain assumptions as local builds?

## Anti-Patterns

- Treating `flutter pub get` success as proof that iOS native dependencies are correct.
- Mixing SwiftPM and CocoaPods without documenting why.
- Ignoring minimum deployment target warnings until archive time.
- Using Packt/example deployment targets as current recommendations.
- Blindly deleting generated Xcode project files to "fix" dependency issues.

## Source / Provenance

- [Flutter - Swift Package Manager for app developers](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers): Flutter 3.44 SwiftPM default, CocoaPods maintenance/fallback, migration details.
- [Flutter - Build and release an iOS app](https://docs.flutter.dev/deployment/ios): iOS release prerequisites, iOS deployment target guidance and build process. Docs reflect Flutter 3.44.0 and were updated 2026-05-05.
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): `pubspec.yaml`, generated iOS Runner project, educational package set.

## Cross-Links

- [06-platform-integration-plugins.md](06-platform-integration-plugins.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
- [13-common-mistakes.md](13-common-mistakes.md)
