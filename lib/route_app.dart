import 'package:get/get.dart';
import 'package:mobileapp/auth/login.dart';
import 'package:mobileapp/auth/splash_screen.dart';
import 'package:mobileapp/page/home.dart';
import 'package:mobileapp/page/menu_nav.dart';

class RouteApp {
  static final pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/home', page: () => Home()),          
    GetPage(name: '/menu-nav', page: () => MenuNav()),   
    // GetPage(name: '/scanner', page: () => Scanner()),  
  ];
}
