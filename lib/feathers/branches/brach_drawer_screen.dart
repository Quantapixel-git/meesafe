import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/branches/brach_report_screen.dart';
import 'package:mee_safe/feathers/branches/branch_dashboard.dart';
import 'package:mee_safe/feathers/branches/branch_customer.dart';
import 'package:mee_safe/feathers/branches/branch_plan_screen.dart';
import 'package:mee_safe/feathers/branches/branch_warrenty_list.dart';
import 'package:mee_safe/feathers/branches/branch_members_screen.dart';
import 'package:mee_safe/feathers/branches/brach_claim_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchDrawerScreen extends StatelessWidget {
  final String role; // "Manager" or "Executive"

  const BranchDrawerScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🔷 Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_balance, size: 48, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  role == "Manager" ? "Branch Manager" : "Branch Executive",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          // 🏠 Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BranchDashboard()),
              );
            },
          ),

          // 👥 Customers
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Customers"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BranchCustomer()),
              );
            },
          ),
           // 👨‍💼 Branch Members
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text("Branch Members"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BranchMembersScreen(
                    isManager: role == "Manager",
                  ),
                ),
              );
            },
          ),

           ListTile(
            leading: const Icon(Icons.subscriptions_outlined),
            title: const Text("Plans"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BranchPlanScreen()),
              );
            },
          ),


          // 🧾 Warranties
          ListTile(
            leading: const Icon(Icons.verified),
            title: const Text("Warranties"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BranchWarrentyList()),
              );
            },
          ),

         

          // 📄 Claims (Manager only)
          if (role == "Manager")
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text("Claims"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BrachClaimScreen()),
                );
              },
            ),

          // 📊 Reports (Manager only)
          if (role == "Manager")
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BranchReportsScreen()),
                );
              },
            ),

          const Divider(),

          // 🚪 Logout
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.primary),
            title: const Text(
              "Logout",
              style: TextStyle(color: AppColors.primary),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Logged out successfully"),
                          ),
                        );
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
