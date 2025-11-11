import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminClaimApprovalScreen extends StatefulWidget {
  const AdminClaimApprovalScreen({super.key});

  @override
  State<AdminClaimApprovalScreen> createState() =>
      _AdminClaimApprovalScreenState();
}

class _AdminClaimApprovalScreenState extends State<AdminClaimApprovalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> claims = [
    {
      "id": 1,
      "user_name": "John Doe",
      "imei": "123456789012345",
      "issue": "Screen not working after 2 weeks of purchase.",
      "image": null,
      "status": "Pending",
      "refundEligible": true,
    },
    {
      "id": 2,
      "user_name": "Jane Smith",
      "imei": "987654321098765",
      "issue": "Device overheating during charging.",
      "image": null,
      "status": "Approved",
      "refundEligible": false,
    },
    {
      "id": 3,
      "user_name": "Michael Lee",
      "imei": "555666777888999",
      "issue": "Battery draining quickly.",
      "image": null,
      "status": "Rejected",
      "refundEligible": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _viewClaimDetails(Map<String, dynamic> claim) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Claim Details - IMEI: ${claim['imei']}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("👤 User: ${claim['user_name']}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("📄 Issue: ${claim['issue']}"),
              const SizedBox(height: 12),
              claim['image'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        claim['image'] as File,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Text("📷 No image uploaded"),
              const SizedBox(height: 16),
              Text(
                "Refund Eligible: ${claim['refundEligible'] ? "Yes" : "No"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: claim['refundEligible'] ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          if (claim['status'] == "Pending") ...[
            ElevatedButton.icon(
              onPressed: () {
                _updateClaimStatus(claim, true);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check_circle),
              label: const Text("Approve"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _rejectClaimWithReason(claim);
              },
              icon: const Icon(Icons.cancel),
              label: const Text("Reject"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  void _rejectClaimWithReason(Map<String, dynamic> claim) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reject Claim"),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: "Enter Rejection Reason",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _updateClaimStatus(claim, false,
                  rejectionReason: reasonController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Reject Claim"),
          ),
        ],
      ),
    );
  }

  void _updateClaimStatus(Map<String, dynamic> claim, bool approved,
      {String? rejectionReason}) {
    setState(() {
      final index = claims.indexWhere((c) => c['id'] == claim['id']);
      if (index != -1) {
        claims[index]['status'] = approved ? "Approved" : "Rejected";
        claims[index]['rejectionReason'] = rejectionReason;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approved
              ? (claim['refundEligible']
                  ? "✅ Claim approved — Refund or repair initiated."
                  : "✅ Claim approved — Repair process started.")
              : "❌ Claim rejected${claim['refundEligible'] ? ' — No refund as per policy.' : '.'}",
        ),
        backgroundColor: approved ? Colors.green : AppColors.primary,
      ),
    );
  }

  Widget _buildClaimCard(Map<String, dynamic> claim) {
    Color statusColor;
    switch (claim['status']) {
      case "Approved":
        statusColor = Colors.green;
        break;
      case "Rejected":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.assignment, color: AppColors.primary),
        title: Text("IMEI: ${claim['imei']}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User: ${claim['user_name']}"),
            Text("Status: ${claim['status']}",
                style: TextStyle(color: statusColor)),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _viewClaimDetails(claim),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text("View"),
        ),
      ),
    );
  }

  Widget _buildClaimList(String status) {
    final filteredClaims =
        claims.where((claim) => claim['status'] == status).toList();

    if (filteredClaims.isEmpty) {
      return Center(
        child: Text(
          "No $status claims found.",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredClaims.length,
      itemBuilder: (context, index) =>
          _buildClaimCard(filteredClaims[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Claim Approvals"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Approved"),
            Tab(text: "Rejected"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClaimList("Pending"),
          _buildClaimList("Approved"),
          _buildClaimList("Rejected"),
        ],
      ),
    );
  }
}
