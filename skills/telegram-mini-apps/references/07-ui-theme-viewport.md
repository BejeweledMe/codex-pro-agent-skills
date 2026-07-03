# UI Theme And Viewport

## Цель UX

Mini App должен ощущаться как часть Telegram: быстрый, mobile-first, responsive, поддерживающий темы, нативные controls и ограничения WebView.

## Theme

Telegram передает theme params, которые нужно использовать вместо жестко заданной палитры. Theme можно получить из launch parameters или запросить через platform method. При изменении темы Telegram отправляет событие theme change.

Практические правила:

- Используйте Telegram CSS variables или SDK binding для theme params.
- Проверяйте light/dark режимы.
- Не делайте UI, который хорошо выглядит только в одной теме.
- Синхронизируйте header/background/bottom bar colors с текущей темой.

## Buttons And Controls

WebApp API дает Telegram-native controls:

- Back Button.
- Main Button / Bottom Button.
- Secondary Button.
- Settings Button.
- Popups.
- Haptic Feedback.

Main/Bottom buttons имеют text, active, visible, colors, loader/progress state. Если действие долгое, показывайте loading state и блокируйте повторный submit.

## Events

Mini App получает события от Telegram через `onEvent`/`offEvent` или SDK wrappers. События нужны для:

- button clicks;
- viewport changes;
- theme changes;
- invoice closed;
- popup closed;
- QR/clipboard callbacks;
- fullscreen/safe-area changes.

Всегда отписывайте обработчики при unmount, особенно в React.

## Viewport

На мобильных Telegram открывает Mini App в bottom sheet. Размер может меняться во время жестов и анимаций.

Важные поля:

- `viewportHeight` - текущая высота, может часто меняться.
- `viewportStableHeight` - последняя стабильная высота.
- `isExpanded`/`expanded` - достигнута максимальная высота.
- fullscreen state.
- safe area и content safe area.

Не закрепляйте нижние элементы на `viewportHeight` во время жестов. Для стабильной компоновки используйте stable height, safe-area variables и события изменения viewport.

## Fullscreen

Fullscreen полезен для игр, media-first интерфейсов и immersive UX. Он требует аккуратной работы с header/status bar, safe area и ориентацией. Не включайте fullscreen только ради "больше места", если это ухудшает навигацию.

## Связанные Файлы

- [05-sdk-api-and-native-capabilities.md](05-sdk-api-and-native-capabilities.md)
- [09-testing-debugging-local-dev.md](09-testing-debugging-local-dev.md)
- [11-common-mistakes.md](11-common-mistakes.md)
