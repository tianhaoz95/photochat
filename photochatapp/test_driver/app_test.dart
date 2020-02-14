import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('real device smoke test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('smoke test', () async {
      await driver.waitFor(find.byValueKey('home_screen_title'));
      await driver.tap(find.byValueKey('home_screen_contribute_btn'));
    });
  });
}