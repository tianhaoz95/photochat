import 'package:flutter/material.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/i18n/i18n.dart';
import 'package:provider/provider.dart';

typedef void OnShareHandler();

class EncodeResultScreenShareBtn extends StatelessWidget {
  final OnShareHandler onShareHandler;
  const EncodeResultScreenShareBtn({@required this.onShareHandler});
  @override
  Widget build(BuildContext context) {
    if (Provider.of<AppContext>(context).isIpad()) {
      return Container();
    }
    return Container(
      child: RaisedButton(
        onPressed: this.onShareHandler,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share),
            SizedBox(
              width: 20.0,
            ),
            Text(AppLocalizations.of(context).encodeResultScreenShareBtnText),
          ],
        ),
      ),
    );
  }
}
