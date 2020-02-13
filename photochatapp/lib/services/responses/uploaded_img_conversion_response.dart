import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

class UploadedImageConversionResponse {
  imglib.Image editableImage;
  Image displayableImage;
  UploadedImageConversionResponse(this.editableImage, this.displayableImage);
}
