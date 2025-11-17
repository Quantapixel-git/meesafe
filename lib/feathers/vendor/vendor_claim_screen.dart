import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_drawer.dart';

class VendorClaimScreen extends StatefulWidget {
  const VendorClaimScreen({super.key});

  @override
  State<VendorClaimScreen> createState() =>
      _VendorClaimScreenState();
}

class _VendorClaimScreenState extends State<VendorClaimScreen>
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
  bool isWeb = MediaQuery.of(context).size.width > 900;

  // ------------------ WEB VERSION ------------------
  if (isWeb) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FF),
      body: Row(
        children: [
          // LEFT PERMANENT SIDEBAR
          VendorDrawer(),

          // RIGHT CONTENT AREA
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "Claim Approvals",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // ----------------- TABS -----------------
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Pending"),
                      Tab(text: "Approved"),
                      Tab(text: "Rejected"),
                    ],
                  ),
                ),

                // ----------------- TAB CONTENT -----------------
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildWebList("Pending"),
                      _buildWebList("Approved"),
                      _buildWebList("Rejected"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
  }

  // ------------------ MOBILE VERSION ------------------
  return Scaffold(
    appBar: AppBar(
      title: const Text("Claim Approvals"),
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
Widget _buildWebList(String status) {
  final filteredClaims = claims.where((c) => c['status'] == status).toList();

  if (filteredClaims.isEmpty) {
    return const Center(
      child: Text(
        "No claims found.",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  return ListView(
    padding: const EdgeInsets.all(30),
    children: filteredClaims.map((claim) {
      return Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // title shown in your screenshot (use user name or product name)
                  claim["user_name"] ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: claim["status"] == "Pending"
                        ? Colors.orange
                        : claim["status"] == "Approved"
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    claim["status"] ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Details block (imitates screenshot)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // left details column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User: ${claim['user_name'] ?? '-'}"),
                      const SizedBox(height: 6),
                      Text("IMEI: ${claim['imei'] ?? '-'}"),
                      const SizedBox(height: 6),
                      Text("Issue: ${claim['issue'] ?? '-'}"),
                      const SizedBox(height: 6),
                      Text("Refund Eligible: ${claim['refundEligible'] == true ? "Yes" : "No"}"),
                    ],
                  ),
                ),

                // optional image preview area
                if (claim['image'] != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        claim['image'] as File,
                        width: 160,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 18),
            const Divider(),

            // bottom row with status icon + actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.verified, color: Colors.green),
                    SizedBox(width: 8),
                    Text("Documents Uploaded"),
                  ],
                ),
                Row(
                  children: [
                    if (claim['status'] == "Pending") ...[
                      ElevatedButton(
                        onPressed: () => _updateClaimStatus(claim, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text("Approve"),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _rejectClaimWithReason(claim),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text("Reject"),
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () => _viewClaimDetails(claim),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        child: const Text("View Details"),
                      ),
                    ]
                  ],
                )
              ],
            ),
          ],
        ),
      );
    }).toList(),
  );
}



}
class _SideMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SideMenuItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
