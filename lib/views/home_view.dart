import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/views/todo_view.dart';
import 'package:todo_app/views/widgets/home_appbar_widget.dart';
import 'package:todo_app/views/widgets/todo_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: _buildBody(context),
      ),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (context.isPortrait) {
      return _buildComponents(context);
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: context.h(1000),
        child: _buildComponents(context),
      ),
    );
  }

  Widget _buildComponents(BuildContext context) {
    return Column(
      children: [
        const HomeAppTopBar(),
        _buildText("Inbox", context),
        const TodoListWidget(),
        Row(
          children: [
            _buildText("Completed", context),
            _buildNumber(context),
          ],
        ),
      ],
    );
  }

  Widget _buildNumber(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kProductColor,
      ),
      padding: const EdgeInsets.all(5),
      height: context.h(40),
      margin: EdgeInsets.only(left: context.w(20)),
      alignment: Alignment.center,
      child: Text(
        "5",
        style: kResponseTextStyle,
      ),
    );
  }

  Widget _buildText(String text, BuildContext context) {
    return Container(
      height: context.h(60),
      margin: EdgeInsets.only(left: context.w(80)),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: kBodyTextStyle,
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TodoView()),
        );
      },
      child: const Icon(
        Icons.add_rounded,
        size: 50,
      ),
      backgroundColor: kAccentColor,
    );
  }
}
