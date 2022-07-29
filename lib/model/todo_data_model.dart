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
  String date;

  factory TodoDataModel.fromJson(Map<String, dynamic> json) {
    return TodoDataModel(
      id: json["id"] as String,
      title: json["title"] as String,
      date: json["date"] as String,
      desc: json["desc"] as String,
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

  Map<String, dynamic> updateTitle() {
    final Map<String, dynamic> json = {"title": title};
    return json;
  }

  Map<String, dynamic> updateDesc() {
    final Map<String, dynamic> json = {"desc": desc};
    return json;
  }

  Map<String, dynamic> updateDate() {
    final Map<String, dynamic> json = {"date": date};
    return json;
  }
}
