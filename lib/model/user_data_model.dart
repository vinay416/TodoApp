class UserDataModel {
  const UserDataModel({
    required this.id,
    required this.email,
    required this.name,
  });

  final String id;
  final String email;
  final String? name;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["id"],
      email: json["email"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
    };
  }
}
