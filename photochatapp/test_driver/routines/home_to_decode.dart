import 'package:flutter_driver/flutter_driver.dart';

import '../utilities/screenshot.dart';

Future<void> checkHomeToDecode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('home_screen_decode_message_btn'));
  await takeNamedScreenshot(driver, 'decode_screen');
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.byValueKey('decode_pick_image_from_gallery_btn'));
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds : 2));
}