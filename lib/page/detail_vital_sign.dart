import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/vital_sign_models.dart';

class DetailVitalSign extends StatelessWidget {
  final VitalSigns vitalSign = Get.arguments as VitalSigns;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('d MMMM yyyy, HH:mm:ss').format(vitalSign.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Vital Sign',
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
                    label: 'ID Domba',
                    value: vitalSign.sheepId),
                _buildDetailRow(
                    icon: Icons.pets,
                    label: 'Nama Domba',
                    value: vitalSign.sheepName),
                _buildDetailRow(
                  icon: Icons.health_and_safety,
                  label: 'Status',
                  value: vitalSign.statusCondition,
                  valueColor: vitalSign.statusCondition.toLowerCase() == 'sehat'
                      ? Colors.green
                      : Colors.red,
                ),
              ]),
              const SizedBox(height: 20),
              _buildSectionTitle('Data Vital'),
              _buildCard([
                _buildDetailRow(
                    icon: Icons.thermostat,
                    label: 'Suhu Tubuh',
                    value: '${vitalSign.temperature}°C'),
                _buildDetailRow(
                    icon: Icons.favorite,
                    label: 'Denyut Jantung',
                    value: '${vitalSign.heartRate} bpm'),
                _buildDetailRow(
                    icon: Icons.air,
                    label: 'Laju Pernapasan',
                    value: '${vitalSign.respiratoryRate} bpm'),
                _buildDetailRow(
                    icon: Icons.monitor_weight,
                    label: 'Berat Badan',
                    value: '${vitalSign.weight} kg'),
                _buildDetailRow(
                    icon: Icons.info_outline,
                    label: 'Informasi Tambahan',
                    value: vitalSign.additionalInfo ?? "-"),
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
            offset: const Offset(0, 3), // changes position of shadow
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
    Color? valueColor,
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
