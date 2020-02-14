import 'package:flutter_driver/flutter_driver.dart';

// import '../utilities/screenshot.dart';

Future<void> checkEncodeToResult(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('decode_screen_msg_input'));
  await driver.enterText('my awesome message');
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.byValueKey('encode_screen_token_checkbox'));
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.byValueKey('encode_screen_token_input'));
  await Future.delayed(const Duration(seconds : 2));
  await driver.enterText('my awesome token');
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.byValueKey('decode_screen_decode_btn'));
  await Future.delayed(const Duration(seconds : 2));
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds : 2));
}