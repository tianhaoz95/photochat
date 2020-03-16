import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:photochatapp/services/i18n/wrappers/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    String name = locale.toString();
    if (locale != null &&
        locale.countryCode != null &&
        locale.countryCode.isNotEmpty) {
      name = locale.languageCode;
    }
    String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Mini Donkey',
      name: 'title',
      desc: 'Title for the application',
      locale: localeName,
    );
  }

  String get encodeBtnText {
    return Intl.message(
      'Encode',
      name: 'encodeBtnText',
      desc: 'Text for the encoding button',
      locale: localeName,
    );
  }

  String get decodeBtnText {
    return Intl.message(
      'Decode',
      name: 'decodeBtnText',
      desc: 'Text for the decoding button',
      locale: localeName,
    );
  }

  String get contribBtnText {
    return Intl.message(
      'Contribute',
      name: 'contribBtnText',
      desc: 'Text for the contribute button',
      locale: localeName,
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
