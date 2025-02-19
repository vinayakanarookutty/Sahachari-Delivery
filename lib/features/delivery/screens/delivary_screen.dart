import 'package:flutter/material.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/account/services/account_services.dart';
// import 'package:nexamart/features/admin/screens/analytics_screen.dart';
// import 'package:nexamart/features/admin/screens/orders_screen.dart';
// import 'package:nexamart/features/admin/screens/post_screen.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
import 'package:nexamart_delivary/features/account/services/account_services.dart';
import 'package:nexamart_delivary/features/delivery/screens/accepted_orders_screen.dart';

import 'orders_screen.dart';
import 'profile_screen.dart';

class DelivaryScreen extends StatefulWidget {
  static const String routeName = '/admin';
  const DelivaryScreen({super.key});

  @override
  State<DelivaryScreen> createState() => _DelivaryScreenState();
}

class _DelivaryScreenState extends State<DelivaryScreen> {
  final AccountServices accountServices = AccountServices();
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const OrdersScreen(),
    const AcceptedOrdersScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Image.asset(
              //     'assets/images/Logo.png',
              //     width: 10,
              //     height: 60,
              //   ),
              // ),
              const Text(
                'Delivery',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // SizedBox(
              //   width: double.infinity,
              // )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.person_outline_rounded),
              ),
              label: ''
          ),
        ],
      ),
    );
  }
}
