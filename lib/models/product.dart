import 'dart:convert';

import 'package:nexamart_delivary/models/rating.dart';

class Product {
  String? id;
  final String name;
  final String description;
  final List<String> images;
  final double quantity;
  String? adminId;
  final double price;
  final String category;
  List<Rating>? rating;

  Product(
      {this.id,
        required this.name,
        required this.description,
        required this.images,
        required this.quantity,
        this.adminId,
        required this.price,
        required this.category,
        this.rating});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'quantity': quantity,
      'adminId': adminId,
      'price': price,
      'category': category,
      'rating': rating?.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: (map['quantity'] as num).toDouble(), // Cast to double
      images: List<String>.from(map['images'] as List<dynamic>),
      category: map['category'] as String,
      price: (map['price'] as num).toDouble(), // Cast to double
      id: map['_id'] != null ? map['_id'] as String : null,
      adminId: map['adminId'] != null ? map['adminId'] as String : null,
      rating: map['ratings'] != null
          ? List<Rating>.from(
        map['ratings']?.map((x) => Rating.fromMap(x)),
      )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  Product copyWith({
    String? name,
    String? description,
    double? quantity,
    List<String>? images,
    String? category,
    double? price,
    String? id,
    String? adminId,
    List<Rating>? rating,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      id: id ?? this.id,
      adminId: adminId ?? this.adminId,
      rating: rating ?? this.rating,
    );
  }
}
