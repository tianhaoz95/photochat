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
                child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/loading_dunkey.gif'),
            )),
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
