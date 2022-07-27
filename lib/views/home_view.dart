import 'package:flutter/material.dart';
import 'package:todo_app/model/auth_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Homeview"),
            TextButton(
              onPressed: () {
                AuthModel().logout();
              },
              child: const Text("log-out"),
            )
          ],
        ),
      ),
    );
  }
}
