import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/device_provider.dart';
import '../../providers/zone_provider.dart';

class ZoneManagerScreen extends StatelessWidget {
  const ZoneManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final zones = context.watch<ZoneProvider>().zones;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms / Zones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add Zone (mock)')),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: zones.length,
        itemBuilder: (_, i) {
          final zone = zones[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: const Icon(Icons.meeting_room, color: AppColors.primary),
              ),
              title: Text(zone.zoneName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text(
                  '${zone.devices.length} device(s) • ${zone.activeCount} ON'),
              trailing: Switch(
                value: zone.activeCount > 0,
                activeThumbColor: AppColors.primary,
                onChanged: (v) =>
                    context.read<DeviceProvider>().toggleZone(zone.zoneId, v),
              ),
            ),
          );
        },
      ),
    );
  }
}
