import 'package:flutter/material.dart';

/// Message Logo
///
/// {@category Screens: Home}
class HomeScreenMessageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 20,
        maxHeight: 200,
      ),
      child: Image.asset(
        'assets/message_logo.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
