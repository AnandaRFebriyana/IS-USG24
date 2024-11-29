import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/page/assessment.dart';
import 'package:mobileapp/page/drawer.dart';
import 'package:mobileapp/page/radiology.dart';
import 'package:mobileapp/page/vital_sign.dart';
import 'home.dart'; 
import 'profile.dart'; 

class MenuNav extends StatefulWidget {
  @override
  _MenuNavState createState() => _MenuNavState();
}

class _MenuNavState extends State<MenuNav> {
  int currentTab = 0;

  final List<Widget> screens = [
    Home(),
    Assesment(),
    VitalSign(),
    Radiology()
  ];

  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(onSelect: _selectDrawerItem), // Panggil Drawer dengan fungsi onSelect

      body: currentScreen,

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Color(0xFF697565),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        onPressed: () => Get.toNamed('scanner'), // Navigasi ke halaman scanner
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTabItem(0, Icons.home, 'Home'),
                SizedBox(width: 3),
                _buildTabItem(1, Icons.assessment, 'Assesment'),
                SizedBox(width: 90),
                _buildTabItem(2, Icons.health_and_safety, 'Vital Sign'),
                SizedBox(width: 30),
                _buildTabItem(3, Icons.monitor_heart, 'Radiologi'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun item navigasi di Bottom Navigation Bar
  Widget _buildTabItem(int index, IconData icon, String text) {
    return GestureDetector(
      onTap: () => _updateTab(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: currentTab == index ? Color(0xFF323A23) : Color(0xFF697565),
          ),
          SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: currentTab == index ? Color(0xFF40563A) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk update tampilan saat tab ditekan
  void _updateTab(int index) {
    setState(() {
      currentScreen = screens[index]; // Update halaman yang ditampilkan
      currentTab = index;             // Update tab yang aktif
    });
  }

  // Fungsi untuk menanggapi pilihan di Drawer
  void _selectDrawerItem(String route) {
    Navigator.of(context).pop(); // Tutup Drawer
    if (route == 'profile') {
      setState(() {
        currentScreen = Profile();
        currentTab = 1;          
      });
    } else if (route == 'settings') {
    } else if (route == 'help') {
    }
  }
}
