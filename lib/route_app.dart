import 'package:get/get.dart';
import 'package:mobileapp/page/assesment_awal.dart';
import 'package:mobileapp/page/login.dart';
import 'package:mobileapp/page/splash_screen.dart';
import 'package:mobileapp/page/addSheep.dart';
import 'package:mobileapp/page/datadomba.dart';
import 'package:mobileapp/page/detail_assesment.dart';
import 'package:mobileapp/page/detail_domba.dart';
import 'package:mobileapp/page/home.dart';
import 'package:mobileapp/page/menu_nav.dart';
import 'package:mobileapp/page/scanner.dart';
import 'package:mobileapp/page/usg.dart';
import 'package:mobileapp/page/vital_sign.dart';

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
    GetPage(name: '/assesment', page: () => Assesment()),
    GetPage(name: '/detailass', page: () => DetailAssesmentAwal()),
    GetPage(name: '/vital', page: () => VitalSign()),
    GetPage(name: '/usg', page: () => USGPage()),
    //GetPage(name: '/detailvitalsign', page: () => DetailVitalSign()),
    //GetPage(name: '/vitalsign', page: () => VitalSign()),
  ];
}