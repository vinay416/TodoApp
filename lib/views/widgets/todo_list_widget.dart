import 'package:flutter/material.dart';
import 'package:todo_app/views/widgets/todo_model_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (_, index) {
          return const TodoModelWidget();
        },
      ),
    );
  }
}
