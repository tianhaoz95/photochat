import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
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
  bool selected;
  bool sending;

  Future<void> pickImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    editableImage = imglib.decodeImage(imageFile.readAsBytesSync());
    setState(() {
      image = Image.file(imageFile);
    });
  }

  Future<void> sendToEncode() async {
    // Uint16List imageBytes = Uint16List.fromList(image.readAsBytesSync().toList());
    // await ImageGallerySaver.saveImage(Uint8List.fromList(imageBytes.toList()));
    // Image.asset('assets/photo_placeholder.png')
    setState(() {
      this.sending = true;
    });
    print('start');
    EncodeRequest req = EncodeRequest(this.editableImage, '');
    Navigator.pushNamed(context, '/encoded', arguments: req);
    print('end');
    setState(() {
      this.sending = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.image = Image.asset('assets/photo_placeholder.png');
    this.selected = false;
    this.sending = false;
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
                  child: this.image,
                )),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: this.pickImage,
                child: Icon(Icons.add_a_photo),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
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
                onPressed: this.sendToEncode,
                child:
                    this.sending ? Text('Sending') : Text('Encode My Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
