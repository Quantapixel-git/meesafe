import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchDashboard extends StatelessWidget {
  const BranchDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalMembers = 12;
    final int totalCustomers = 120;
    final int totalWarranties = 85;
    final int activeWarranties = 62;
    final int expiredWarranties = 23;
    final int totalClaims = 30;
    final int approvedClaims = 18;
    final int pendingClaims = 12;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Branch Dashboard"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      drawer: const BranchDrawerScreen(role: 'Manager'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard("Branch Members", totalMembers, Colors.blueAccent),
                _buildStatCard("Customers", totalCustomers, Colors.orangeAccent),
                _buildStatCard("Total Warranties", totalWarranties, Colors.teal),
                _buildStatCard("Active Warranties", activeWarranties, Colors.green),
                _buildStatCard("Expired Warranties", expiredWarranties, AppColors.primary),
                _buildStatCard("Total Claims", totalClaims, Colors.purpleAccent),
                _buildStatCard("Approved Claims", approvedClaims, Colors.lightBlue),
                _buildStatCard("Pending Claims", pendingClaims, Colors.amber),
              ],
            ),

            const SizedBox(height: 28),

          ],
        ),
      ),
    );
  }

  // 🧱 Stat Card Widget
  Widget _buildStatCard(String title, int value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(2, 2),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insights, color: color, size: 36),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

}
