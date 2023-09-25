import 'dart:convert';




ForgotPasswordValidationResponse forgotPasswordValidationResponseFromJson(String str) => ForgotPasswordValidationResponse.fromJson(json.decode(str));


String forgotPasswordValidationResponseToJson(ForgotPasswordValidationResponse data) => json.encode(data.toJson());

class ForgotPasswordValidationResponse {
  ForgotPasswordValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory ForgotPasswordValidationResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}