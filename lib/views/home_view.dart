import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/views/todo_view.dart';
import 'package:todo_app/views/widgets/home_appbar_widget.dart';
import 'package:todo_app/views/widgets/todo_list_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(child: _buildBody()),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildBody() {
    if (context.isPortrait) {
      return _buildComponents();
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: context.h(1000),
        child: _buildComponents(),
      ),
    );
  }

  Widget _buildComponents() {
    return Column(
      children: [
        const HomeAppTopBar(),
        _buildText("Inbox"),
        const TodoListWidget(),
        Row(
          children: [
            _buildText("Completed"),
            _buildNumber(),
          ],
        ),
      ],
    );
  }

  Widget _buildNumber() {
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

  Widget _buildText(String text) {
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

  Widget _buildFloatingButton() {
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
