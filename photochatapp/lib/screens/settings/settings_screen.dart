import 'package:flutter/material.dart';
import 'package:photochatapp/screens/settings/theme_settings/theme_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: ListView(
          children: [
            ThemeSettings(),
          ],
        ),
      ),
    );
  }
}
