import 'package:image/image.dart' as imglib;

/// Decode Request
///
/// {@category Services: Requests}
class DecodeRequest {
  imglib.Image original;
  String token;

  DecodeRequest(this.original, {this.token});

  bool shouldDecrypt() {
    return (token != null && token != '');
  }
}
