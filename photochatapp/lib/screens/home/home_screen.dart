import 'package:flutter/material.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';
import 'package:photochatapp/screens/home/btns/contrib_btn.dart';
import 'package:photochatapp/screens/home/btns/start_decode_btn.dart';
import 'package:photochatapp/screens/home/btns/start_encode_btn.dart';
import 'package:photochatapp/screens/home/logos/donkey_logo.dart';
import 'package:photochatapp/screens/home/logos/message_logo.dart';
import 'package:photochatapp/services/i18n/i18n.dart';

/// Home Screen
///
/// {@category Home Screen}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).title,
          key: Key('home_screen_title'),
        ),
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
