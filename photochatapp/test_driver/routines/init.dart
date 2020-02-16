import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';

Future<void> initHome(FlutterDriver driver) async {
  logger.info('initializing integration test...');
  await driver.waitFor(find.byValueKey('home_screen_title'));
  logger.info('home screen confirmed');
  await Future.delayed(const Duration(seconds: 2));
}
