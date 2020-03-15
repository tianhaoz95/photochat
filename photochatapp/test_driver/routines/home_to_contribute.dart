import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';
import '../utilities/screenshot.dart';

Future<void> checkHomeToContribute(FlutterDriver driver) async {
  logger.info('try to tap contribute btn');
  await driver.tap(find.byValueKey('home_screen_contribute_btn'));
  logger.info('contribute btn tapped');
  await Future.delayed(const Duration(seconds: 1));
  await takeNamedScreenshot(driver, 'contribute_screen');
  logger.info('try to go back from contribute to home');
  await driver.tap(find.byValueKey('contrib_screen_back_btn'));
  logger.info('back btn tapped');
  await Future.delayed(const Duration(seconds: 1));
}
