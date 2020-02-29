import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/services/utilities/msg_bytes_converter.dart';

UploadedImageConversionResponse convertUploadedImageToData(
    UploadedImageConversionRequest req) {
  imglib.Image editableImage = imglib.decodeImage(req.file.readAsBytesSync());
  Image displayableImage = Image.file(req.file, fit: BoxFit.fitWidth);
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

Future<UploadedImageConversionResponse> getRandomImageFromWebAsync() async {
  Random randomGenerator = Random();
  int randomId = randomGenerator.nextInt(1000);
  String randomImageUrl = 'https://i.picsum.photos/id/${randomId.toString()}/300/300.jpg';
  http.Response urlResponse = await http.get(randomImageUrl);
  imglib.Image editableImage = imglib.decodeImage(msg2bytes(urlResponse.body));
  Image displayableImage = Image.network(randomImageUrl, fit: BoxFit.fitWidth);
  UploadedImageConversionResponse response =
      UploadedImageConversionResponse(editableImage, displayableImage);
  return response;
}
