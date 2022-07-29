class UserDataModel {
  const UserDataModel({
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["id"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "email": email};
  }
}
