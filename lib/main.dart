import 'package:flutter/material.dart';
import 'chats.dart';
import 'log_in_screen.dart';

void main() => runApp(MessengerT());

class MessengerT extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(),
      home: LogIn(),
    );
  }
}
