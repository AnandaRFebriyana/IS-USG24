import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool isObscure;
  final bool readOnly;
  final VoidCallback? toggleObscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.isObscure = false,
    this.readOnly = false,
    this.toggleObscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5), // Spasi antar field
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri untuk label
        children: [
          // Label di luar kotak
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Spasi horizontal untuk label
            child: Text(
              labelText,
              style: GoogleFonts.poppins(
                color: const Color(0xFF697565),
                fontSize: 14,
              ),
            ),
          ),
          // Kotak teks
          TextField(
            controller: controller,
            obscureText: isPassword ? isObscure : false,
            readOnly: readOnly,
            decoration: InputDecoration(
              // Menghilangkan border default
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Menambah sudut
                borderSide: BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2), // Border saat fokus
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10), // Padding di dalam kotak
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: toggleObscureText,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
