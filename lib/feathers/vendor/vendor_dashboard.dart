import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_drawer.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int activeWarranties = 42;
    final int expiredWarranties = 18;
    final int totalCustomers = 120;

    final int totalCompanyApproved = 100;

    final int totalCompanyPending = 20;
    final int totalProducts = 75;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Vendor Dashboard"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      drawer: const VendorDrawer(), 
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            // 🔹 Stats cards grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard(
                  "Active Warranties",
                  activeWarranties,
                  Icons.verified,
                  Colors.green,
                ),
                _buildStatCard(
                  "Expired Warranties",
                  expiredWarranties,
                  Icons.warning,
                  AppColors.primary,
                ),
                _buildStatCard(
                  "Total Companies",
                  totalCustomers,
                  Icons.people,
                  Colors.blue,
                ),
                 _buildStatCard(
                  "Company approved",
                  totalCompanyApproved,
                  Icons.people,
                  Colors.deepOrange,
                ),
                  _buildStatCard(
                  "Company Pending",
                  totalCompanyPending,
                  Icons.people,
                  Colors.deepOrange,
                ),
                _buildStatCard(
                  "Products",
                  totalProducts,
                  Icons.devices_other,
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Stat card widget
  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 🔹 Action button widget
  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
