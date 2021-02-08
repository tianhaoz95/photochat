import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:minidonkey/services/requests/uploaded_img_conversion_request.dart';
import 'package:minidonkey/services/responses/uploaded_img_conversion_response.dart';
import 'package:image/image.dart' as imglib;
import 'package:minidonkey/services/utilities/get_capacity.dart';
import 'package:minidonkey/services/utilities/msg_bytes_converter.dart';

UploadedImageConversionResponse convertUploadedImageToData(
    UploadedImageConversionRequest req) {
  imglib.Image editableImage = imglib.decodeImage(req.file!.readAsBytesSync());
  Image displayableImage = Image.file(req.file!, fit: BoxFit.fitWidth);
  int imageByteSize = getEncoderCapacity(
      Uint16List.fromList(editableImage.getBytes().toList()));
  UploadedImageConversionResponse response = UploadedImageConversionResponse(
      editableImage, displayableImage, imageByteSize);
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
  String randomImageUrl =
      'https://i.picsum.photos/id/${randomId.toString()}/150/150.jpg';
  http.Response urlResponse = await http.get(randomImageUrl);
  imglib.Image editableImage = imglib.decodeImage(msg2bytes(urlResponse.body));
  Image displayableImage =
      Image.memory(imglib.encodePng(editableImage) as Uint8List, fit: BoxFit.fitWidth);
  int imageByteSize = getEncoderCapacity(
      Uint16List.fromList(editableImage.getBytes().toList()));
  UploadedImageConversionResponse response = UploadedImageConversionResponse(
      editableImage, displayableImage, imageByteSize);
  return response;
}
