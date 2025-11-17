import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 900;

        // ------------------------ DESKTOP / WEB VERSION ------------------------
        if (isDesktop) {
          return Scaffold(
            body: Row(
              children: [
                const SizedBox(width: 260, child: AdminDrawer()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header + Add Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: const Text(
                                  "Manage Users",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _addOrEditUser(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text("Add User"),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Data Table for Desktop
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 40,
                                headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                                columns: const [
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Role")),
                                  DataColumn(label: Text("Actions")),
                                ],
                                rows: _users.map((user) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(user["name"])),
                                      DataCell(Text(user["email"])),
                                      DataCell(Text(user["role"])),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.orange),
                                              onPressed: () => _addOrEditUser(user: user),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () => _deleteUser(user["id"]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // ------------------------ MOBILE VERSION (ORIGINAL CODE) ------------------------
        return Scaffold(
          appBar: AppBar(
            title: Text("Manage Users"),
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
      },
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

      // 🔥 Responsive UI using LayoutBuilder
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            // ======= WEB / DESKTOP VIEW =======
            return _buildDesktopView(isEditing);
          }

          // ======= MOBILE VIEW (YOUR ORIGINAL CODE) =======
          return _buildMobileView(isEditing);
        },
      ),
    );
  }

  // ============================================================
  // ✅ ORIGINAL MOBILE VIEW (DO NOT TOUCH)
  // ============================================================
  Widget _buildMobileView(bool isEditing) {
    return Padding(
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

          DropdownButtonFormField<String>(
            value: _selectedRole,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              labelText: "User Role",
            ),
            items: roles
                .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                .toList(),
            onChanged: (value) => setState(() => _selectedRole = value!),
          ),

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: _saveUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(Icons.save),
            label: Text(
              isEditing ? "Update User" : "Add User",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ✅ DESKTOP / WEB VIEW — NEW UI (CENTERED WIDE CARD)
  // ============================================================
  Widget _buildDesktopView(bool isEditing) {
    return Center(
      child: Container(
        width: 550,
        padding: const EdgeInsets.all(28),
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Text(
              isEditing ? "Edit User" : "Add New User",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // Form fields in desktop layout
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                labelText: "User Role",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: roles
                  .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedRole = value!),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.save),
                label: Text(
                  isEditing ? "Update User" : "Add User",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
