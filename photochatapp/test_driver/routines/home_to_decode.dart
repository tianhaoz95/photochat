import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';
import '../utilities/screenshot.dart';
import 'decode_to_result.dart';

Future<void> checkHomeToDecode(FlutterDriver driver) async {
  const String homeToDecodeTestLoggingNamespace =
      'home_to_decode_integration_test';
  logger.info('try to navigate to decode screen',
      name: homeToDecodeTestLoggingNamespace);
  await driver.tap(find.byValueKey('home_screen_decode_message_btn'));
  logger.info('reached decode screen', name: homeToDecodeTestLoggingNamespace);
  await takeNamedScreenshot(driver, 'decode_screen');
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to tap pick image from gallery button',
      name: homeToDecodeTestLoggingNamespace);
  await driver.tap(find.byValueKey('decode_pick_image_from_gallery_btn'));
  await Future.delayed(const Duration(seconds: 1));
  logger.info('image picked from gallery, try to test decode result screen',
      name: homeToDecodeTestLoggingNamespace);
  await checkDecodeToResult(driver);
  logger.info('navigated back from decode result screen',
      name: homeToDecodeTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to go back to home screen',
      name: homeToDecodeTestLoggingNamespace);
  await driver.tap(find.pageBack());
  logger.info('should have reached home screen',
      name: homeToDecodeTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
}
