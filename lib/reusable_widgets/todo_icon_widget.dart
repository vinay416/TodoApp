import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';

class TodoIcon extends StatelessWidget {
  const TodoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kProductColor, width: 2),
      ),
      padding: const EdgeInsets.all(8),
      child: const Icon(
        Icons.assignment,
        color: kProductColor,
        size: 35,
      ),
    );
  }
}
