import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:photochatapp/main.dart' as app;

import 'config/logger.dart';
import 'fixtures/corgi_image.dart';
import 'fixtures/encrypted_corgi_image.dart';

void main() {
  enableFlutterDriverExtension();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');
  bool isEncoding = true;
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    logger.info('isEncoding: ' + isEncoding.toString());
    Uint8List bytes = corgiByteImage;
    if (!isEncoding) {
      logger.info('use encrypted corgi image');
      bytes = encryptedcorgiByteImage;
    }
    Directory tempDir = await getTemporaryDirectory();
    String filename = 'corgi.tmp';
    if (!isEncoding) {
      filename = 'encrypted_corgi.tmp';
    }
    File file = await File('${tempDir.path}/$filename').writeAsBytes(bytes);
    if (isEncoding) {
      logger.info('use corgi image');
      isEncoding = false;
      logger.info('setting isEncoding to ' + isEncoding.toString());
    }
    logger.info('setting selected image to ' + file.path);
    return file.path;
  });
  app.main();
}
