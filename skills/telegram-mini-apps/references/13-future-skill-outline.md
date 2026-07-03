# Future Skill Outline

## Цель Skill

Skill должен помогать агенту проектировать, писать, ревьюить и сопровождать Telegram Mini Apps на production-ready уровне. Он должен не просто знать API, а проверять архитектуру, security boundary, auth flow, platform limitations, UX и production operations.

## Поведение Агента

Агент должен:

- Начинать с выяснения launch mode, типа продукта, backend stack и payment requirements.
- Проверять, что система спроектирована как `bot + frontend + backend`.
- Не принимать frontend auth за trusted auth.
- Считать raw `initData` и backend validation обязательными.
- Требовать feature detection для Telegram-native capabilities.
- Требовать real-device/WebView QA, а не только browser testing.
- Держать future maintenance: версии Bot API, SDK compatibility, observability, graceful fallbacks.

## Обязательные Чеклисты

### Architecture Checklist

- Есть bot, frontend, backend.
- Определены launch modes.
- Определен способ передачи raw `initData`.
- Определен session strategy.
- Определены payment flows, если есть платежи.
- Определены unsupported-client fallbacks.

### Security Checklist

- `initDataUnsafe` не используется как trusted source.
- Raw `initData` валидируется на backend.
- Проверяется `auth_date`.
- Bot token не попадает во frontend.
- Secrets лежат в env/secrets manager.
- API endpoints имеют rate limit.
- Admin access ограничен.

### Frontend Checklist

- `ready()` вызывается после critical UI.
- Theme params подключены.
- Viewport/safe area учтены.
- Native buttons имеют loading/disabled states.
- Event handlers отписываются.
- SDK/API calls имеют feature detection.
- Browser mock выключается в production.

### Testing Checklist

- Test environment или HTTPS tunnel настроены.
- Проверены iOS, Android, Desktop/Web.
- Проверены debug flows.
- Проверены invalid/expired init data.
- Проверены payment success/failure paths.
- Проверены light/dark themes, keyboard, fullscreen, slow network.

### Production Checklist

- HTTPS production URL.
- BotFather settings корректны.
- Webhook mode для production bot, если применимо.
- Observability настроена.
- Payment support/terms готовы.
- Static assets оптимизированы.
- Dependencies обновляются.

## Code Recipes, Которые Стоит Добавить В Skill

- React/TypeScript bootstrap with `@tma.js/sdk-react`.
- Server middleware для `Authorization: tma <raw-init-data>`.
- Node validation через `@tma.js/init-data-node`.
- HMAC validation reference implementation с constant-time compare.
- Ed25519 third-party validation recipe.
- Theme/viewport hook.
- Back/Main/Secondary button hooks.
- Dev-only Telegram mock guard.
- Payment invoice/openInvoice/update handling skeleton.

## Review Prompts

Skill должен уметь задавать такие вопросы в ревью:

- Что будет, если пользователь подменит `initDataUnsafe`?
- Где именно проверяется подпись `initData`?
- Какой TTL у auth/session?
- Какой launch mode используется и какие данные он реально дает?
- Что произойдет, если метод WebApp API недоступен?
- Есть ли iOS/Android/Desktop расхождения?
- Как приложение ведет себя при нестабильном viewport?
- Что считается фактом успешной оплаты?
- Как отключаются dev mocks и debug tools?
