import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/resuable_widgets/loader_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.icon,
    this.isLoader = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final IconData? icon;
  final bool isLoader;

  @override
  Widget build(BuildContext context) {
    return isLoader ? const LoaderWidget() : _buildButton();
  }

  Widget _buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kAccentColor,
        onPrimary: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Container(
              child: Icon(icon),
              margin: const EdgeInsets.only(right: 10),
            ),
          Text(
            label,
            style: kAccentTextStyle,
          ),
        ],
      ),
    );
  }
}
