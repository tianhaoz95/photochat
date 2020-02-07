import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:photochatapp/services/decoder.dart';
import 'package:photochatapp/services/encoder.dart';

void main() {
  test('encoder decoder should be invariant', () async {
    int testCapacity = 100;
    Uint8List img = Uint8List(testCapacity);
    for (int i = 0; i < testCapacity; ++i) {
      img[i] = 8;
    }
    String msg = "my message";
    Uint8List encoded = await encodeMessageIntoImage(img, msg, "my_token");
    String decoded = await decodeMessageFromImage(encoded, "my_token");
    expect(decoded, msg);
  });

  test('last bit extractor should work', () {
    int lastBitZero = extractLastBit(8);
    int lastBitOne = extractLastBit(7);
    expect(lastBitZero, 0);
    expect(lastBitOne, 1);
  });

  test('assemble byte should work', () {
    int assembled = assembleBits(Uint8List.fromList([0, 0, 0, 0, 1, 0, 0, 0]));
    expect(assembled, 8);
    assembled = assembleBits(Uint8List.fromList([0, 0, 0, 1, 0, 0, 0, 0]));
    expect(assembled, 16);
    assembled = assembleBits(Uint8List.fromList([0, 0, 1, 0, 0, 0, 0, 0]));
    expect(assembled, 32);
    assembled = assembleBits(Uint8List.fromList([1, 1, 1, 1, 1, 1, 1, 0]));
    expect(assembled, 254);
  });

  test('bits to bytes should work', () {
    List<int> bits = [];
    bits += [1, 1, 1, 1, 1, 1, 1, 0];
    bits += [0, 0, 1, 0, 0, 0, 0, 0];
    bits += [0, 0, 0, 0, 1, 0, 0, 0];
    Uint8List bytes = bits2bytes(Uint8List.fromList(bits));
    expect(bytes[0], 254);
    expect(bytes[1], 32);
    expect(bytes[2], 8);
  });
}
