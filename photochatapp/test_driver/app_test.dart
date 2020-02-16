import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'config/logger.dart';
import 'routines/home_to_contribute.dart';
import 'routines/home_to_decode.dart';
import 'routines/home_to_encode.dart';
import 'routines/init.dart';
import 'utilities/screenshot.dart';

void main() {
  group('real device smoke test', () {
    FlutterDriver driver;
    StreamSubscription streamSubscription;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      // This is a workaround to prevent flutter driver from pausing isolates
      streamSubscription = driver.serviceClient.onIsolateRunnable
          .asBroadcastStream()
          .listen((isolateRef) {
        logger.info(
            ('resuming isolate: ${isolateRef.numberAsString}:${isolateRef.name}'));
        isolateRef.resume();
      }, onDone: () {
        logger.info('isolate finished');
      }, onError: (dynamic error, StackTrace stackTrace) {
        logger.info('isolate error out: ' + error.toString());
      });
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
      // This is a workaround to prevent flutter driver from pausing isolates
      if (streamSubscription != null) {
        streamSubscription.cancel();
      }
    });
    test('smoke test', () async {
      await prepareScreenshotArea();
      await initHome(driver);
      await checkHomeToContribute(driver);
      await checkHomeToEncode(driver);
      await checkHomeToDecode(driver);
    }, timeout: Timeout(Duration(minutes: 10)));
  });
}
