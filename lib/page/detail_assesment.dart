import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/assesment_models.dart';

class DetailAssesmentAwal extends StatelessWidget {
  final Assessment assessment = Get.arguments as Assessment;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy, HH:mm:ss').format(assessment.created_at);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Assessment',
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
                  value: assessment.id,
                ),
                _buildDetailRow(
                  icon: Icons.pets,
                  label: 'ID Domba',
                  value: assessment.sheepId,
                ),
              ]),
              const SizedBox(height: 20),
              _buildSectionTitle('Data Status & Kondisi'),
              _buildCard([
                _buildDetailRow(
                    icon: Icons.health_and_safety,
                    label: 'Kondisi Kuku',
                    value: assessment.hoof),
                _buildDetailRow(
                    icon: Icons.favorite,
                    label: 'Kondisi Mata',
                    value: assessment.eye),
                _buildDetailRow(
                    icon: Icons.monitor_weight,
                    label: 'Kondisi Bulu',
                    value: assessment.wool),
                _buildDetailRow(
                    icon: Icons.info_outline,
                    label: 'Informasi Tambahan',
                    value: assessment.additionalInfo ?? "-"),
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