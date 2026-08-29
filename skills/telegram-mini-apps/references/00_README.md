# Telegram Mini Apps Knowledge Base

Дата подготовки: 2026-07-03.

Эта папка собрана как база знаний для будущего skill'а по проектированию, разработке, проверке и поддержке Telegram Mini Apps. Материал опирается на официальную документацию Telegram Mini Apps, практические статьи Habr и документацию/репозиторий `tma.js`.

## Порядок Чтения

1. [01-overview.md](01-overview.md) - базовая модель Telegram Mini Apps, требования и роли bot/frontend/backend.
2. [02-launch-modes-and-lifecycle.md](02-launch-modes-and-lifecycle.md) - способы запуска, lifecycle, `startapp`, `sendData`, `query_id`.
3. [03-auth-initdata.md](03-auth-initdata.md) - модель доверия, `initData`, `initDataUnsafe`, поток auth.
4. [04-backend-validation.md](04-backend-validation.md) - серверная проверка подписи, HMAC, Ed25519, TTL, библиотеки.
5. [05-frontend-backend-architecture.md](05-frontend-backend-architecture.md) - разделение ответственности между bot, frontend и backend.
6. [06-sdk-api-and-native-capabilities.md](06-sdk-api-and-native-capabilities.md) - официальный WebApp API, `@tma.js/*`, feature detection.
7. [07-ui-theme-viewport.md](07-ui-theme-viewport.md) - Telegram-native UI, темы, buttons, events, viewport, fullscreen, safe area.
8. [08-storage-biometry-sensors-location.md](08-storage-biometry-sensors-location.md) - storage, biometry, sensors, location, ограничения.
9. [09-payments-and-stars.md](09-payments-and-stars.md) - invoices, Stars, digital vs physical goods, payment flow.
10. [10-testing-debugging-local-dev.md](10-testing-debugging-local-dev.md) - local dev, test environment, HTTPS tunnels, WebView debugging.
11. [11-deployment-production-checklist.md](11-deployment-production-checklist.md) - production checklist.
12. [12-common-mistakes.md](12-common-mistakes.md) - частые ошибки и проверки перед релизом.
13. [13-future-skill-outline.md](13-future-skill-outline.md) - что вынести в будущий skill для агентов.

## Единая Позиция

Telegram Mini App - это web app внутри Telegram, но production-ready система должна проектироваться как связка `bot + frontend + backend`. Frontend получает Telegram-контекст и управляет UX, но не является security boundary. Backend проверяет `initData`, хранит секреты, управляет пользователями, бизнес-логикой и платежами.

`initDataUnsafe` можно использовать только как удобное клиентское представление для UI, но не как доверенное основание. Доверие начинается после server-side validation raw `initData`.

Browser mock полезен для быстрой UI-разработки, но не заменяет тестирование в реальном Telegram WebView на iOS, Android, Desktop/Web и в test environment.
