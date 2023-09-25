// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.data,

  });

  bool status;
  Map<String,dynamic> data;


  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data":  data
  };
}

class User {
  User({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    required this.avatar,
    required this.avatar_original,
    required this.phone,
  });

  int id;
  String type;
  String name;
  String email;
  String avatar;
  String avatar_original;
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    email: json["email"],
    avatar: json["avatar"],
    avatar_original: json["avatar_original"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "email": email,
    "avatar": avatar,
    "avatar_original": avatar_original,
    "phone": phone,
  };
}
