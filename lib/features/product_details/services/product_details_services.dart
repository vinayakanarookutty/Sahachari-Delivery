// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nexamart_delivary/constants/error_handling.dart';
// import 'package:nexamart_delivary/constants/global_variables.dart';
// import 'package:nexamart_delivary/constants/utils.dart';
// import 'package:nexamart_delivary/models/product.dart';
// import 'package:nexamart_delivary/models/user.dart';
// import 'package:provider/provider.dart';
//
// import '../../../provider/user_provider.dart';
//
// class ProductDetailsServices {
//   void addToCart({
//     required BuildContext context,
//     required Product product,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/add-to-cart'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//         body: jsonEncode({
//           'id': product.id!,
//         }),
//       );
//
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           User user =
//               userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
//           userProvider.setUserFromModel(user);
//
//           showSnackbar(context, 'Product added to Cart Successfully');
//         },
//       );
//     } catch (e) {
//       showSnackbar(
//         context,
//         e.toString(),
//       );
//     }
//   }
//
//   void rateProducts({
//     required BuildContext context,
//     required Product product,
//     required double rating,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/rate-products'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//         body: jsonEncode({
//           'id': product.id!,
//           'rating': rating,
//         }),
//       );
//
//       httpErrorHandle(response: res, context: context, onSuccess: () {});
//     } catch (e) {
//       showSnackbar(
//         context,
//         e.toString(),
//       );
//     }
//   }
// }
