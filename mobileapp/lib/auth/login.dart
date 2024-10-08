import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _usernameNotEntered = false;
  bool _passwordNotEntered = false;
  bool _loginFailed = false; // Untuk mengelola status login gagal

  // Dummy credentials
  final String dummyUsername = 'user123';
  final String dummyPassword = '123456';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white, // Background warna putih
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Row untuk WELCOME BACK text dan gambar domba
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WELCOME',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF697565),
                          ),
                        ),
                        Text(
                          'BACK!',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF697565),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 35), 
                    Image.asset(
                      'assets/domba.png', 
                      width: 160, 
                      height: 160, 
                    ),
                  ],
                ),
                SizedBox(height: 40),
                // Kotak input username
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) {
                        setState(() {
                          _usernameNotEntered = usernameController.text.isEmpty;
                          _loginFailed = false; // Reset error jika ada perubahan
                        });
                      },
                    ),
                    if (_usernameNotEntered)
                      Text(
                        'Please enter your username',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                // Kotak input password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {
                          _passwordNotEntered = passwordController.text.isEmpty;
                          _loginFailed = false; // Reset error jika ada perubahan
                        });
                      },
                    ),
                    if (_passwordNotEntered)
                      Text(
                        'Please enter your password',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                // Pesan error jika login gagal
                if (_loginFailed)
                  Text(
                    'Invalid username or password',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                // Tombol login di tengah
                MyButton(
                  text: "LOGIN",
                  onPressed: () {
                    setState(() {
                      _usernameNotEntered = usernameController.text.isEmpty;
                      _passwordNotEntered = passwordController.text.isEmpty;
                    });

                    // Cek jika username dan password telah diisi
                    if (!_usernameNotEntered && !_passwordNotEntered) {
                      // Validasi dengan data dummy
                      if (usernameController.text == dummyUsername &&
                          passwordController.text == dummyPassword) {
                        // Jika cocok, navigasi ke halaman home
                        Get.toNamed('/menu-nav');
                      } else {
                        // Jika tidak cocok, tampilkan error
                        setState(() {
                          _loginFailed = true;
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
