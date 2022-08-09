import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.onChange,
    this.onTap,
    this.isReadOnly = false,
    this.hintStyle,
  }) : super(key: key);
  final Function(String?)? onChange;
  final VoidCallback? onTap;
  final String hint;
  final bool isReadOnly;
  final TextStyle? hintStyle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle ?? kBodyTextStyle,
        fillColor: kPrimaryColor,
        filled: true,
      ),
      cursorHeight: 25,
      validator: (value) {
        if (value!.isEmpty && !isReadOnly) {
          return "Field required";
        }

        if (isReadOnly && controller.text.isEmpty) {
          return "Field required";
        }

        return null;
      },
    );
  }
}
