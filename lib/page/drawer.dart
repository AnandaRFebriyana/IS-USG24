import 'package:flutter/material.dart';
import 'package:mobileapp/services/auth_service.dart';
import 'package:mobileapp/models/user_models.dart';

class MyDrawer extends StatelessWidget {
  final Function(String) onSelect; // Menambahkan parameter untuk fungsi navigasi

  const MyDrawer({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 149, 181, 139),
      child: Column(
        children: [
          // Drawer Header dengan Foto dan Nama
          FutureBuilder<User>(
            future: AuthService.getUser(), // Memanggil fungsi getUser() untuk mendapatkan data user
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return UserAccountsDrawerHeader(
                  accountName: Text('Loading...'),
                  accountEmail: null, // Hilangkan email
                  currentAccountPicture: Image.asset('assets/logogmf.png', width: 50, height: 50), // Ganti dengan logo GMF
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasError) {
                return UserAccountsDrawerHeader(
                  accountName: Text('Error loading user data'),
                  accountEmail: null, // Hilangkan email
                  currentAccountPicture: Image.asset('assets/logogmf.png', width: 50, height: 50), // Ganti dengan logo GMF
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasData) {
                User user = snapshot.data!;
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name ?? 'No Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  accountEmail: Text(  // Menambahkan email pengguna
                    user.email ?? 'No Email',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  currentAccountPicture: Image.asset('assets/logogmf.png', width: 50, height: 50), // Ganti dengan logo GMF
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  accountName: Text('No user data available'),
                  accountEmail: null,
                  currentAccountPicture: Image.asset('assets/logogmf.png', width: 50, height: 50), // Ganti dengan logo GMF
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              }
            },
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

  void _logout(BuildContext context) async {
    try {
      await AuthService.logout(); // Panggil fungsi logout
      Navigator.of(context).pushReplacementNamed('/login'); // Kembali ke halaman login
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout, try again later.')),
      );
    }
  }
}
