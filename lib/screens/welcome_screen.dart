import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/methods/custom_button.dart';
import 'package:messenger_t/screens/log_in_screen.dart';
import 'package:messenger_t/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(kLogoImageRoute),
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 250),
                  text: ['T.Messenger'],
                  textStyle: kAppNameTextStyle,
                )
              ],
            ),
            SizedBox(
              height: 48,
            ),
            CustomButton(
              color: kLogInButtonColor,
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LogIn.id,
                );
              },
            ),
            CustomButton(
              color: kRegisterButtonColor,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RegisterScreen.id,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
