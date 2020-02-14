import 'package:flutter_driver/flutter_driver.dart';

Future<void> initHome(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('home_screen_title'));
  await Future.delayed(const Duration(seconds : 2));
}