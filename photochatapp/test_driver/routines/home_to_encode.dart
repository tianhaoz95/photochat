import 'package:flutter_driver/flutter_driver.dart';

import '../utilities/screenshot.dart';
import 'encode_to_result.dart';

Future<void> checkHomeToEncode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('home_screen_encode_message_btn'));
  await takeNamedScreenshot(driver, 'encode_screen');
  await Future.delayed(const Duration(seconds : 1));
  await driver.tap(find.byValueKey('encode_pick_image_from_gallery_btn'));
  await Future.delayed(const Duration(seconds : 1));
  await checkEncodeToResult(driver);
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds : 1));
}