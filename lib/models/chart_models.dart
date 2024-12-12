class ChartData {
  final DateTime createdAt;
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final double weight;

  ChartData({
    required this.createdAt,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.weight,
  });
}
