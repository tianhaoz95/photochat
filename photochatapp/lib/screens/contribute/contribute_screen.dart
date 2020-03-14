import 'package:flutter/material.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';

class ContributeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text('Contribute'),
              SizedBox(
                width: 10.0,
              ),
              Icon(Icons.favorite),
            ],
          ),
          leading: IconButton(
              key: Key('contrib_screen_back_btn'),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        resizeToAvoidBottomInset: false,
        body: ScreenAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'All Kinds of Contribution are Welcome!',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/in_love_corgi_long.gif'),
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      '1. File bug reports & feature requests.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      '2. Code contribution.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/programming_corgi.gif'),
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      '3. Sponsor Apple developer account.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
