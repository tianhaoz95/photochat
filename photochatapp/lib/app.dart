import 'package:flutter/material.dart';
import 'package:photochatapp/screens/home/home_screen.dart';
import 'package:photochatapp/screens/receive/receive_screen.dart';
import 'package:photochatapp/screens/send/send_screen.dart';
import 'package:photochatapp/theme.dart';

class PhotoChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Chat',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/send': (context) => SendScreen(),
        '/receive': (context) => ReceiveScreen(),
      },
    );
  }
}