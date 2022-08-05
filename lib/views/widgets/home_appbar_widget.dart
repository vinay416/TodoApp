import 'package:flutter/material.dart';
import 'package:todo_app/const/assets_const.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/model/user_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/icon_button_widget.dart';
import 'package:todo_app/reusable_widgets/loader_widget.dart';
import 'package:todo_app/reusable_widgets/snackbar_widget.dart';
import 'package:todo_app/utils.dart';

class HomeAppTopBar extends StatefulWidget {
  const HomeAppTopBar({Key? key}) : super(key: key);

  @override
  State<HomeAppTopBar> createState() => _HomeAppTopBarState();
}

class _HomeAppTopBarState extends State<HomeAppTopBar> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return Stack(
      children: [
        _buildBackGround(),
        _buildForeGround(),
      ],
    );
  }

  Widget _buildBackGround() {
    return SizedBox(
      height: context.isPortrait ? context.h(250) : context.h(450),
      width: double.maxFinite,
      child: Image.asset(
        kBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildForeGround() {
    return SizedBox(
      height: context.isPortrait ? context.h(250) : context.h(450),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildLeftSide(), _buildRightSide()],
      ),
    );
  }

  Widget _buildLeftSide() {
    return Container(
      margin: context.isPortrait
          ? EdgeInsets.only(top: context.h(20))
          : EdgeInsets.zero,
      height: context.isPortrait ? context.h(250) : context.h(450),
      width: context.w(600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: context.w(80)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopIcon(),
                  _buildTodoTitle(),
                  _buildDate(),
                ],
              ),
            ),
          ),
          Container(
            color: kProductColor,
            height: 5,
            width: double.maxFinite,
          )
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return Container(
      height: context.isPortrait ? context.h(250) : context.h(450),
      width: context.w(400),
      color: Colors.black26,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildLogOut(),
          _buildTodoCount(),
          if (context.isPortrait) SizedBox(height: context.h(10)),
          _buildPercentage(),
          if (context.isPortrait) SizedBox(height: context.h(10))
        ],
      ),
    );
  }

  Widget _buildTodoTitle() {
    return Text(
      "Your\nThings",
      style: kPrimaryAccentTextStyle,
    );
  }

  Widget _buildTodoCount() {
    return Row(
      children: [
        _buildPersonalCount(),
        _buildBusinessCount(),
      ],
    );
  }

  Widget _buildPersonalCount() {
    return Container(
      margin: context.isPortrait
          ? EdgeInsets.all(context.h(20))
          : EdgeInsets.symmetric(
              horizontal: context.w(50), vertical: context.h(20)),
      child: StreamBuilder<List<TodoDataModel>>(
        stream: DataBaseRepo().getUserTodoStream,
        builder: (context, snapshot) {
          int? todoLength = snapshot.data?.length;

          todoLength ??= 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                todoLength.toString(),
                style: kPrimaryAccentTextStyle,
              ),
              Text(
                "Personal",
                style: kSmallestTextStyle,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBusinessCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "5",
          style: kPrimaryAccentTextStyle,
        ),
        Text(
          "Business",
          style: kSmallestTextStyle,
        ),
      ],
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
    final UserDataModel user = AuthModel().getUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: context.w(20)),
          child: Text(
            user.name ?? user.email,
            maxLines: 1,
            style: kResponseTextStyle,
          ),
        ),
        CustomIconTextButton(
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
          label: "Sign out",
        ),
      ],
    );
  }

  Widget _buildTopIcon() {
    return const Icon(
      Icons.format_align_left_rounded,
      color: kPrimaryColor,
      size: 30,
    );
  }

  Widget _buildDate() {
    return Text(
      getFormattedDate(DateTime.now()),
      style: kResponseTextStyle,
    );
  }

  Widget _buildPercentage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.data_saver_off_rounded,
          color: kPrimaryColor,
        ),
        SizedBox(width: context.w(20)),
        Text(
          "15% Done",
          style: kSmallestTextStyle,
        ),
      ],
    );
  }
}
