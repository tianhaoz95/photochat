import 'package:flutter_driver/flutter_driver.dart';

// import '../utilities/screenshot.dart';

Future<void> checkDecodeToResult(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('decode_encrypt_checkbox'));
  await Future.delayed(const Duration(seconds: 1));
  await driver.tap(find.byValueKey('decode_screen_token_input'));
  await Future.delayed(const Duration(seconds: 1));
  await driver.enterText('my awesome token');
  await Future.delayed(const Duration(seconds: 1));
  await driver.tap(find.byValueKey('decode_screen_decode_btn'));
  await Future.delayed(const Duration(seconds: 1));
  await driver.tap(find.pageBack());
  await Future.delayed(const Duration(seconds: 1));
}
