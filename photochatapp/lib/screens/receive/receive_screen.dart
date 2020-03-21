import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';
import 'package:photochatapp/components/token_input_field/token_input_field.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/converters/uploaded_img_to_data.dart';
import 'package:photochatapp/services/i18n/i18n.dart';
import 'package:photochatapp/services/requests/decode_request.dart';
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/states/loading_states.dart';
import 'package:provider/provider.dart';

class ReceiveScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceiveScreen();
  }
}

class _ReceiveScreen extends State<ReceiveScreen> {
  Image image;
  imglib.Image editableImage;
  File imageFile;
  LoadingState uploadingState;
  TextEditingController tokenCtrl;
  bool decrypt;

  @override
  void initState() {
    super.initState();
    this.image =
        Image.asset('assets/photo_placeholder.png', fit: BoxFit.fitWidth);
    this.tokenCtrl = TextEditingController();
    this.decrypt = false;
  }

  Future<void> pickImageFromGallery() async {
    setState(() {
      uploadingState = LoadingState.LOADING;
    });
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      setState(() {
        this.image =
            Image.asset('assets/test_images/corgi.png', fit: BoxFit.fitWidth);
      });
    } else {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        print('got image');
        UploadedImageConversionResponse response =
            await convertUploadedImageToDataaAsync(
                UploadedImageConversionRequest(imageFile));
        editableImage = response.editableImage;
        setState(() {
          this.image = response.displayableImage;
        });
      }
    }
    setState(() {
      uploadingState = LoadingState.SUCCESS;
    });
  }

  void sendToDecode() {
    DecodeRequest req =
        DecodeRequest(this.editableImage, token: this.tokenCtrl.text);
    Navigator.pushNamed(context, '/decoded', arguments: req);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).decodeScreenTitleText),
          leading: IconButton(
              key: Key('receive_screen_back_btn'),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        resizeToAvoidBottomInset: false,
        body: ScreenAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ListView(
              key: Key('decode_screen_scrollable_list'),
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 600,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: this.image,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: RaisedButton(
                    key: Key('decode_pick_image_from_gallery_btn'),
                    onPressed: this.pickImageFromGallery,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonLogoWithLoadingAndError(
                              this.uploadingState, Icons.camera),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(AppLocalizations.of(context)
                              .decodeScreenGalleryBtnText),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          key: Key('decode_encrypt_checkbox'),
                          value: this.decrypt,
                          onChanged: (bool nextVal) {
                            setState(() {
                              this.decrypt = nextVal;
                            });
                          }),
                      Text(AppLocalizations.of(context)
                          .decodeScreenDecryptCheckboxText),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: TokenInputField(
                    this.decrypt,
                    this.tokenCtrl,
                    keyVal: 'decode_screen_token_input',
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    child: RaisedButton(
                  key: Key('decode_screen_decode_btn'),
                  onPressed: this.sendToDecode,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.drafts),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(AppLocalizations.of(context)
                            .decodeScreenDecodeBtnText),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
