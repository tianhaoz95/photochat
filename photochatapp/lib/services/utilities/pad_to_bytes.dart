import 'dart:typed_data';

import 'package:minidonkey/services/utilities/config.dart';

Uint16List padToBytes(Uint16List msg) {
  int padSize = dataLength - msg.length % dataLength;
  Uint16List padded = Uint16List(msg.length + padSize);
  for (int i = 0; i < msg.length; ++i) {
    padded[i] = msg[i];
  }
  for (int i = 0; i < padSize; ++i) {
    padded[msg.length + i] = 0;
  }
  return padded;
}
