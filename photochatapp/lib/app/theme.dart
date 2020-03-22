import 'package:flutter/material.dart';

/// App Theme
///
/// {@category App Config}
ThemeData theme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.amber[50],
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      )),
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      )),
);
