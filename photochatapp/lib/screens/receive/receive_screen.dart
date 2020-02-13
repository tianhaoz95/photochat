import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
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
  LoadingState uploadingImage;
  TextEditingController tokenCtrl;

  @override
  void initState() {
    super.initState();
    this.image = Image.asset('assets/photo_placeholder.png');
    this.tokenCtrl = TextEditingController();
  }

  Future<void> pickImageFromGallery() async {
    setState(() {
      uploadingImage = LoadingState.LOADING;
    });
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      UploadedImageConversionResponse response =
          await convertUploadedImageToDataaAsync(
              UploadedImageConversionRequest(imageFile));
      editableImage = response.editableImage;
      setState(() {
        this.image = response.displayableImage;
      });
    }
    setState(() {
      uploadingImage = LoadingState.SUCCESS;
    });
  }

  void sendToDecode() {
    DecodeRequest req = DecodeRequest(this.editableImage, token: this.tokenCtrl.text);
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
                onPressed: this.pickImageFromGallery,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonLogoWithLoadingAndError(
                          this.uploadingImage, Icons.camera),
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
              child: TextField(
                controller: this.tokenCtrl,
                decoration: InputDecoration(
                  labelText: 'Secret Token',
                ),
              ),
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
