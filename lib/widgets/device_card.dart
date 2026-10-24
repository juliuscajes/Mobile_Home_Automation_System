import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../data/models/device_model.dart';
import '../providers/device_provider.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback? onTap;

  const DeviceCard({super.key, required this.device, this.onTap});

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: device.isOn
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.divider,
                child: Icon(_iconForType(device.type),
                    color: device.isOn
                        ? AppColors.primary
                        : AppColors.textSecondary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.deviceName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${device.type} • ${device.controlSource}',
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Switch(
                value: device.isOn,
                activeThumbColor: AppColors.primary,
                onChanged: (_) => context
                    .read<DeviceProvider>()
                    .toggleDevice(device.deviceId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
