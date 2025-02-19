// import 'dart:convert';
//
// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String password;
//   final String address;
//   final String type;
//   final String token;
//   final List<dynamic> cart;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.address,
//     required this.type,
//     required this.token,
//     required this.cart,
//   });
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'email': email,
//       'password': password,
//       'address': address,
//       'type': type,
//       'token': token,
//       'cart': cart,
//     };
//   }
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['_id'] as String? ?? '',
//       name: map['name'] as String? ?? '',
//       email: map['email'] as String? ?? '',
//       password: map['password'] as String? ?? '',
//       address: map['address'] as String? ?? '',
//       type: map['type'] as String? ?? '',
//       token: map['token'] as String? ?? '',
//       cart: List<Map<String, dynamic>>.from(
//         (map['cart'] as List<dynamic>? ?? []).map(
//               (x) => Map<String, dynamic>.from(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory User.fromJson(String source) =>
//       User.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   User copyWith({
//     String? id,
//     String? name,
//     String? email,
//     String? password,
//     String? address,
//     String? type,
//     String? token,
//     List<dynamic>? cart,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       address: address ?? this.address,
//       type: type ?? this.type,
//       token: token ?? this.token,
//       cart: cart ?? this.cart,
//     );
//   }
// }

import 'dart:convert';

class User {
  final String id;
  final String? name;
  final String? email;
  final String password;
  final List<dynamic>? servicablePincode;
  // final String? logo;
  final String token;
  // final List<dynamic> cart;

  User({
    required this.id,
    this.name,
    this.email,
    required this.password,
    this.servicablePincode,
    // this.logo,
    required this.token,
    // required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'servicablePincode': servicablePincode,
      // 'logo': logo,
      'token': token,
      // 'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      servicablePincode: map['servicablePincode'] != null
          ? List<String>.from(map['servicablePincode'].map((x) => x.toString()))
          : null,
      // logo: map['logo'] as String?,
      token: map['token'] ?? '',
      // cart: List<Map<String, dynamic>>.from(
      //   (map['cart'] as List<dynamic>? ?? []).map(
      //         (x) => Map<String, dynamic>.from(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);


  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<String>? servicablePincode,
    String? logo,
    String? token,
    // List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      servicablePincode: servicablePincode ?? this.servicablePincode,
      // logo: logo ?? this.logo,
      token: token ?? this.token,
      // cart: cart ?? this.cart,
    );
  }
}
