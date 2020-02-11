import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:photochatapp/services/requests/decode_request.dart';
import 'package:photochatapp/services/responses/decode_response.dart';
import 'package:photochatapp/services/utilities/config.dart';
import 'package:photochatapp/services/utilities/msg_bytes_converter.dart';
import 'package:photochatapp/services/utilities/pad_to_bytes.dart';

int extractLastBit(int pixel) {
  int lastBit = pixel & 1;
  return lastBit;
}

int assembleBits(Uint16List byte) {
  if (byte.length != dataLength) {
    throw FlutterError('byte_incorrect_size');
  }
  int assembled = 0;
  for (int i = 0; i < dataLength; ++i) {
    if (byte[i] != 1 && byte[i] != 0) {
      throw FlutterError('bit_not_0_or_1');
    }
    assembled = assembled << 1;
    assembled = assembled | byte[i];
  }
  return assembled;
}

Uint16List bits2bytes(Uint16List bits) {
  if ((bits.length % dataLength) != 0) {
    throw FlutterError('bits_contain_incomplete_byte');
  }
  int byteCnt = bits.length ~/ dataLength;
  Uint16List byteMsg = Uint16List(byteCnt);
  for (int i = 0; i < byteCnt; ++i) {
    Uint16List bitsOfByte = Uint16List.fromList(
        bits.getRange(i * dataLength, i * dataLength + dataLength).toList());
    int byte = assembleBits(bitsOfByte);
    byteMsg[i] = byte;
  }
  return byteMsg;
}

Uint16List extractBitsFromImg(Uint16List img) {
  Uint16List extracted = Uint16List(img.length);
  for (int i = 0; i < img.length; i++) {
    extracted[i] = extractLastBit(img[i]);
  }
  return extracted;
}

Uint16List sanitizePaddingZeros(Uint16List msg) {
  int lastNonZeroIdx = msg.length - 1;
  while (msg[lastNonZeroIdx] == 0) {
    --lastNonZeroIdx;
  }
  Uint16List sanitized =
      Uint16List.fromList(msg.getRange(0, lastNonZeroIdx + 1).toList());
  return sanitized;
}

DecodeResponse decodeMessageFromImage(DecodeRequest req) {
  Uint16List img = Uint16List.fromList(req.original.getBytes().toList());
  // String token = req.token;
  Uint16List extracted = extractBitsFromImg(img);
  Uint16List padded = padToBytes(extracted);
  Uint16List byteMsg = bits2bytes(padded);
  Uint16List sanitized = sanitizePaddingZeros(byteMsg);
  String msg = bytes2msg(sanitized);
  DecodeResponse response = DecodeResponse(msg);
  return response;
}

Future<DecodeResponse> decodeMessageFromImageAsync(DecodeRequest req) async {
  final DecodeResponse res = await compute(decodeMessageFromImage, req);
  return res;
}
