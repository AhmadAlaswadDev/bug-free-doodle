import 'dart:convert';
import 'package:ammanauto/models/clubs/clubs_response.dart';
import 'package:ammanauto/models/guest_layout_response.dart';

ClubDetailResponse ClubDetailResponseFromJson(String str) =>
    ClubDetailResponse.fromJson(json.decode(str));

class ClubDetailResponse {
  ClubDetailResponse({
    required this.club,
    required this.club_details,
    required this.success,
  });

  Club club;
  ClubDetail club_details;
  bool success;

  factory ClubDetailResponse.fromJson(Map<String, dynamic> json) =>
      ClubDetailResponse(
        club: Club.fromJson(json["data"]["club"]),
        club_details: ClubDetail.fromJson(json['data']['club']),
        success: json["status"],
      );
}

class ClubDetail {
  ClubDetail({
    required this.id,
    required this.name,
    required this.duration,
    required this.times,
    required this.price,
    required this.prev_price,
    required this.discount,
    required this.vat_text,
    required this.total_price_with_vat,
    required this.color,
    required this.description,
    required this.subscribe_text,
    required this.services,
  });

  String id;
  String name;
  String duration;
  String times;
  int price;
  int prev_price;
  String discount;
  String vat_text;
  String total_price_with_vat;
  String color;
  String description;
  String subscribe_text;
  List<Service> services;


  factory ClubDetail.fromJson(Map<String, dynamic> json) => ClubDetail(
        id: json['id'],
        name: json['name'],
        duration: json['duration'],
        times: json['times'],
        price: json['price'],
        color: json['color'],
        prev_price: json['prev_price'],
        discount: json['discount'],
        vat_text: json['vat_text'],
        total_price_with_vat: json['total_price_with_vat'],
        description: json['description'],
        subscribe_text: json['subscribe_text'],
        services:List<Service>.from(json['services'].map((x) => Service.fromJson(x)))
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "duration": duration,
        "times": times,
        "price": price,
        "prev_price": prev_price,
        "discount": discount,
        "vat_text": vat_text,
        "total_price_with_vat": total_price_with_vat,
        "color": color,
        "description": description,
        "subscribe_text": subscribe_text,
        "services":services
      };
}
