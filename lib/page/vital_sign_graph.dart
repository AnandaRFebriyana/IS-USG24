import 'package:flutter/material.dart';
import 'package:mobileapp/models/chart_models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class VitalSignGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ambil data dari arguments
    final List<ChartData> chartData = Get.arguments ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik Perkembangan Kesehatan'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            title: ChartTitle(text: 'Grafik Vital Signs'),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              overflowMode: LegendItemOverflowMode.wrap,
              textStyle: TextStyle(fontSize: 10),
              ),
            trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
            ),
            primaryXAxis: DateTimeAxis(
              title: AxisTitle(text: 'Tanggal'),
              intervalType: DateTimeIntervalType.days,
              majorGridLines: MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Nilai'),
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(size: 0),
            ),
            series: _getStackedLineSeries(chartData),
          ),
        ),
      ),
    );
  }

  /// Mengembalikan data series untuk Stacked Line Chart
  List<StackedLineSeries<ChartData, DateTime>> _getStackedLineSeries(
      List<ChartData> chartData) {
    return <StackedLineSeries<ChartData, DateTime>>[
      StackedLineSeries<ChartData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.createdAt,
        yValueMapper: (ChartData data, _) => data.temperature,
        name: 'Suhu Tubuh',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.blue,
      ),
      StackedLineSeries<ChartData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.createdAt,
        yValueMapper: (ChartData data, _) => data.heartRate,
        name: 'Denyut Jantung',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.red,
      ),
      StackedLineSeries<ChartData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.createdAt,
        yValueMapper: (ChartData data, _) => data.respiratoryRate,
        name: 'Laju Pernapasan',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.green,
      ),
      StackedLineSeries<ChartData, DateTime>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.createdAt,
        yValueMapper: (ChartData data, _) => data.weight,
        name: 'Berat Badan',
        markerSettings: MarkerSettings(isVisible: true),
        color: Colors.purple,
      ),
    ];
  }
}
