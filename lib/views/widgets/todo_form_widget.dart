import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/base_model.dart' as base;
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/repository/database_repo.dart';
import 'package:todo_app/reusable_widgets/elevated_buttons_widget.dart';
import 'package:todo_app/reusable_widgets/extension_widget.dart';
import 'package:todo_app/reusable_widgets/textfield_widget.dart';
import 'package:todo_app/utils.dart';

class TodoFormWidget extends StatefulWidget {
  const TodoFormWidget({Key? key, required this.todo}) : super(key: key);

  final TodoDataModel? todo;

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    final todo = widget.todo;
    if (todo != null) {
      _titleController.text = todo.title;
      _descController.text = todo.desc;
      _dateController.text = todo.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildForm(),
          SizedBox(height: context.h(50)),
          _buildButton(),
          if (!context.isPortrait) SizedBox(height: context.h(80)),
        ],
      ),
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
      controller: _titleController,
      hint: "Title",
    );
  }

  Widget _buildDescField() {
    return CustomTextField(
      controller: _descController,
      hint: "Description",
    );
  }

  Widget _buildDateField() {
    return CustomTextField(
      controller: _dateController,
      onChange: (value) {},
      onTap: () async {
        final String? pickDate = await _pickDate();
        if (pickDate != null) {
          _dateController.text = pickDate;
        }
      },
      isReadOnly: true,
      hint: "Date",
      hintStyle: _dateController.text.isNotEmpty
          ? const TextStyle(color: Colors.black)
          : null,
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
    return Consumer2<base.BaseModel, DataBaseRepo>(
      builder: (context, baseModel, dataBaseRepo, child) {
        return CustomElevatedButton(
          paddingVert: 12,
          paddingHoriz: 100,
          onTap: () => _onSubmit(baseModel, dataBaseRepo),
          label: "Add Your Thing",
        );
      },
    );
  }

  void _onSubmit(base.BaseModel baseModel, DataBaseRepo dataBaseRepo) async {
    baseModel.setState(base.State.loading);

    if (!(_formKey.currentState?.validate() ?? false)) {
      baseModel.setState(base.State.view);
      return;
    }

    TodoDataModel todo = TodoDataModel(
      id: "",
      title: _titleController.text,
      desc: _descController.text,
      date: _dateController.text,
    );

    if (widget.todo == null) {
      await dataBaseRepo.createTodo(userTodo: todo);
    } else {
      final todoId = widget.todo!.id;
      await dataBaseRepo.modifyTodo(todoId: todoId, todoModel: todo);
    }

    baseModel.setState(base.State.view);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
