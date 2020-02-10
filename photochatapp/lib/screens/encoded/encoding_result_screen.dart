import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photochatapp/services/encoder.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:photochatapp/services/responses/encode_response.dart';

class EncodingResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EncodingResultScreen();
  }
}

class _EncodingResultScreen extends State<EncodingResultScreen> {
  Future<Image> encodedImage;
  Uint16List encodedByteImage;

  @override
  void initState() {
    super.initState();
    encodedByteImage = Uint16List.fromList([]);
    print('here at encode');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context).settings.arguments != null) {
      EncodeRequest req = ModalRoute.of(context).settings.arguments;
      encodedImage = encodeImage(req);
    }
  }

  Future<Image> encodeImage(EncodeRequest req) async {
    EncodeResponse response = await encodeMessageIntoImageAsync(req);
    return response.displayableImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encoded Result'),
      ),
      body: FutureBuilder<Image>(
          future: this.encodedImage,
          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
            if (snapshot.hasData) {
              print('has data');
              return Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: snapshot.data,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print('has error');
              return Container();
            } else {
              print('loading');
              return Container(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
          }),
    );
  }
}
