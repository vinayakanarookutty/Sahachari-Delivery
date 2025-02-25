import 'package:flutter/material.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/features/account/widgets/below_app_bar.dart';
import 'package:nexamart_delivary/features/account/widgets/orders.dart';
import 'package:nexamart_delivary/features/account/widgets/top_buttons.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/account/widgets/below_app_bar.dart';
// import 'package:nexamart/features/account/widgets/orders.dart';
// import 'package:nexamart/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.backgroundColor,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: 120,
                  height: 60,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          Container(
            color: GlobalVariables.secondaryColor,
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          const TopButtons(),
          const SizedBox(height: 20),
          const Orders()
        ],
      ),
    );
  }
}
