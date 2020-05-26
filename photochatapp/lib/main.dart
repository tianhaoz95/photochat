import 'package:flutter/material.dart';
import 'package:photochatapp/app/app.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/theme/base_theme_service.dart';
import 'package:photochatapp/services/theme/prod_theme_service.dart';
import 'package:provider/provider.dart';

/// Entry Point
///
/// {@category App}
void main() {
  AppTheme appTheme = ProdAppTheme();
  AppContext appContext =
      AppContext(appRunningStateOverride: AppRunningState.PRODUCTION);
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
