import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/mock/mock_data.dart';
import '../../core/constants/app_colors.dart';

class EnergyReportScreen extends StatefulWidget {
  const EnergyReportScreen({super.key});
  @override
  State<EnergyReportScreen> createState() => _EnergyReportScreenState();
}

class _EnergyReportScreenState extends State<EnergyReportScreen> {
  String _range = 'Day';

  @override
  Widget build(BuildContext context) {
    final report = MockData.energyReport;
    final hourly = List<double>.from(report['hourlyData']);
    final topDevices = List<Map<String, dynamic>>.from(report['topDevices']);

    return Scaffold(
      appBar: AppBar(title: const Text('Energy Report')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Range chips
            Row(
              children: ['Day', 'Week', 'Month'].map((r) {
                final selected = _range == r;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(r),
                    selected: selected,
                    selectedColor: AppColors.primary.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() => _range = r),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Total Consumption',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
            const SizedBox(height: 4),
            Text('${report['totalKwh']} kWh',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(hourly.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: hourly[i],
                          color: AppColors.primary,
                          width: 12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Top Devices', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...topDevices.map((d) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.power, color: AppColors.primary),
                    title: Text(d['name']),
                    trailing: Text('${d['kwh']} kWh',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
