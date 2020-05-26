import 'package:flutter/material.dart';

/// The default light theme which uses yellow as main color
/// and black as secondary color.
///
/// TODO(tianhaoz95): use white instead of yellow theme as the
/// default light theme.
ThemeData lightTheme = ThemeData(
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
