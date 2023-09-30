import 'dart:convert';

CheckCouponResponse checkCouponResponseFromJson(String str) => CheckCouponResponse.fromJson(json.decode(str));

String checkCouponResponseToJson(CheckCouponResponse data) => json.encode(data.toJson());

class CheckCouponResponse {
  CheckCouponResponse({
    required this.result,
    required this.message,
    required this.data,
  });

  bool result;
  String message;
  Map<String,dynamic> data;

  factory CheckCouponResponse.fromJson(Map<String, dynamic> json) => CheckCouponResponse(
    result: json["status"],
    message: json["message"],
    data: json['data']
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data":data,
    "message": message,
  };
}