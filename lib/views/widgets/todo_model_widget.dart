import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/icon_button_widget.dart';
import 'package:todo_app/reusable_widgets/todo_icon_widget.dart';
import 'package:todo_app/views/todo_view.dart';

class TodoModelWidget extends StatefulWidget {
  const TodoModelWidget({Key? key, required this.todo}) : super(key: key);

  final TodoDataModel todo;

  @override
  State<TodoModelWidget> createState() => _TodoModelWidgetState();
}

class _TodoModelWidgetState extends State<TodoModelWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildTodoCard();
  }

  Widget _buildTodoCard() {
    return Hero(
      tag: widget.todo.id,
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
                onTap: onTap,
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
      widget.todo.title,
      style: kTodoProductTitleTextStyle,
    );
  }

  Widget _buildDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.todo.desc,
          style: kBodyTextStyle,
        ),
        Text(
          widget.todo.date,
          style: kBodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return CustomIconTextButton(
      axisSize: MainAxisSize.min,
      onTap: () async {
        final String todoId = widget.todo.id;
        DataBaseRepo().deleteTodo(todoId);
      },
      icon: Icons.delete_rounded,
      iconColor: kRedColor,
      iconSize: 30,
    );
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodoView(
          todo: widget.todo,
          isEdit: true,
        ),
      ),
    );
  }
}
