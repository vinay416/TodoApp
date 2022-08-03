import 'package:flutter/material.dart';
import 'package:todo_app/const/color_const.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/resuable_widgets/elevated_buttons_widget.dart';
import 'package:todo_app/resuable_widgets/extension_widget.dart';
import 'package:todo_app/resuable_widgets/textfield_widget.dart';
import 'package:todo_app/utils.dart';

class TodoFormWidget extends StatefulWidget {
  const TodoFormWidget({Key? key, required this.todo}) : super(key: key);

  final TodoDataModel? todo;

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  String title = "";
  String desc = "";
  String date = "";

  @override
  void initState() {
    final todo = widget.todo;
    if (todo != null) {
      title = todo.title;
      desc = todo.desc;
      date = todo.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return Column(
      children: [
        _buildCard(),
        SizedBox(height: context.h(50)),
        _buildButton(),
        if (!context.isPortrait) SizedBox(height: context.h(80)),
      ],
    );
  }

  Widget _buildCard() {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(
        horizontal: context.w(40),
        vertical: context.h(50),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: kProductColor,
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.w(40),
        vertical: context.h(50),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTitleField(),
            SizedBox(height: context.h(40)),
            _buildDescField(),
            SizedBox(height: context.h(40)),
            _buildDateField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return CustomTextField(
      onChange: (value) {
        if (value != null) {
          setState(() => title = value);
        }
      },
      initialvalue: title,
      hint: "Title",
    );
  }

  Widget _buildDescField() {
    return CustomTextField(
      maxLines: 5,
      onChange: (value) {
        if (value != null) {
          setState(() => desc = value);
        }
      },
      initialvalue: desc,
      hint: "Description",
    );
  }

  Widget _buildDateField() {
    return CustomTextField(
      onChange: (value) {},
      onTap: () async {
        final String? pickDate = await _pickDate();
        if (pickDate != null) {
          setState(() => date = pickDate);
        }
      },
      isReadOnly: true,
      hint: date.isNotEmpty ? date : "Date",
      hintStyle: date.isNotEmpty ? const TextStyle(color: Colors.black) : null,
    );
  }

  Future<String?> _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (date != null) {
      return getFormattedDate(date);
    }

    return null;
  }

  Widget _buildButton() {
    return CustomElevatedButton(
      isLoader: isLoading,
      onTap: _onSubmit,
      label: "Submit",
    );
  }

  void _onSubmit() async {
    setState(() => isLoading = true);

    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() => isLoading = false);
      return;
    }

    TodoDataModel todo = TodoDataModel(
      id: "",
      title: title,
      date: date,
      desc: desc,
    );

    if (widget.todo == null) {
      await DataBaseRepo().createTodo(userTodo: todo);
    } else {
      final todoId = widget.todo!.id;
      await DataBaseRepo().modifyTodo(todoId: todoId, todoModel: todo);
    }

    setState(() => isLoading = false);

    Navigator.pop(context);
  }
}
