import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:photochatapp/services/i18n/wrappers/messages_all.dart';

/// {@category i18n}
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

  String get encodeScreenTitle {
    return Intl.message(
      'Encode a Message',
      name: 'encodeScreenTitle',
      desc: 'Text for the title of the encode screen',
      locale: localeName,
    );
  }

  String get encodeScreenRandomBtnText {
    return Intl.message(
      'Random',
      name: 'encodeScreenRandomBtnText',
      desc: 'Text for the random button of the encode screen',
      locale: localeName,
    );
  }

  String get encodeScreenGalleryBtnText {
    return Intl.message(
      'Gallery',
      name: 'encodeScreenGalleryBtnText',
      desc: 'Text for the random button of the encode screen',
      locale: localeName,
    );
  }

  String get encodeScreenCameraBtnText {
    return Intl.message(
      'Camera',
      name: 'encodeScreenCameraBtnText',
      desc: 'Text for the camera button of the encode screen',
      locale: localeName,
    );
  }

  String get encodeScreenEncodeBtnText {
    return Intl.message(
      'Encode',
      name: 'encodeScreenEncodeBtnText',
      desc: 'Text for the encode button of the encode screen',
      locale: localeName,
    );
  }

  String get encodeResultScreenTitleText {
    return Intl.message(
      'Hooray! Encoded!',
      name: 'encodeResultScreenTitleText',
      desc: 'Text for the title of the encode result screen',
      locale: localeName,
    );
  }

  String get encodeResultScreenSaveBtnText {
    return Intl.message(
      'Save',
      name: 'encodeResultScreenSaveBtnText',
      desc: 'Text for the save button of the encode result screen',
      locale: localeName,
    );
  }

  String get encodeResultScreenShareBtnText {
    return Intl.message(
      'Share',
      name: 'encodeResultScreenShareBtnText',
      desc: 'Text for the share button of the encode result screen',
      locale: localeName,
    );
  }

  String get decodeScreenTitleText {
    return Intl.message(
      'Decode a Message',
      name: 'decodeScreenTitleText',
      desc: 'Text for the title of the decode screen',
      locale: localeName,
    );
  }

  String get decodeScreenGalleryBtnText {
    return Intl.message(
      'Gallery',
      name: 'decodeScreenGalleryBtnText',
      desc: 'Text for the gallery button of the decode screen',
      locale: localeName,
    );
  }

  String get decodeScreenDecodeBtnText {
    return Intl.message(
      'Decode',
      name: 'decodeScreenDecodeBtnText',
      desc: 'Text for the decode button of the decode screen',
      locale: localeName,
    );
  }

  String get decodeScreenDecryptCheckboxText {
    return Intl.message(
      'Decrypt my message!',
      name: 'decodeScreenDecryptCheckboxText',
      desc: 'Text for the decrypt checkbox of the decode screen',
      locale: localeName,
    );
  }

  String get showTokenCheckboxText {
    return Intl.message(
      'Show token',
      name: 'showTokenCheckboxText',
      desc: 'Text for the show token checkbox',
      locale: localeName,
    );
  }

  String get decodeResultScreenTitle {
    return Intl.message(
      'Here is Your Message!',
      name: 'decodeResultScreenTitle',
      desc: 'Text for the title of the decode result screen',
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
