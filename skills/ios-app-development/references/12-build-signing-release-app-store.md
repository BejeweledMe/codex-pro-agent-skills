# Build, Signing, Release, And App Store

Use when: preparing iOS release, TestFlight, App Store submission, CI signing, versioning or release review.

## Core Ideas

- Release is a workflow, not a final command: configure app, sign, build/archive IPA, upload/validate, TestFlight, App Review, staged/manual release.
- Flutter iOS release still uses Apple ecosystem concepts: Xcode project, Bundle ID, certificates, provisioning profiles, App Store Connect and App Review.
- `flutter build ipa` builds the IPA; publishing/uploading and App Store review are separate steps.
- TestFlight is optional in the docs flow, but it is the practical validation stage before production App Store release.
- Version/build numbers matter. On iOS, Flutter `build-name` maps to `CFBundleShortVersionString`, and `build-number` maps to `CFBundleVersion`.

## Flutter iOS Flow

- Verify app metadata, Bundle ID and signing in Xcode/App Store Connect.
- Set app icon, launch screen and required iOS metadata.
- Run dependency setup and analysis/tests before archive.
- Build release IPA.
- Upload/publish to App Store Connect.
- Wait for validation; then choose TestFlight or App Store submission.
- Use TestFlight for internal/external testers and real-device release candidate validation.
- Submit complete App Store metadata and review notes.

## Signing / CI Notes

- CI needs explicit access to App Store Connect API/certificates/profiles or a managed signing solution.
- Keychain handling matters on macOS runners; restore default keychain after temporary signing setup.
- Keep certificates, private keys and API keys out of repo.
- CI release should be reproducible from a clean checkout and documented environment variables.

## Agent Checklist

- Apple Developer Program available?
- App Store Connect app record exists?
- Bundle ID matches project and provisioning profile?
- Version/build incremented?
- Release build tested on device?
- Permissions, privacy strings, privacy manifests, required-reason APIs and SDK signatures reviewed?
- Crash reporting configured for release environment?
- If this is an App Store production candidate, TestFlight or an equivalent release-candidate validation pass completed?
- App Review metadata/screenshots/privacy labels/review notes ready?

## Anti-Patterns

- First signing attempt on release day.
- Assuming TestFlight is automatic after `flutter build ipa`.
- Forgetting to increment build number for a new upload.
- Testing launch screen only with hot reload.
- Shipping debug/staging environment by accident.
- Storing signing secrets in source control.

## Source / Provenance

- [Flutter - Build and release an iOS app](https://docs.flutter.dev/deployment/ios): official Flutter iOS release path, TestFlight and App Store submission. Docs reflect Flutter 3.44.0 and were updated 2026-05-05.
- [Apple third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/): privacy manifest and SDK signature requirements for listed SDKs.
- [Packt Flutter repo](https://github.com/PacktPublishing/Flutter-for-Beginners-Fourth-edition): `pubspec.yaml` version/build comments and iOS project snapshot.

## Cross-Links

- [04-project-setup-dependencies.md](04-project-setup-dependencies.md)
- [09-permissions-privacy-security.md](09-permissions-privacy-security.md)
- [14-production-checklist.md](14-production-checklist.md)
