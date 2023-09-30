import 'dart:convert';




PayClubWithCCValidationResponse payClubWithCCValidationResponseFromJson(String str) => PayClubWithCCValidationResponse.fromJson(json.decode(str));


String payClubWithCCValidationResponseToJson(PayClubWithCCValidationResponse data) => json.encode(data.toJson());

class PayClubWithCCValidationResponse {
  PayClubWithCCValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory PayClubWithCCValidationResponse.fromJson(Map<String, dynamic> json) => PayClubWithCCValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}