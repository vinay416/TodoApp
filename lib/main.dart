import 'package:flutter/material.dart';
import 'package:todo_app/views/auth_view.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AuthView.route: (context) => const AuthView(),
      },
    );
  }
}
