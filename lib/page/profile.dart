import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background photo or placeholder
          Container(
            color: Colors.white, // Placeholder color
            width: double.infinity,
            height: double.infinity,
            // You can replace this with your actual background image
            // child: Image.asset('assets/background.jpg', fit: BoxFit.cover,),
          ),
          // Text 'Profil' positioned at the top-left corner
          Positioned(
            top: 50, // Adjust this value for top margin
            left: 20, // Adjust this value for left margin
            child: Text(
              'Profil', // Your profile text
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Centered profile photo, name, and phone number
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/foto_profile.jpeg'), // Your profile photo
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Adjust the vertical space between photo and text
                Text(
                  'Nanda Febriyana', // Replace with actual name
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 5), // Adjust the vertical space between name and phone number
                Text(
                  '+62 831 1539 1209', // Replace with actual phone number
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 30), // Adjust the vertical space between phone number and buttons
                // Three buttons with icons and text
                buildButton(
                  icon: Icons.account_circle,
                  text: 'Account info',
                  onPressed: () {
                    Get.toNamed('/detailprofile');
                  },
                ),
                SizedBox(height: 10), // Adjust the vertical space between buttons
                buildButton(
                  icon: Icons.lock,
                  text: 'Change password',
                  onPressed: () {
                    // Handle Change password button press
                  },
                ),
                SizedBox(height: 10), // Adjust the vertical space between buttons
                buildButton(
                  icon: Icons.exit_to_app,
                  text: 'Keluar',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text('Apakah anda yakin ingin keluar?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Tidak'),
                              onPressed: () {
                                Navigator.of(context).pop(); //close the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Ya'),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        );
                      }

                    );
                    // Handle Keluar button press
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({required IconData icon, required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[900]),
          SizedBox(width: 20),
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}