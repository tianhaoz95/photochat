import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photochatapp/screens/send/token_field.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:image/image.dart' as imglib;

class SendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SendScreen();
  }
}

class _SendScreen extends State<SendScreen> {
  File imageFile;
  imglib.Image editableImage;
  Image image;
  TextEditingController msgCtrl;
  TextEditingController tokenCtrl;
  bool encrypt;

  Future<void> pickImageFromGallery() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      editableImage = imglib.decodeImage(imageFile.readAsBytesSync());
      Image displayableImage = Image.file(imageFile);
      setState(() {
        this.image = displayableImage;
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      editableImage = imglib.decodeImage(imageFile.readAsBytesSync());
      Image displayableImage = Image.file(imageFile);
      setState(() {
        this.image = displayableImage;
      });
    }
  }

  Future<void> sendToEncode() async {
    EncodeRequest req = EncodeRequest(this.editableImage, msgCtrl.text);
    Navigator.pushNamed(context, '/encoded', arguments: req);
  }

  @override
  void initState() {
    super.initState();
    this.image = Image.asset('assets/photo_placeholder.png');
    this.msgCtrl = TextEditingController();
    this.tokenCtrl = TextEditingController();
    this.encrypt = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encode a Message'),
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
                      Icon(Icons.camera),
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
              child: RaisedButton(
                onPressed: this.pickImageFromCamera,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera_alt),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Take Picture with Camera'),
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
                controller: this.msgCtrl,
                decoration: InputDecoration(
                  labelText: 'Message',
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
                      value: this.encrypt,
                      onChanged: (bool nextVal) {
                        setState(() {
                          this.encrypt = nextVal;
                        });
                      }),
                  Text('Encrypt my message!'),
                ],
              ),
            ),
            TokenInputField(this.encrypt, this.tokenCtrl),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: RaisedButton(
                onPressed: this.sendToEncode,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.email),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Encode My Message'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
