import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/methods/custom_button.dart';
import 'package:messenger_t/screens/chats_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:messenger_t/methods/FirebaseAuth.dart';
import 'package:messenger_t/methods/show_dialog.dart';

class LogIn extends StatefulWidget {
  static const id = 'logIn';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final fireAuthInstance = FireAuth();

  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(kLogoImageRoute),
                    height: 200,
                  ),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              CustomButton(
                color: kLogInButtonColor,
                text: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    if (await fireAuthInstance.signInWithEmail(
                        email: email, password: password)) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Chats.id, (route) => false);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    showMyDialog(context, 'Error', e.toString());
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
