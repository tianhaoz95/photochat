import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photochatapp/components/alerts/dialog.dart';
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';
import 'package:photochatapp/screens/encoded/share_btn.dart';
import 'package:photochatapp/services/encoder.dart';
import 'package:photochatapp/services/i18n/i18n.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:photochatapp/services/requests/encode_result_screen_render_request.dart';
import 'package:photochatapp/services/responses/encode_response.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:photochatapp/services/states/encode_result_states.dart';
import 'package:photochatapp/services/states/loading_states.dart';

/// Encode Result Screen
/// 
/// {@category Screens}
/// {@category Screens: Encode Result}
class EncodingResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EncodingResultScreen();
  }
}

class _EncodingResultScreen extends State<EncodingResultScreen> {
  Future<DecodeResultScreenRenderRequest> renderRequest;
  LoadingState savingState;

  @override
  void initState() {
    super.initState();
    this.savingState = LoadingState.PENDING;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context).settings.arguments != null) {
      EncodeRequest encodeReq = ModalRoute.of(context).settings.arguments;
      renderRequest = requestEncodeImage(encodeReq);
    }
  }

  Future<DecodeResultScreenRenderRequest> requestEncodeImage(
      EncodeRequest req) async {
    EncodeResponse response =
        await encodeMessageIntoImageAsync(req, context: context);
    return DecodeResultScreenRenderRequest(
        DecodeResultState.SUCCESS, response.data, response.displayableImage);
  }

  Future<void> saveImage(Uint8List imageData) async {
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
    setState(() {
      this.savingState = LoadingState.LOADING;
    });
    dynamic response = await ImageGallerySaver.saveImage(imageData);
    print(response);
    if (response.toString().toLowerCase().contains('not found')) {
      setState(() {
        this.savingState = LoadingState.ERROR;
      });
      throw FlutterError('save_image_to_gallert_failed');
    }
    setState(() {
      this.savingState = LoadingState.SUCCESS;
    });
  }

  Future<void> shareImage(List<int> imageData) async {
    try {
      await Share.file('encoded image', 'encoded.png', imageData, 'image/png',
        text: 'This is the encoded image.');
    } catch (err) {
      showAlert(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).encodeResultScreenTitleText),
          leading: IconButton(
              key: Key('encoded_screen_back_btn'),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        resizeToAvoidBottomInset: false,
        body: ScreenAdapter(
          child: FutureBuilder<DecodeResultScreenRenderRequest>(
              future: this.renderRequest,
              builder: (BuildContext context,
                  AsyncSnapshot<DecodeResultScreenRenderRequest> snapshot) {
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
                          child: snapshot.data.encodedImage,
                        )),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () {
                              this.saveImage(snapshot.data.encodedByteImage);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonLogoWithLoadingAndError(
                                    this.savingState, Icons.save),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(AppLocalizations.of(context)
                                    .encodeResultScreenSaveBtnText),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        EncodeResultScreenShareBtn(
                          onShareHandler: () {
                            this.shareImage(snapshot.data.encodedByteImage);
                          },
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
                  return Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            'Whoops >_<',
                            style: TextStyle(fontSize: 30.0),
                          )),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          child: Center(
                              child: Text('It seems something went wrong: ' +
                                  snapshot.error.toString())),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset('assets/bear_bye.gif'),
                        )),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: ListView(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset('assets/loading_donkey.gif'),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                          child: Text(
                              'Please be patient, mini donkey is encoding your message...'),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
