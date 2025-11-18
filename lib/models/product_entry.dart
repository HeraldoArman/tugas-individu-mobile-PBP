import 'package:meta/meta.dart';
import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String model;
  final String pk;
  final Fields fields;

  Product({required this.model, required this.pk, required this.fields});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  final int user;
  final String name;
  final double price;
  final String description;
  final String thumbnail;
  final bool flipThumbnail;
  final String category;
  final bool isFeatured;
  final String size;
  final double rating;
  final int stock;
  final int totalSales;
  final String brand;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isMine;

  Fields({
    required this.user,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.flipThumbnail,
    required this.category,
    required this.isFeatured,
    required this.size,
    required this.rating,
    required this.stock,
    required this.totalSales,
    required this.brand,
    required this.createdAt,
    required this.updatedAt,
    required this.isMine,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    thumbnail: json["thumbnail"],
    flipThumbnail: json["flip_thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    size: json["size"],
    rating: json["rating"],
    stock: json["stock"],
    totalSales: json["total_sales"],
    brand: json["brand"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isMine: json["is_mine"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "flip_thumbnail": flipThumbnail,
    "category": category,
    "is_featured": isFeatured,
    "size": size,
    "rating": rating,
    "stock": stock,
    "total_sales": totalSales,
    "brand": brand,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_mine": isMine,
  };
}
