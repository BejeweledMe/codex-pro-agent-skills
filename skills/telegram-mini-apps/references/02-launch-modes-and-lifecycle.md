# Launch Modes And Lifecycle

## Способы Запуска

Официальная документация Telegram описывает семь основных способов запуска Mini Apps:

- Main Mini App из профиля бота.
- Keyboard button через `KeyboardButton.web_app`.
- Inline button через `InlineKeyboardButton.web_app`.
- Menu button бота.
- Inline mode через `InlineQueryResultsButton`.
- Direct link.
- Attachment menu.

Выбор launch mode влияет на доступный контекст, способ возврата данных и UX. Например, `sendData` подходит для простых keyboard-flow, а полноценный сервис обычно требует backend API и server-side auth.

## Lifecycle

Типовой lifecycle:

1. Разработчик создает бота и настраивает Mini App URL в BotFather или Bot API.
2. Пользователь открывает Mini App из одного из launch modes.
3. Telegram открывает WebView и передает launch parameters.
4. Frontend инициализирует официальный WebApp API или SDK.
5. Frontend вызывает `ready()` после загрузки критичного интерфейса.
6. Frontend отправляет raw `initData` на backend.
7. Backend валидирует подпись и `auth_date`, затем создает trusted server context.

## Важные Параметры

- `tgWebAppData` содержит raw init data.
- `tgWebAppStartParam` передает значение `startapp`/`startattach`.
- `start_param` дублируется внутри init data.
- `chat_type` и `chat_instance` появляются в direct/main link сценариях и помогают учитывать контекст чата.
- `query_id` нужен для сценариев, где бот отвечает через `answerWebAppQuery`.

## `sendData`

`Telegram.WebApp.sendData` отправляет строку боту как service message, закрывает Mini App и имеет лимит 4096 байт. Этот метод работает только для Mini Apps, открытых через keyboard button. Его стоит рассматривать как удобный механизм для простых форм, но не как универсальный транспорт для сложного приложения.

## `startapp`

Direct/main links используют `startapp` как один компактный параметр запуска. Значение start parameter ограничено длиной до 512 символов и набором `A-Z`, `a-z`, `0-9`, `_`, `-`. Для нескольких значений используйте собственное кодирование внутри одного значения, например base64url или строго валидируемый delimiter.

Не рассчитывайте, что произвольные query params сохранятся так же, как в обычном web app. Важное исключение: `mode=compact` - официальный query parameter для direct/main links, который меняет стартовую высоту Mini App.

## Связанные Файлы

- [02-auth-initdata.md](02-auth-initdata.md)
- [04-frontend-backend-architecture.md](04-frontend-backend-architecture.md)
- [06-ui-theme-viewport.md](06-ui-theme-viewport.md)
