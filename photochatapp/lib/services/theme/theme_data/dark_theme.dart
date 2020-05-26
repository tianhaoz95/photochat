import 'package:flutter/material.dart';

/// Dark theme with all default Flutter theme colors
///
/// TODO(tianhaoz95): customize the dark theme so that
/// it doesn't use all default values which look the
/// same as all other Flutter apps.
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  )),
);
