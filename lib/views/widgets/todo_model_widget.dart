import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
import 'package:todo_app/resuable_widgets/icon_button_widget.dart';

class TodoModelWidget extends StatefulWidget {
  const TodoModelWidget({Key? key}) : super(key: key);

  @override
  State<TodoModelWidget> createState() => _TodoModelWidgetState();
}

class _TodoModelWidgetState extends State<TodoModelWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildTodoCard();
  }

  Widget _buildTodoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w(50)),
      child: Card(
        child: _buildList(),
        shadowColor: kProductColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        context.w(50),
        context.h(10),
        context.w(20),
        context.h(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildData(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Topic",
          style: kTodoProductTitleTextStyle,
        ),
        Text(
          "Desc",
          style: kBodyTextStyle,
        ),
        Text(
          "Date",
          style: kBodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        CustomIconTextButton(
          onTap: () {},
          icon: Icons.edit,
          iconColor: kAccentColor,
          iconSize: 30,
        ),
        SizedBox(
          width: context.w(20),
        ),
        CustomIconTextButton(
          onTap: () {},
          icon: Icons.delete_rounded,
          iconColor: kRedColor,
          iconSize: 30,
        )
      ],
    );
  }
}
