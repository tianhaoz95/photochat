import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:minidonkey/services/states/encode_result_states.dart';

/// Decode Result Screen Render Request
///
/// {@category Services: Requests}
class DecodeResultScreenRenderRequest {
  Image encodedImage;
  Uint8List encodedByteImage;
  DecodeResultState state;
  DecodeResultScreenRenderRequest(
      this.state, this.encodedByteImage, this.encodedImage);
}
