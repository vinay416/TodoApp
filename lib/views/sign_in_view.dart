import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/svg_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/resuable_widgets/elevated_buttons_widget.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
import 'package:todo_app/resuable_widgets/snackbar_widget.dart';
import 'package:todo_app/utils.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool isLoading = false;

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
      child: SingleChildScrollView(
        child: context.isPortrait ? _buildPortrait() : _buildLandscape(),
      ),
    );
  }

  Widget _buildPortrait() {
    return Column(
      children: [
        _buildBannerImage(),
        _buildTitleText(),
        SizedBox(height: context.h(20)),
        _buildInstructionsText(),
        SizedBox(height: context.h(150)),
        _buildSignInButton(),
      ],
    );
  }

  Widget _buildLandscape() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBannerImage(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: context.h(50)),
            _buildTitleText(),
            SizedBox(height: context.h(20)),
            _buildInstructionsText(),
            SizedBox(height: context.h(250)),
            _buildSignInButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildBannerImage() {
    if (context.isPortrait) {
      return Container(
        height: context.h(500),
        margin: EdgeInsets.symmetric(horizontal: context.w(80)),
        child: SvgPicture.asset(kSigninSvg),
      );
    }

    return Container(
      height: context.h(750),
      width: context.w(500),
      margin: EdgeInsets.symmetric(
        horizontal: context.w(10),
        vertical: context.h(50),
      ),
      child: SvgPicture.asset(kSigninSvg),
    );
  }

  Widget _buildTitleText() {
    return Text(
      "Welcome to Things",
      style: kProductTitleTextItlaticStyle,
    );
  }

  Widget _buildInstructionsText() {
    return Column(
      children: [
        Text(
          "Create your things now.",
          style: kBodyTextStyle,
        ),
        Text(
          "To get started click below to Sign-in.",
          style: kBodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return CustomElevatedButton(
      icon: kGoogleSvg,
      isLoader: isLoading,
      onTap: () async {
        setState(() => isLoading = true);
        final bool ressponse = await AuthModel().signInWithGoogle();
        if (!ressponse) {
          showSnackBar(
            context,
            "Something went wrong, please try again",
            Respose.fail,
          );
        }
        if (mounted) setState(() => isLoading = false);
      },
      label: "Sign in",
    );
  }
}
