import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/icon_button_widget.dart';
import 'package:todo_app/reusable_widgets/todo_icon_widget.dart';
import 'package:todo_app/views/todo_view.dart';

class TodoModelWidget extends StatelessWidget {
  const TodoModelWidget({Key? key, required this.todo}) : super(key: key);

  final TodoDataModel todo;

  @override
  Widget build(BuildContext context) {
    return _buildTodoCard(context);
  }

  Widget _buildTodoCard(BuildContext context) {
    return Hero(
      tag: todo.id,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: context.w(80)),
        child: Material(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(top: context.h(10)),
                leading: const TodoIcon(),
                title: _buildTitle(),
                subtitle: _buildDesc(),
                trailing: _buildButtons(),
                onTap: () => onTap(context),
              ),
              const Divider(color: kProductColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      todo.title,
      style: kTodoProductTitleTextStyle,
    );
  }

  Widget _buildDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.desc,
          style: kBodyTextStyle,
        ),
        Text(
          todo.date,
          style: kBodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return CustomIconTextButton(
      axisSize: MainAxisSize.min,
      onTap: () async {
        final String todoId = todo.id;
        DataBaseRepo().deleteTodo(todoId);
      },
      icon: Icons.delete_rounded,
      iconColor: kRedColor,
      iconSize: 30,
    );
  }

  void onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoView(
          todo: todo,
          isEdit: true,
        ),
      ),
    );
  }
}
