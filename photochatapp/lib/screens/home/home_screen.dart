import 'package:flutter/material.dart';
import 'package:minidonkey/components/screen_adapter/screen_adapter.dart';
import 'package:minidonkey/screens/home/btns/contrib_btn.dart';
import 'package:minidonkey/screens/home/btns/start_decode_btn.dart';
import 'package:minidonkey/screens/home/btns/start_encode_btn.dart';
import 'package:minidonkey/screens/home/logos/donkey_logo.dart';
import 'package:minidonkey/screens/home/logos/message_logo.dart';
import 'package:minidonkey/services/context/app_context.dart';
import 'package:minidonkey/services/i18n/i18n.dart';
import 'package:provider/provider.dart';

/// Home Screen
///
/// {@category Screens}
/// {@category Screens: Home}
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppContext>(context, listen: false).initializeContext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title,
          key: Key('home_screen_title'),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              }),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: ScreenAdapter(
          child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            HomeScreenDonkeyLogo(),
            SizedBox(
              height: 10.0,
            ),
            HomeScreenMessageLogo(),
            SizedBox(
              height: 5.0,
            ),
            HomeScreenStartEncodeBtn(),
            SizedBox(
              height: 5.0,
            ),
            HomeScreenStartDecodeBtn(),
            SizedBox(
              height: 5.0,
            ),
            HomeScreenContribBtn(),
          ],
        ),
      )),
    );
  }
}
