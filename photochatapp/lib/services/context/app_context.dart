import 'package:device_info/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/states/loading_states.dart';
import 'package:photochatapp/services/states/platform_states.dart';

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

  /// The platform the app is running on.
  PlatformState platformState;

  /// The state of the app context
  LoadingState loadingState;
  AppContext({AppRunningState appRunningStateOverride}) {
    if (appRunningStateOverride == null) {
      this.appRunningState = AppRunningState.PRODUCTION;
    } else {
      this.appRunningState = appRunningStateOverride;
    }
    loadingState = LoadingState.PENDING;
    platformState = PlatformState.GENERIC;
  }

  /// Initializes the entire [AppContext]
  /// with all async initializers.
  Future<void> initializeContext() async {
    if (loadingState == LoadingState.SUCCESS) {
      return;
    }
    loadingState = LoadingState.LOADING;
    try {
      await initializeDeviceType();
    } catch (err) {
      loadingState = LoadingState.ERROR;
      notifyListeners();
    }
    loadingState = LoadingState.SUCCESS;
    notifyListeners();
  }

  /// Initializes the platform the app is
  /// running on at the start of the app.
  /// This method is normally called within
  /// [initializeContext] and usually not
  /// called directly.
  Future<void> initializeDeviceType() async {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    print('App running on ' + iosInfo.name);
    if (iosInfo.name.toLowerCase().contains('ipad')) {
      print('is ipad');
      platformState = PlatformState.IPAD;
    } else if (iosInfo.name.toLowerCase().contains('iphone')) {
      platformState = PlatformState.IPHONE;
    } else {
      platformState = PlatformState.GENERIC;
    }
  }

  /// Checks if [AppContext] is fully initialized
  /// and ready to use.
  bool isReady() {
    return loadingState == LoadingState.SUCCESS;
  }

  /// Checks if the current app is running on iPad
  /// to implement iPad specific UI code.
  bool isIpad() {
    return platformState == PlatformState.IPAD;
  }

  /// Checks if the current app is running on the
  /// iOS ecosystem.
  bool isIos() {
    if (platformState == PlatformState.IPAD) {
      return true;
    }
    if (platformState == PlatformState.IPHONE) {
      return true;
    }
    return false;
  }

  AppRunningState getAppRunningState() {
    return appRunningState;
  }
}
