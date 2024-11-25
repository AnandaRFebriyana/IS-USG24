import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mobileapp/models/vital_sign_models.dart';

class VitalSignGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan data yang dikirim melalui routing
    final List<VitalSigns> vitalSignsList = Get.arguments ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik Perkembangan Kesehatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat('dd/MM/yyyy'), // Format tanggal
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                ),
                title: ChartTitle(text: 'Perkembangan Kesehatan Domba'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  // Grafik Suhu Tubuh
                  LineSeries<VitalSigns, DateTime>(
                    dataSource: vitalSignsList,
                    xValueMapper: (VitalSigns data, _) => data.createdAt,
                    yValueMapper: (VitalSigns data, _) => data.temperature,
                    name: 'Suhu Tubuh',
                    color: Colors.blue,
                  ),
                  // Grafik Denyut Jantung
                  LineSeries<VitalSigns, DateTime>(
                    dataSource: vitalSignsList,
                    xValueMapper: (VitalSigns data, _) => data.createdAt,
                    yValueMapper: (VitalSigns data, _) => data.heartRate,
                    name: 'Denyut Jantung',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}