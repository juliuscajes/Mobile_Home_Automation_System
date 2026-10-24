import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/admin_dashboard.dart';
import 'features/dashboard/user_dashboard.dart';
import 'features/dashboard/elderly_dashboard.dart';

class CCSmartHomeApp extends StatelessWidget {
  const CCSmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CC Smart Home',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (!auth.isLoggedIn) return const LoginScreen();
          final role = auth.currentUser!.role;
          if (role == 'Admin') return const AdminDashboard();
          if (role == 'Elderly') return const ElderlyDashboard();
          return const UserDashboard();
        },
      ),
    );
  }
}
