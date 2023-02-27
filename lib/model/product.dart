// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.products,
    required this.count,
  });

  List<Product> products;
  int count;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "count": count,
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.company,
    required this.colors,
    required this.featured,
    required this.freeShipping,
    required this.inventory,
    required this.averageRating,
    required this.numOfReviews,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.productId,
  });

  String id;
  String name;
  int price;
  String description;
  String image;
  String category;
  String company;
  List<String> colors;
  bool featured;
  bool freeShipping;
  int inventory;
  int averageRating;
  int numOfReviews;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String productId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        image: json["image"],
        category: json["category"],
        company: json["company"],
        colors: List<String>.from(json["colors"].map((x) => x)),
        featured: json["featured"],
        freeShipping: json["freeShipping"],
        inventory: json["inventory"],
        averageRating: json["averageRating"],
        numOfReviews: json["numOfReviews"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        productId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "category": category,
        "company": company,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "featured": featured,
        "freeShipping": freeShipping,
        "inventory": inventory,
        "averageRating": averageRating,
        "numOfReviews": numOfReviews,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": productId,
      };
}
