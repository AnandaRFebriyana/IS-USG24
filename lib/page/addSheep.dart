import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/sheep_controller.dart';
import 'package:mobileapp/components/button.dart';

import '../components/textfield_auth.dart'; // Pastikan untuk mengimpor MyTextField

class AddSheepForm extends StatefulWidget {
  @override
  _AddSheepFormState createState() => _AddSheepFormState();
}

class _AddSheepFormState extends State<AddSheepForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idDombaController = TextEditingController();
  final TextEditingController namaDombaController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController jenisDombaController = TextEditingController();

  final SheepController sheepController = Get.find<SheepController>();

  // Fungsi untuk membuat ID Domba otomatis
  String generateSheepId() {
    // Menggunakan timestamp sebagai ID domba yang unik
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  void initState() {
    super.initState();
    // Mengisi ID Domba otomatis saat form dibuka
    idDombaController.text = generateSheepId();
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
              // Gambar di bagian atas tengah
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/domba.png', // Ganti dengan path gambar domba Anda
                    height: 100, // Ukuran gambar
                    width: 100,
                  ),
                ),
              ),
              // Input ID Domba
              MyTextField(
                controller: idDombaController,
                labelText: 'ID Domba',
                isPassword: false,
                isObscure: false,
              ),
              SizedBox(height: 16),
              // Input Nama Domba
              MyTextField(
                controller: namaDombaController,
                labelText: 'Nama Domba',
                isPassword: false,
                isObscure: false,
              ),
              SizedBox(height: 16),
              // Input Tanggal Lahir
              MyTextField(
                controller: tanggalLahirController,
                labelText: 'Tanggal Lahir',
                isPassword: false,
                isObscure: false,
              ),
              SizedBox(height: 16),
              // Input Umur Domba
              MyTextField(
                controller: umurController,
                labelText: 'Umur Domba',
                isPassword: false,
                isObscure: false,
              ),
              SizedBox(height: 16),
              // Input Jenis Domba
              MyTextField(
                controller: jenisDombaController,
                labelText: 'Jenis Domba',
                isPassword: false,
                isObscure: false,
              ),
              SizedBox(height: 18),
              // Tombol Tambah Domba
              MyButton(
                text: 'Tambah Domba',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sheepController.addSheep(
                      idDombaController.text,
                      namaDombaController.text,
                      tanggalLahirController.text,
                      umurController.text,
                      jenisDombaController.text,
                    );
                    Get.back(); // Kembali setelah menambah domba
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
