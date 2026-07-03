# Platform Integration And Plugins

Use when: feature touches camera, photos, location, push, payments, maps, biometrics, native SDKs, app extensions or any iOS-specific API.

## Core Ideas

- Platform integration is where cross-platform abstractions meet iOS reality: permissions, entitlements, Info.plist, callbacks, background modes, review policies and device-specific behavior.
- Use a mature Flutter plugin when it covers the product requirement, has iOS support, compatible deployment target and maintained native dependencies.
- Write native Swift/Objective-C bridge code when plugin behavior is insufficient, a first-party Apple API is too new, or the integration is product-critical.
- Keep platform-specific code behind a clear interface so UI and domain logic do not depend on plugin details.
- Test plugin behavior on real devices, especially camera, push, location, biometrics, in-app purchases and deep links.

## Flutter Notes

- Services can wrap platform plugins the same way they wrap REST endpoints or files.
- AppDelegate/plugin registration is part of the generated iOS Runner shape.
- Native plugins can add build settings, permissions, entitlements and dependency-manager requirements.
- SwiftPM is the default native dependency path as of Flutter 3.44, but CocoaPods fallback still matters for plugins without SwiftPM.

## Swift / Native Notes

- Native APIs usually expose more complete platform behavior and diagnostics.
- Keep wrappers small: convert Apple framework details into domain-oriented results and errors.
- Avoid leaking `UIApplicationDelegate`, `UNUserNotificationCenter`, `CLLocationManager` or StoreKit details into feature UI.
- For App Extensions/widgets/background tasks, check target boundaries and shared code packaging early.

## Agent Checklist

- Is there a maintained plugin or should this be native?
- What iOS permissions and entitlements are required?
- Does the feature need background execution or system callbacks?
- Is there a fallback when permission is denied or API is unavailable?
- Are plugin/native errors mapped to domain errors?
- Has it been tested on real iPhone/iPad hardware?

## Anti-Patterns

- Selecting a plugin by popularity only, without checking iOS support and native dependency path.
- Calling plugin APIs directly from UI.
- Ignoring permission-denied and limited-access states.
- Assuming simulator behavior matches device behavior.
- Manually editing generated Flutter iOS files without documenting why.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): services can wrap platform APIs and external data sources.
- [Flutter SwiftPM docs](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers): plugin native dependencies via SwiftPM/CocoaPods.
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): plugin examples such as `mobile_scanner` and iOS Runner registration.

## Cross-Links

- [04-project-setup-dependencies.md](04-project-setup-dependencies.md)
- [09-permissions-privacy-security.md](09-permissions-privacy-security.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
