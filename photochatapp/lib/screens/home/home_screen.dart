import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Chat'),
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
              child: Image.asset('assets/message_in_crop.gif'),
            )),
            SizedBox(
              height: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/send');
              },
              child: Text('Compose a Message'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/message_out_crop.gif'),
            )),
            SizedBox(
              height: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/receive');
              },
              child: Text('Decode a Message'),
            )
          ],
        ),
      ),
    );
  }
}
