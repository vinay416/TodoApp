import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/model/user_data_model.dart';
import 'package:todo_app/utils.dart';

const String _usersCollection = "Users";

const String _todoCollection = "Todos";

class DataBaseRepo {
  DataBaseRepo({required this.authModel});

  final AuthModel authModel;

  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  Future<void> createNewUser(User user) async {
    try {

      final userId = user.uid;

      final CollectionReference users =
          _firestoreDB.collection(_usersCollection);

      final userRecord = await users.doc(userId).get();

      if (userRecord.exists) {
        return;
      }

      final UserDataModel userData = UserDataModel(
        email: user.email!,
        id: user.uid,
        name: user.displayName,
      );

      final Map<String, dynamic> payload = userData.toJson();

      await users.doc(userId).set(payload);

      await createTodo();
    } on Exception catch (e) {
      log("User Create error : $e");
    }
  }

  Future<void> createTodo({TodoDataModel? userTodo}) async {
    try {
      final String date = getFormattedDate(DateTime.now());

      final CollectionReference todos = _getUserTodoCollection;

      final String todoId = todos.doc().id;

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

      await todos.doc(todoId).set(payload);
    } on Exception catch (e) {
      log("Todo Create error : $e");
    }
  }

  Future<void> modifyTodo({
    required TodoDataModel todoModel,
    required String todoId,
  }) async {
    final CollectionReference todoDb = _getUserTodoCollection;

    todoModel.id = todoId;

    final Map<String, dynamic> payload = todoModel.toJson();

    await todoDb.doc(todoId).update(payload);
  }

  Future<void> deleteTodo(String todoId) async {
    final CollectionReference todoDB = _getUserTodoCollection;

    await todoDB.doc(todoId).delete();
  }

  Stream<List<TodoDataModel>> get getUserTodoStream {
    if (authModel.user == null) return const Stream.empty();

    final CollectionReference todoDB = _getUserTodoCollection;

    return todoDB
        .orderBy("date")
        .snapshots()
        .map((event) => _getListTodoModel(event));
  }

  List<TodoDataModel> _getListTodoModel(QuerySnapshot<Object?> event) {
    final todoList = event.docs;
    return todoList.map((e) => _getTodoModel(e)).toList();
  }

  TodoDataModel _getTodoModel(QueryDocumentSnapshot<Object?> todo) {
    final todoJson = todo.data() as Map<String, dynamic>;
    return TodoDataModel.fromJson(todoJson);
  }

  CollectionReference get _getUserTodoCollection {
    final String userId = authModel.user!.uid;

    final CollectionReference todoDb = _firestoreDB
        .collection(_usersCollection)
        .doc(userId)
        .collection(_todoCollection);

    return todoDb;
  }
}
