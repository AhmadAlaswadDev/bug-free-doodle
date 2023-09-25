import 'dart:convert';




SignupValidationResponse signupValidationResponseFromJson(String str) => SignupValidationResponse.fromJson(json.decode(str));


String signupValidationResponseToJson(SignupValidationResponse data) => json.encode(data.toJson());

class SignupValidationResponse {
  SignupValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory SignupValidationResponse.fromJson(Map<String, dynamic> json) => SignupValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}