import 'dart:typed_data';

Uint16List msg2bytes(String msg) {
  return Uint16List.fromList(msg.codeUnits);
}

String bytes2msg(Uint16List bytes) {
  return String.fromCharCodes(bytes);
}
