import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminGraphicalScreen extends StatefulWidget {
  const AdminGraphicalScreen({super.key});

  @override
  State<AdminGraphicalScreen> createState() => _AdminGraphicalScreenState();
}

class _AdminGraphicalScreenState extends State<AdminGraphicalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Overview'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
      ),
drawer: const AdminDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Warranty Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Registered', '1,240', Icons.devices, Colors.blue),
                _buildStatCard('Active', '980', Icons.verified, Colors.green),
                _buildStatCard('Expired', '260', Icons.warning, AppColors.primary),
              ],
            ),
            const SizedBox(height: 25),

            // Pie Chart Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Warranty Status Breakdown',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 1240,
                            title: 'Registered',
                            radius: 50,
                            titleStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: 980,
                            title: 'Active',
                            radius: 50,
                            titleStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          PieChartSectionData(
                            color: AppColors.primary,
                            value: 260,
                            title: 'Expired',
                            radius: 50,
                            titleStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
