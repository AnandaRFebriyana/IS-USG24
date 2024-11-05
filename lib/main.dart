import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/page/auth/splash_screen.dart';
import 'package:mobileapp/route_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IS-USG',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(), // Set SplashScreen sebagai layar awal
      defaultTransition: Transition.rightToLeft,
      getPages: RouteApp.pages, // Daftar rute Get
    );
  }
}
