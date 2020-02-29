import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';

// import '../utilities/screenshot.dart';

Future<void> checkDecodeToResult(FlutterDriver driver) async {
  String decodeToResultTestLoggingNamespace =
      'decode_to_result_integration_test';
  logger.info('try to tap checkbox to open token input',
      name: decodeToResultTestLoggingNamespace);
  await driver.tap(find.byValueKey('decode_encrypt_checkbox'));
  await Future.delayed(const Duration(seconds: 1));
  await driver.scrollUntilVisible(
      find.byValueKey('decode_screen_scrollable_list'),
      find.byValueKey('decode_screen_token_input'));
  logger.info('try to tap on token input',
      name: decodeToResultTestLoggingNamespace);
  await driver.tap(find.byValueKey('decode_screen_token_input'));
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to enter token', name: decodeToResultTestLoggingNamespace);
  await driver.enterText('my awesome token');
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to tap on send to decode result button',
      name: decodeToResultTestLoggingNamespace);
  await driver.tap(find.byValueKey('decode_screen_decode_btn'));
  await Future.delayed(const Duration(seconds: 1));
  logger.info('should have landed on the decode result screen',
      name: decodeToResultTestLoggingNamespace);
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds: 1));
  logger.info('should have been back from decode screen',
      name: decodeToResultTestLoggingNamespace);
}
