import 'package:flutter/material.dart';

/// Mini Donkey Logo
///
/// {@category Home Screen}
class HomeScreenDonkeyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 20,
          maxHeight: 400,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/loading_donkey.gif',
            fit: BoxFit.fitWidth,
          ),
        ));
  }
}
