import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

class EncodeResponse {
  imglib.Image editableImage;
  Image displayableImage;
  EncodeResponse(this.editableImage, this.displayableImage);
}
