import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/reusable_widgets/loader_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.icon,
    this.isLoader = false,
    this.paddingVert = 8,
    this.paddingHoriz = 100,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final String? icon;
  final bool isLoader;
  final double paddingVert;
  final double paddingHoriz;

  @override
  Widget build(BuildContext context) {
    return isLoader ? const LoaderWidget() : _buildButton();
  }

  Widget _buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kAccentColor,
        onPrimary: kPrimaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHoriz,
          vertical: paddingVert,
        ),
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
              height: 35,
              width: 40,
              child: SvgPicture.asset(icon!),
              margin: const EdgeInsets.only(right: 20),
            ),
          Text(
            label,
            style: kResponseTextStyle,
          ),
        ],
      ),
    );
  }
}
