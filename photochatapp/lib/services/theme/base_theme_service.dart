import 'package:flutter/material.dart';
import 'package:photochatapp/services/theme/backend_types.dart';
import 'package:photochatapp/services/theme/theme_data/dark_theme.dart';
import 'package:photochatapp/services/theme/theme_data/light_theme.dart';
import 'package:photochatapp/services/theme/theme_types.dart';

/// App Theme
///
/// This is the service provider that controls the
/// themes for the entire app.
/// It is implemented with:
/// * [MockAppTheme] which has no persistency between
/// app reloads and it is used for local development
/// and unit testing.
/// * [ProdAppTheme] which has some backend to help
/// persist configurations between app reloads and
/// it is used in the production application.
abstract class AppTheme extends ChangeNotifier {
  /// A flag to indicate the currently select theme.
  ThemeType themeType;

  /// A flag to indicate whether to honor system theme
  /// settings over the user-defined theme settings.
  bool useSystem;

  /// The ctor takes in override values for the initial
  /// theme type and system settings preference.
  AppTheme({
    this.themeType = ThemeType.LIGHT,
    this.useSystem = true,
  }) : super() {
    loadSettings();
  }

  /// Used by the UI to switch between themes. It will
  /// notify all the widgets that depends on the service
  /// to rebuild.
  void setThemeType(ThemeType type) {
    themeType = type;
    saveSettings();
    notifyListeners();
  }

  /// Used by the UI to switch between using and not using
  /// system (iOS/Android/Chrome) theme settings. It will
  /// notify all the widgets that depends on the service
  /// to rebuild.
  void setUseSystem(bool val) {
    useSystem = val;
    saveSettings();
    notifyListeners();
  }

  /// Returns theme corresponding to [themeType] which
  /// is used when the system theme settings are not
  /// honored.
  ThemeData getCustomTheme() {
    switch (themeType) {
      case ThemeType.LIGHT:
        return lightTheme;
      case ThemeType.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }

  /// Returns the default light theme if system theme
  /// settings are honored and returns [getCustomTheme]
  /// if the system theme settings are not honored.
  ThemeData getLightTheme() {
    if (useSystem) {
      return lightTheme;
    } else {
      return getCustomTheme();
    }
  }

  /// Returns the default dark theme if system theme
  /// settings are honored and returns [getCustomTheme]
  /// if the system theme settings are not honored.
  ThemeData getDarkTheme() {
    if (useSystem) {
      return darkTheme;
    } else {
      return getCustomTheme();
    }
  }

  /// Returns the required services by the concret
  /// theme service object.
  ///
  /// TODO(tianhaoz95): consolidate all backend types
  /// into a single definition and use the splash
  /// screen to get a list/set of them and initialize
  /// all required services in one place.
  ThemeBackendType getRequiredService();

  /// Loads theme settings from a backend.
  Future<void> loadSettings();

  /// Saves theme settings to a backend.
  Future<void> saveSettings();
}
