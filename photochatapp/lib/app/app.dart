import 'package:flutter/material.dart';
import 'package:photochatapp/app/theme.dart';
import 'package:photochatapp/screens/contribute/contribute_screen.dart';
import 'package:photochatapp/screens/decoded/decoding_result_screen.dart';
import 'package:photochatapp/screens/encoded/encoding_result_screen.dart';
import 'package:photochatapp/screens/home/home_screen.dart';
import 'package:photochatapp/screens/receive/receive_screen.dart';
import 'package:photochatapp/screens/send/send_screen.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class PhotoChatApp extends StatelessWidget {
  final AppRunningState appRunningState;
  const PhotoChatApp(this.appRunningState);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppContext>(
        create: (context) =>
            AppContext(appRunningStateOverride: this.appRunningState),
        child: MaterialApp(
          title: 'Mini Donkey',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale.fromSubtags(languageCode: 'zh'),
          ],
          theme: theme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/send': (context) => SendScreen(),
            '/receive': (context) => ReceiveScreen(),
            '/encoded': (context) => EncodingResultScreen(),
            '/decoded': (context) => DecodingResultScreen(),
            '/contribute': (context) => ContributeScreen(),
          },
        ));
  }
}
