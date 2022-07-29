import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/auth_model.dart';
import 'package:todo_app/model/todo_data_model.dart';
import 'package:todo_app/model/user_data_model.dart';

const String _usersDB = "Users";

const String _todoDB = "Todos";

class DataBaseRepo {
  DataBaseRepo._privateConstructor();

  static final DataBaseRepo _instance = DataBaseRepo._privateConstructor();

  factory DataBaseRepo() => _instance;

  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  final UserDataModel _userModel = AuthModel().getUser;

  Future<void> createNewUser() async {
    final userId = _userModel.id;

    final CollectionReference userDB = _firestoreDB.collection(_usersDB);

    final userRecord =
        await userDB.doc(userId).get();

    if (userRecord.exists) {
      return;
    }

    final Map<String, dynamic> payload = _userModel.toJson();

    await userDB.doc(userId).set(payload);

    await _createSampleTodo(userId);
  }

  Future<void> _createSampleTodo(String userId) async {
    final String date = _getFormattedDate();

    final CollectionReference todoDb =
        _firestoreDB.collection(_usersDB).doc(userId).collection(_todoDB);

    final String docId = todoDb.doc().id;

    final TodoDataModel sampleTodo = TodoDataModel(
      id: docId,
      title: "Sample Data",
      date: "Hi, there!",
      desc: date,
    );

    final Map<String, dynamic> payload = sampleTodo.toJson();

    await todoDb.doc(docId).set(payload);
  }

  String _getFormattedDate() {
    final String date = DateFormat.yMMMMd().format(DateTime.now());
    return date;
  }
}
