import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  // Sample static data
  final int totalUsers = 1200;
  final int totalCompanies = 50;
  final int approvedCompanies = 35;
  final int pendingCompanies = 15;
  final int totalWarranty = 900;
  final int totalClaims = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Users & Companies
            Row(
              children: [
                _buildStatCard("Total Users", totalUsers, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard("Total Companies", totalCompanies, Colors.green),
              ],
            ),
            const SizedBox(height: 16),

            // Row 2: Approved / Pending Companies
            Row(
              children: [
                _buildStatCard("Approved Companies", approvedCompanies, Colors.teal),
                const SizedBox(width: 16),
                _buildStatCard("Pending Companies", pendingCompanies, Colors.orange),
              ],
            ),
            const SizedBox(height: 16),

            // Row 3: Warranty & Claims
            Row(
              children: [
                _buildStatCard("Total Warranty", totalWarranty, Colors.purple),
                const SizedBox(width: 16),
                _buildStatCard("Total Claims", totalClaims, Colors.red),
              ],
            ),

                    ],
        ),
      ),
    );
  }

  // Widget to build statistic cards
  Widget _buildStatCard(String title, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
