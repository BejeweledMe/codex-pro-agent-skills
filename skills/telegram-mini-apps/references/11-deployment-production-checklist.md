# Deployment Production Checklist

## Environments

- Local, staging и production изолированы.
- Для dev/staging лучше использовать отдельного бота или отдельные настройки.
- Production URL настроен в BotFather и указывает на HTTPS.
- Test environment не смешивается с production.

## Security

- Backend валидирует raw `initData`.
- Проверяется `auth_date` и TTL.
- Bot token и provider tokens хранятся только на backend/env.
- CORS ограничен нужными origin.
- CSP не ломает Telegram WebView, но ограничивает лишние origins/domains.
- API endpoints имеют rate limit.
- Admin-интерфейсы закрыты IP/VPN/auth.
- Dependencies обновляются, CVE отслеживаются.

## Frontend Build

- Dev mocks выключены в production.
- `ready()` вызывается после загрузки критичного UI.
- Static assets минифицированы и имеют content hash.
- Gzip/Brotli включены на CDN/server.
- UI проверен в light/dark themes.
- Viewport/safe area протестированы на iOS/Android/Desktop.

## Backend And Bot

- Bot работает через webhook в production, если нужна масштабируемость и быстрые updates.
- Webhook endpoint защищен и наблюдаем.
- Auth/payment/business errors логируются.
- Public GET-запросы кэшируются только когда это безопасно и идемпотентно.
- Redis/Memcached используются там, где они реально снижают нагрузку.

## Payments

- Определен тип товара: digital или physical.
- Digital goods/services внутри Telegram используют Stars/XTR.
- Physical goods/services используют корректный provider setup.
- Fulfillment происходит только после `successful_payment`.
- Payment ids сохраняются.
- Для digital goods/services bot или Mini App поддерживает `/paysupport`.
- Для возвратов Stars предусмотрен flow через `refundStarPayment`.
- Есть terms/support/refund/dispute process.

## QA Before Release

- Проверены все production launch modes.
- Проверены invalid/expired init data.
- Проверены iOS, Android, Desktop/Web.
- Проверены slow network и reload.
- Проверены analytics/logging без утечки secrets/PII.
- Проверены feature fallbacks.

## Связанные Файлы

- [00-overview.md](00-overview.md)
- [02-auth-initdata.md](02-auth-initdata.md)
- [03-backend-validation.md](03-backend-validation.md)
- [08-payments-and-stars.md](08-payments-and-stars.md)
- [09-testing-debugging-local-dev.md](09-testing-debugging-local-dev.md)
