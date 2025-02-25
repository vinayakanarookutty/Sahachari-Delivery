// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:nexamart/models/product.dart';
import 'package:nexamart_delivary/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  int status;
  final double totalPrice;

  Order(
      {required this.id,
      required this.products,
      required this.quantity,
      required this.address,
      required this.userId,
      required this.orderedAt,
      required this.status,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      products: List<Product>.from((map['products'] as List<dynamic>?)
              ?.map<Product>((x) =>
                  Product.fromMap(x['product'] as Map<String, dynamic>)) ??
          []),
      quantity: List<int>.from((map['quantity'] as List<dynamic>?)
              ?.map<int>((x) => x['quantity'] as int) ??
          []),
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as int,
      status: map['status'] as int,
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
