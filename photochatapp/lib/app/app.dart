import 'package:flutter/material.dart';
import 'package:minidonkey/screens/contribute/contribute_screen.dart';
import 'package:minidonkey/screens/decoded/decoding_result_screen.dart';
import 'package:minidonkey/screens/encoded/encoding_result_screen.dart';
import 'package:minidonkey/screens/home/home_screen.dart';
import 'package:minidonkey/screens/receive/receive_screen.dart';
import 'package:minidonkey/screens/send/send_screen.dart';
import 'package:minidonkey/screens/settings/settings_screen.dart';
import 'package:minidonkey/services/i18n/i18n.dart';
import 'package:minidonkey/services/theme/base_theme_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Top level app
///
/// {@category App Config}
class PhotoChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
        builder: (BuildContext context, AppTheme appTheme, Widget child) {
      return MaterialApp(
        title: 'Mini Donkey',
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          print('checking ' + locale.toString());
          return locale;
        },
        supportedLocales: [
          const Locale('en'),
          const Locale.fromSubtags(languageCode: 'zh'),
        ],
        theme: appTheme.getLightTheme(),
        darkTheme: appTheme.getDarkTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/send': (context) => SendScreen(),
          '/receive': (context) => ReceiveScreen(),
          '/encoded': (context) => EncodingResultScreen(),
          '/decoded': (context) => DecodingResultScreen(),
          '/contribute': (context) => ContributeScreen(),
          '/settings': (context) => SettingsScreen(),
        },
      );
    });
  }
}
