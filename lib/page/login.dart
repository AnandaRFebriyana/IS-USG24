import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import '../components/button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _usernameNotEntered = false;
  bool _passwordNotEntered = false;
  bool _loginFailed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) {
                        setState(() {
                          _usernameNotEntered = email.text.isEmpty;
                          _loginFailed = false; // Reset error jika ada perubahan
                        });
                      },
                    ),
                    if (_usernameNotEntered)
                      Text(
                        'Please enter your email',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                SizedBox(height: 20),
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
                      controller: password,
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
                          _passwordNotEntered = password.text.isEmpty;
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
                MyButton(
                  text: "LOGIN",
                  onPressed: () => AuthController.login(context, email, password),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
