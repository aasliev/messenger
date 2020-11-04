import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunctions {
  final _firestore = FirebaseFirestore.instance;

  static const MAIN_USER_COLLECTION = 'users';
  static const MAIN_CHATS_COLLECTION = 'chats';

  static const OPEN_CHAT_SUB_COLLECTION = 'openChat';
  static const MESSAGES_SUB_COLLECTION = 'messages';

  static const USER_EMAIL_FIELD = 'email';
  static const PHOTO_URL_FIELD = 'photoURL';
  static const CHAT_WITH_FIELD = 'chatWith';
  static const SENDER_FIELD = 'sender';
  static const TEXT_FIELD = 'text';
  static const TIME_FIELD = 'time';
  static const CHAT_ID_FIELD = 'chatID';

  void createUserWithEmail({String email}) {
    _firestore
        .collection(FirestoreFunctions.MAIN_USER_COLLECTION)
        .doc(email.toLowerCase())
        .set({
      FirestoreFunctions.USER_EMAIL_FIELD: email,
    });
  }

  bool checkIfUserExists(String email) {
    _firestore
        .collection(MAIN_USER_COLLECTION)
        .doc(email.toLowerCase())
        .get()
        .then((value) => value.exists);
  }

  void sendMessage(
      {String chatID, String sender, String messageText, DateTime dateTime}) {
    if (messageText != '') {
      _firestore
          .collection(MAIN_CHATS_COLLECTION)
          .doc(chatID)
          .collection(MESSAGES_SUB_COLLECTION)
          .doc(dateTime.toString())
          .set({
        TEXT_FIELD: messageText,
        SENDER_FIELD: sender,
        TIME_FIELD: dateTime,
      });
    }
  }
}
