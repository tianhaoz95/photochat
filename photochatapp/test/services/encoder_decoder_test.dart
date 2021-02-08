import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minidonkey/services/decoder.dart';
import 'package:minidonkey/services/encoder.dart';
import 'package:minidonkey/services/requests/decode_request.dart';
import 'package:minidonkey/services/requests/encode_request.dart';
import 'package:minidonkey/services/responses/decode_response.dart';
import 'package:minidonkey/services/responses/encode_response.dart';
import 'package:minidonkey/services/utilities/msg_bytes_converter.dart';
import 'package:minidonkey/services/utilities/pad_to_bytes.dart';
import 'package:image/image.dart' as imglib;

import '../utilities/image_file_loader.dart';

final List<String> testMessages = [
  'The most basic message',
  'This is a message that end with a non-character!',
  '中文的也应该可以',
  '中文以标点符号结束应该也可以！',
  '再試試繁體的行不行',
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('encoder decoder should be invariant', () async {
    File imageFile = loadFixtureImageFile('photo_placeholder.png');
    imglib.Image original = imglib.decodeImage(imageFile.readAsBytesSync());
    String msg = "basic message";
    EncodeResponse response =
        await encodeMessageIntoImageAsync(EncodeRequest(original, msg));
    DecodeResponse decoded = await decodeMessageFromImageAsync(
        DecodeRequest(response.editableImage));
    String decodedMsg = decoded.decodedMsg;
    expect(decodedMsg, msg);
  });

  test('encoder decoder should be invariant across msg', () async {
    File imageFile = loadFixtureImageFile('photo_placeholder.png');
    imglib.Image original = imglib.decodeImage(imageFile.readAsBytesSync());
    for (String msg in testMessages) {
      EncodeResponse response =
          await encodeMessageIntoImageAsync(EncodeRequest(original, msg));
      DecodeResponse decoded = await decodeMessageFromImageAsync(
          DecodeRequest(response.editableImage));
      String decodedMsg = decoded.decodedMsg;
      expect(decodedMsg, msg);
    }
  });

  test('last bit extractor should work', () {
    int lastBitZero = extractLastBit(8);
    int lastBitOne = extractLastBit(7);
    expect(lastBitZero, 0);
    expect(lastBitOne, 1);
  });

  test('assemble byte should work', () {
    int assembled = assembleBits(
        Uint16List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0]));
    expect(assembled, 8);
    assembled = assembleBits(
        Uint16List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0]));
    expect(assembled, 16);
    assembled = assembleBits(
        Uint16List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0]));
    expect(assembled, 32);
    assembled = assembleBits(
        Uint16List.fromList([0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0]));
    expect(assembled, 254);
  });

  test('bits to bytes should work', () {
    List<int> bits = [];
    bits += [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0];
    bits += [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    bits += [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0];
    Uint16List bytes = bits2bytes(Uint16List.fromList(bits));
    expect(bytes[0], 254);
    expect(bytes[1], 32);
    expect(bytes[2], 8);
  });

  test("pad msg should work", () {
    Uint16List beforePadded = Uint16List.fromList([1, 2, 3]);
    Uint16List expectedPadded = Uint16List.fromList([1, 2, 3, 0, 0, 0, 0]);
    expect(padMsg(7, beforePadded), expectedPadded);
  });

  test('pad to bytes should work', () {
    Uint16List beforePadded = Uint16List.fromList([1, 2, 3]);
    Uint16List expectedPadded =
        Uint16List.fromList([1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    expect(padToBytes(beforePadded), expectedPadded);
  });

  test('expand msg should work', () {
    Uint16List compressed = Uint16List.fromList([5, 4, 1]);
    List<int> expandedRaw = [];
    expandedRaw += [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1];
    expandedRaw += [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0];
    expandedRaw += [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
    Uint16List expanded = Uint16List.fromList(expandedRaw);
    expect(expandMsg(compressed), expanded);
  });

  test('msg byte converter should be invariant', () {
    for (String msg in testMessages) {
      expect(bytes2msg(msg2bytes(msg)), msg);
    }
  });
}
