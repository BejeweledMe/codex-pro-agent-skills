# Frontend Backend Architecture

## Базовая Архитектура

Production-ready Telegram Mini App проектируется как система из трех частей:

- Telegram Bot.
- Frontend Mini App.
- Backend API.

Bot и Mini App не заменяют backend. Backend нужен для доверия, хранения состояния, бизнес-логики, платежей, rate limit, observability и интеграций.

## Frontend Responsibilities

- Инициализировать WebApp API или SDK.
- Вызвать `ready()` после загрузки критичного UI.
- Управлять theme, viewport, buttons, haptics, popups.
- Отправлять raw `initData` на backend.
- Проверять доступность native capabilities перед вызовом.
- Держать UI responsive, mobile-first и Telegram-native.

## Backend Responsibilities

- Проверять raw `initData`.
- Создавать собственный trusted user context.
- Хранить и обновлять пользователей.
- Выполнять business rules.
- Выполнять payment fulfillment после подтвержденного Bot API update.
- Хранить secrets и env config.
- Логировать auth/payment/business ошибки.
- Ставить rate limit на API endpoints.

## Bot Responsibilities

- Создать launch entry points: menu, main app, buttons, direct links.
- Обрабатывать Bot API updates.
- Создавать invoices и отвечать на payment updates.
- Отправлять сообщения пользователю, если пользователь дал нужные permissions и сценарий это допускает.

## Архитектурные Решения

Для простых одноразовых форм можно использовать keyboard button + `sendData`. Для полноценного продукта лучше строить backend API, потому что:

- `sendData` ограничен 4096 байтами.
- Он закрывает Mini App.
- Он доступен не во всех launch modes.
- Он не заменяет server-side validation и бизнес-логику.

## Рекомендованный Поток API

1. Frontend загружается внутри Telegram.
2. Frontend получает raw `initData`.
3. Frontend вызывает `/auth/tma` или передает `Authorization: tma ...`.
4. Backend валидирует `initData`.
5. Backend возвращает короткоживущую session cookie/token или принимает raw `initData` per request.
6. Дальнейшие API calls используют trusted backend context.

## Связанные Файлы

- [01-launch-modes-and-lifecycle.md](01-launch-modes-and-lifecycle.md)
- [02-auth-initdata.md](02-auth-initdata.md)
- [08-payments-and-stars.md](08-payments-and-stars.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
