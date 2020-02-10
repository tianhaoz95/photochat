import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photochatapp/services/utilities/config.dart';
import 'package:photochatapp/services/utilities/msg_bytes_converter.dart';

int getEncoderCapacity(Uint16List img) {
  return img.length;
}

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

Future<Uint16List> encodeMessageIntoImage(
    Uint16List img, String msg, String token) async {
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
  return encodedImg;
}
