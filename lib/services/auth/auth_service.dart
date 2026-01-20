import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  //instance of auth & firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? get currentUser {
    return _auth.currentUser;
  }

  //sing in
  Future<UserCredential> singInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      //sign in user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  //sing up
  Future<UserCredential> singUpWithEmailPassword(String email, password) async {
    try {
      //create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info if ir does not exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  //sign out

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //errors
}
