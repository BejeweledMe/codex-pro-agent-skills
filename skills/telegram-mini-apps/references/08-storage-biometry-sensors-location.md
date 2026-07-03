# Storage Biometry Sensors Location

## Storage В Telegram Mini Apps

Telegram WebApp API дает несколько storage-механизмов. Их нельзя смешивать с backend database: storage в клиенте нужен для локального состояния, preferences и небольших пользовательских данных.

## CloudStorage

CloudStorage хранится в Telegram cloud storage для конкретного бота и пользователя:

- до 1024 items на пользователя для бота;
- key: 1-128 символов, разрешены `A-Z`, `a-z`, `0-9`, `_`, `-`;
- value: до 4096 символов.

Используйте для небольших настроек: скрыть подсказку, выбранный режим, локальный UI-state. Не используйте как базу данных, ledger, source of truth или хранилище секретов.

## DeviceStorage

DeviceStorage добавлен в Bot API 9.0. Это persistent local storage на устройстве пользователя, доступное только боту, который его создал. Официальная документация описывает лимит до 5 MB на пользователя для бота.

Подходит для локальных preference/state, которые не обязаны синхронизироваться между устройствами.

## SecureStorage

SecureStorage добавлен в Bot API 9.0 для sensitive local data. На iOS используется Keychain, на Android - Keystore; значения хранятся encrypted at rest. Документация указывает лимит до 10 items на пользователя.

Даже при SecureStorage не храните bot token. Для пользовательской сессии используйте короткий TTL, revoke strategy и backend checks.

## Biometry

`BiometricManager` требует инициализации перед использованием. Он работает с доступностью биометрии, permission, biometric token, `deviceId`, `requestAccess`, `authenticate`, `updateBiometricToken`.

Практический подход:

- Запрашивать доступ только после явного user action.
- Объяснять пользователю, зачем нужна биометрия.
- Держать fallback path.
- Не считать biometric success заменой backend authorization.

## Location And Sensors

Bot API 8.0 добавил:

- `LocationManager`;
- `Accelerometer`;
- `DeviceOrientation`;
- `Gyroscope`.

Сенсоры стартуют/останавливаются и отправляют changed/failed events. Частота обновления может отличаться от запрошенной, а часть устройств/клиентов может не поддерживать нужные данные.

## Связанные Файлы

- [05-sdk-api-and-native-capabilities.md](05-sdk-api-and-native-capabilities.md)
- [06-ui-theme-viewport.md](06-ui-theme-viewport.md)
- [11-common-mistakes.md](11-common-mistakes.md)
