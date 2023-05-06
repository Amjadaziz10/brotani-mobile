import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.data,
  });

  List<UserData> data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserData {
  UserData({
    required this.id,
    required this.username,
    required this.email,
    required this.telephone,
    required this.address,
  });

  int id;
  String username;
  String email;
  String telephone;
  String address;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        telephone: json["telephone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "telephone": telephone,
        "address": address,
      };
}
