import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/model/user_data_model.dart';
import 'package:todo_app/utils.dart';

const String _usersDB = "Users";

const String _todoDB = "Todos";

class DataBaseRepo {
  DataBaseRepo._privateConstructor();

  static final DataBaseRepo _instance = DataBaseRepo._privateConstructor();

  factory DataBaseRepo() => _instance;

  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  final UserDataModel _userModel = AuthModel().getUser;

  Future<void> createNewUser() async {
    try {
      final userId = _userModel.id;

      final CollectionReference userDB = _firestoreDB.collection(_usersDB);

      final userRecord = await userDB.doc(userId).get();

      if (userRecord.exists) {
        return;
      }

      final Map<String, dynamic> payload = _userModel.toJson();

      await userDB.doc(userId).set(payload);

      await createTodo();
    } on Exception catch (e) {
      log("User Create error : $e");
    }
  }

  Future<void> createTodo({TodoDataModel? userTodo}) async {
    try {
      final String date = getFormattedDate(DateTime.now());

      final CollectionReference todoDb = _getUserTodoDB;

      final String todoId = todoDb.doc().id;

      Map<String, dynamic> payload;

      if (userTodo == null) {
        TodoDataModel sampleTodo = TodoDataModel(
          id: todoId,
          title: "Sample Data",
          desc: "Hi, there!",
          date: date,
        );

        payload = sampleTodo.toJson();
      } else {
        userTodo.id = todoId;
        payload = userTodo.toJson();
      }

      await todoDb.doc(todoId).set(payload);
    } on Exception catch (e) {
      log("Todo Create error : $e");
    }
  }

  Future<void> modifyTodo({
    required TodoDataModel todoModel,
    required String todoId,
  }) async {
    final CollectionReference todoDb = _getUserTodoDB;

    todoModel.id = todoId;

    final Map<String, dynamic> payload = todoModel.toJson();

    await todoDb.doc(todoId).update(payload);
  }

  Future<void> deleteTodo(String todoId) async {
    final CollectionReference todoDB = _getUserTodoDB;

    await todoDB.doc(todoId).delete();
  }

  Stream<List<TodoDataModel>> get getUserTodoStream {
    final CollectionReference todoDB = _getUserTodoDB;

    return todoDB.snapshots().map((event) => _getListTodoModel(event));
  }

  List<TodoDataModel> _getListTodoModel(QuerySnapshot<Object?> event) {
    final todoList = event.docs;
    return todoList.map((e) => _getTodoModel(e)).toList();
  }

  TodoDataModel _getTodoModel(QueryDocumentSnapshot<Object?> todo) {
    final todoJson = todo.data() as Map<String, dynamic>;
    return TodoDataModel.fromJson(todoJson);
  }

  CollectionReference get _getUserTodoDB {
    final String userId = _userModel.id;

    final CollectionReference todoDb =
        _firestoreDB.collection(_usersDB).doc(userId).collection(_todoDB);

    return todoDb;
  }
}
