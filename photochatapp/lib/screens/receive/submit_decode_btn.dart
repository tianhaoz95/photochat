import 'package:flutter/material.dart';
import 'package:photochatapp/services/i18n/i18n.dart';

typedef void OnSubmitDecodeHandler();

class ReceiveScreenSubmitDecodeBtn extends StatelessWidget {
  final OnSubmitDecodeHandler onSubmitDecodeHandler;
  const ReceiveScreenSubmitDecodeBtn({@required this.onSubmitDecodeHandler});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      key: Key('decode_screen_decode_btn'),
      onPressed: this.onSubmitDecodeHandler,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.drafts),
            SizedBox(
              width: 15.0,
            ),
            Text(AppLocalizations.of(context).decodeScreenDecodeBtnText),
          ],
        ),
      ),
    ));
  }
}
