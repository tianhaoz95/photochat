# Translated Messages

## Adding new message

### Add message config

The top-level message file, `intl_messages.arb`, contains the config for all messages. To add a new message, add the following into `intl_messages.arb`:

```json
"awesomeNewMessage": "An awesome new message",
"@awesomeNewMessage": {
  "description": "Example for how to add a new message",
  "type": "text",
  "placeholders": {}
}
```

### Add localized translations

After the top-level message is added, add localized message by adding the following into `intl_[locale].arb` (e.g. `intl_zh.arb`):

```json
// for intl_zh.arb
"awesomeNewMessage": "一条新信息",
"@awesomeNewMessage": {
  "description": "新信息例子",
  "type": "text"
}
// for intl_en.arb
"awesomeNewMessage": "An awesome new message",
"@awesomeNewMessage": {
  "description": "Example for how to add a new message",
  "type": "text"
}
```

### Generate dart code from translations

```bash
flutter pub run intl_translation:generate_from_arb --output-dir=lib/services/i18n/wrappers lib/services/i18n/i18n.dart lib/services/i18n/messages/*.arb
```

> note: assuming running from the Flutter project root