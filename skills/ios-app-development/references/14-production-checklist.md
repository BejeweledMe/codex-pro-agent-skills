# Production Checklist

Use when: deciding whether an iOS app/feature is ready for TestFlight, App Store submission or serious internal rollout.

## Product / Platform

- [ ] Target platforms and iOS versions are explicit.
- [ ] Flutter/native/mixed stack choice is documented.
- [ ] Required Apple capabilities and entitlements are known.
- [ ] Real-device QA plan exists.
- [ ] App Store category, privacy requirements and review risks are known.

## Architecture

- [ ] UI does not own business logic.
- [ ] ViewModel/state owner is clear.
- [ ] Repositories own domain data source-of-truth behavior.
- [ ] Services wrap concrete external sources.
- [ ] Optional domain/use-case layer is justified by complexity or reuse.
- [ ] Loading/error/empty/success states are explicit.

## Data / Persistence

- [ ] Source of truth is documented.
- [ ] Offline/cache policy is documented.
- [ ] Retry/conflict/stale-data behavior is documented.
- [ ] Migration/versioning plan exists for persistent data.
- [ ] Sensitive data is not stored in normal preferences/files.
- [ ] SwiftData usage has target OS/availability checked if applicable.

## Security / Privacy

- [ ] Permissions are requested just-in-time or with clear user context.
- [ ] Info.plist usage descriptions are accurate.
- [ ] Entitlements match actual capabilities.
- [ ] Backend enforces auth/authorization independent of client UI.
- [ ] Secrets are not embedded in client source/assets.
- [ ] Third-party SDK privacy behavior is reviewed.
- [ ] Apple privacy manifests, required-reason APIs and SDK signatures are reviewed for included SDKs.

## Performance / Reliability

- [ ] Release/profile build performance checked on device.
- [ ] Main isolate/main actor is not doing heavy work.
- [ ] Large images/media are sized/cached deliberately.
- [ ] Long-lived streams/tasks/timers/observers are disposed/cancelled.
- [ ] Crash/error reporting is configured and tested.
- [ ] App version/build metadata appears in crash reports.

## Testing

- [ ] Unit tests cover domain/ViewModel/repository logic.
- [ ] Widget/UI tests cover important UI contracts.
- [ ] Integration/device tests cover native plugins and critical flows.
- [ ] Permission denied/unavailable cases tested.
- [ ] Network failure and stale cache cases tested.
- [ ] Lints/analyzers run in CI.

## Build / Dependencies

- [ ] Flutter/Dart/Xcode/iOS SDK versions are documented.
- [ ] SwiftPM/CocoaPods path is understood for all native dependencies.
- [ ] No unreviewed generated Xcode file edits.
- [ ] Minimum deployment target matches product and plugin requirements.
- [ ] Clean clone setup works.
- [ ] CI matches local release assumptions.

## Release

- [ ] Apple Developer Program access available.
- [ ] App Store Connect app record exists.
- [ ] Bundle ID and provisioning profiles match.
- [ ] Version/build number incremented.
- [ ] App icon and launch screen verified without hot reload assumptions.
- [ ] Release IPA built and uploaded.
- [ ] For App Store production candidates, TestFlight or equivalent release-candidate validation completed.
- [ ] App Store metadata, screenshots, privacy labels and review notes ready.

## Source / Provenance

- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide)
- [Flutter iOS release](https://docs.flutter.dev/deployment/ios)
- [Flutter SwiftPM docs](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Apple third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/)
- The Swift Programming Language (Swift 6.3)
- [Apple SwiftData](https://developer.apple.com/documentation/swiftdata)

## Cross-Links

- [00-overview.md](00-overview.md)
- [11-testing-debugging-observability.md](11-testing-debugging-observability.md)
- [12-build-signing-release-app-store.md](12-build-signing-release-app-store.md)
- [13-common-mistakes.md](13-common-mistakes.md)
