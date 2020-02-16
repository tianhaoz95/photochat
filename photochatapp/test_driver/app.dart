import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:photochatapp/app/app.dart';
import 'package:photochatapp/services/states/app_running_states.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(PhotoChatApp(AppRunningState.INTEGRATION_TEST));
}
