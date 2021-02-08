import 'package:flutter/material.dart';
import 'package:minidonkey/services/theme/base_theme_service.dart';
import 'package:minidonkey/services/theme/theme_types.dart';
import 'package:provider/provider.dart';

class CustomThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (BuildContext context, AppTheme appTheme, Widget child) {
        if (appTheme.useSystem) {
          return Container();
        } else {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Custom theme selector: '),
                RaisedButton(
                  onPressed: () {
                    Provider.of<AppTheme>(context, listen: false)
                        .setThemeType(ThemeType.LIGHT);
                  },
                  child: Container(),
                  color: Colors.amber,
                ),
                RaisedButton(
                  onPressed: () {
                    Provider.of<AppTheme>(context, listen: false)
                        .setThemeType(ThemeType.DARK);
                  },
                  child: Container(),
                  color: Colors.black,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
