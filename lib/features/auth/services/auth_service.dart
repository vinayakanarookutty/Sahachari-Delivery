// import 'dart:convert';
// import 'package:flutter/material.dart';
// // import 'package:nexamart/common/widgets/bottom_bar.dart';
// // import 'package:nexamart/constants/error_handling.dart';
// // import 'package:nexamart/constants/global_variables.dart';
// // import 'package:nexamart/constants/utils.dart';
// // import 'package:nexamart/features/admin/screens/delivary_screen.dart';
// // import 'package:nexamart/models/user.dart';
// import 'package:http/http.dart' as http;
// import 'package:nexamart_admin/Common/widgets/bottom_bar.dart';
// import 'package:nexamart_admin/constants/error_handling.dart';
// import 'package:nexamart_admin/constants/global_variables.dart';
// import 'package:nexamart_admin/constants/utils.dart';
// import 'package:nexamart_admin/features/admin/screens/delivary_screen.dart';
// import 'package:nexamart_admin/models/user.dart';
// import 'package:nexamart_admin/provider/user_provider.dart';
// // import 'package:nexamart/provider/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthService {
//   void signupUser(
//       {required String name,
//       required String email,
//       required String password,
//         required String address,
//       required BuildContext context}) async {
//     try {
//       User user = User(
//         id: '',
//         name: name,
//         email: email,
//         password: password,
//         address: address,
//         type: '',
//         token: '',
//         cart: [],
//       );
//
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signup'),
//         body: user.toJson(),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () {
//             showSnackbar(
//                 context, 'Account Created Login with the same credentials');
//           });
//     } catch (e) {
//       showSnackbar(
//         context,
//         e.toString(),
//       );
//     }
//   }
//
//   void signinUser(
//       {required String email,
//         required String password,
//         required BuildContext context}) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/api/signin'),
//         body: jsonEncode({'email': email, 'password': password}),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () async {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//             await prefs.setString(
//                 'x-auth-token', jsonDecode(res.body)['token']);
//
//             Navigator.pushNamedAndRemoveUntil(context, AdminScreen.routeName, (route)=> false);
//           });
//     } catch (e) {
//       showSnackbar(
//         context,
//         e.toString(),
//       );
//     }
//   }
//   Future<void> getUserData(BuildContext context) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//
//       if (token == null) {
//         prefs.setString('x-auth-token', '');
//       }
//
//       var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': token!
//           });
//
//       var response = jsonDecode(tokenRes.body);
//       if (response == true) {
//         http.Response userRes = await http.get(Uri.parse('$uri/'),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//               'x-auth-token': token
//             });
//
//         var userProvider = Provider.of<UserProvider>(context, listen: false);
//         userProvider.setUser(userRes.body);
//       }
//     } catch (e) {
//       showSnackbar(
//         context,
//         e.toString(),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';

// import 'package:nexamart/common/widgets/bottom_bar.dart';
// import 'package:nexamart/constants/error_handling.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/constants/utils.dart';
// import 'package:nexamart/features/admin/screens/delivary_screen.dart';
// import 'package:nexamart/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:nexamart_delivary/constants/error_handling.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/constants/utils.dart';

// import 'package:nexamart_delivary/features/admin/screens/delivary_screen.dart';
import 'package:nexamart_delivary/features/delivery/screens/delivary_screen.dart';
import 'package:nexamart_delivary/models/user.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';

// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signupUser(
      {required String name,
      required String email,
      required String password,
      required List<String> servicablePincode,
      required BuildContext context}) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        servicablePincode: servicablePincode,
        token: '',
        // cart: [],
      );
      print('Posting to: ${Uri.parse('$uri/delivery/signup')}');
      print('Request body: ${user.toJson()}');

      http.Response res = await http.post(
        Uri.parse('$uri/delivery/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context, 'Account Created Login with the same credentials');
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  void signinUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/delivery/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var responseBody = jsonDecode(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', responseBody['token']);
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          Navigator.pushNamedAndRemoveUntil(
            context,
            DelivaryScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  // Future<void> getUserData(BuildContext context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');

  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }

  //     var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': token!
  //         });

  //     var response = jsonDecode(tokenRes.body);
  //     if (response == true) {
  //       http.Response userRes = await http.get(Uri.parse('$uri/'),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             'x-auth-token': token
  //           });

  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     showSnackbar(
  //       context,
  //       e.toString(),
  //     );
  //   }
  // }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null || token.isEmpty) {
        prefs.setString('x-auth-token', '');
        return;
      }

      // Validate the token.
      http.Response tokenRes = await http.get(
        Uri.parse('$uri/delivery/token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      if (tokenRes.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(tokenRes.body);
        userData['token'] = token;
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(json.encode(userData));
      }
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }
}
