# Common Mistakes

## Auth And Trust

- Доверять `initDataUnsafe`.
- Проверять auth только на frontend.
- Отправлять на backend распарсенный объект вместо raw `initData`.
- Не проверять `auth_date`.
- Делать бессрочную сессию из одного запуска Mini App.
- Хранить bot token или payment provider token во frontend.
- Хранить вечный JWT в `localStorage`.

## Launch And Params

- Ожидать, что обычные query params будут работать как в обычном сайте.
- Использовать несколько произвольных query params вместо одного `startapp`/`startattach` значения. Исключение: официально поддержанный `mode=compact`.
- Забыть ограничения start parameter: до 512 символов, только `A-Z`, `a-z`, `0-9`, `_`, `-`.
- Не валидировать формат start parameter.
- Использовать `sendData` для сложного приложения, где нужен backend API.
- Забывать, что `sendData` закрывает Mini App и работает только в keyboard button flow.

## SDK And Platform

- Не проверять поддержку метода/версии клиента.
- Не держать fallback для biometry, location, sensors, fullscreen.
- Считать, что все Telegram-клиенты ведут себя одинаково.
- Полагаться на SSR для Telegram-only данных, которые доступны только через `window`.
- Оставлять browser mock включенным в production.

## UX

- Не вызвать `ready()` вовремя.
- Не учитывать theme params.
- Не тестировать dark mode.
- Закреплять нижние элементы на нестабильном `viewportHeight`.
- Игнорировать safe area в fullscreen.
- Делать heavy animations без учета слабых устройств.
- Не тестировать keyboard behavior на iOS и Android.

## Testing And Production

- Проверять только обычный браузер.
- Не тестировать iOS.
- Использовать production bot для экспериментальной разработки.
- Оставить `localhost` или HTTP URL в production-настройках.
- Не настроить monitoring auth/payment errors.
- Выдавать товар после `pre_checkout_query`, не дождавшись `successful_payment`.

## Быстрый Audit

Перед релизом спросить:

1. Где валидируется raw `initData`?
2. Какой TTL у auth/session?
3. Где лежат bot token и provider tokens?
4. Какие launch modes реально поддержаны?
5. Что произойдет на неподдержанном Telegram client?
6. Как приложение выглядит в light/dark themes?
7. Как layout ведет себя при keyboard/bottom sheet/fullscreen?
8. Проверены ли iOS, Android, Desktop/Web?
9. Отключены ли mocks/debug tools?
10. Как backend узнает, что payment действительно успешен?

## Связанные Файлы

- [02-auth-initdata.md](02-auth-initdata.md)
- [03-backend-validation.md](03-backend-validation.md)
- [06-ui-theme-viewport.md](06-ui-theme-viewport.md)
- [09-testing-debugging-local-dev.md](09-testing-debugging-local-dev.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
