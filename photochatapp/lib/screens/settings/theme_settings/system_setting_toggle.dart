import 'package:flutter/material.dart';
import 'package:minidonkey/services/theme/base_theme_service.dart';
import 'package:provider/provider.dart';

class SystemSettingToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (BuildContext context, AppTheme appTheme, Widget child) {
        return Container(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Use system theme'),
              Switch(
                  value: appTheme.useSystem,
                  onChanged: (bool val) {
                    Provider.of<AppTheme>(context, listen: false)
                        .setUseSystem(val);
                  }),
            ],
          ),
        );
      },
    );
  }
}
