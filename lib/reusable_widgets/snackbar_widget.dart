import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';

void showSnackBar(
  BuildContext context,
  String text,
  Respose respose,
) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: kResponseTextStyle,
      textAlign: TextAlign.center,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: respose == Respose.fail ? kRedColor : kProductColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

enum Respose {
  success,
  fail,
}
