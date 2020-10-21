import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:messenger_t/pin_screen.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/5c/f2/72/5cf27278-05ee-5433-5110-6bf79b05adc9/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/1200x630wa.png'),
            ),
            SizedBox(
              height: 20,
              width: 250,
              child: Divider(
                color: Colors.orange,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (value) {
                      print(value.toString());
                    },
                    initialSelection: 'us',
                  ),
                  Flexible(
                    child: TextField(
                      onChanged: (String value) {
                        print(value);
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[10],
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              // color: Colors.orange,
              width: 250,
              child: FlatButton(
                color: Colors.orange,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PinScreen();
                  }));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
 CountryCodePicker(
                    onChanged: (value) {
                      print(value.toString());
                    },
                    initialSelection: 'US',
                    showCountryOnly: false,
                  ),
 */
