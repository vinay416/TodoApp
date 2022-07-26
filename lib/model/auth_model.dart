import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  AuthModel._privateConstructor();

  static final AuthModel _instance = AuthModel._privateConstructor();

  static AuthModel get instance => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get getAuthStream => _firebaseAuth.authStateChanges();

  void signInAnon() => _firebaseAuth.signInAnonymously();

  void logout() => _firebaseAuth.signOut();
}
