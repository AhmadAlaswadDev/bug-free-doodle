import 'dart:convert';

OfferDetailResponse OfferDetailResponseFromJson(String str) =>
    OfferDetailResponse.fromJson(json.decode(str));

class OfferDetailResponse {
  OfferDetailResponse({
    required this.amman_card,
    required this.offer_details,
    required this.success,
  });

  AmmanCardItem amman_card;
  OfferDetail offer_details;
  bool success;

  factory OfferDetailResponse.fromJson(Map<String, dynamic> json) =>
      OfferDetailResponse(
        amman_card: AmmanCardItem.fromJson(json['data']['offer']),
        offer_details: OfferDetail.fromJson(json['data']['offer']),
        success: json["status"],
      );
}

class OfferDetail {
  OfferDetail({
    required this.id,
    required this.company,
    required this.qr_code,
    required this.description,
    required this.amman_card,
  });

  String id;
  String company;
  String qr_code;
  String description;
  AmmanCardItem amman_card;

  factory OfferDetail.fromJson(Map<String, dynamic> json) => OfferDetail(
      id: json['id'],
      company: json['company'],
      qr_code: json['qr_code'],
      description: json['description'],
      amman_card: AmmanCardItem(
          amanauto_ms: json['ams'],
          vin: json['vin'],
          ex_date: json['end_date'],
          color: json['color']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company,
        "qr_code": qr_code,
        "description": description,
        "amman_card": amman_card
      };
}

class AmmanCardItem {
  String amanauto_ms;
  String vin;
  String ex_date;
  String color;

  AmmanCardItem({
    required this.amanauto_ms,
    required this.vin,
    required this.ex_date,
    required this.color,
  });

  factory AmmanCardItem.fromJson(Map<String, dynamic> json) => AmmanCardItem(
      amanauto_ms: json['ams'],
      vin: json['vin'],
      ex_date: json['end_date'],
      color: json['color']);

  Map<String, dynamic> toJson() => {
        "amanauto_ms": amanauto_ms,
        "vin": vin,
        "ex_date": ex_date,
        "color": color
      };
}
