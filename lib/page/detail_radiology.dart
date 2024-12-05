import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/radiologi_models.dart';

class DetailRadiology extends StatelessWidget {
  final Radiologi radiologi = Get.arguments as Radiologi;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy, HH:mm:ss').format(DateTime.parse(radiologi.sheepCreated));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Radiologi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('Informasi Domba'),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCard([
                _buildDetailRow(
                  icon: Icons.tag,
                  label: 'ID Assesment',
                  value: radiologi.assesmentId.toString(),
                ),
                _buildDetailRow(
                  icon: Icons.pets,
                  label: 'ID Domba',
                  value: radiologi.sheepId.toString(),
                ),
                _buildDetailRow(
                  icon: Icons.pets,
                  label: 'Nama Domba',
                  value: radiologi.sheepName,
                ),
              ]),
              const SizedBox(height: 20),
              _buildSectionTitle('Data Radiologi'),
              _buildCard([
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: radiologi.radiologiImage != null && radiologi.radiologiImage!.isNotEmpty
                      ? Image.network(
                          'https://isusg-mbkm.research-ai.my.id/storage/${radiologi.radiologiImage}',
                          fit: BoxFit.cover,
                        )
                      : const Text('Gambar tidak tersedia'),
                ),
                const SizedBox(height: 10),
                _buildDetailRow(
                  icon: Icons.info,
                  label: 'Pregnancy Status',
                  value: radiologi.pregnancyStatus,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF697565),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF697565), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
