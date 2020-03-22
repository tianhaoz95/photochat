import 'package:flutter/material.dart';
import 'package:photochatapp/services/i18n/i18n.dart';

/// Home Screen Start Decode Button
///
/// {@category Screens: Home}
class HomeScreenStartDecodeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/receive');
      },
      key: Key('home_screen_decode_message_btn'),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.drafts),
            SizedBox(
              width: 15.0,
            ),
            Text(AppLocalizations.of(context).decodeBtnText),
          ],
        ),
      ),
    );
  }
}
