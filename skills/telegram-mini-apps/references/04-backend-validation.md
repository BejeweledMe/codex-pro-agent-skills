# Backend Validation

## Зачем

Backend validation - обязательная часть production auth. Без нее любой пользователь может подменить клиентские данные и попытаться выдать себя за другого пользователя.

## HMAC Validation С Bot Token

Алгоритм проверки raw `initData`:

1. Распарсить raw query string как пары `key=value`.
2. Исключить поле `hash`, но сохранить его значение для сравнения.
3. Отсортировать оставшиеся пары по ключу.
4. Собрать data-check-string в формате `key=value`, разделитель - line feed `\n`.
5. Получить secret key: HMAC-SHA256 от bot token с ключом `WebAppData`.
6. Посчитать HMAC-SHA256 от data-check-string с этим secret key.
7. Сравнить полученный hex hash с `hash` из init data.
8. Проверить `auth_date`, чтобы не принимать устаревшие данные.

Если пишете свою реализацию, используйте constant-time compare и строгий parser query string. Не нормализуйте JSON-поля вручную.

## Third-Party Validation

Telegram поддерживает validation без передачи bot token третьей стороне. Для этого проверяется параметр `signature`, а не `hash`: Telegram подписывает data-check-string Ed25519-подписью, проверяющая сторона использует public key Telegram и `bot_id`.

Data-check-string для third-party validation отличается от HMAC-variant: сначала идет `bot_id:WebAppData`, затем line feed, затем поля init data, отсортированные по ключу, исключая `hash` и `signature`. Для test environment нужны test public keys или test-mode flag в библиотеке; production и test ключи нельзя смешивать.

Практическое правило: если backend ваш, проще и понятнее HMAC через bot token. Если validation выполняет сторонний processor, используйте third-party validation.

## Библиотеки

Для Node.js документация `tma.js` предлагает `@tma.js/init-data-node`:

- `validate`
- `isValid`
- `validate3rd`
- `isValid3rd`

У validation есть expiration-настройки. Не полагайтесь на default без явного решения: для auth-сценария задавайте TTL исходя из риска продукта.

## Ошибки, Которые Нужно Отличать

- Нет `auth_date`.
- Нет `hash`.
- Нет `signature` для third-party validation.
- Подпись не совпадает.
- Данные просрочены.
- Некорректный формат raw query string.
- Использован test/prod ключ не от того окружения.

## Связанные Файлы

- [02-auth-initdata.md](02-auth-initdata.md)
- [04-frontend-backend-architecture.md](04-frontend-backend-architecture.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
