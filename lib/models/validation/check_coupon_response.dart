import 'dart:convert';




CheckCouponValidationResponse checkCouponValidationResponseFromJson(String str) => CheckCouponValidationResponse.fromJson(json.decode(str));


String checkCouponValidationResponseToJson(CheckCouponValidationResponse data) => json.encode(data.toJson());

class CheckCouponValidationResponse {
  CheckCouponValidationResponse({
    required this.message,
    required this.errors,
  });


  String message;
  Map<String,dynamic> errors;

  factory CheckCouponValidationResponse.fromJson(Map<String, dynamic> json) => CheckCouponValidationResponse(
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors,
  };
}