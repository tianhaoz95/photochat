import 'package:flutter/material.dart';

class ScreenAdapter extends StatelessWidget {
  final child;
  ScreenAdapter({this.child});
  @override
  Widget build(BuildContext context) {
    double aspectRatio =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
    double preferredAspectRatio = 10.0 / 16.0;
    if (aspectRatio > preferredAspectRatio) {
      aspectRatio = preferredAspectRatio;
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(aspectRatio: aspectRatio, child: this.child),
        ],
      ),
    );
  }
}
