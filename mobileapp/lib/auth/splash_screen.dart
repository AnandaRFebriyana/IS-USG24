import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer untuk mengarahkan ke halaman login setelah 3 detik
    Timer(Duration(seconds: 3), () {
      Get.offNamed('/login'); // Menggunakan rute '/login'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Center(
        child: Image.asset(
          'assets/logogmf.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
