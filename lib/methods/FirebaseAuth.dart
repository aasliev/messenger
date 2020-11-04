import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final _auth = FirebaseAuth.instance;

  Future<bool> createUserWithEmail({String email, String password}) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (newUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithEmail({String email, String password}) async {
    final signedInUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (signedInUser != null) {
      return true;
    } else {
      return false;
    }
  }
  User getCurrentUser() {
      final user = _auth.currentUser;
      if (user != null) {
         return user;
      }
      return null;
  }

  void signOutUser(){
    _auth.signOut();
  }

}
