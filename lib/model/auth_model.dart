import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/model/user_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';

class AuthModel {
  AuthModel._privateConstructor();

  static final AuthModel _instance = AuthModel._privateConstructor();

  factory AuthModel() => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get getAuthStream => _firebaseAuth.authStateChanges();

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

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        await DataBaseRepo().createNewUser();

        return true;
      }
      return false;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  UserDataModel get getUser {
    final User user = _firebaseAuth.currentUser!;

    return UserDataModel(
      email: user.email!,
      id: user.uid,
      name: user.displayName!,
    );
  }
}
