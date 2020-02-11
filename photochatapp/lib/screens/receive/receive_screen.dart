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
              height: 15.0,
            ),
            Container(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: this.image,
            )),
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: RaisedButton(
                onPressed: this.pickImage,
                child: Icon(Icons.add_a_photo),
              ),
            ),
            SizedBox(
              height: 15.0,
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
              height: 15.0,
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
