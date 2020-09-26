import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementaion {
  Future<String> sigIn(String email, String password);
  Future<String> sigUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> singOut();
}

class Auth implements AuthImplementaion {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> sigIn(String email, String password) async {
    // FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
    //     email: email, password: password);

    // return user.uid;
    return null;
  }

  Future<String> sigUp(String email, String password) async {
    // FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
    //     email: "dd", password: "dd");
    // return user.uid;
    return null;
  }

  Future<String> getCurrentUser() async {
    // FirebaseUser user = await _firebaseAuth.currentUser;
    // return user.uid;
    return null;
  }

  Future<void> singOut() async {
    _firebaseAuth.signOut();
  }
}
