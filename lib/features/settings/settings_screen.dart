import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _tile(Icons.person_outline, 'Profile'),
          _tile(Icons.home_outlined, 'Home Information'),
          _tile(Icons.tune, 'App Preferences'),
          _tile(Icons.notifications_none, 'Notification Settings'),
          _tile(Icons.mic_none, 'Voice Assistant'),
          _tile(Icons.security, 'Security'),
          _tile(Icons.info_outline, 'About'),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.danger),
            title: const Text('Logout',
                style: TextStyle(
                    color: AppColors.danger, fontWeight: FontWeight.w600)),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
