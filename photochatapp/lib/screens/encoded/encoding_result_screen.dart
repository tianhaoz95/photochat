import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photochatapp/services/encoder.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:photochatapp/services/responses/encode_response.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class EncodingResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EncodingResultScreen();
  }
}

class _EncodingResultScreen extends State<EncodingResultScreen> {
  Future<Image> encodedImage;
  Uint8List encodedByteImage;

  @override
  void initState() {
    super.initState();
    encodedByteImage = Uint8List.fromList([]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context).settings.arguments != null) {
      EncodeRequest req = ModalRoute.of(context).settings.arguments;
      encodedImage = encodeImage(req);
    }
  }

  Future<Image> encodeImage(EncodeRequest req) async {
    EncodeResponse response = await encodeMessageIntoImageAsync(req);
    encodedByteImage = response.data;
    return response.displayableImage;
  }

  Future<void> saveImage() async {
    if (Platform.isAndroid) {
      PermissionStatus permissionStorage = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permissionStorage != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissionStatus =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        permissionStorage = permissionStatus[PermissionGroup.storage] ??
            PermissionStatus.unknown;

        if (permissionStorage != PermissionStatus.granted) {
          print('no storage permission to save image');
          return;
        }
      }
    }
    dynamic response = await ImageGallerySaver.saveImage(
        Uint8List.fromList(encodedByteImage.toList()));
    print(response);
  }

  Future<void> shareImage() async {
    await Share.file(
        'encoded image', 'encoded.png', this.encodedByteImage, 'image/png',
        text: 'This is the encoded image.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hooray! Encoded!'),
      ),
      body: FutureBuilder<Image>(
          future: this.encodedImage,
          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: snapshot.data,
                    )),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: this.saveImage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.save),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('Save'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: RaisedButton(
                        onPressed: this.shareImage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.share),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/rabbits_clapping.gif'),
                    )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container(
                child: ListView(
                  children: <Widget>[
                    LinearProgressIndicator(),
                    Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset('assets/loading_dunkey.gif'),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                      child: Text(
                          'Please be patient, mini dunkey is encoding your message...'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
