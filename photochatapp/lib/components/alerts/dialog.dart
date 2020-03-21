import 'package:flutter/material.dart';

Future<void> showAlert(String warningMsg, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Whoops, something went wrong :('),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Error message: '),
              Text(warningMsg),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
