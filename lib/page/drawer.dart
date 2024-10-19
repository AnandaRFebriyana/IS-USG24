import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function(String) onSelect; // Menambahkan parameter untuk fungsi navigasi

  const MyDrawer({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header dengan Foto dan Nama
          UserAccountsDrawerHeader(
            accountName: Text(
              'Nanda',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            accountEmail: null, // Hilangkan email
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/domba.png'), 
            ),
            decoration: BoxDecoration(
              color: Colors.white
              ,
            ),
          ),
          // List item My Profile
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text(
              'My Profile',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              onSelect('profile'); // Panggil fungsi dengan route yang sesuai
            },
          ),
          // List item Settings
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              onSelect('settings'); // Panggil fungsi dengan route yang sesuai
            },
          ),
          // List item Helps
          ListTile(
            leading: Icon(Icons.help, color: Colors.black),
            title: Text(
              'Helps',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              onSelect('help'); // Panggil fungsi dengan route yang sesuai
            },
          ),
          // Tombol Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Aksi logout
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
  void _logout(BuildContext context) {
    // Logika untuk logout (misalnya, menghapus token, kembali ke login screen, dll.)
    Navigator.of(context).pushReplacementNamed('/login'); // Ganti dengan route login yang sesuai
  }
}
