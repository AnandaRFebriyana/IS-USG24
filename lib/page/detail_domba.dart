import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:mobileapp/controllers/sheep_controller.dart';

class DetailDomba extends StatelessWidget {
  final SheepController sheepController = Get.find<SheepController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments == null || arguments['idDomba'] == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detail Domba'),
        ),
        body: Center(
          child: Text('No data found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Domba'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Barcode Widget
                BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: arguments['idDomba'],
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 20),
                
                // ID Domba
                _buildDetailField('ID Domba', arguments['idDomba']),
                SizedBox(height: 20),
                
                // Nama Domba
                _buildDetailField('Nama Domba', arguments['namaDomba']),
                SizedBox(height: 20),
                
                // Tanggal Lahir
                _buildDetailField('Tanggal Lahir', arguments['tanggalLahir']),
                SizedBox(height: 20),
                
                // Umur (dapat ditambahkan jika diperlukan)
                _buildDetailField('Umur', arguments['umur']),
              ],
            ),
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
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          readOnly: true, // Menjadikan field tidak dapat diedit
        ),
      ],
    );
  }
}
