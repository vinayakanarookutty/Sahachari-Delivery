import 'package:flutter/material.dart';
import 'package:nexamart_delivary/provider/order_provider.dart';
import 'package:nexamart_delivary/provider/user_provider.dart';
import 'package:nexamart_delivary/router.dart';
import 'package:provider/provider.dart';

import 'Common/widgets/splash_screen.dart';
import 'constants/global_variables.dart';
import 'features/auth/services/auth_service.dart';
// import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => OrderProvider(),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
        const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
