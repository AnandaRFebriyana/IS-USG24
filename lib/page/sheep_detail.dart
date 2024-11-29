import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/sheep_models.dart';

class DetailDomba extends StatelessWidget {
  final Sheep sheep = Get.arguments as Sheep;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy').format(sheep.sheepBirth);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Data Domba',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: sheep.sheepPhotoPath != null && sheep.sheepPhotoPath!.isNotEmpty
                        ? NetworkImage('https://isusg-mbkm.research-ai.my.id/storage/${sheep.sheepPhotoPath}')
                        : const AssetImage('assets/domba.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildDetailField('ID Domba', sheep.id),
              SizedBox(height: 20),
              _buildDetailField('Nama Domba', sheep.sheepName),
              SizedBox(height: 20),
              _buildDetailField('Tanggal Lahir', formattedDate),
              SizedBox(height: 20),
              _buildDetailField('Jenis Kelamin', sheep.sheepGender),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: TextEditingController(text: value),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          readOnly: true,
        ),
      ],
    );
  }
}
