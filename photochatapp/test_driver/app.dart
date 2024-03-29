import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:minidonkey/app/app.dart';
import 'package:minidonkey/services/context/app_context.dart';
import 'package:minidonkey/services/states/app_running_states.dart';
import 'package:minidonkey/services/theme/base_theme_service.dart';
import 'package:minidonkey/services/theme/mock_theme_service.dart';
import 'package:provider/provider.dart';

void main() {
  enableFlutterDriverExtension();
  AppTheme appTheme = MockAppTheme();
  AppContext appContext =
      AppContext(appRunningStateOverride: AppRunningState.INTEGRATION_TEST);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appTheme),
        ChangeNotifierProvider(create: (context) => appContext),
      ],
      child: PhotoChatApp(),
    ),
  );
}
