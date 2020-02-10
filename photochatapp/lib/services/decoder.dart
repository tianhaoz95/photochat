import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:photochatapp/services/utilities/pad_to_bytes.dart';

int extractLastBit(int pixel) {
  int lastBit = pixel & 1;
  return lastBit;
}

int assembleBits(Uint8List byte) {
  if (byte.length != 8) {
    throw FlutterError('byte_incorrect_size');
  }
  int assembled = 0;
  for (int i = 0; i < 8; ++i) {
    if (byte[i] != 1 && byte[i] != 0) {
      throw FlutterError('bit_not_0_or_1');
    }
    assembled = assembled << 1;
    assembled = assembled | byte[i];
  }
  return assembled;
}

Uint8List bits2bytes(Uint8List bits) {
  if ((bits.length % 8) != 0) {
    throw FlutterError('bits_contain_incomplete_byte');
  }
  int byteCnt = bits.length ~/ 8;
  Uint8List byteMsg = Uint8List(byteCnt);
  for (int i = 0; i < byteCnt; ++i) {
    Uint8List bitsOfByte =
        Uint8List.fromList(bits.getRange(i * 8, i * 8 + 8).toList());
    int byte = assembleBits(bitsOfByte);
    byteMsg[i] = byte;
  }
  return byteMsg;
}

Uint8List extractBitsFromImg(Uint8List img) {
  Uint8List extracted = Uint8List(img.length);
  for (int i = 0; i < img.length; i++) {
    extracted[i] = extractLastBit(img[i]);
  }
  return extracted;
}

Uint8List sanitizePaddingZeros(Uint8List msg) {
  int lastNonZeroIdx = msg.length - 1;
  while (msg[lastNonZeroIdx] == 0) {
    --lastNonZeroIdx;
  }
  Uint8List sanitized = Uint8List.fromList(msg.getRange(0, lastNonZeroIdx + 1).toList());
  return sanitized;
}

Future<String> decodeMessageFromImage(Uint8List img, String token) async {
  Uint8List extracted = extractBitsFromImg(img);
  Uint8List padded = padToBytes(extracted);
  Uint8List byteMsg = bits2bytes(padded);
  Uint8List sanitized = sanitizePaddingZeros(byteMsg);
  String msg = String.fromCharCodes(sanitized);
  return msg;
}
