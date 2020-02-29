import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/converters/pad_cryption_key.dart';
import 'package:photochatapp/services/requests/decode_request.dart';
import 'package:photochatapp/services/responses/decode_response.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/utilities/config.dart';
import 'package:photochatapp/services/utilities/msg_bytes_converter.dart';
import 'package:photochatapp/services/utilities/pad_to_bytes.dart';
import 'package:encrypt/encrypt.dart' as crypto;
import 'package:provider/provider.dart';

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
  Uint16List extracted = extractBitsFromImg(img);
  Uint16List padded = padToBytes(extracted);
  Uint16List byteMsg = bits2bytes(padded);
  Uint16List sanitized = sanitizePaddingZeros(byteMsg);
  String msg = bytes2msg(sanitized);
  print('message decoded as: ' + msg);
  String token = req.token;
  print('token requested: ' + token);
  if (req.shouldDecrypt()) {
    crypto.Key key = crypto.Key.fromUtf8(padCryptionKey(token));
    crypto.IV iv = crypto.IV.fromLength(16);
    crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(key));
    crypto.Encrypted encryptedMsg = crypto.Encrypted.fromBase64(msg);
    msg = encrypter.decrypt(encryptedMsg, iv: iv);
  }
  DecodeResponse response = DecodeResponse(msg);
  return response;
}

DecodeResponse getMockedDecodeResult() {
  String msg = 'My awesome message!';
  DecodeResponse response = DecodeResponse(msg);
  return response;
}

Future<DecodeResponse> decodeMessageFromImageAsync(DecodeRequest req,
    {BuildContext context}) async {
  if (context != null) {
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      return getMockedDecodeResult();
    } else {
      final DecodeResponse res = await compute(decodeMessageFromImage, req);
      return res;
    }
  } else {
    final DecodeResponse res = await compute(decodeMessageFromImage, req);
    return res;
  }
}
