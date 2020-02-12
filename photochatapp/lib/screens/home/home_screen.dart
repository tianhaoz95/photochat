import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Image.asset('assets/message_logo.png'),
            ),
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
