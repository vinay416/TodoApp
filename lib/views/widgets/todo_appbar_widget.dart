import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
import 'package:todo_app/resuable_widgets/icon_button_widget.dart';

class TodoAppBar extends StatelessWidget {
  const TodoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTopBar(context);
  }

  Widget _buildTopBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: context.w(20), top: context.h(10)),
          child: CustomIconTextButton(
            axisSize: MainAxisSize.min,
            buttonAlignment: MainAxisAlignment.start,
            icon: Icons.arrow_back_rounded,
            iconColor: kAccentColor,
            iconSize: 40,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Center(
          child: Text(
            "Todo Details",
            style: kProductTitleTextItlaticStyle,
          ),
        )
      ],
    );
  }
}
