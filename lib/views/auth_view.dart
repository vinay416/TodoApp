import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/sign_in_view.dart';

class AuthView extends StatelessWidget {
  static const String route = "/";
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthModel().getAuthStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SignInView();
        }

        return const HomeView();
      },
    );
  }
}
