import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/mock/mock_data.dart';
import '../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _iconForType(String type) {
    switch (type) {
      case 'Security':
        return Icons.shield_outlined;
      case 'Threshold':
        return Icons.thermostat;
      default:
        return Icons.lightbulb_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.alerts.length,
        itemBuilder: (_, i) {
          final a = MockData.alerts[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Icon(_iconForType(a.type), color: AppColors.primary),
              ),
              title: Text(a.message,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              subtitle: Text(DateFormat('MMM d, h:mm a').format(a.createdAt)),
              trailing: a.acknowledged
                  ? const Icon(Icons.check_circle, color: AppColors.success)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
