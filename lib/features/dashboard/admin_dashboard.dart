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
import '../rooms/zone_manager_screen.dart';
import '../monitoring/environment_screen.dart';
import '../monitoring/energy_report_screen.dart';
import '../alerts/notifications_screen.dart';
import '../settings/settings_screen.dart';
import '../voice/voice_assistant_screen.dart';
import '../schedules/schedule_screen.dart';
import '../users/user_management_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _AdminHomeTab(),
      const DeviceListScreen(),
      const ZoneManagerScreen(),
      const EnergyReportScreen(),
      const _MoreTab(),
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

class _AdminHomeTab extends StatelessWidget {
  const _AdminHomeTab();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final devices = context.watch<DeviceProvider>().devices;
    final env = MockData.environment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, ${auth.currentUser?.displayName ?? "User"}',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text('Welcome back to CC Smart Home',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
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
                  const SizedBox(width: 12),
                  Expanded(
                      child: StatCard(
                    icon: Icons.speed,
                    label: 'Pressure',
                    value: '${env['pressure']}',
                    color: AppColors.accent,
                  )),
                ],
              ),
            ),
            const SectionHeader(
                title: 'Active Devices', actionLabel: 'See all'),
            ...devices.take(3).map((d) => DeviceCard(
                  device: d,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            DeviceDetailScreen(deviceId: d.deviceId)),
                  ),
                )),
            const SectionHeader(title: 'Quick Actions'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _quickAction(context, Icons.mic, 'Voice', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VoiceAssistantScreen()));
                  }),
                  const SizedBox(width: 12),
                  _quickAction(context, Icons.schedule, 'Schedule', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ScheduleScreen()));
                  }),
                  const SizedBox(width: 12),
                  _quickAction(context, Icons.people, 'Users', () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const UserManagementScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(
      BuildContext ctx, IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
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
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreTab extends StatelessWidget {
  const _MoreTab();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        children: [
          _tile(
              context,
              Icons.people_outline,
              'User Management',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const UserManagementScreen()))),
          _tile(
              context,
              Icons.mic_none,
              'Voice Assistant (CC AI)',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const VoiceAssistantScreen()))),
          _tile(
              context,
              Icons.schedule,
              'Schedules',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ScheduleScreen()))),
          _tile(
              context,
              Icons.notifications_none,
              'Alerts & Notifications',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const NotificationsScreen()))),
          _tile(
              context,
              Icons.thermostat,
              'Environment Monitoring',
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EnvironmentScreen()))),
          _tile(
              context,
              Icons.settings,
              'Settings',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()))),
        ],
      ),
    );
  }

  Widget _tile(
      BuildContext ctx, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
