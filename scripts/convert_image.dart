import 'dart:io';

import 'dart:typed_data';

String imageFilename = '/Users/tianhaozhou/Desktop/proj/photochat/photochatapp/assets/test_images/encrypted_corgi.png';

void main() {
  File image = File(imageFilename);
  Uint8List bytes = image.readAsBytesSync();
  String outputFile = 'import \'dart:typed_data\';\n\n';
  outputFile += 'Uint8List image = Uint8List.fromList([';
  for (int byte in bytes.toList()) {
    outputFile += byte.toString();
    outputFile += ',';
  }
  outputFile += ']);';
  File output = File('./generated.dart');
  output.writeAsStringSync(outputFile);
}