import 'dart:typed_data';

Uint8List padToBytes(Uint8List msg) {
  int padSize = 8 - msg.length % 8;
  Uint8List padded = Uint8List(msg.length + padSize);
  for (int i = 0; i < msg.length; ++i) {
    padded[i] = msg[i];
  }
  for (int i = 0; i < padSize; ++i) {
    padded[msg.length + i] = 0;
  }
  return padded;
}
