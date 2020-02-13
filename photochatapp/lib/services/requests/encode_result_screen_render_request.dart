import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/states/encode_result_states.dart';

class DecodeResultScreenRenderRequest {
  Image encodedImage;
  Uint8List encodedByteImage;
  DecodeResultState state;
  DecodeResultScreenRenderRequest(this.state, this.encodedByteImage, this.encodedImage);
}