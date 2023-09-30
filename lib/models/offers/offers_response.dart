import 'dart:convert';


OffersResponse OffersResponseFromJson(String str) => OffersResponse.fromJson(json.decode(str));


class OffersResponse {

  OffersResponse({
    // required this.slider,
    required this.offers,
    required this.success,
  });

  // List<Slider> slider;
  List<Offer> offers;
  bool success;

  factory OffersResponse.fromJson(Map<String, dynamic> json) => OffersResponse(
    offers: List<Offer>.from(json["data"]["offers"].map((x) => Offer.fromJson(x))),
    success: json["status"],
  );



}



class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.discount,
    required this.company,
    required this.end_date,
    required this.download_url,
  });

  String id;
  String name;
  String discount;
  String company;
  String end_date;
  String download_url;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    name: json['name'],
    discount: json['discount'],
    company: json['company'],
    end_date: json['end_date'],
    download_url: json['download_url'],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "duration":discount,
    "times":company,
    "price":end_date,
    "color":download_url,
  };
}