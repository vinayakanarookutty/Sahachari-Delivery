import 'package:flutter/material.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        color: GlobalVariables.backgroundColor,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(fontSize: 22, color: Colors.black),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
