import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class SendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SendScreen();
  }
}

class _SendScreen extends State<SendScreen> {
  File _image;

  Future<void> pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> saveEncodedImage() async {
    Uint16List imageBytes =
        Uint16List.fromList(_image.readAsBytesSync().toList());
    await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes.toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: _image == null
                      ? Image.asset('assets/photo_placeholder.png')
                      : Image.file(_image),
                )),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Secret Token',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: this.pickImage,
                child: Icon(Icons.add_a_photo),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: this.saveEncodedImage,
                child: Text('Save Encoded Photo to Gallery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
