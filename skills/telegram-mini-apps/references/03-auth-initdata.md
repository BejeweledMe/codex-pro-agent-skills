# Auth And Init Data

## Главное Правило

Frontend не является доверенным основанием. `initDataUnsafe` нельзя использовать для авторизации, начисления баланса, выдачи товара, прав доступа или любых security-sensitive решений.

Доверенный поток выглядит так:

1. Frontend получает raw `initData` из Telegram WebApp API/SDK.
2. Frontend отправляет raw строку на backend, часто через `Authorization: tma <raw-init-data>`.
3. Backend проверяет подпись и свежесть данных.
4. Backend использует проверенные поля пользователя/чата для собственной сессии или для per-request auth.

## Что Такое `initData`

`initData` - raw query string, который Telegram подписывает данными, связанными с запуском Mini App. В нем могут быть:

- `auth_date`
- `hash`
- `signature`
- `query_id`
- `user`
- `receiver`
- `chat`
- `chat_type`
- `chat_instance`
- `start_param`
- `can_send_after`

Состав зависит от launch mode. Поэтому код должен быть готов к отсутствию optional-полей.

`hash` используется для server-side validation через bot token. `signature` используется для third-party validation через Ed25519 public key Telegram и `bot_id`, когда проверяющей стороне нельзя раскрывать bot token.

## `initData` vs `initDataUnsafe`

- `initData` - raw строка для server-side validation.
- `initDataUnsafe` - распарсенный объект, удобный для отображения на клиенте, но недоверенный.

Практический подход: использовать `initDataUnsafe.user.first_name` для приветствия можно, но решение "этот пользователь имеет доступ к платной функции" должен принимать backend после проверки raw `initData`.

## Сессии

Есть два основных подхода:

- Per-request validation: frontend отправляет raw `initData` на каждый чувствительный backend-запрос.
- Session exchange: backend валидирует raw `initData` один раз, затем выдает собственную короткоживущую сессию.

Для большинства production-приложений второй вариант удобнее, но он не отменяет TTL, revoke strategy и защиту от replay.

## Нельзя

- Хранить bot token во frontend.
- Проверять подпись на frontend.
- Доверять Telegram user id из URL или `initDataUnsafe`.
- Делать бессрочную сессию из единожды полученного `initData`.
- Привязывать критичные действия только к клиентскому состоянию.

## Связанные Файлы

- [03-backend-validation.md](03-backend-validation.md)
- [04-frontend-backend-architecture.md](04-frontend-backend-architecture.md)
- [11-common-mistakes.md](11-common-mistakes.md)
