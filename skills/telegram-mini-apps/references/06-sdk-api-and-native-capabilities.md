# SDK API And Native Capabilities

## Два Слоя Интеграции

Есть два практических слоя:

- Официальный Telegram WebApp API через `telegram-web-app.js`.
- Community SDK `@tma.js/*`, который дает TypeScript-friendly wrappers, components, helpers и backend packages.

Официальная документация остается source of truth по платформе. SDK удобен для разработки, но его версию и поддержку новых Bot API capabilities нужно проверять.

## Официальный WebApp API

Официальный способ подключения:

```html
<script src="https://telegram.org/js/telegram-web-app.js"></script>
```

Скрипт должен быть в `head` до других скриптов. После подключения доступен `window.Telegram.WebApp`.

Ключевые возможности:

- `initData` и `initDataUnsafe`.
- `ready()`, `expand()`, `close()`.
- `requestFullscreen()`, `exitFullscreen()`, `hideKeyboard()`, `requestChat()`.
- `BackButton`, `MainButton`, `SecondaryButton`, `SettingsButton`.
- `BottomButton.iconCustomEmojiId` и совместимость с историческим названием `MainButton`.
- `HapticFeedback`.
- `CloudStorage`, `DeviceStorage`, `SecureStorage`.
- `BiometricManager`, `LocationManager`, sensors.
- `openInvoice`, `openLink`, `openTelegramLink`.
- `addToHomeScreen()`, `checkHomeScreenStatus()`.
- `setEmojiStatus()`, `requestEmojiStatusAccess()`.
- `shareToStory()`, `shareMessage()`, `downloadFile()`.
- `onEvent`/`offEvent`.

Этот список не исчерпывающий. Telegram WebApp API активно меняется: перед реализацией capability нужно сверять актуальную версию Bot API, official Web Apps changelog и поддержку в выбранном SDK.

## `tma.js`

`tma.js` - TypeScript monorepo для Telegram Mini Apps. Важные пакеты:

- `@tma.js/sdk` - client-side SDK.
- `@tma.js/sdk-react` - React integration.
- `@tma.js/init-data-node` - server-side parse/validate/sign init data.
- `@tma.js/create-mini-app` - scaffold CLI.

Типовой client setup в SDK-подходе:

- вызвать `init()`;
- mounted components: back button, mini app, theme params, viewport;
- восстановить/получить init data;
- bind CSS variables для theme/viewport, если SDK это поддерживает;
- включать debug tools только в dev.

## Feature Detection

Capabilities зависят от версии Telegram client, платформы и Bot API. Перед вызовом:

- проверяйте version/support;
- держите fallback path;
- не делайте critical flow зависящим только от sensor/biometry/location;
- не вызывайте методы, требующие user interaction, из фонового кода.

## Практический Выбор

- Для простого vanilla app можно использовать официальный `window.Telegram.WebApp`.
- Для React/TypeScript production проекта удобнее `@tma.js/sdk`/`@tma.js/sdk-react` плюс backend package для validation.
- Для криптографии и parsing init data лучше брать поддерживаемую библиотеку, а не писать руками.

## Связанные Файлы

- [02-auth-initdata.md](02-auth-initdata.md)
- [06-ui-theme-viewport.md](06-ui-theme-viewport.md)
- [07-storage-biometry-sensors-location.md](07-storage-biometry-sensors-location.md)
