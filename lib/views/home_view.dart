import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
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
      children: const [
        HomeAppTopBar(),
        TodoListWidget(),
      ],
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
