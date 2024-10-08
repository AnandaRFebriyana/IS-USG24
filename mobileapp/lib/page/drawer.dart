import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          // Drawer Header dengan Foto dan Nama
          UserAccountsDrawerHeader(
            accountName: Text(
              'Nanda',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            accountEmail: null, // Hilangkan email
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/domba.png'), 
            ),
            decoration: BoxDecoration(
              color: Colors.grey[850],
            ),
          ),
          // List item My Profile
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Navigasi ke halaman Profile
            },
          ),
          // List item Settings
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Navigasi ke halaman Settings
            },
          ),
          // List item Helps
          ListTile(
            leading: Icon(Icons.help, color: Colors.white),
            title: Text(
              'Helps',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // Navigasi ke halaman Helps
            },
          ),
        ],
      ),
    );
  }
}
