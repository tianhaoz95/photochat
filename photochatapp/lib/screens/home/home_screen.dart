import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!', key: Key('home_screen_title'),),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: 20,
                  maxHeight: 400,
                ),
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/loading_donkey.gif', fit: BoxFit.fitWidth,),
            )),
            SizedBox(
              height: 10.0,
            ),
            Container(
              constraints: BoxConstraints(
                  minHeight: 20,
                  maxHeight: 200,
                ),
              child: Image.asset('assets/message_logo.png', fit: BoxFit.fitWidth,),
            ),
            SizedBox(
              height: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/send');
              },
              key: Key('home_screen_encode_message_btn'),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Encode a Message'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/receive');
              },
              key: Key('home_screen_decode_message_btn'),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.drafts),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Decode a Message'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/contribute');
              },
              key: Key('home_screen_contribute_btn'),
              color: Colors.pinkAccent,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('Contribute to the Project'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
