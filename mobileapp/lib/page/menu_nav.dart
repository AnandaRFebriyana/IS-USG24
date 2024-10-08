import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/page/drawer.dart';
import 'home.dart'; 
import 'profile.dart'; 

class MenuNav extends StatefulWidget {
  @override
  _MenuNavState createState() => _MenuNavState();
}

class _MenuNavState extends State<MenuNav> {
  int currentTab = 0;

  final List<Widget> screens = [
    Home(),    // Halaman Home
    Profile(), // Halaman Profile
  ];

  Widget currentScreen = Home(); // Default ke halaman Home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Panggil Drawer yang sudah kamu buat
      drawer: MyDrawer(),

      // Isi body dari halaman saat ini (Home/Profile)
      body: currentScreen,

      // FloatingActionButton di tengah untuk scanner
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Color(0xFF1E3B57),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () => Get.toNamed('scanner'), // Navigasi ke halaman scanner
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
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
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Tab untuk Home
                _buildTabItem(0, Icons.home, 'Home'),
                SizedBox(width: 40), // Spacer untuk tombol scanner di tengah
                // Tab untuk Profile
                _buildTabItem(1, Icons.person, 'Profile'),
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
            color: currentTab == index ? Color(0xFF356899) : Color(0xFF353840),
          ),
          SizedBox(height: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: currentTab == index ? Color(0xFF356899) : Colors.grey,
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
}
