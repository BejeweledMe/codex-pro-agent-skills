# Payments And Stars

## Ключевая Модель

Mini App не должна сама "подтверждать оплату". Frontend может открыть invoice UI, но решение о выдаче товара или включении доступа принимает backend/bot после подтвержденного Bot API update.

## `openInvoice`

WebApp API поддерживает `openInvoice`. Mini App открывает invoice по ссылке, а затем получает событие/callback закрытия invoice со статусом. Этот статус полезен для UX, но финальное fulfillment-решение должно быть привязано к backend обработке Bot API payment updates.

## Digital Goods And Telegram Stars

Для digital goods/services внутри Telegram используются Telegram Stars, currency `XTR`. Официальная документация Telegram указывает, что digital goods/services внутри Telegram должны продаваться через Stars, а сторонние payment providers/другие валюты для этого сценария недопустимы.

Production flow для Stars:

1. Bot/backend создает invoice через `sendInvoice` с `currency: "XTR"`.
2. Для digital goods/services `provider_token` можно оставлять пустым: provider token нужен для physical goods/services.
3. Bot получает update с `pre_checkout_query`.
4. Bot отвечает через `answerPreCheckoutQuery` в течение 10 секунд.
5. Bot ждет update с `successful_payment`.
6. Backend сохраняет `telegram_payment_charge_id`.
7. Только после этого backend выдает товар/доступ.

Важная деталь: успешный ответ на `pre_checkout_query` не равен успешной оплате.

## Physical Goods And Services

Для physical goods/services Telegram Bot Payments могут использовать сторонних провайдеров. Telegram не хранит платежные данные: sensitive payment data обрабатывают payment providers. Telegram также поддерживает Apple Pay и Google Pay для соответствующих платежных сценариев.

## Live Checklist Для Payments

- Проверить, digital или physical товар продается.
- Для digital goods использовать Stars/XTR.
- Для physical goods настроить provider token через BotFather.
- Не выдавать товар до `successful_payment`.
- Сохранять payment ids для поддержки и возможных refunds.
- Для digital goods/services поддерживать `/paysupport` и процесс обработки payment disputes.
- Для возвратов Stars использовать Bot API method `refundStarPayment`.
- Подготовить `/terms`, поддержку пользователей и dispute process.
- Мониторить payment errors и fulfillment failures.

## Связанные Файлы

- [04-frontend-backend-architecture.md](04-frontend-backend-architecture.md)
- [10-deployment-production-checklist.md](10-deployment-production-checklist.md)
- [11-common-mistakes.md](11-common-mistakes.md)
