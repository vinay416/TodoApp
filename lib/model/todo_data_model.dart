import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDataModel {
  TodoDataModel({
    required this.id,
    required this.title,
    required this.date,
    required this.desc,
  });

  String id;
  String title;
  String desc;
  DateTime date;

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
      id: json["id"] as String,
      title: json["title"] as String,
      desc: json["desc"] as String,
      date: (json["date"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      "id": id,
      "title": title,
      "desc": desc,
      "date": date
    };

    return json;
  }
}
