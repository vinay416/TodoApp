import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/const/assets_const.dart';
import 'package:todo_app/const/text_style_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/loader_widget.dart';
import 'package:todo_app/views/widgets/todo_model_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<TodoDataModel>>(
          stream: DataBaseRepo().getUserTodoStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoading();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildNoData(context);
            }

            final List<TodoDataModel> todoList = snapshot.data!;

            return _buildTodoList(todoList);
          }),
    );
  }

  Widget _buildTodoList(List<TodoDataModel> todoList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: todoList.length,
      itemBuilder: (_, index) {
        return TodoModelWidget(
          todo: todoList[index],
        );
      },
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Loading Things",
          style: kBodyTextStyle,
        ),
        const LoaderWidget(),
      ],
    );
  }

  Widget _buildNoData(BuildContext context) {
    if (context.isPortrait) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: context.h(50)),
        child: Column(
          children: [
            SvgPicture.asset(
              kNoTodoDataSvg,
              height: context.h(500),
            ),
            _buildNoDataText(),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: context.w(50), vertical: context.h(50)),
      child: Row(
        children: [
          SvgPicture.asset(
            kNoTodoDataSvg,
            height: context.h(600),
          ),
          _buildNoDataText(),
        ],
      ),
    );
  }

  Widget _buildNoDataText() {
    return Text(
      "No things found, create a new thing by clicking floating + button.",
      textAlign: TextAlign.center,
      style: kBodyTextStyle,
    );
  }
}
