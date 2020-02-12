import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.amber,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0)
      ),
    )
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0)
      ),
    )
  ),
);
