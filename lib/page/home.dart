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
                TextButton.icon(
                  onPressed: () {
                    Get.toNamed('/addsheep');
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Color(0xFF697565),
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
            //

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
                    return SingleChildScrollView(
                      child: Column(
                        children: sheepList.map((sheep) {
                          return ListTile(
                            leading: Icon(Icons.pets),
                            title: Text(sheep.id),
                            subtitle: Text(sheep.sheepName),
                            onTap: () {
                              Get.toNamed('/detaildomba', arguments: sheep);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return Center(child: Text('Tidak ada data domba.'));
                  }
                },
              ),
            ),
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
