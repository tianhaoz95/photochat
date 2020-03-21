import 'package:flutter/material.dart';
import 'package:photochatapp/services/i18n/i18n.dart';

/// Home Screen Contribute Button
///
/// {@category Home Screen}
class HomeScreenContribBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/contribute');
      },
      key: Key('home_screen_contribute_btn'),
      color: Colors.pinkAccent,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.favorite),
            SizedBox(
              width: 15.0,
            ),
            Text(AppLocalizations.of(context).contribBtnText),
          ],
        ),
      ),
    );
  }
}
