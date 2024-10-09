import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedTimeframe = 'Minggu'; // Default waktu untuk grafik

  // Data untuk grafik
  List<SalesData> data = [
    SalesData(1, 5),
    SalesData(2, 25),
    SalesData(3, 100),
    SalesData(4, 75),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Aksi untuk notifikasi
            },
          ),
        ],
        // Menambahkan bagian foto dan welcome ke AppBar
        title: Row(
          children: [
            CircleAvatar(
              radius: 20, // Mengurangi ukuran agar sesuai dengan AppBar
              backgroundImage: AssetImage('assets/domba.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'User123', // Nama user
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Grafik Aktivitas Domba Hamil
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Aktivitas Domba Hamil',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedTimeframe,
                  items: ['Minggu', 'Bulan', 'Tahun']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTimeframe = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 300, // Ukuran grafik
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  LineSeries<SalesData, String>(
                    dataSource: data,
                    xValueMapper: (SalesData sales, _) => sales.year.toString(),
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            // Tombol Aksi (4 tombol) dengan warna yang diperbarui
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton('Assessment Awal', Icons.assignment, Colors.blue),
                _buildActionButton('Vital Sign', Icons.favorite, Colors.red),
                _buildActionButton('USG', Icons.camera_alt, Colors.orange),
                _buildActionButton('Data Domba', Icons.pets, Colors.green),
              ],
            ),
            SizedBox(height: 30),

            // Edukasi Domba
            Text(
              'Edukasi Pemeliharaan Domba',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Image.network(
                  'https://example.com/image.jpg', // Gambar edukasi domba (ubah ke URL gambar asli)
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Pemeliharaan domba hamil sangat penting untuk menjaga kesehatan dan produktivitas domba. Pastikan domba diberi makan yang cukup, perawatan rutin, dan pengawasan kesehatan secara berkala.',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ),
              ],
            ),
            // Menambahkan informasi lebih lanjut tentang edukasi dari Google
            SizedBox(height: 10),
            Text(
              'Untuk informasi lebih lanjut, kunjungi situs pemeliharaan domba.',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun tombol aksi dengan warna yang ditentukan
  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color, // Menggunakan warna yang diteruskan
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Data model untuk grafik
class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}