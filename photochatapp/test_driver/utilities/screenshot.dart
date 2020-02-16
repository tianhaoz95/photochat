import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

import '../config/consts.dart';
import '../config/logger.dart';
import 'dir_tools.dart';

Future<void> takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  await file.writeAsBytes(pixels);
}

Future<void> takeNamedScreenshot(FlutterDriver driver, String id) async {
  await createDirIfNotExist(screenshotDir);
  String path = screenshotDir + '/' + id + '.png';
  await takeScreenshot(driver, path);
}

Future<void> prepareScreenshotArea() async {
  logger.info('prepare screenshot area');
  await removeDirIfExist(screenshotDir);
  await createDirIfNotExist(screenshotDir);
  logger.info('screenshot area prepared');
}
