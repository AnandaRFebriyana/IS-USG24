import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool isObscure;
  final VoidCallback? toggleObscureText;
  final TextInputType keyboardType;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.isObscure = false,
    this.toggleObscureText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              labelText,
              style: GoogleFonts.poppins(
                color: const Color(0xFF697565),
                fontSize: 14,
              ),
            ),
          ),
          TextField(
            controller: controller,
            obscureText: isPassword ? isObscure : false,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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

ThemeData datePickerTheme() {
  return ThemeData.light().copyWith(
    primaryColor: const Color(0xFF697565),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF697565),
      secondary: const Color(0xFF697565),
    ),
  );
}

class MyDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final VoidCallback onTap;

  const MyDatePicker({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              labelText,
              style: GoogleFonts.poppins(
                color: const Color(0xFF697565),
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  // hintText: 'Pilih Tanggal Lahir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 241, 241, 241)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 241, 241, 241)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDropdown extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const MyDropdown({
    Key? key,
    required this.labelText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              labelText,
              style: GoogleFonts.poppins(
                color: const Color(0xFF697565),
                fontSize: 14,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 241, 241, 241)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text(
                  "Pilih Jenis Kelamin",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ),
              ...items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ],
            onChanged: onChanged,
            isExpanded: true,
            hint: Text("Pilih Jenis Kelamin"),
          ),
        ],
      ),
    );
  }
}
