import 'dart:typed_data';

import 'package:flutter/material.dart';

Uint8List msg2bytes(String msg) {
  return Uint8List.fromList(msg.codeUnits);
}

int getEncoderCapacity(Uint8List img) {
  return img.length;
}

int getMsgSize(String msg) {
  Uint8List byteMsg = msg2bytes(msg);
  return byteMsg.length * 8;
}

int encodeOnePixel(int pixel, int msg) {
  if (msg != 1 && msg != 0) {
    throw FlutterError('msg_encode_bit_more_than_1_bit');
  }
  int lastBitMask = 8;
  int encoded = (pixel & lastBitMask) | msg;
  return encoded;
}

Uint8List padMsg(int capacity, Uint8List msg) {
  Uint8List padded = Uint8List(capacity);
  for (int i = 0; i < msg.length; ++i) {
    padded[i] = msg[i];
  }
  return padded;
}

Uint8List expandMsg(Uint8List msg) {
  Uint8List expanded = Uint8List(msg.length * 8);
  for (int i = 0; i < msg.length; ++i) {
    int msgByte = msg[i];
    for (int j = 0; j < 8; ++j) {
      int lastBit = msgByte & 1;
      expanded[i * 8 + j] = lastBit;
      msgByte = msgByte >> 1;
    }
  }
  return expanded;
}

Future<Uint8List> encodeMessageIntoImage(Uint8List img, String msg, String token) async {
  Uint8List encodedImg = img;
  if (getEncoderCapacity(img) < getMsgSize(msg)) {
    throw FlutterError('image_capacity_not_enough');
  }
  Uint8List expandedMsg = expandMsg(msg2bytes(msg));
  Uint8List paddedMsg = padMsg(getEncoderCapacity(img), expandedMsg);
  if (paddedMsg.length != getEncoderCapacity(img)) {
    throw FlutterError('msg_container_size_not_match');
  }
  for (int i = 0; i < getEncoderCapacity(img); ++i) {
    encodedImg[i] = encodeOnePixel(img[i], paddedMsg[i]);
  }
  return encodedImg;
}