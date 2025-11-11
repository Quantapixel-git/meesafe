import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class UserDeviceList extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final void Function(Map<String, dynamic> user)? onTapUser;

  const UserDeviceList({
    super.key,
    this.onRefresh,
    this.onTapUser,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Static list of users
    final List<Map<String, dynamic>> users = [
      {
        "user_id": 1,
        "user_name": "John Doe",
        "email": "john@example.com",
        "device_count": 3
      },
      {
        "user_id": 2,
        "user_name": "Jane Smith",
        "email": "jane@example.com",
        "device_count": 1
      },
      {
        "user_id": 3,
        "user_name": "Michael Johnson",
        "email": "michael.j@example.com",
        "device_count": 2
      },
      {
        "user_id": 4,
        "user_name": "Emily Brown",
        "email": "emily.b@example.com",
        "device_count": 4
      },
    ];

    // 🧩 List view UI
    final listView = ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final String name = (user['user_name'] ?? 'Unknown').toString();
        final String email = (user['email'] ?? '').toString();
        final int deviceCount = (user['device_count'] is int)
            ? user['device_count'] as int
            : int.tryParse('${user['device_count']}') ?? 0;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            onTap: onTapUser != null ? () => onTapUser!(user) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: email.isNotEmpty ? Text(email) : null,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$deviceCount ${deviceCount == 1 ? "Device" : "Devices"}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
    );

    return onRefresh != null
        ? RefreshIndicator(onRefresh: onRefresh!, child: listView)
        : listView;
  }
}
