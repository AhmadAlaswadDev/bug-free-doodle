import 'dart:convert';

import 'package:ammanauto/dummy_data/dummey_services.dart';



GuestLayoutResponse guestLayoutResponseFromJson(String str) => GuestLayoutResponse.fromJson(json.decode(str));

class GuestLayoutResponse {
  GuestLayoutResponse({
    // required this.slider,
    required this.entities,
    required this.services,
    required this.common_questions,
    // this.services,
    // this.subscreption_steps,
    // this.questions,
    required this.success,
  });

  // List<Slider> slider;
  List<Entity> entities;
    List<Service> services;
    List<CommonQuestions> common_questions;
  // List<Product> services;
  // List<Product> recommended_products;
  // List<Slider> subscreption_steps;
  // List<Slider> questions;
  bool success;

  factory GuestLayoutResponse.fromJson(Map<String, dynamic> json) => GuestLayoutResponse(
    entities: List<Entity>.from(json["data"]["entities"].map((x) => Entity.fromJson(x))),
    services: List<Service>.from(json['data']['services'].map((x)=>Service.fromJson(x))),
    common_questions: List<CommonQuestions>.from(json['data']['common_questions'].map((x)=>CommonQuestions.fromJson(x))),
    success: json["status"],
  );

  // Map<String, dynamic> toJson() => {
  //   "data": List<dynamic>.from(categories.map((x) => x.toJson())),
  //   "success": success,
  //   "status": status,
  // };

}


class Slider {
  Slider({
    required this.photo,
  });

  String photo;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
  };
}

class Entity {
  Entity({
    required this.id,
    required this.img,
  });

  int id;
  String img;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json["id"],
    img: json['img']
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "img": img,
  };
}


class Service {
  int id;
  String name;
  String img;

  Service({required this.id, required this.name,required this.img});

    factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    img: json['img'], 
    name: json['name']
  );

    Map<String, dynamic> toJson() => {
    "id":id,
    "img": img,
    "name": name
  };
}



class CommonQuestions {
  CommonQuestions({
    required this.id,
    required this.question,
    required this.answer
  });

  int id;
  String question;
  String answer;

  factory CommonQuestions.fromJson(Map<String, dynamic> json) => CommonQuestions(
    id: json["id"],
    question: json['question'],
    answer: json['answer']
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "question": question,
    "answer": answer,
  };
}

// class Links {
//   Links({
//     this.products,
//     this.subCategories,
//   });

//   String products;
//   String subCategories;

//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//     products: json["products"],
//     subCategories: json["sub_categories"],
//   );

//   Map<String, dynamic> toJson() => {
//     "products": products,
//     "sub_categories": subCategories,
//   };
// }

// class Product {
//   Product({
//     this.id,
//     this.name,
//     this.thumbnail_image,
//     this.main_price,
//     this.stroked_price,
//     this.has_discount,
//     this.discount,
//     this.rating,
//     this.sales,
//     this.links,
//   });

//   int id;
//   String name;
//   String thumbnail_image;
//   String main_price;
//   String stroked_price;
//   bool has_discount;
//   var discount;
//   int rating;
//   int sales;
//   Links links;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     thumbnail_image: json["thumbnail_image"],
//     main_price: json["main_price"],
//     stroked_price: json["stroked_price"],
//     has_discount: json["has_discount"],
//     discount: json["discount"],
//     rating: json["rating"].toInt(),
//     sales: json["sales"],
//     // links: Links.fromJson(json["links"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "thumbnail_image": thumbnail_image,
//     "main_price": main_price,
//     "stroked_price": stroked_price,
//     "has_discount": has_discount,
//     "discount": discount,
//     "rating": rating,
//     "sales": sales,
//     "links": links.toJson(),
//   };
// }

