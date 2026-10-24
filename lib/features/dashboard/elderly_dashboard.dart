import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/device_provider.dart';
import '../voice/voice_assistant_screen.dart';

class ElderlyDashboard extends StatelessWidget {
  const ElderlyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final devices = context.watch<DeviceProvider>().devices;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CC Smart Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Hello, ${auth.currentUser?.displayName ?? "User"}',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Tap the big button and say your command',
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
            const SizedBox(height: 32),

            // BIG voice button
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const VoiceAssistantScreen())),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, color: Colors.white, size: 90),
                    SizedBox(height: 10),
                    Text('TAP TO SPEAK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text('Your Devices', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            // Big device buttons
            ...devices.map((d) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          d.isOn ? AppColors.primary : Colors.white,
                      foregroundColor:
                          d.isOn ? Colors.white : AppColors.textPrimary,
                      side: const BorderSide(
                          color: AppColors.divider, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 22),
                    ),
                    onPressed: () =>
                        context.read<DeviceProvider>().toggleDevice(d.deviceId),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(d.deviceName,
                            style: const TextStyle(fontSize: 22)),
                        Text(d.isOn ? 'ON' : 'OFF',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
