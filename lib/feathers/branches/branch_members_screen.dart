import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchMembersScreen extends StatefulWidget {
  final bool isManager;

  const BranchMembersScreen({super.key, required this.isManager});

  @override
  State<BranchMembersScreen> createState() => _BranchMembersScreenState();
}

class _BranchMembersScreenState extends State<BranchMembersScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> branchMembers = [
    {"name": "John Doe", "role": "Executive", "email": "john@example.com"},
    {"name": "Sarah Lee", "role": "Executive", "email": "sarah@example.com"},
    {"name": "Amit Kumar", "role": "Manager", "email": "amit@example.com"},
  ];

  String selectedRole = "Executive";
  final List<String> roles = ["Executive"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          "Branch Members",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
         drawer: BranchDrawerScreen(role: 'Manager'),
      floatingActionButton: widget.isManager
          ? FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                _showAddMemberDialog(context);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by name or email",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),

            // 👥 Member List
            Expanded(
              child: ListView.builder(
                itemCount: branchMembers.length,
                itemBuilder: (context, index) {
                  final member = branchMembers[index];
                  if (!member["name"]
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()) &&
                      !member["email"]
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        member["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${member["email"]}\nRole: ${member["role"]}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧱 Add Member Dialog
  void _showAddMemberDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    String role = "Executive";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Add New Member"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: role,
              decoration: const InputDecoration(
                labelText: "Role",
                prefixIcon: Icon(Icons.work),
              ),
              items: ["Executive", "Manager"]
                  .map((r) => DropdownMenuItem(
                        value: r,
                        child: Text(r),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) role = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                branchMembers.add({
                  "name": nameController.text,
                  "role": role,
                  "email": emailController.text,
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // 🧱 Role Change Dialog
  void _showRoleAssignDialog(BuildContext context, int index) {
    String newRole = branchMembers[index]["role"];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Role"),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: DropdownButtonFormField<String>(
          value: newRole,
          items: roles
              .map((r) => DropdownMenuItem(
                    value: r,
                    child: Text(r),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) newRole = value;
          },
          decoration: const InputDecoration(
            labelText: "Select Role",
            prefixIcon: Icon(Icons.admin_panel_settings),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              setState(() {
                branchMembers[index]["role"] = newRole;
              });
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
