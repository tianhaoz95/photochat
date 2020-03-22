import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/states/app_running_states.dart';

/// App Context
///
/// {@category Services}
///
/// The world state of the app for information that
/// is useful for the entire application. Also, this
/// is a good place to put config that user cannot and
/// should not change. For example, if the app is
/// running as an integration test.
class AppContext extends ChangeNotifier {
  /// The state the app is running with like development,
  /// integration test or production which should never
  /// change while the app is running.
  /// TODO(#54): change it to final and required.
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
