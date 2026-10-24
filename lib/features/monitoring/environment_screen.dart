import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/mock/mock_data.dart';
import '../../core/constants/app_colors.dart';

class EnvironmentScreen extends StatelessWidget {
  const EnvironmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final env = MockData.environment;
    return Scaffold(
      appBar: AppBar(title: const Text('Environment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _envCard('Temp', '${env['temperature']}°C', Icons.thermostat,
                    AppColors.danger),
                const SizedBox(width: 12),
                _envCard('Humidity', '${env['humidity']}%', Icons.water_drop,
                    AppColors.primaryLight),
              ],
            ),
            const SizedBox(height: 12),
            _envCard('Pressure', '${env['pressure']} hPa', Icons.speed,
                AppColors.accent),
            const SizedBox(height: 24),
            Text('Real-time Status',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 24),
                        FlSpot(1, 25),
                        FlSpot(2, 26),
                        FlSpot(3, 26.5),
                        FlSpot(4, 27),
                        FlSpot(5, 26.8),
                        FlSpot(6, 26.5),
                      ],
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
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

  Widget _envCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            Text(value,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
