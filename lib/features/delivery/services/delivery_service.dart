import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:nexamart/constants/error_handling.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/constants/utils.dart';
// import 'package:nexamart/features/admin/models/sales.dart';
// import 'package:nexamart/models/order.dart';
// import 'package:nexamart/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:nexamart_delivary/constants/error_handling.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/constants/utils.dart';
import 'package:nexamart_delivary/features/delivery/models/sales.dart';
import 'package:nexamart_delivary/features/delivery/screens/delivary_screen.dart';
import 'package:nexamart_delivary/models/order.dart';
import 'package:nexamart_delivary/models/product.dart';
import 'package:nexamart_delivary/models/user_data.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';

// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

class DeliveryServices {
  // Future<List<Order>> fetchAllOrders(BuildContext context) async {
  //   final userProvider = Provider.of<UserProvider>(
  //     context,
  //     listen: false,
  //   );
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/delivery/get-orders'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       // 'x-auth-token': userProvider.user.token,
  //     });
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onSuccess: () {
  //           for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //             orderList.add(
  //               Order.fromJson(
  //                 jsonEncode(
  //                   jsonDecode(
  //                     res.body,
  //                   )[i],
  //                 ),
  //               ),
  //             );
  //           }
  //         });
  //   } catch (e) {
  //     showSnackbar(
  //       context,
  //       e.toString(),
  //     );
  //     print(e);
  //   }
  //   return orderList;
  // }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Order> orderList = [];

    try {
      final response = await http.get(
        Uri.parse('$uri/delivery/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final List<dynamic> decodedData = jsonDecode(response.body);
          orderList = decodedData
              .map((data) => Order.fromJson(jsonEncode(data)))
              .toList();

          for (Order order in orderList) {
            print('Order Details:');
            print('ID: ${order.id}');
            print('name: ${order.products[0].name}');
            print('Status: ${order.status}');
            print('--------------------------');
          }
        },
      );
    } catch (e) {
      showSnackbar(context, 'Failed to fetch orders: ${e.toString()}');
    }

    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print('Order status changed to $status for order ID: ${order.id}');
          onSuccess();
        },
      );
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Sales> sales = [];
    int? totalEarning;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales(response['mobileEarnings'], 'Mobiles'),
              Sales(response['essentialEarnings'], 'Essentials'),
              Sales(response['applianceEarnings'], 'Appliances'),
              Sales(response['booksEarnings'], 'Books'),
              Sales(response['fashionEarnings'], 'Fashion'),
            ];
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
      print(e);
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

  Future<UserData?> getUserData(BuildContext context, String userId) async {
    UserData? userData;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/get-user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'userId': userId}),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            final data = jsonDecode(res.body);
            print("Decoded Response Data: $data");
            userData = UserData.fromMap(data);
            print('Response Data: $data');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return userData;
  }

  // Future<UserData?> getUserData(BuildContext context, String userId) async {
  //   UserData? userData;
  //
  //   try {
  //     print("Sending request to: $uri/admin/get-user with userId: $userId");
  //
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/admin/get-user'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode({'userId': userId}),
  //     );
  //
  //     print("Response Status Code: ${res.statusCode}");
  //     print("Response Body: ${res.body}");
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         try {
  //           final data = jsonDecode(res.body);
  //           print("Decoded Response Data: $data");
  //
  //           userData = UserData.fromMap(data);
  //           print("Parsed User Data: ${userData.toString()}");
  //         } catch (decodeError) {
  //           showSnackbar(context, "Invalid response format.");
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackbar(context, e.toString());
  //   }
  //
  //   return userData;
  // }


  Future<bool> acceptOrder(String orderId, BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      final response = await http.post(
        Uri.parse('$uri/delivery/added-orders'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token // Define the content type
        },
        body: json.encode({
          'id': orderId,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to accept order: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<Order>> fetchAddedOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Order> addedOrders = [];

    try {
      final response = await http.get(
        Uri.parse('$uri/delivery/get-added-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      print('Posting to: ${Uri.parse('$uri/delivery/get-added-orders')}');
      print('Response body: ${response.body}');
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            final List<dynamic> decodedList = jsonDecode(response.body);
            final filteredList =
                decodedList.where((item) => item != null).toList();
            addedOrders = filteredList
                .map((data) => Order.fromJson(jsonEncode(data)))
                .toList();
            print('Mapped Orders: $addedOrders');
          });
      print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } catch (e) {
      showSnackbar(context, 'Failed to fetch added orders: ${e.toString()}');
    }
    return addedOrders;
  }

  Future<List<UserData>> getAdminAddresses(
      BuildContext context, List<String> adminIds) async {
    List<UserData> adminAddresses = [];

    try {
      print(
          "Sending request to: $uri/delivery/get-admin with adminId: $adminIds");

      // Send the POST request
      http.Response res = await http.post(
        Uri.parse('$uri/delivery/get-admin'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'adminId': adminIds}),
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      // Handle HTTP errors
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> decodedData = jsonDecode(res.body);
          print('Decoded Data: $decodedData');
          adminAddresses = decodedData
              .map((data) =>
                  UserData.fromMap(data))
              .toList();
          adminAddresses.forEach((admin) {
            print(
                'Parsed Admin - Name: ${admin.name}, Address: ${admin.address}');
          });
        },
      );
    } catch (e) {
      showSnackbar(
        context,
        'Failed to fetch admin addresses: ${e.toString()}',
      );
    }

    return adminAddresses;
  }

  // Future<void> changeOrderStatus(String token, String orderId, int status) async {
  //   final url = Uri.parse('http://54.91.121.37:5000/admin/change-order-status');
  //
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   final body = jsonEncode({
  //     "Id": orderId,
  //     "status": status,
  //   });
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: body,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       print('Order status changed successfully: $responseData');
  //     } else {
  //       print('Failed to change order status. Status code: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //     }
  //   } catch (error) {
  //     print('Error changing order status: $error');
  //   }
  // }
}
