import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '/models/chart_model.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (screenWidth >= 1024) {
      crossAxisCount = 3;
    } else if (screenWidth >= 768) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: const [LineChartWidget(), BarChartWidget(), PieChartWidget()],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userActivityData = getUserActivityData();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Weekly User Activity',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: false,
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= 0 && index < userActivityData.length) {
                            return Text(userActivityData[index].label);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final index = spot.x.toInt();
                          final label =
                              (index >= 0 && index < userActivityData.length)
                              ? userActivityData[index].label
                              : '';
                          return LineTooltipItem(
                            '$label\n${spot.y.toStringAsFixed(1)}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: true,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: userActivityData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                          .toList(),
                      isCurved: true,
                      barWidth: 3,
                      color: getColor(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final salesData = getSalesData();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Monthly Sales',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= 0 && index < salesData.length) {
                            return Text(salesData[index].label);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  barGroups: salesData.asMap().entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(toY: e.value.value, color: getColor()),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color getColor() {
  List colors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.amber,
    Colors.pink,
    Colors.brown,
  ];
  final random = Random();
  return colors[random.nextInt(colors.length)];
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pieData = getDeviceUsageData();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Sales', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: pieData.map((data) {
                    final color = _getColorForLabel(data.label);
                    return PieChartSectionData(
                      value: data.value,
                      title: data.label,
                      titleStyle: TextStyle(fontSize: 10),
                      color: color,
                      radius: 50,
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Online':
        return Colors.blue;
      case 'Retail':
        return Colors.orange;
      case 'Wholesale':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
