// File: lib/models/chart_model.dart

class ChartData {
  final String label;
  final double value;

  ChartData({required this.label, required this.value});
}

// Sales data for Bar Chart
List<ChartData> getSalesData() {
  return [
    ChartData(label: 'Jan', value: 1200),
    ChartData(label: 'Feb', value: 1500),
    ChartData(label: 'Mar', value: 900),
    ChartData(label: 'Apr', value: 2000),
    ChartData(label: 'May', value: 1800),
  ];
}

// User activity data for Line Chart
List<ChartData> getUserActivityData() {
  return [
    ChartData(label: 'Week 1', value: 500),
    ChartData(label: 'Week 2', value: 750),
    ChartData(label: 'Week 3', value: 620),
    ChartData(label: 'Week 4', value: 880),
  ];
}

// Device usage for Pie Chart
List<ChartData> getDeviceUsageData() {
  return [
    ChartData(label: 'Online', value: 35000),
    ChartData(label: 'Retail', value: 20000),
    ChartData(label: 'Wholesale', value: 15000),
  ];
}
