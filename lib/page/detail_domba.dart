import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:mobileapp/models/sheep_models.dart';

class DetailDomba extends StatelessWidget {
  final Sheep sheep = Get.arguments as Sheep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vital Sign',
          style: TextStyle(
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
              BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: sheep.id,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              _buildDetailField('ID Domba', sheep.id),
              SizedBox(height: 20),
              _buildDetailField('Nama Domba', sheep.sheepName),
              SizedBox(height: 20),
              _buildDetailField('Tanggal Lahir', sheep.sheepBirth),
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
