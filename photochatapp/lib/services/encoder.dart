import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/converters/pad_cryption_key.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:photochatapp/services/responses/encode_response.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/utilities/config.dart';
import 'package:image/image.dart' as imglib;
import 'package:encrypt/encrypt.dart' as crypto;
import 'package:photochatapp/services/utilities/get_capacity.dart';
import 'package:photochatapp/services/utilities/load_asset.dart';
import 'package:photochatapp/services/utilities/msg_bytes_converter.dart';
import 'package:provider/provider.dart';

int getMsgSize(String msg) {
  Uint16List byteMsg = msg2bytes(msg);
  return byteMsg.length * dataLength;
}

int encodeOnePixel(int pixel, int msg) {
  if (msg != 1 && msg != 0) {
    throw FlutterError('msg_encode_bit_more_than_1_bit');
  }
  int lastBitMask = 254;
  int encoded = (pixel & lastBitMask) | msg;
  return encoded;
}

Uint16List padMsg(int capacity, Uint16List msg) {
  Uint16List padded = Uint16List(capacity);
  for (int i = 0; i < msg.length; ++i) {
    padded[i] = msg[i];
  }
  return padded;
}

Uint16List expandMsg(Uint16List msg) {
  Uint16List expanded = Uint16List(msg.length * dataLength);
  for (int i = 0; i < msg.length; ++i) {
    int msgByte = msg[i];
    for (int j = 0; j < dataLength; ++j) {
      int lastBit = msgByte & 1;
      expanded[i * dataLength + (dataLength - j - 1)] = lastBit;
      msgByte = msgByte >> 1;
    }
  }
  return expanded;
}

EncodeResponse encodeMessageIntoImage(EncodeRequest req) {
  Uint16List img = Uint16List.fromList(req.original.getBytes().toList());
  String msg = req.msg;
  String token = req.token;
  if (req.shouldEncrypt()) {
    crypto.Key key = crypto.Key.fromUtf8(padCryptionKey(token));
    crypto.IV iv = crypto.IV.fromLength(16);
    crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(key));
    crypto.Encrypted encrypted = encrypter.encrypt(msg, iv: iv);
    msg = encrypted.base64;
  }
  Uint16List encodedImg = img;
  if (getEncoderCapacity(img) < getMsgSize(msg)) {
    throw FlutterError('image_capacity_not_enough');
  }
  Uint16List expandedMsg = expandMsg(msg2bytes(msg));
  Uint16List paddedMsg = padMsg(getEncoderCapacity(img), expandedMsg);
  if (paddedMsg.length != getEncoderCapacity(img)) {
    throw FlutterError('msg_container_size_not_match');
  }
  for (int i = 0; i < getEncoderCapacity(img); ++i) {
    encodedImg[i] = encodeOnePixel(img[i], paddedMsg[i]);
  }
  imglib.Image editableImage = imglib.Image.fromBytes(
      req.original.width, req.original.height, encodedImg.toList());
  Image displayableImage =
      Image.memory(imglib.encodePng(editableImage), fit: BoxFit.fitWidth);
  Uint8List data = Uint8List.fromList(imglib.encodePng(editableImage));
  EncodeResponse response =
      EncodeResponse(editableImage, displayableImage, data);
  return response;
}

Future<EncodeResponse> getMockedEncodeResult() async {
  Uint8List mockedEncodedImageData =
      await loadAsset('assets/test_images/encrypted_corgi.png');
  imglib.Image mockedEditableImage =
      imglib.decodeImage(mockedEncodedImageData.toList());
  Image mockedDisplayableImage =
      Image.memory(imglib.encodePng(mockedEditableImage), fit: BoxFit.fitWidth);
  EncodeResponse mockedResponse = EncodeResponse(
      mockedEditableImage, mockedDisplayableImage, mockedEncodedImageData);
  return mockedResponse;
}

Future<EncodeResponse> encodeMessageIntoImageAsync(EncodeRequest req,
    {BuildContext context}) async {
  if (context != null) {
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      EncodeResponse mockedResponse = await getMockedEncodeResult();
      return mockedResponse;
    } else {
      final EncodeResponse res = await compute(encodeMessageIntoImage, req);
      return res;
    }
  } else {
    final EncodeResponse res = await compute(encodeMessageIntoImage, req);
    return res;
  }
}
