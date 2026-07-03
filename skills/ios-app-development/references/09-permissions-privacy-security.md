# Permissions, Privacy, And Security

Use when: app handles personal data, permissions, secrets, auth, network security, storage security or App Store privacy disclosure.

## Core Ideas

- Mobile client is not a trusted security boundary. Server-side validation remains required for auth, payments, authorization and business rules.
- Permissions must map to actual user value. Request them just-in-time with clear pre-permission UX when appropriate.
- iOS permission strings and privacy disclosures must match app behavior and SDK behavior.
- App Store privacy labels, Apple privacy manifests, required-reason API declarations and SDK signatures are related but different checks. Review them separately.
- Secrets do not belong in client code. Tokens with limited scope/expiry are different from backend secrets.
- Secure storage choices matter: Keychain for credentials/secrets, normal persistence for non-sensitive app data.

## Flutter Notes

- Plugins can introduce permissions, entitlements and privacy implications even if Dart code looks small.
- Validate plugin SDK behavior, data collection and native setup before release.
- Apple's third-party SDK requirements list `Flutter` and multiple Flutter-related SDKs/plugins; listed SDKs require privacy manifests, and listed binary dependencies also require signatures in the covered submission cases.
- Keep auth/session storage behind a service/repository boundary.
- Handle denied, restricted, limited and unavailable permission states.

## Swift / Native Notes

- Apple frameworks often require Info.plist usage descriptions and sometimes entitlements/capabilities.
- Use Keychain for credentials and long-lived sensitive tokens.
- Use App Transport Security defaults unless there is a documented, reviewed reason to relax them.
- Avoid assuming jailbreak/rooted-device resistance from client code alone.

## Agent Checklist

- What personal/sensitive data is collected, stored or transmitted?
- Which permissions are required and when are they requested?
- Are usage descriptions accurate and user-facing?
- Are credentials stored in Keychain or equivalent secure storage?
- Does backend enforce authorization independently of client UI?
- Do third-party SDKs affect privacy labels or tracking rules?
- Do any included SDKs appear in Apple's third-party SDK requirements list, and are privacy manifests/signatures present where required?

## Anti-Patterns

- Requesting all permissions at first launch.
- Hiding backend secrets in Flutter assets, plist files or Swift source.
- Treating biometric unlock as authentication to the backend by itself.
- Storing auth tokens in plain preferences.
- Ignoring third-party SDK privacy behavior until App Store submission.

## Source / Provenance

- [Flutter iOS release](https://docs.flutter.dev/deployment/ios): release process touches App Store review and platform metadata.
- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide): service/repository boundaries for platform and data access.
- [Apple third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/): privacy manifests, SDK signatures and listed SDKs including `Flutter`.
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui) and Apple Developer docs: platform integration context. For exact permission/privacy APIs, verify the current Apple docs for the target capability.

## Cross-Links

- [06-platform-integration-plugins.md](06-platform-integration-plugins.md)
- [07-networking-storage-persistence.md](07-networking-storage-persistence.md)
- [14-production-checklist.md](14-production-checklist.md)
