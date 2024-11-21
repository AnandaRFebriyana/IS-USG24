import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/models/user_models.dart';
import 'package:mobileapp/services/auth_service.dart';
import 'package:mobileapp/services/sheep_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User user = User(name: '');
  String currentDate = '';

  @override
  void initState() {
    fetchUser();
    super.initState();
    currentDate = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
  }

  Future<void> fetchUser() async {
    try {
      User getUser = await AuthService.getUser();
      setState(() {
        user = getUser;
      });
    } catch (e) {
      print('Error: $e');
    }
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
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/bg_sheep.jpg',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                // Konten di atas gambar
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'IS-USG',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Datang ${user.name}',
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Suhu Udara', '30°C', Colors.blue.shade100,
                        Colors.blue, Icons.thermostat),
                    _buildInfoBox('Kelembapan', '60%', Colors.green.shade100,
                        Colors.green, Icons.water_drop),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox('Metana', '150 ppm', Colors.orange.shade100,
                        Colors.orange, Icons.air),
                    _buildInfoBox('Amonia', '20 ppm', Colors.red.shade100,
                        Colors.red, Icons.science),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
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
                TextButton(
                  onPressed: () {
                    Get.toNamed('/datadomba');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "See All",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF697565),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: Color(0xFF697565),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Sheep>>(
                future: SheepService.getSheep(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Sheep> sheepList = snapshot.data!;
                    return ListView.builder(
                      itemCount: sheepList.length,
                      itemBuilder: (context, index) {
                        Sheep sheep = sheepList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange[100],
                                child: Image.asset(
                                  'assets/domba.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              title: Text(
                                sheep.id,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(sheep.sheepName),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Get.toNamed('/detaildomba', arguments: sheep);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Tidak ada data domba.'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun kotak informasi dengan warna judul yang bisa diatur
  Widget _buildInfoBox(String title, String value, Color backgroundColor,
      Color titleColor, IconData icon) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor, // Menambahkan warna latar belakang
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
              color: titleColor,
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
