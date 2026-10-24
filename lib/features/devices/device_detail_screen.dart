import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/device_provider.dart';
import '../schedules/schedule_screen.dart';

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;
  const DeviceDetailScreen({super.key, required this.deviceId});

  IconData _iconForType(String type) {
    switch (type) {
      case 'Light':
        return Icons.lightbulb_outline;
      case 'Fan':
        return Icons.air;
      case 'Socket':
        return Icons.power_outlined;
      default:
        return Icons.devices_other;
    }
  }

  @override
  Widget build(BuildContext context) {
    final device = context.watch<DeviceProvider>().getById(deviceId);
    if (device == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Device')),
        body: const Center(child: Text('Device not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(device.deviceName),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: device.isOn
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.divider,
              ),
              child: Icon(_iconForType(device.type),
                  size: 70,
                  color: device.isOn
                      ? AppColors.primary
                      : AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            Text('Status: ${device.isOn ? "ON" : "OFF"}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Channel ${device.relayChannel} • ${device.type}',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          device.isOn ? AppColors.primary : AppColors.divider,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: !device.isOn
                        ? () => context
                            .read<DeviceProvider>()
                            .toggleDevice(device.deviceId)
                        : null,
                    child: const Text('ON'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !device.isOn ? AppColors.danger : AppColors.divider,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: device.isOn
                        ? () => context
                            .read<DeviceProvider>()
                            .toggleDevice(device.deviceId)
                        : null,
                    child: const Text('OFF'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _infoTile(
                Icons.schedule,
                'Schedule',
                'Set automation',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ScheduleScreen()))),
            _infoTile(
                Icons.power, 'Power Usage', '${device.powerUsage} kWh', null),
            _infoTile(Icons.info_outline, 'Device Info',
                'ID: ${device.deviceId}', null),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
      IconData icon, String title, String subtitle, VoidCallback? onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}
