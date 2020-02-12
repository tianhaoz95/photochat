import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:image/image.dart' as imglib;

UploadedImageConversionResponse convertUploadedImageToData(
    UploadedImageConversionRequest req) {
  imglib.Image editableImage = imglib.decodeImage(req.file.readAsBytesSync());
  Image displayableImage = Image.file(req.file);
  UploadedImageConversionResponse response =
      UploadedImageConversionResponse(editableImage, displayableImage);
  return response;
}

Future<UploadedImageConversionResponse> convertUploadedImageToDataaAsync(
    UploadedImageConversionRequest req) async {
  UploadedImageConversionResponse response = await compute<
      UploadedImageConversionRequest,
      UploadedImageConversionResponse>(convertUploadedImageToData, req);
  return response;
}
