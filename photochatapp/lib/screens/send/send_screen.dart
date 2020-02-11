import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    editableImage = imglib.decodeImage(imageFile.readAsBytesSync());
    Image displayableImage = Image.file(imageFile);
    setState(() {
      this.image = displayableImage;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose a Message'),
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
                controller: this.msgCtrl,
                decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
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
                onPressed: this.sendToEncode,
                child: Text('Encode My Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
