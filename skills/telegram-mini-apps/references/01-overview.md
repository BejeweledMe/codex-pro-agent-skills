# Overview

## Суть

Telegram Mini App - это веб-приложение, которое открывается внутри Telegram WebView и взаимодействует с Telegram через WebApp API. Практически это обычный web frontend, но с Telegram-контекстом: theme params, launch params, нативные кнопки, события, платежи, storage и другие capabilities.

Сейчас Mini App строится вокруг Telegram Bot: без бота Mini App не создается как самостоятельный продукт. Telegram загружает URL приложения в WebView, а бот и BotFather участвуют в настройке запуска.

## Production Baseline

- Telegram Bot создан и настроен через BotFather.
- Mini App URL указывает на публичный HTTPS-домен.
- Frontend адаптирован под mobile-first WebView, темы Telegram и viewport.
- Backend принимает raw `initData`, проверяет подпись и `auth_date`.
- Bot token, payment provider tokens и другие секреты живут только на backend/env.
- Есть dev/staging/prod окружения и real-device QA.

## Роли Компонентов

- Bot: точка входа, Bot API flows, menu/main app/inline/keyboard сценарии, invoices, updates.
- Frontend: UI, Telegram WebApp API/SDK, theme, buttons, viewport, launch params, передача raw `initData`.
- Backend: users, sessions, server-side validation, business logic, rate limit, платежная выдача товара, audit logs.

## Почему Это Важно

Mini App выглядит как часть Telegram, но остается web app. Поэтому она наследует ограничения WebView, клиентской среды и разных Telegram-клиентов. Системная ошибка - относиться к Mini App как к обычной странице в Chrome или как к полностью доверенному мобильному приложению.

## Связанные Файлы

- [01-launch-modes-and-lifecycle.md](01-launch-modes-and-lifecycle.md)
- [02-auth-initdata.md](02-auth-initdata.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
