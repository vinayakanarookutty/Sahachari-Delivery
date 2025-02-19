// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nexamart_delivary/constants/global_variables.dart';
// import 'package:nexamart_delivary/features/admin/screens/delivary_screen.dart';
import 'package:nexamart_delivary/features/auth/screens/auth_screen.dart';
import 'package:nexamart_delivary/features/delivery/screens/delivary_screen.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../features/auth/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/home';
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      authService.getUserData(context).then((_) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (userProvider.user.token.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed(DelivaryScreen.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.secondaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/images/newLogo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
