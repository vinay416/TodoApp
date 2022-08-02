import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/resuable_widgets/loader_widget.dart';

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    Key? key,
    required this.onTap,
    this.label,
    this.icon,
    this.isLoader = false,
    this.iconColor = kProductColor,
    this.iconSize = 20,
    this.buttonAlignment = MainAxisAlignment.end,
    this.axisSize = MainAxisSize.max,
  }) : super(key: key);
  final VoidCallback onTap;
  final String? label;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final bool isLoader;
  final MainAxisAlignment buttonAlignment;
  final MainAxisSize axisSize;

  @override
  Widget build(BuildContext context) {
    return _buildMain(context);
  }

  Widget _buildMain(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: isLoader ? const LoaderWidget() : _buildButton(),
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: buttonAlignment,
      mainAxisSize: axisSize,
      children: [
        if (label != null)
          Text(
            label!,
            style: kBlackAccentTextStyle,
          ),
        if (icon != null)
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
      ],
    );
  }
}
