import 'package:flutter/material.dart';

class ScreenAdapter extends StatelessWidget {
  final child;
  ScreenAdapter({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(aspectRatio: 9.0 / 16.0, child: this.child),
        ],
      ),
    );
  }
}
