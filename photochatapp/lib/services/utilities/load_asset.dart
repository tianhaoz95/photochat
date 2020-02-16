import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> loadAsset(String assetName) async {
  ByteData bytes = await rootBundle.load(assetName);
  Uint8List data = bytes.buffer.asUint8List();
  return data;
}
