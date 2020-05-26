import 'package:image/image.dart' as imglib;

/// Encode Request
///
/// {@category Services: Requests}
class EncodeRequest {
  imglib.Image original;
  String msg;
  String token;

  EncodeRequest(this.original, this.msg, {this.token});

  bool shouldEncrypt() {
    return (token != null && token != '');
  }
}
