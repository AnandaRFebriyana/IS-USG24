import 'package:get/get.dart';
import 'package:mobileapp/page/detail_radiology.dart';
import 'package:mobileapp/page/assessment.dart';
import 'package:mobileapp/page/sheep_form.dart';
import 'package:mobileapp/page/detail_vital_sign.dart';
import 'package:mobileapp/page/login.dart';
import 'package:mobileapp/page/radiology.dart';
import 'package:mobileapp/page/splash_screen.dart';
import 'package:mobileapp/page/sheep.dart';
import 'package:mobileapp/page/detail_assesment.dart';
import 'package:mobileapp/page/sheep_detail.dart';
import 'package:mobileapp/page/home.dart';
import 'package:mobileapp/page/menu_nav.dart';
import 'package:mobileapp/page/scanner.dart';
import 'package:mobileapp/page/vital_sign.dart';
import 'package:mobileapp/page/vital_sign_graph.dart';

class RouteApp {
  static final pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/home', page: () => Home()),

    GetPage(name: '/menu-nav', page: () => MenuNav()),   
    GetPage(name: '/scanner', page: () => Scanner()),
    GetPage(name: '/sheep-form', page: () => SheepForm()),
    GetPage(name: '/sheep', page: () => SheepPage()),
    GetPage(name: '/detail-sheep', page: () => DetailDomba()),

    GetPage(name: '/assesment', page: () => Assesment()),
    GetPage(name: '/detail-ass', page: () => DetailAssesmentAwal()),

    GetPage(name: '/vital', page: () => VitalSign()),
     GetPage(name: '/detail-vitalsign', page: () => DetailVitalSign()),
    GetPage(name: '/grafik-vitalsign', page: () => VitalSignGraph()),

    GetPage(name: '/radiology', page: () => Radiology()),
    GetPage(name: '/detailradiology', page: () => DetailRadiology()),
   
  ];
}