import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:photochatapp/components/token_input_field/token_input_field.dart';
import 'package:photochatapp/services/converters/uploaded_img_to_data.dart';
import 'package:photochatapp/services/requests/decode_request.dart';
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:photochatapp/services/states/loading_states.dart';

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
    this.image = Image.asset('assets/photo_placeholder.png');
    this.tokenCtrl = TextEditingController();
    this.decrypt = false;
  }

  Future<void> pickImageFromGallery() async {
    setState(() {
      uploadingState = LoadingState.LOADING;
    });
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
        title: Text('Decode a Message'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Container(
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
                      Text('Choose from Gallery'),
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
                      value: this.decrypt,
                      onChanged: (bool nextVal) {
                        setState(() {
                          this.decrypt = nextVal;
                        });
                      }),
                  Text('Decrypt my message!'),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: TokenInputField(this.decrypt, this.tokenCtrl),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
                child: RaisedButton(
              onPressed: this.sendToDecode,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.drafts),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Decode My Message'),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
