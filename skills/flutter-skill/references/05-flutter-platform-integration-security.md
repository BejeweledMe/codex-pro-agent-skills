# Flutter Platform Integration, Security, And Privacy

Use when: Flutter feature touches native plugins, platform channels, permissions, entitlements, native SDKs, auth, secrets or App Store privacy checks.

## Core Ideas

- Platform integration is where Flutter abstractions meet iOS reality: permissions, entitlements, Info.plist, callbacks, background modes, review policies and device behavior.
- Use a mature plugin when it covers the requirement, supports iOS, has compatible native dependencies and is maintained.
- Write native bridge code when plugin behavior is insufficient, the Apple API is too new, or the feature is product-critical.
- Keep plugin/native APIs behind services or adapters.
- Test plugin behavior on real devices.

## Security / Privacy

- Mobile client code is not a trusted security boundary.
- Backend must enforce auth, authorization, payments and business rules independently of client UI.
- Secrets do not belong in Flutter source, assets, plist files or app bundles.
- App Store privacy labels, Apple privacy manifests, required-reason API declarations and SDK signatures are separate checks.
- Apple's third-party SDK requirements list `Flutter` and multiple Flutter-related SDKs/plugins; listed SDKs require privacy manifests, and listed binary dependencies also require signatures in covered submissions.

## Agent Checklist

- What permissions, capabilities and entitlements are required?
- What happens when permission is denied, limited, restricted or unavailable?
- Is plugin iOS setup documented and checked?
- Are privacy manifests/signatures required for included SDKs?
- Are auth tokens stored securely and scoped appropriately?

## Source / Provenance

- [Flutter SwiftPM docs](https://docs.flutter.dev/packages-and-plugins/swift-package-manager/for-app-developers)
- [Apple third-party SDK requirements](https://developer.apple.com/support/third-party-SDK-requirements/)
- [Flutter app architecture](https://docs.flutter.dev/app-architecture/guide)
