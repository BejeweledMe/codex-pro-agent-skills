# Swift Platform, Security, Testing, And Release

Use when: native Swift work touches Apple APIs, permissions, privacy, Keychain, tests, observability, signing, TestFlight, App Store or production readiness.

## Platform Integration

- Apple frameworks often require Info.plist usage descriptions, entitlements/capabilities and real-device testing.
- Keep Apple framework details behind focused adapters when domain or tests benefit from it.
- Background tasks, push, location, camera, StoreKit, HealthKit, widgets and App Intents must be designed with platform lifecycle and review constraints.

## Security / Privacy

- Mobile client code is not a trusted security boundary.
- Backend must enforce auth, authorization, payments and business rules independently of client UI.
- Use Keychain for credentials and long-lived sensitive tokens.
- App Store privacy labels, privacy manifests, required-reason APIs and SDK signatures are separate checks.
- Review third-party SDK behavior before submission.

## Testing / Observability

- Use XCTest for unit tests and XCUITest for critical UI flows where appropriate.
- Prefer testing domain/state/services over brittle UI-only tests.
- Test permission denied/unavailable states, network failures and stale cache.
- Configure crash/error reporting with environment, app version and build number.
- Use real devices before TestFlight.

## Release Checklist

- [ ] Target iOS versions and Apple framework availability are explicit.
- [ ] Bundle ID, certificates and provisioning profiles match.
- [ ] Version/build number is incremented.
- [ ] Permissions, entitlements, privacy manifests, SDK signatures and privacy labels are reviewed.
- [ ] Release-build device QA is complete.
- [ ] Crash reporting and observability are verified.
- [ ] TestFlight or equivalent release-candidate validation is done for App Store production candidates.
- [ ] App Store metadata, screenshots and review notes are ready.

## Source / Provenance

- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Apple SwiftData](https://developer.apple.com/documentation/swiftdata)
- [Apple third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/)
