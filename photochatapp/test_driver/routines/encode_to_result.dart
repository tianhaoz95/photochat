import 'package:flutter_driver/flutter_driver.dart';

import '../config/logger.dart';

// import '../utilities/screenshot.dart';

Future<void> checkEncodeToResult(FlutterDriver driver) async {
  String encodeToResultTestLoggingNamespace =
      'encode_to_result_integration_test';
  logger.info('try to tap message input',
      name: encodeToResultTestLoggingNamespace);
  await driver.scrollUntilVisible(find.byValueKey('encode_screen'),
      find.byValueKey('encode_screen_msg_input'));
  await driver.tap(find.byValueKey('encode_screen_msg_input'));
  logger.info('try to type in message',
      name: encodeToResultTestLoggingNamespace);
  await driver.enterText('my awesome message');
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to tap checkbox to enter token',
      name: encodeToResultTestLoggingNamespace);
  await driver.scrollUntilVisible(
      find.byValueKey('encode_screen_scrollable_list'),
      find.byValueKey('encode_screen_token_checkbox'));
  await driver.tap(find.byValueKey('encode_screen_token_checkbox'));
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to scroll to token input',
      name: encodeToResultTestLoggingNamespace);
  await driver.scrollUntilVisible(
      find.byValueKey('encode_screen_scrollable_list'),
      find.byValueKey('encode_screen_token_input'));
  logger.info('try to tap token input',
      name: encodeToResultTestLoggingNamespace);
  await driver.tap(find.byValueKey('encode_screen_token_input'));
  await Future.delayed(const Duration(seconds: 1));
  logger.info('try to enter token', name: encodeToResultTestLoggingNamespace);
  await driver.enterText('my awesome token');
  await Future.delayed(const Duration(seconds: 1));
  logger.info('scroll down to find send to encode button',
      name: encodeToResultTestLoggingNamespace);
  await driver.scrollUntilVisible(
      find.byValueKey('encode_screen_scrollable_list'),
      find.byValueKey('encode_screen_encode_btn'));
  logger.info('try to tap send to encode button',
      name: encodeToResultTestLoggingNamespace);
  await driver.tap(find.byValueKey('encode_screen_encode_btn'));
  logger.info('shoud have landed to encode result screen',
      name: encodeToResultTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
  await driver.tap(find.byValueKey('encoded_screen_back_btn'));
  logger.info('shoud have gone back from encode result screen to encode screen',
      name: encodeToResultTestLoggingNamespace);
  await Future.delayed(const Duration(seconds: 1));
}
