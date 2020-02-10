import 'package:image/image.dart' as imglib;

class DecodeRequest {
  imglib.Image original;
  String token;

  DecodeRequest(this.original, {this.token});

  bool shouldDecrypt() {
    return (token != null && token != '');
  }
}
