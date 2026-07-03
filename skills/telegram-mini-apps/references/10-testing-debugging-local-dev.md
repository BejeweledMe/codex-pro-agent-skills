# Testing Debugging Local Dev

## Главная Идея

Telegram Mini App нельзя полноценно проверить только в обычном браузере. Browser mock полезен для UI/dev smoke, но реальные проблемы часто проявляются внутри Telegram WebView, на конкретной платформе и версии клиента.

## Local Dev

В production Telegram требует HTTPS URL. Для разработки есть варианты:

- Telegram test environment, где разрешены HTTP/IP links.
- HTTPS tunnel к локальному dev server.
- Staging-домен с dev bot.
- Browser mock для быстрых UI-итераций.

Mock Telegram env нельзя переносить в production bundle или включать без явного dev flag.

## Test Environment

Telegram test environment отделен от production. Для него нужны отдельный пользователь и отдельный bot. В test environment можно тестировать HTTP/IP links, что удобно для ранней разработки.

## Debugging

Поддерживаемые подходы:

- Telegram Desktop beta: включить webview inspection в experimental settings.
- Telegram macOS beta: включить Debug Mini Apps через debug menu.
- Android: включить USB debugging, WebView Debug в Telegram, затем использовать `chrome://inspect/#devices`.
- iOS: включить Safari Web Inspector и инспектировать WebView через Safari на macOS.
- Eruda: lightweight console внутри приложения как fallback, особенно когда native inspector недоступен.

## Что Тестировать

- Launch mode, который реально будет в production.
- `initData` auth flow и TTL.
- Поведение при invalid/expired init data.
- Theme switching.
- Viewport resize, keyboard, bottom sheet, safe area.
- Back/Main/Secondary buttons.
- iOS, Android, Desktop/Web различия.
- Slow network и cold start.
- Payment happy path и failure path.
- Отсутствие dev mocks в production build.

## Known Platform Caveats

Практические материалы отмечают, что WebView может вести себя иначе, чем обычный Chrome/Safari, а SSR-подходы нужно аккуратно адаптировать: Telegram API доступен через `window`, то есть только на клиенте.

## Связанные Файлы

- [01-launch-modes-and-lifecycle.md](01-launch-modes-and-lifecycle.md)
- [06-ui-theme-viewport.md](06-ui-theme-viewport.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
