import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/components/button.dart';
import 'package:mobileapp/components/widgets.dart';

class SheepForm extends StatefulWidget {
  @override
  _SheepFormState createState() => _SheepFormState();
}

class _SheepFormState extends State<SheepForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaDombaController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  String? _jenisKelamin;
  File? _image;

  Future<void> _pilihTanggalLahir(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: datePickerTheme(),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      tanggalLahirController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Ambil Foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Domba'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Input Nama Domba
              MyTextField(
                controller: namaDombaController,
                labelText: 'Nama Domba',
              ),
              SizedBox(height: 16),

              // Input Tanggal Lahir
              MyDatePicker(
                controller: tanggalLahirController,
                labelText: 'Tanggal Lahir',
                onTap: () => _pilihTanggalLahir(context),
              ),
              SizedBox(height: 16),
              MyDropdown(
                labelText: 'Jenis Kelamin',
                selectedValue: _jenisKelamin,
                items: ['Jantan', 'Betina'],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _jenisKelamin = value;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              Text(
                'Foto Domba',
                style: GoogleFonts.poppins(
                    color: const Color(0xFF697565), fontSize: 14),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _showImageSourceDialog(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt),
                      const SizedBox(width: 10),
                      Text(
                        "Unggah Foto",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (_image != null)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              else
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              MyButton(
                text: 'Simpan',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
