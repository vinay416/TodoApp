import 'package:flutter/material.dart';
import 'package:todo_app/model/auth_model.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Signin"),
            TextButton(
                onPressed: () {
                  AuthModel().signInWithGoogle();
                },
                child: const Text("Sign-in"))
          ],
        ),
      ),
    );
  }
}
