import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_dashboard.dart';

class VendorApprovalStatusScreen extends StatefulWidget {
  const VendorApprovalStatusScreen({super.key});

  @override
  State<VendorApprovalStatusScreen> createState() =>
      _VendorApprovalStatusScreenState();
}

class _VendorApprovalStatusScreenState
    extends State<VendorApprovalStatusScreen> {
  String _status = "pending"; 
  // Possible values: "pending", "approved", "rejected"
  // Later, replace with API response

  @override
  void initState() {
    super.initState();
    _checkApprovalStatus();
  }

  void _checkApprovalStatus() async {
    // 🔹 Replace this section with API call to check vendor status
    await Future.delayed(const Duration(seconds: 2));

    // Example simulation: admin approved vendor
    setState(() {
      _status = "approved"; // change this to "pending" or "rejected" for testing
    });

    if (_status == "approved") {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const VendorDashboardScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_status == "pending") {
      body = _buildStatusCard(
        title: "Approval Pending",
        icon: Icons.hourglass_empty,
        color: Colors.orange,
        message:
            "Your vendor account is under review.\nPlease wait for admin approval.",
      );
    } else if (_status == "rejected") {
      body = _buildStatusCard(
        title: "Rejected",
        icon: Icons.cancel,
        color: AppColors.primary,
        message:
            "Your vendor application has been rejected.\nPlease contact support for more info.",
      );
    } else {
      body = _buildStatusCard(
        title: "Approved",
        icon: Icons.check_circle,
        color: Colors.green,
        message: "Congratulations! Redirecting to your dashboard...",
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(child: body),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required IconData icon,
    required Color color,
    required String message,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 80),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            if (_status == "rejected") ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: retry / resubmit form
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Resubmit Details"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
