---
name: telegram-mini-apps
description: Use when designing, building, reviewing, validating, debugging, deploying, or operating Telegram Mini Apps and Telegram Web Apps. Trigger for Telegram bot + mini app architecture, launch modes, BotFather setup, initData authentication, backend validation, HMAC/Ed25519 checks, tma.js, Telegram WebApp API, native buttons, theme/viewport/safe area, CloudStorage/DeviceStorage/SecureStorage, biometrics, sensors, location, Telegram Stars/payments, WebView testing, mobile debugging, production readiness, security reviews, and long-term maintenance.
---

# Telegram Mini Apps

Use this skill to design, implement, or review Telegram Mini Apps as production systems. Treat a Mini App as `bot + frontend + backend`, not as a standalone trusted webpage.

## Core Rule

Do not trust the frontend. `initDataUnsafe` is for client convenience only. Sensitive decisions start after backend validation of raw `initData`, `auth_date`, and the correct signature path.

## Reference Routing

Read only the references needed for the current task.

- Always start with `references/01-overview.md` for broad design, implementation, or review.
- For launch entry points, `startapp`, `sendData`, `query_id`, and lifecycle, read `references/02-launch-modes-and-lifecycle.md`.
- For auth model, `initData`, `initDataUnsafe`, session strategy, and trust boundaries, read `references/03-auth-initdata.md`.
- For HMAC, Ed25519, `signature`, `hash`, TTL, and library validation, read `references/04-backend-validation.md`.
- For bot/frontend/backend boundaries, API shape, business logic, and system architecture, read `references/05-frontend-backend-architecture.md`.
- For official WebApp API, `@tma.js/*`, React/TypeScript setup, and feature detection, read `references/06-sdk-api-and-native-capabilities.md`.
- For Telegram-native UI, buttons, events, theme, viewport, fullscreen, safe areas, and mobile UX, read `references/07-ui-theme-viewport.md`.
- For CloudStorage, DeviceStorage, SecureStorage, biometrics, location, and sensors, read `references/08-storage-biometry-sensors-location.md`.
- For invoices, Telegram Stars, `XTR`, payment providers, `pre_checkout_query`, `/paysupport`, and fulfillment, read `references/09-payments-and-stars.md`.
- For local development, test environment, HTTPS tunnels, mocks, and WebView debugging, read `references/10-testing-debugging-local-dev.md`.
- For release hardening, BotFather settings, secrets, observability, QA, and rollout, read `references/11-deployment-production-checklist.md`.
- For audits and pre-release review, read `references/12-common-mistakes.md`.
- For creating or updating this skill, read `references/13-future-skill-outline.md`.

## Workflow

1. Classify the request:
   - New Mini App design: read `01`, `02`, `03`, `04`, `05`, `06`, `07`, `10`, `11`; add `09` if payments are in scope.
   - Code implementation: read the topic file for the touched layer, plus `03` and `04` for auth-sensitive code.
   - Security/auth review: read `03`, `04`, `05`, `11`, `12`.
   - Frontend/UX review: read `06`, `07`, `10`, `12`.
   - Payments work: read `05`, `09`, `10`, `11`, `12`.
   - Native capabilities/storage/biometry/sensors/location: read `06`, `08`, `10`, `12`.
   - Testing/debugging: read `02`, `06`, `07`, `10`.
   - Production readiness review: read `03`, `04`, `05`, `09` if payments, `10`, `11`, `12`.
2. Identify blocking unknowns: launch mode, backend stack, auth/session strategy, payment type, target clients, and deployment environment. Ask only when the answer changes implementation or risk.
3. Prefer the project's existing framework and SDK choices. If none exist, recommend a conservative stack: bot + backend API + mobile-first frontend, with official Telegram docs as source of truth and `@tma.js/*` where TypeScript ergonomics help.
4. Separate facts from engineering advice when docs are not explicit. Mark current-version claims as requiring fresh verification if Telegram Bot API, payments, or SDK compatibility matter.
5. Validate every design against auth, backend ownership, launch mode constraints, WebView behavior, feature detection, payments, observability, and release/rollback.

## Output For New Design

Include:

- Product scope, target Telegram clients, launch modes, and non-goals.
- Bot/frontend/backend architecture and ownership boundaries.
- Auth flow with raw `initData`, backend validation, TTL, and session strategy.
- Data model/API sketch and server-side business rules.
- Frontend SDK/API choice, theme/viewport/buttons/events plan.
- Native capability plan with feature detection and fallbacks.
- Payment flow if relevant, including Stars vs physical goods distinction.
- Local dev, test environment, WebView debugging, and real-device QA plan.
- Production checklist: HTTPS, BotFather settings, secrets, observability, rate limit, rollout, support.
- Risks, assumptions, and next validation steps.

## Output For Review

Lead with risks and missing decisions:

- Critical trust/auth flaws.
- Missing backend validation or weak session strategy.
- Wrong assumptions about launch mode, `sendData`, `startapp`, or query parameters.
- SDK/API compatibility and feature-detection gaps.
- UI/theme/viewport/safe-area regressions.
- Storage/biometry/sensor/location misuse.
- Payment fulfillment and Stars/provider mistakes.
- Local/dev mocks leaking into production.
- Missing real-device/WebView QA, monitoring, rollback, or support process.

## Coding Quality Bar

- Never put bot tokens, provider tokens, or validation secrets in frontend code.
- Never authorize sensitive actions from `initDataUnsafe`, URL params, or client-only state.
- Prefer a maintained validation library when available; if implementing HMAC/Ed25519 manually, use strict parsing, correct data-check-string construction, TTL, and constant-time compare.
- Guard Telegram WebApp calls with support/version checks and fallbacks.
- Use Telegram theme params and viewport/safe-area data instead of assuming browser dimensions.
- Keep browser mocks dev-only and impossible to enable accidentally in production.
- Fulfill payments only after server-side `successful_payment`, never after `openInvoice` UI state or `pre_checkout_query` alone.

## Currentness Guardrail

Telegram WebApp API, Bot API payments, and `@tma.js/*` evolve. For current API names, SDK versions, payment rules, or platform requirements, verify against official Telegram docs and the relevant SDK docs before finalizing implementation.
