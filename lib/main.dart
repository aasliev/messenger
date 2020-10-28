import 'package:flutter/material.dart';
import 'package:messenger_t/screens/chat_screen.dart';
import 'package:messenger_t/screens/register_screen.dart';
import 'package:messenger_t/screens/welcome_screen.dart';
import 'screens/chats_screen.dart';
import 'screens/log_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MessengerT());
}

class MessengerT extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LogIn.id: (context) => LogIn(),
        Chats.id: (context) => Chats(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
}
