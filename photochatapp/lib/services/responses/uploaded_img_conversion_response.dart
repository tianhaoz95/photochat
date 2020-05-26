import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as imglib;

/// Upload Image Conversion Response
///
/// {@category Services: Responses}
class UploadedImageConversionResponse {
  imglib.Image editableImage;
  Image displayableImage;
  int imageByteSize;
  UploadedImageConversionResponse(
      this.editableImage, this.displayableImage, this.imageByteSize);
}
