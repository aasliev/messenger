import 'package:flutter/material.dart';
import 'package:messenger_t/screens/chat_screen.dart';
import 'package:messenger_t/screens/profile_screen.dart';
import 'package:messenger_t/screens/register_screen.dart';
import 'package:messenger_t/screens/welcome_screen.dart';
import 'screens/chats_screen.dart';
import 'screens/log_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'methods/FirebaseAuth.dart';

User loggedInUser;
final FireAuthInstance = FireAuth();
String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  loggedInUser = FireAuthInstance.getCurrentUser();
  if (loggedInUser != null) {
    initialRoute = Chats.id;
  } else {
    initialRoute = WelcomeScreen.id;
  }
  runApp(MessengerT());
}

class MessengerT extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LogIn.id: (context) => LogIn(),
        Chats.id: (context) => Chats(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
