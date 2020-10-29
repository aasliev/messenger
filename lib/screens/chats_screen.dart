import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/methods/Firestore.dart';
import 'package:messenger_t/screens/chat_screen.dart';
import 'new_message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class Chats extends StatefulWidget {
  static const id = 'chatsScreen';
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return NewMessageScreen();
                      }));
            },
          ),
        ],
        title: Text(
          '️Chats',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: OpenChatStream(),
      ),
    );
  }
}

class OpenChatStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(FirestoreFunctions.MAIN_USER_COLLECTION)
          .doc(loggedInUser.email)
          .collection(FirestoreFunctions.OPEN_CHAT_SUB_COLLECTION)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final openChats = snapshot.data.docs;
        // List<Text> openChatTextWidgets = [];
        List<OpenChatTile> openChatTiles = [];
        for (var eachChat in openChats) {
          final chatWith = eachChat.get(FirestoreFunctions.CHAT_WITH_FIELD);
          final chatID = eachChat.get(FirestoreFunctions.CHAT_ID_FIELD);

          final chatTile = OpenChatTile(
            email: chatWith,
            chatID: chatID,
          );

          openChatTiles.add(chatTile);
        }
        return ListView(
          padding: EdgeInsets.all(5),
          children: ListTile.divideTiles(
            context: context,
            tiles: openChatTiles,
          ).toList(),
        );
      },
    );
  }
}

class OpenChatTile extends StatelessWidget {
  OpenChatTile(
      {@required this.email, this.image, this.lastMessage, this.chatID});

  final String email;
  final ImageProvider image;
  final String lastMessage;
  final String chatID;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text(lastMessage == null ? "" : lastMessage),
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: CircleAvatar(
          backgroundImage: image != null ? image : AssetImage(kLogoImageRoute),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatScreen(
              email: email,
              chatID: chatID,
            );
          }));
        },
        title: Text(email),
      ),
    );
  }
}
