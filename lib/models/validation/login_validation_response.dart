import 'dart:convert';




LoginValidationResponse loginValidationResponseFromJson(String str) => LoginValidationResponse.fromJson(json.decode(str));


String loginValidationResponseToJson(LoginValidationResponse data) => json.encode(data.toJson());

class LoginValidationResponse {
  LoginValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory LoginValidationResponse.fromJson(Map<String, dynamic> json) => LoginValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}