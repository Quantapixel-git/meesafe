import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';

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

  // ============================================================================
  // VIEW CLAIM DETAILS POPUP
  // ============================================================================
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

  // ============================================================================
  // REJECT WITH REASON
  // ============================================================================
  void _rejectClaimWithReason(Map<String, dynamic> claim) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reject Claim"),
        content: TextField(
          controller: controller,
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
                  rejectionReason: controller.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Reject Claim"),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UPDATE STATUS
  // ============================================================================
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
                  : "✅ Claim approved — Repair started.")
              : "❌ Claim rejected.",
        ),
        backgroundColor: approved ? Colors.green : Colors.red,
      ),
    );
  }

  // ============================================================================
  // DESKTOP TAB BAR (BEAUTIFUL)
  // ============================================================================
  Widget _desktopTabBar() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _desktopTab("Pending", 0),
          const SizedBox(width: 16),
          _desktopTab("Approved", 1),
          const SizedBox(width: 16),
          _desktopTab("Rejected", 2),
        ],
      ),
    );
  }

  Widget _desktopTab(String title, int index) {
    final selected = _tabController.index == index;

    return InkWell(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {});
      },
      borderRadius: BorderRadius.circular(40),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? AppColors.primary : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // CLAIM CARD UI (RESPONSIVE)
  // ============================================================================
  Widget _buildClaimCard(Map<String, dynamic> claim, bool isDesktop) {
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

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("IMEI: ${claim['imei']}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text("User: ${claim['user_name']}"),
          Text("Status: ${claim['status']}",
              style: TextStyle(color: statusColor)),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => _viewClaimDetails(claim),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child: const Text("View",style: TextStyle(color: Colors.white),),
            ),
          ),
          // EXTRA ADMIN CONTENT
const SizedBox(height: 10),

Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: const [
          Icon(Icons.info_outline, size: 18, color: Colors.black54),
          SizedBox(width: 6),
          Text(
            "Issue Details",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      const SizedBox(height: 6),
      Text(
        claim["issue"] ?? "-",
        style: const TextStyle(color: Colors.black87),
      ),
    ],
  ),
),

const SizedBox(height: 12),

Row(
  children: [
    Icon(
      claim['refundEligible'] ? Icons.check_circle : Icons.cancel,
      color: claim['refundEligible'] ? Colors.green : Colors.red,
      size: 18,
    ),
    const SizedBox(width: 6),
    Text(
      claim['refundEligible']
          ? "Refund Eligible"
          : "Not Eligible for Refund",
      style: TextStyle(
        color: claim['refundEligible'] ? Colors.green : Colors.red,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),

const SizedBox(height: 12),

Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: Colors.white,
    border: Border.all(color: Colors.black12),
  ),
  child: Row(
    children: [
      const Icon(Icons.verified, color: Colors.green, size: 20),
      const SizedBox(width: 8),
      Text(
        "Documents Uploaded",
        style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),

        ],
      ),
    );
  }

  // ============================================================================
  // LIST BUILDER - DESKTOP = GRID | MOBILE = LIST
  // ============================================================================
  Widget _buildClaimList(String status, bool isDesktop) {
    final filtered =
        claims.where((claim) => claim['status'] == status).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Text("No claims found.",
            style: TextStyle(fontSize: 16, color: Colors.grey)),
      );
    }

    if (isDesktop) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: filtered.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (_, i) => _buildClaimCard(filtered[i], true),
          ),
        ),
      );
    }

    // MOBILE LIST
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (_, i) => _buildClaimCard(filtered[i], false),
    );
  }

  // ============================================================================
  // BUILD
  // ============================================================================
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth >= 900;

      return Scaffold(
        drawer: isDesktop ? null : const AdminDrawer(),

        appBar: AppBar(
          title: const Text("Admin Claim Approvals"),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: isDesktop ? 5 : 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: isDesktop
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _desktopTabBar(),
                  )
                : TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    tabs: const [
                      Tab(text: "Pending"),
                      Tab(text: "Approved"),
                      Tab(text: "Rejected"),
                    ],
                  ),
          ),
        ),

        body: Row(
          children: [
            if (isDesktop)
              const SizedBox(width: 250, child: AdminDrawer()),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildClaimList("Pending", isDesktop),
                  _buildClaimList("Approved", isDesktop),
                  _buildClaimList("Rejected", isDesktop),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
