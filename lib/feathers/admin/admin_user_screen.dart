import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final List<Map<String, dynamic>> _users = [
    {"id": 1, "name": "Ravi Kumar", "email": "ravi@mail.com", "role": "User"},
    {"id": 2, "name": "Asha Patel", "email": "asha@mail.com", "role": "Vendor"},
    {"id": 3, "name": "Vikas Sharma", "email": "vikas@mail.com", "role": "Branch Member"},
  ];

  void _addOrEditUser({Map<String, dynamic>? user}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditUserScreen(user: user),
      ),
    );
    if (result != null) {
      setState(() {
        if (user == null) {
          _users.add({
            "id": DateTime.now().millisecondsSinceEpoch,
            ...result,
          });
        } else {
          user.addAll(result);
        }
      });
    }
  }

  void _deleteUser(int id) {
    setState(() {
      _users.removeWhere((u) => u["id"] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Manage Users"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(user["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${user["email"]}\nRole: ${user["role"]}"),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _addOrEditUser(user: user)),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(user["id"])),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () => _addOrEditUser(),
      ),
    );
  }
}
class AddEditUserScreen extends StatefulWidget {
  final Map<String, dynamic>? user;
  const AddEditUserScreen({super.key, this.user});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _selectedRole = "User";

  final List<String> roles = ["User", "Vendor", "Agency Owner", "Admin"];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?["name"] ?? "");
    _emailController = TextEditingController(text: widget.user?["email"] ?? "");
    _selectedRole = widget.user?["role"] ?? "User";
  }

  void _saveUser() {
    final userData = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "role": _selectedRole,
    };
    Navigator.pop(context, userData);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit User" : "Add User"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            // InputDecorator(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey.shade400),
            //     borderRadius: BorderRadius.circular(8),
            //   ).copyWith(
            //     contentPadding:
            //         const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton<String>(
            //       value: _selectedRole,
            //       isExpanded: true,
            //       items: roles
            //           .map((role) =>
            //               DropdownMenuItem(value: role, child: Text(role)))
            //           .toList(),
            //       onChanged: (val) => setState(() => _selectedRole = val!),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _saveUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.save),
              label: Text(isEditing ? "Update User" : "Add User",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
