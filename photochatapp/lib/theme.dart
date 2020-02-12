import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.amber,
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
