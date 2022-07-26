import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    this.onChange,
    this.initialvalue,
    this.maxLines = 1,
    this.onTap,
    this.isReadOnly = false,
    this.hintStyle,
  }) : super(key: key);
  final Function(String?)? onChange;
  final VoidCallback? onTap;
  final String? initialvalue;
  final String hint;
  final int maxLines;
  final bool isReadOnly;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return TextFormField(
      onTap: onTap,
      readOnly: isReadOnly,
      maxLines: maxLines,
      onChanged: onChange,
      initialValue: initialvalue,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle ?? kBodyTextStyle,
        fillColor: kPrimaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      cursorHeight: 25,
      validator: isReadOnly
          ? null
          : (value) {
              if (value!.isEmpty) {
                return "Field required";
              }

              return null;
            },
    );
  }
}
