import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/components/button.dart';
import 'package:mobileapp/components/widgets.dart';
import 'package:mobileapp/controllers/sheep_controller.dart';
import 'package:mobileapp/models/sheep_models.dart';

class SheepForm extends StatefulWidget {
  @override
  _SheepFormState createState() => _SheepFormState();
}

class _SheepFormState extends State<SheepForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController sheepName = TextEditingController();
  final TextEditingController sheepBirth = TextEditingController();
  String? _sheepGender;
  File? _sheepPhoto;

  Future<void> _saveSheep() async {
  DateTime sheepBirthDate = DateFormat('dd/MM/yyyy').parse(sheepBirth.text);
  if (_formKey.currentState!.validate()) {
    Sheep sheep = Sheep(
      id: '',
      sheepName: sheepName.text,
      sheepBirth: sheepBirthDate,
      sheepGender: _sheepGender!,
      sheepPhoto: _sheepPhoto,
    );
    await SheepController.createSheep(context, sheep);
  }
}

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
      sheepBirth.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _sheepPhoto = File(pickedFile.path);
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
        title: Text(
          'Tambah Data Domba',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              MyTextField(
                controller: sheepName,
                labelText: 'Nama Domba',
              ),
              SizedBox(height: 16),
              MyDatePicker(
                controller: sheepBirth,
                labelText: 'Tanggal Lahir',
                onTap: () => _pilihTanggalLahir(context),
              ),
              SizedBox(height: 16),
              MyDropdown(
                labelText: 'Jenis Kelamin',
                selectedValue: _sheepGender,
                items: ['Jantan', 'Betina'],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _sheepGender = value;
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
              if (_sheepPhoto != null)
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.file(
                    _sheepPhoto!,
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
                onPressed: _saveSheep
              ),
            ],
          ),
        ),
      ),
    );
  }
}
