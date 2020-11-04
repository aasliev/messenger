import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/main.dart';
import 'package:messenger_t/methods/custom_button.dart';
import 'package:messenger_t/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

User loggedInUser;

class ProfileScreen extends StatefulWidget {
  static const id = 'profileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    loggedInUser = FireAuthInstance.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.chat,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(100),
              color: Colors.red,
              width: double.infinity,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(kLogoImageRoute),
                    radius: 60,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                    color: Colors.grey,
                    onPressed: () {
                      print('Button Pressed');
                    },
                    child: Text(
                      'Edit',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.orange,
                    child: Text(
                      'asliev.asliddin@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              color: Colors.red,
              onPressed: () {
                print('sign out');
                FireAuthInstance.signOutUser();
                Navigator.pushNamedAndRemoveUntil(
                    context, WelcomeScreen.id, (route) => false);
              },
              text: 'Sign Out',
            ),
          ],
        ),
      ),
    );
  }
}
