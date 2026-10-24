import 'package:flutter/material.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/user_model.dart';
import '../../core/constants/app_colors.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});
  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late List<UserModel> _users;

  @override
  void initState() {
    super.initState();
    _users = List.from(MockData.users);
  }

  void _approve(UserModel u) {
    setState(() => u.status = 'Approved');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${u.displayName} approved')),
    );
  }

  void _reject(UserModel u) {
    setState(() => u.status = 'Rejected');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${u.displayName} rejected')),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return AppColors.success;
      case 'Pending':
        return AppColors.warning;
      default:
        return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add User (mock)')),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (_, i) {
          final u = _users[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text(u.displayName[0].toUpperCase(),
                    style: const TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
              title: Text(u.displayName,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${u.role} • ${u.email}'),
              trailing: u.status == 'Pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: AppColors.success),
                          onPressed: () => _approve(u),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.cancel, color: AppColors.danger),
                          onPressed: () => _reject(u),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(u.status).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(u.status,
                          style: TextStyle(
                              color: _statusColor(u.status),
                              fontWeight: FontWeight.w600,
                              fontSize: 13)),
                    ),
            ),
          );
        },
      ),
    );
  }
}
