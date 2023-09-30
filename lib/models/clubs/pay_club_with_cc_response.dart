import 'dart:convert';


PayClubWithCCResponse PayClubWithCCResponseFromJson(String str) => PayClubWithCCResponse.fromJson(json.decode(str));

class PayClubWithCCResponse {
  PayClubWithCCResponse({
    required this.redirect_url,
    required this.success,
  });

  // List<Slider> slider;
  String redirect_url;
  bool success;

  factory PayClubWithCCResponse.fromJson(Map<String, dynamic> json) => PayClubWithCCResponse(
    redirect_url: json["redirect"],
    success: json["status"],
  );
}
