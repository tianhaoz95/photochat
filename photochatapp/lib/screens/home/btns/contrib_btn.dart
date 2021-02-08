import 'package:flutter/material.dart';
import 'package:minidonkey/services/context/app_context.dart';
import 'package:minidonkey/services/i18n/i18n.dart';
import 'package:provider/provider.dart';

/// Home Screen Contribute Button
///
/// {@category Screens: Home}
class HomeScreenContribBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AppContext>(context).isIos()) {
      return Container();
    }
    return RaisedButton(
      onPressed: Provider.of<AppContext>(context).isReady()
          ? () {
              Navigator.pushNamed(context, '/contribute');
            }
          : null,
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
            Text(AppLocalizations.of(context)!.contribBtnText),
          ],
        ),
      ),
    );
  }
}
