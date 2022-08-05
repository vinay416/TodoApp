import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/icon_button_widget.dart';
import 'package:todo_app/reusable_widgets/todo_icon_widget.dart';
import 'package:todo_app/views/widgets/todo_form_widget.dart';

class TodoView extends StatelessWidget {
  const TodoView({
    Key? key,
    this.todo,
    this.isEdit = false,
  }) : super(key: key);
  final TodoDataModel? todo;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: isEdit ? todo!.id : "",
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(context),
          SizedBox(height: context.h(50)),
          _buildThingIcon(),
          SizedBox(height: context.h(50)),
          TodoFormWidget(todo: todo),
        ],
      ),
    );
  }

  Widget _buildThingIcon() {
    return const Center(
      child: TodoIcon(),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBackButton(context),
        _buildTitle(),
        _buildIcon(),
      ],
    );
  }

  Widget _buildIcon() {
    return const Icon(
      Icons.subject_outlined,
      color: kProductColor,
      size: 30,
    );
  }

  Widget _buildTitle() {
    return Text(
      "Add New Thing",
      style: kPrimaryTitleTextItlaticStyle,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.h(10)),
      child: CustomIconTextButton(
        axisSize: MainAxisSize.min,
        buttonAlignment: MainAxisAlignment.start,
        icon: Icons.arrow_back_rounded,
        iconColor: kAccentColor,
        iconSize: 40,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
