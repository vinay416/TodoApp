import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/svg_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/resuable_widgets/buttons_widget.dart';
import 'package:todo_app/status_bar.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  void initState() {
    setStatusBarIconColor(iconColor: Brightness.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  child: SvgPicture.asset(
                    kSigninSvg,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("Welcome to MyTodo", style: kTitleTextItlaticStyle),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create your Todo's now.\n To get started please Sign-in.",
                    style: kBodyTextStyle,
                  ),
                ),
              ),
            ],
          ),
          CustomElevatedButton(
            onTap: () {},
            label: "Sign in",
          ),
        ],
      ),
    );
  }
}
