import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get getAuthStream => _firebaseAuth.authStateChanges();

  User? get user => _firebaseAuth.currentUser;

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        return user;
      }
      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
