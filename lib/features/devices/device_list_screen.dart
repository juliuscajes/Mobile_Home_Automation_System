import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/device_provider.dart';
import '../../widgets/device_card.dart';
import 'device_detail_screen.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});
  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  String _filter = 'All';
  final _filters = ['All', 'Light', 'Fan', 'Socket'];

  @override
  Widget build(BuildContext context) {
    final devices = context.watch<DeviceProvider>().devices;
    final filtered = _filter == 'All'
        ? devices
        : devices.where((d) => d.type == _filter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Devices')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _filters
                    .map((f) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(f),
                            selected: _filter == f,
                            selectedColor:
                                AppColors.primary.withValues(alpha: 0.2),
                            onSelected: (_) => setState(() => _filter = f),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No devices found'))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => DeviceCard(
                      device: filtered[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DeviceDetailScreen(
                              deviceId: filtered[i].deviceId),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
