import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/methods/Firestore.dart';
import 'package:messenger_t/screens/chats_screen.dart';

class NewMessageScreen extends StatefulWidget {
  @override
  _NewMessageScreenState createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  final _firestore = FirebaseFirestore.instance;
  final messageTextController = TextEditingController();

  String messageText;
  String email;
  String openChatID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Message'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageReceiverContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'To: ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // email
                        email = value;
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                        hintText: 'Email',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      // check if email exists in firestore
                      openChatID = '${loggedInUser.email}-$email';
                      _firestore
                          .collection(FirestoreFunctions.MAIN_USER_COLLECTION)
                          .doc(email.toLowerCase())
                          .get()
                          .then((value) {
                        if (value.exists) {
                          //send message
                          // create openchat for loggedInUser
                          _firestore
                              .collection(
                                  FirestoreFunctions.MAIN_USER_COLLECTION)
                              .doc(loggedInUser.email)
                              .collection(
                                  FirestoreFunctions.OPEN_CHAT_SUB_COLLECTION)
                              .doc(openChatID)
                              .set({
                            FirestoreFunctions.CHAT_WITH_FIELD: email,
                            FirestoreFunctions.CHAT_ID_FIELD: openChatID,
                          });
                          //create openchat for email (receiver)
                          _firestore
                              .collection(
                                  FirestoreFunctions.MAIN_USER_COLLECTION)
                              .doc(email)
                              .collection(
                                  FirestoreFunctions.OPEN_CHAT_SUB_COLLECTION)
                              .doc(openChatID)
                              .set({
                            FirestoreFunctions.CHAT_WITH_FIELD:
                                loggedInUser.email,
                            FirestoreFunctions.CHAT_ID_FIELD: openChatID,
                          });

                          // create chats path
                          _firestore
                              .collection(
                                  FirestoreFunctions.MAIN_CHATS_COLLECTION)
                              .doc(openChatID)
                              .collection(
                                  FirestoreFunctions.MESSAGES_SUB_COLLECTION)
                              .add({
                            FirestoreFunctions.SENDER_FIELD: loggedInUser.email,
                            FirestoreFunctions.TEXT_FIELD: messageText,
                            FirestoreFunctions.TIME_FIELD: DateTime.now(),
                          });

                          print('email exists, send message');
                        } else {
                          // show error 'email does not exists
                          print('email does not exists');
                        }
                      });

                      print('email: $email');
                      print('message sent: $messageText');

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
