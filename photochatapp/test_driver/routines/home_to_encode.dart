import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';
import '../utilities/screenshot.dart';
import 'encode_to_result.dart';

Future<void> checkHomeToEncode(FlutterDriver driver) async {
  String homeToEncodeTestLoggingNamespace = 'encode_screen_integration_test';
  logger.info('try to navigate to decode screen',
      name: homeToEncodeTestLoggingNamespace);
  await driver.tap(find.byValueKey('home_screen_encode_message_btn'));
  logger.info('decode screen reached', name: homeToEncodeTestLoggingNamespace);
  await takeNamedScreenshot(driver, 'encode_screen');
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to pick image from gallery',
      name: homeToEncodeTestLoggingNamespace);
  await driver.tap(find.byValueKey('encode_pick_image_from_gallery_btn'));
  logger.info('image picked from gallery',
      name: homeToEncodeTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to test encode result screen',
      name: homeToEncodeTestLoggingNamespace);
  await checkEncodeToResult(driver);
  logger.info('back from encode result screen, try to go back to home screen',
      name: homeToEncodeTestLoggingNamespace);
  await driver.tap(find.pageBack());
  logger.info('should have reached home screen',
      name: homeToEncodeTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
}
