import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minidonkey/services/theme/backend_types.dart';
import 'package:minidonkey/services/theme/base_theme_service.dart';
import 'package:minidonkey/services/theme/theme_types.dart';

class ProdAppTheme extends AppTheme {
  /// Opens a port to the local Hive storage
  late Box themeDb;

  Map<ThemeType, String> themeTypeNameLookup = {
    ThemeType.LIGHT: 'light',
    ThemeType.DARK: 'dark',
  };

  Map<String, ThemeType> themeTypeLookup = {
    'light': ThemeType.LIGHT,
    'dark': ThemeType.DARK,
  };

  @override
  ThemeBackendType getRequiredService() {
    return ThemeBackendType.HIVE;
  }

  @override
  Future<void> loadSettings() async {
    await Hive.initFlutter();
    themeDb = await Hive.openBox('theme');
    try {
      String? themeTypeName = themeDb.get('type');
      themeType = themeTypeLookup[themeTypeName!];
      useSystem = themeDb.get('system').toLowerCase() == 'true';
      notifyListeners();
    } catch (err) {
      useSystem = false;
      themeType = ThemeType.LIGHT;
    }
  }

  @override
  Future<void> saveSettings() async {
    themeDb = await Hive.openBox('theme');
    themeDb.put('type', themeTypeNameLookup[themeType!]);
    themeDb.put('system', useSystem.toString());
  }
}
