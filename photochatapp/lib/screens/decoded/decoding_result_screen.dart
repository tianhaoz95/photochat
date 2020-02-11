import 'package:flutter/material.dart';
import 'package:photochatapp/services/decoder.dart';
import 'package:photochatapp/services/requests/decode_request.dart';
import 'package:photochatapp/services/responses/decode_response.dart';

class DecodingResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DecodingResultScreen();
  }
}

class _DecodingResultScreen extends State<DecodingResultScreen> {
  Future<String> decodedMsg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context).settings.arguments != null) {
      DecodeRequest req = ModalRoute.of(context).settings.arguments;
      decodedMsg = this.decodeMsg(req);
    }
  }

  Future<String> decodeMsg(DecodeRequest req) async {
    DecodeResponse response = await decodeMessageFromImageAsync(req);
    String msg = response.decodedMsg;
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Here is your message!'),
      ),
      body: FutureBuilder<String>(
          future: this.decodedMsg,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  children: <Widget>[Text(snapshot.data)],
                ),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container(
                child: Center(
                  child: Image.asset('assets/loading_dunkey.gif'),
                ),
              );
            }
          }),
    );
  }
}
