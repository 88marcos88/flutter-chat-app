import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sing in
  Future<UserCredential> singInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  //sing up

  //sign out

  //errors
}
