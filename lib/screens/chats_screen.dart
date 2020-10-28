import 'package:flutter/material.dart';
import 'package:messenger_t/constants.dart';
import 'package:messenger_t/screens/chat_screen.dart';
import 'new_message_screen.dart';

class Chats extends StatefulWidget {
  static const id = 'chatsScreen';
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
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
        child: ListView(
          padding: EdgeInsets.all(5),
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              OpenChatTile(
                email: 'email',
                lastMessage: 'Hello',
                onTap: () {
                  //Navigator.pushNamed(context, ChatScreen.id);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatScreen(
                      email: 'asli@gmail.com',
                    );
                  }));
                },
              ),
              OpenChatTile(
                email: 'asli@gmail.com',
                image: NetworkImage(
                  'https://thumbs.dreamstime.com/b/iron-man-17900674.jpg',
                ),
                lastMessage: 'I am Iron Man',
                onTap: () {
                  print('I am Iron Man');
                },
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}

class OpenChatTile extends StatelessWidget {
  OpenChatTile(
      {this.email, @required this.image, this.lastMessage, this.onTap});

  final String email;
  final ImageProvider image;
  final String lastMessage;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text(lastMessage),
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: CircleAvatar(
          backgroundImage: image != null ? image : AssetImage(kLogoImageRoute),
        ),
        onTap: onTap,
        title: Text('Email'),
      ),
    );
  }
}
