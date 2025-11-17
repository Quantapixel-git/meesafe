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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop View
        if (constraints.maxWidth >= 800) {
          return _buildDesktopView(context);
        }

        // Mobile View (YOUR ORIGINAL CODE)
        return _buildMobileView(context);
      },
    );
  }

  // --------------------------------------------------------------------------
  // ✅ MOBILE VIEW (YOUR EXISTING CODE – NOT TOUCHED)
  // --------------------------------------------------------------------------
  Widget _buildMobileView(BuildContext context) {
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
            Row(
              children: [
                _buildStatCard("Total Users", totalUsers, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard("Total Companies", totalCompanies, Colors.green),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _buildStatCard("Approved Companies", approvedCompanies, Colors.teal),
                const SizedBox(width: 16),
                _buildStatCard("Pending Companies", pendingCompanies, Colors.orange),
              ],
            ),
            const SizedBox(height: 16),

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

  // --------------------------------------------------------------------------
  // ✅ DESKTOP VIEW (NEW UI)
  // --------------------------------------------------------------------------
  Widget _buildDesktopView(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),
      body: Row(
        children: [
          // Drawer sidebar fixed on the left
          SizedBox(
            width: 250,
            child: AdminDrawer(),
          ),

          // Main content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Responsive Grid (3 Columns)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columnCount = 3;

                      if (constraints.maxWidth < 1100) {
                        columnCount = 2;
                      }
                      if (constraints.maxWidth < 800) {
                        columnCount = 1;
                      }

                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: columnCount,
                        childAspectRatio: 2,
                        children: [
                          _desktopStatCard("Total Users", totalUsers, Colors.blue),
                          _desktopStatCard("Total Companies", totalCompanies, Colors.green),
                          _desktopStatCard("Approved Companies", approvedCompanies, Colors.teal),
                          _desktopStatCard("Pending Companies", pendingCompanies, Colors.orange),
                          _desktopStatCard("Total Warranty", totalWarranty, Colors.purple),
                          _desktopStatCard("Total Claims", totalClaims, Colors.red),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // MOBILE CARD (NO CHANGE)
  // --------------------------------------------------------------------------
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

  // --------------------------------------------------------------------------
  // DESKTOP CARD (Wide Layout)
  // --------------------------------------------------------------------------
  Widget _desktopStatCard(String title, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 8),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
