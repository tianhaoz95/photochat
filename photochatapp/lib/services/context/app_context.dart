import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/states/app_running_states.dart';

class AppContext extends ChangeNotifier {
  AppRunningState appRunningState;
  AppContext({AppRunningState appRunningStateOverride}) {
    if (appRunningStateOverride == null) {
      this.appRunningState = AppRunningState.PRODUCTION;
    } else {
      this.appRunningState = appRunningStateOverride;
    }
  }
  AppRunningState getAppRunningState() {
    return appRunningState;
  }
}