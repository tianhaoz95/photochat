import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

class UploadedImageConversionResponse {
  imglib.Image editableImage;
  Image displayableImage;
  int imageByteSize;
  UploadedImageConversionResponse(
      this.editableImage, this.displayableImage, this.imageByteSize);
}
