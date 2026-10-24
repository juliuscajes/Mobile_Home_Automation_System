import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock/mock_data.dart';
import '../../providers/auth_provider.dart';
import '../../providers/device_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/device_card.dart';
import '../../widgets/section_header.dart';
import '../devices/device_list_screen.dart';
import '../devices/device_detail_screen.dart';
import '../monitoring/environment_screen.dart';
import '../monitoring/energy_report_screen.dart';
import '../alerts/notifications_screen.dart';
import '../settings/settings_screen.dart';
import '../schedules/schedule_screen.dart';
import '../voice/voice_assistant_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _UserHomeTab(),
      const DeviceListScreen(),
      const EnvironmentScreen(),
      const EnergyReportScreen(),
      const _UserMoreTab(),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _UserHomeTab extends StatelessWidget {
  const _UserHomeTab();
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final devices = context.watch<DeviceProvider>().devices;
    final env = MockData.environment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text('Hi, ${auth.currentUser?.displayName ?? "User"}!',
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                      child: StatCard(
                    icon: Icons.thermostat,
                    label: 'Temp',
                    value: '${env['temperature']}°C',
                    color: AppColors.danger,
                  )),
                  const SizedBox(width: 12),
                  Expanded(
                      child: StatCard(
                    icon: Icons.water_drop_outlined,
                    label: 'Humidity',
                    value: '${env['humidity']}%',
                    color: AppColors.primaryLight,
                  )),
                ],
              ),
            ),
            const SectionHeader(title: 'Your Devices'),
            ...devices.take(4).map((d) => DeviceCard(
                  device: d,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            DeviceDetailScreen(deviceId: d.deviceId)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _UserMoreTab extends StatelessWidget {
  const _UserMoreTab();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.mic_none),
            title: const Text('Voice Assistant'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const VoiceAssistantScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Schedules'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ScheduleScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
    );
  }
}
