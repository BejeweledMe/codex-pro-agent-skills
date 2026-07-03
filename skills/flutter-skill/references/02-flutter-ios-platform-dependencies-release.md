# Flutter iOS Platform, Dependencies, And Release

Use when: Flutter work touches Xcode, iOS target, SwiftPM, CocoaPods, native plugins, signing, IPA, TestFlight or App Store.

## Core Ideas

- Flutter on iOS still uses Apple platform concepts: Xcode project, Bundle ID, certificates, provisioning profiles, App Store Connect, IPA, TestFlight and App Review.
- As of Flutter 3.44, Flutter uses Swift Package Manager for iOS/macOS native dependencies by default.
- Flutter still supports CocoaPods in maintenance mode and falls back to CocoaPods for dependencies that do not support SwiftPM.
- The CocoaPods registry read-only date in Flutter docs is 2026-12-02. Do not translate this into "CocoaPods stops working".
- Packt's research clone had `IPHONEOS_DEPLOYMENT_TARGET = 12.0`; current Flutter deployment docs say Flutter supports iOS 13 and later. Prefer current official docs for targets.

## Release Flow

- Verify Bundle ID, app record, signing and provisioning.
- Review app icon, launch screen, version/build number and required iOS metadata.
- Run analysis/tests and build release IPA.
- Upload/publish to App Store Connect.
- Use TestFlight or equivalent release-candidate validation before production App Store release.
- Submit App Store metadata, screenshots, privacy labels and review notes.

## Agent Checklist

- Which Flutter, Dart, Xcode and iOS SDK versions are assumed?
- Does every plugin support the target iOS version and dependency manager path?
- Are SwiftPM/CocoaPods fallback dependencies understood?
- Is CI signing configured from a clean checkout?
- Are version/build numbers incremented?

## Source / Provenance

- [Flutter iOS deployment](https://docs.flutter.dev/deployment/ios): iOS release flow and deployment target guidance.
- [Flutter SwiftPM for app developers](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers): SwiftPM default, CocoaPods maintenance/fallback.
