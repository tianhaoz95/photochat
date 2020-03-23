import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// import 'routines/home_to_contribute.dart';
import 'routines/home_to_decode.dart';
import 'routines/home_to_encode.dart';
import 'routines/init.dart';
import 'utilities/async_workaround.dart';
import 'utilities/screenshot.dart';

void main() {
  group('real device smoke test', () {
    FlutterDriver driver;
    IsolatesWorkaround workaround;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      // This is a workaround to prevent flutter driver from pausing isolates
      workaround = IsolatesWorkaround(driver);
      await workaround.resumeIsolates();
    });
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
        // This is a workaround to prevent flutter driver from pausing isolates
        await workaround.tearDown();
      }
    });
    test('smoke test', () async {
      await prepareScreenshotArea();
      await initHome(driver);
      // TODO(tianhaoz95): re-enable this once iOS supports contribution.
      // await checkHomeToContribute(driver);
      await checkHomeToEncode(driver);
      await checkHomeToDecode(driver);
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
