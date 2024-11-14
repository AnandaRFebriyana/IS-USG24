import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart'; // Pastikan GetX diimpor
import 'package:mobileapp/page/addSheep.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    // Set tanggal dan waktu saat ini pada saat inisialisasi
    currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140), // Tinggi custom AppBar
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                Image.asset(
                  'assets/bg_sheep.jpg', // Ganti dengan path gambar Anda
                  fit: BoxFit.cover,
                ),
                // Layer untuk menambahkan efek gelap pada gambar
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                // Konten di atas gambar
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      // Logo atau nama aplikasi
                      Text(
                        'IS-USG',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Text "Selamat Datang" dan Tanggal di bawah logo
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang Karyawan',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                currentDate,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Column untuk 2 baris kotak informasi
            Column(
              children: [
                // Baris pertama dengan dua kotak
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Suhu Udara', '30°C', Colors.blue.shade100, Colors.blue, Icons.thermostat),
                    _buildInfoBox('Kelembapan', '60%', Colors.green.shade100, Colors.green, Icons.water_drop),
                  ],
                ),
                SizedBox(height: 20),
                // Baris kedua dengan dua kotak
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Metana', '150 ppm', Colors.orange.shade100, Colors.orange, Icons.air),
                    _buildInfoBox('Amonia', '20 ppm', Colors.red.shade100, Colors.red, Icons.science),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Teks "Data Domba" dengan tombol "+ Add" di sebelah kanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data Domba',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Tombol "+ Add"
                TextButton.icon(
                  onPressed: () {
                    // Aksi saat tombol + Add ditekan, navigasi ke AddSheepForm
                    Get.to(AddSheepForm());
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18,
                    color: const Color(0xFF697565),
                  ),
                  label: Text(
                    "Add",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF697565),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Scrollable data domba
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(20, (index) {
                    return ListTile(
                      leading: Icon(Icons.pets),
                      title: Text('Domba $index'),
                      subtitle: Text('Data detail domba $index'),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun kotak informasi dengan warna judul yang bisa diatur
  Widget _buildInfoBox(String title, String value, Color backgroundColor, Color titleColor, IconData icon) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2, // Menyesuaikan ukuran kotak
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,  // Menambahkan warna latar belakang
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: titleColor,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleColor, // Warna judul disesuaikan
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
