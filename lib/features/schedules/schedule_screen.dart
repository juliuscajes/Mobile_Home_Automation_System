import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/schedule_provider.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final schedules = context.watch<ScheduleProvider>().schedules;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add Schedule (mock)')),
            ),
          ),
        ],
      ),
      body: schedules.isEmpty
          ? const Center(child: Text('No schedules yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: schedules.length,
              itemBuilder: (_, i) {
                final s = schedules[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: s.isActive
                          ? AppColors.primary.withValues(alpha: 0.15)
                          : AppColors.divider,
                      child: Icon(
                        s.action == 'ON'
                            ? Icons.power_settings_new
                            : Icons.power_off,
                        color: s.isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                    title: Text(s.deviceName,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                    subtitle: Text('${s.triggerTime} • ${s.repeatDays}'),
                    trailing: Switch(
                      value: s.isActive,
                      activeThumbColor: AppColors.primary,
                      onChanged: (_) => context
                          .read<ScheduleProvider>()
                          .toggleSchedule(s.scheduleId),
                    ),
                    onLongPress: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Schedule?'),
                        content: Text('Remove "${s.deviceName}" schedule?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<ScheduleProvider>()
                                  .deleteSchedule(s.scheduleId);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete',
                                style: TextStyle(color: AppColors.danger)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
