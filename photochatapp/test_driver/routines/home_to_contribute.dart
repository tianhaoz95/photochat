import 'package:flutter_driver/flutter_driver.dart';

import '../utilities/screenshot.dart';

Future<void> checkHomeToContribute(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('home_screen_contribute_btn'));
  await Future.delayed(const Duration(seconds : 2));
  await takeNamedScreenshot(driver, 'contribute_screen');
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds : 2));
}