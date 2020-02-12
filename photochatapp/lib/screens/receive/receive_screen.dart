import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/services/requests/decode_request.dart';

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

  @override
  void initState() {
    super.initState();
    this.image = Image.asset('assets/photo_placeholder.png');
  }

  Future<void> pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    editableImage = imglib.decodeImage(imageFile.readAsBytesSync());
    Image displayableImage = Image.file(imageFile);
    setState(() {
      this.image = displayableImage;
    });
  }

  void sendToDecode() {
    DecodeRequest req = DecodeRequest(this.editableImage);
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
                onPressed: this.pickImage,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera),
                      SizedBox(width: 15.0,),
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
                onPressed: () {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera_alt),
                      SizedBox(width: 15.0,),
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
                decoration: InputDecoration(
                    labelText: 'Secret Token',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: RaisedButton(
                onPressed: this.sendToDecode,
                child: Text('Decode My Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
