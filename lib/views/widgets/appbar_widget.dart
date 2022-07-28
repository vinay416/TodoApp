import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
import 'package:todo_app/resuable_widgets/icon_button_widget.dart';
import 'package:todo_app/resuable_widgets/loader_widget.dart';
import 'package:todo_app/resuable_widgets/snackbar_widget.dart';

class AppTopBar extends StatefulWidget {
  const AppTopBar({Key? key}) : super(key: key);

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _buildTopBar();
  }

  Widget _buildTopBar() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.w(50),
        vertical: context.h(40),
      ),
      decoration: BoxDecoration(
        color: kProductColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: context.isPortrait ? context.h(180) : context.h(350),
      width: double.infinity,
      child: _buildAppBar(),
    );
  }

  Widget _buildAppBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTodoTitle(),
            _buildTodoCount(),
          ],
        ),
        _buildLogOut(),
      ],
    );
  }

  Widget _buildTodoTitle() {
    return Container(
      margin: context.isPortrait
          ? EdgeInsets.all(context.h(20))
          : EdgeInsets.symmetric(
              horizontal: context.w(50), vertical: context.h(30)),
      child: Text(
        "MyTodo",
        style: kPrimaryTitleTextItlaticStyle,
      ),
    );
  }

  Widget _buildTodoCount() {
    return Container(
      margin: context.isPortrait
          ? EdgeInsets.all(context.h(20))
          : EdgeInsets.symmetric(
              horizontal: context.w(50), vertical: context.h(30)),
      child: Text(
        "20",
        style: kPrimaryTitleTextItlaticStyle,
      ),
    );
  }

  Widget _buildLogOut() {
    return Align(
      alignment: Alignment.centerRight,
      child: isLoading
          ? Padding(
              padding: EdgeInsets.only(right: context.w(20)),
              child: const LoaderWidget(),
            )
          : _buildSignOutButton(),
    );
  }

  Widget _buildSignOutButton() {
    return CustomIconTextButton(
      isLoader: isLoading,
      onTap: () async {
        setState(() => isLoading = true);
        final bool ressponse = await AuthModel().logout();
        if (!ressponse) {
          showSnackBar(
            context,
            "Something went wrong, please try again",
            Respose.fail,
          );
        }
        if (mounted) setState(() => isLoading = false);
      },
      icon: Icons.logout_rounded,
      iconColor: kAccentColor,
      label: "Sign-Out",
    );
  }
}
