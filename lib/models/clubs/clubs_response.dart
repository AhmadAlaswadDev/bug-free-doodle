import 'dart:convert';


ClubsResponse ClubsResponseFromJson(String str) => ClubsResponse.fromJson(json.decode(str));

class ClubsResponse {
  ClubsResponse({
    // required this.slider,
    required this.clubs,
    required this.success,
  });

  // List<Slider> slider;
  List<Club> clubs;
  bool success;

  factory ClubsResponse.fromJson(Map<String, dynamic> json) => ClubsResponse(
    clubs: List<Club>.from(json["data"]["clubs"].map((x) => Club.fromJson(x))),
    success: json["status"],
  );
}



class Club {
  Club({
    required this.id,
    required this.name,
    required this.duration,
    required this.times,
    required this.price,
    required this.color,
    required this.is_coming_soon,
  });

  String id;
  String name;
  String duration;
  String times;
  int price;
  String color;
  int is_coming_soon;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    name: json['name'],
    duration: json['duration'],
    times: json['times'],
    price: json['price'],
    color: json['color'],
    is_coming_soon: json['is_coming_soon'],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "duration":duration,
    "times":times,
    "price":price,
    "color":color,
    "is_coming_soon":is_coming_soon
  };
}
