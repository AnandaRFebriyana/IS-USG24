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
  final TextEditingController jenisDombaController = TextEditingController();

  final SheepController sheepController = Get.find<SheepController>();

  @override
  void initState() {
    super.initState();
    // Mengisi ID Domba otomatis dari API saat form dibuka
    sheepController.getSheepIdFromApi().then((id) {
      setState(() {
        idDombaController.text = id;
      });
    });
  }

  // Fungsi untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Tanggal default
      firstDate: DateTime(2000), // Batas awal tahun
      lastDate: DateTime(2101), // Batas akhir tahun
    );
    if (picked != null) {
      setState(() {
        tanggalLahirController.text = "${picked.toLocal()}".split(' ')[0]; // Format tanggal
      });
    }
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
                readOnly: true,
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
              // Input Tanggal Lahir dengan Kalender
              GestureDetector(
                onTap: () => _selectDate(context), // Fungsi untuk menampilkan kalender
                child: AbsorbPointer(
                  child: MyTextField(
                    controller: tanggalLahirController,
                    labelText: 'Tanggal Lahir',
                    isPassword: false,
                    isObscure: false,
                  ),
                ),
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
                      jenisDombaController.text,
                    ).then((_) {
                      Get.back(); // Menutup form setelah berhasil
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Domba berhasil ditambahkan!')),
                      );
                    }).catchError((e) {
                      // Jika ada error saat menambahkan domba
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal menambah domba: $e')),
                      );
                    });
                  } else {
                    // Jika ada validasi yang gagal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form tidak valid!')),
                    );
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
