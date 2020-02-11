import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

class EncodeResponse {
  imglib.Image editableImage;
  Image displayableImage;
  Uint8List data;
  EncodeResponse(this.editableImage, this.displayableImage, this.data);
}
