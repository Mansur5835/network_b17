class User {
  String? id;
  String? name;
  String? phoneNumber;
  String? createdAt;
  String? avatar;
  User(
      {required this.name,
      required this.phoneNumber,
      this.avatar,
      required this.createdAt,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "avatar": avatar,
    };
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'] ?? "+666";
    createdAt = json['createdAt'];
    avatar = json['avatar'];
  }
}
