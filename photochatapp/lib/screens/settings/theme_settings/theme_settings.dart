import 'package:flutter/material.dart';
import 'package:minidonkey/screens/settings/theme_settings/custom_theme_selector.dart';
import 'package:minidonkey/screens/settings/theme_settings/system_setting_toggle.dart';

class ThemeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
      child: Column(
        children: [
          Text(
            'Theme Settings',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SystemSettingToggle(),
          CustomThemeSelector(),
          Divider(
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
