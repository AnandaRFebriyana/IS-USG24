import 'package:get/get.dart';
import 'package:mobileapp/page/auth/login.dart';
import 'package:mobileapp/page/auth/splash_screen.dart';
import 'package:mobileapp/page/addSheep.dart';
import 'package:mobileapp/page/datadomba.dart';
import 'package:mobileapp/page/detail_domba.dart';
//import 'package:mobileapp/page/detail_vitalsign.dart';
import 'package:mobileapp/page/home.dart';
import 'package:mobileapp/page/menu_nav.dart';
import 'package:mobileapp/page/scanner.dart';
//import 'package:mobileapp/page/vitalsign.dart';

class RouteApp {
  static final pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/home', page: () => Home()),          
    GetPage(name: '/menu-nav', page: () => MenuNav()),   
    GetPage(name: '/scanner', page: () => Scanner()),
    GetPage(name: '/addsheep', page: () => AddSheepForm()),
    GetPage(name: '/datadomba', page: () => Data()),
    GetPage(name: '/detaildomba', page: () => DetailDomba()),
    //GetPage(name: '/detailvitalsign', page: () => DetailVitalSign()),
    //GetPage(name: '/vitalsign', page: () => VitalSign()),
  ];
}