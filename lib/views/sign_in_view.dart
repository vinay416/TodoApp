import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/assets_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/base_model.dart' as base;
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/elevated_buttons_widget.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/snackbar_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: context.isPortrait
            ? _buildPortrait(context)
            : _buildLandscape(context),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Column(
      children: [
        _buildBannerImage(context),
        _buildTitleText(),
        SizedBox(height: context.h(20)),
        _buildInstructionsText(),
        SizedBox(height: context.h(150)),
        _buildSignInButton(),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBannerImage(context),
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

  Widget _buildBannerImage(BuildContext context) {
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
    return Consumer3<base.BaseModel, AuthModel, DataBaseRepo>(
      builder: (context, baseModel, auth, dataBaseRepo, child) {
        return CustomElevatedButton(
          icon: kGoogleSvg,
          onTap: () async {
            baseModel.setState(base.State.loading);

            final User? user = await auth.signInWithGoogle();

            if (user == null) {
              showSnackBar(
                context,
                "Something went wrong, please try again",
                Respose.fail,
              );
            } else {
              await dataBaseRepo.createNewUser(user);
            }

            baseModel.setState(base.State.view);
          },
          label: "Sign in",
        );
      },
    );
  }
}
