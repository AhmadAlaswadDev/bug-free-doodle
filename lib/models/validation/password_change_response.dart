import 'dart:convert';




PasswordChangeValidationResponse passwordChangeValidationResponseFromJson(String str) => PasswordChangeValidationResponse.fromJson(json.decode(str));


String passwordChangeValidationResponseToJson(PasswordChangeValidationResponse data) => json.encode(data.toJson());

class PasswordChangeValidationResponse {
  PasswordChangeValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory PasswordChangeValidationResponse.fromJson(Map<String, dynamic> json) => PasswordChangeValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}