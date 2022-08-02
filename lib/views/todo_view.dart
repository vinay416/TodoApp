import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/views/widgets/todo_appbar_widget.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key, this.todoDataModel}) : super(key: key);
  final TodoDataModel? todoDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Column(
      children: const [
        TodoAppBar(),
      ],
    );
  }
}
