// To parse this JSON data, do
//
//     final passwordConfirmResponse = passwordConfirmResponseFromJson(jsonString);

import 'dart:convert';

PasswordVerifyResponse passwordVerifyResponseFromJson(String str) => PasswordVerifyResponse.fromJson(json.decode(str));

String passwordVerifyResponseToJson(PasswordVerifyResponse data) => json.encode(data.toJson());

class PasswordVerifyResponse {
  PasswordVerifyResponse({
    required this.status,
    required this.data,
  });

  bool status;
  Map<String,dynamic> data;

  factory PasswordVerifyResponse.fromJson(Map<String, dynamic> json) => PasswordVerifyResponse(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": data,
  };
}