import 'dart:convert';



GuestLayoutResponse guestLayoutResponseFromJson(String str) => GuestLayoutResponse.fromJson(json.decode(str));

class GuestLayoutResponse {
  GuestLayoutResponse({
    required this.slider,
    required this.entities,
    // this.services,
    // this.subscreption_steps,
    // this.questions,
    required this.success,
  });

  List<Slider> slider;
  List<Entity> entities;
  // List<Product> services;
  // List<Product> recommended_products;
  // List<Slider> subscreption_steps;
  // List<Slider> questions;
  bool success;

  factory GuestLayoutResponse.fromJson(Map<String, dynamic> json) => GuestLayoutResponse(
    slider: List<Slider>.from(json["data"]["slider"]['data'].map((x) => Slider.fromJson(x))),
    entities: List<Entity>.from(json["data"]["entities"].map((x) => Entity.fromJson(x))),
    // newest_products: List<Product>.from(json["data"]["newest_products"].map((x) => Product.fromJson(x))),
    // recommended_products: List<Product>.from(json["data"]["recommended_products"].map((x) => Product.fromJson(x))),
    // home_banner_2: List<Slider>.from(json["data"]["home_banner_2"]['data'].map((x) => Slider.fromJson(x))),
    // home_banner_3: List<Slider>.from(json["data"]["home_banner_3"]['data'].map((x) => Slider.fromJson(x))),
    // home_youtube_link: json['data']['home_youtube_link'],
    success: json["success"],
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
    required this.photo,
  });

  int id;
  String photo;

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json["id"],
    photo: json['photo']
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
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

