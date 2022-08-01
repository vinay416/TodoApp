import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/resuable_widgets/loader_widget.dart';
import 'package:todo_app/views/widgets/todo_model_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<TodoDataModel>>(
          stream: DataBaseRepo().getUserTodoStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No data");
            }

            final List<TodoDataModel> todoList = snapshot.data!;

            return _buildTodoList(todoList);
          }),
    );
  }

  Widget _buildTodoList(List<TodoDataModel> todoList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoList.length,
      itemBuilder: (_, index) {
        return TodoModelWidget(
          todo: todoList[index],
        );
      },
    );
  }
}
