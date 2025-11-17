import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_drawer.dart';

class VendorWarrantyScreen extends StatefulWidget {
  const VendorWarrantyScreen({super.key});

  @override
  State<VendorWarrantyScreen> createState() => _VendorWarrantyScreenState();
}

class _VendorWarrantyScreenState extends State<VendorWarrantyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> warrantyRequests = [
    {
      "id": 1,
      "user_name": "John Doe",
      "device": "Samsung S24",
      "imei1": "123456789012340",
      "imei2": "123456789012341",
      "purchased_for": "Other Person",
      "year": "2024",
      "document_uploaded": true,
      "status": "Pending",
    },
    {
      "id": 2,
      "user_name": "Alice Smith",
      "device": "OnePlus 12",
      "imei1": "987654321098765",
      "imei2": "987654321098766",
      "purchased_for": "Myself",
      "year": "2023",
      "document_uploaded": false,
      "status": "Approved",
    },
    {
      "id": 3,
      "user_name": "Bob Johnson",
      "device": "iPhone 15",
      "imei1": "112233445566778",
      "imei2": "112233445566779",
      "purchased_for": "Myself",
      "year": "2022",
      "document_uploaded": true,
      "status": "Rejected",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _updateStatus(int id, String status) {
    setState(() {
      final item = warrantyRequests.firstWhere((e) => e['id'] == id);
      item['status'] = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: Row(
        children: [
          // ----------------------------
          // LEFT SIDE : Permanent Drawer
          // ----------------------------
          if (isLargeScreen)
            SizedBox(
              width: 250,
              child: const VendorDrawer(),
            ),

          // ----------------------------
          // RIGHT SIDE : AppBar + Tabs
          // ----------------------------
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: !isLargeScreen,
                title: const Text("Warranty Approvals",
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.black),
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "Pending"),
                    Tab(text: "Approved"),
                    Tab(text: "Rejected"),
                  ],
                ),
              ),

              backgroundColor: const Color(0xffFAF6FF),

              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildWarrantyList("Pending"),
                  _buildWarrantyList("Approved"),
                  _buildWarrantyList("Rejected"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Warranty List
  Widget _buildWarrantyList(String status) {
    final filtered =
        warrantyRequests.where((e) => e['status'] == status).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Text("No data found.", style: TextStyle(fontSize: 16)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: filtered
                .map((item) => _buildWarrantyCard(item, status))
                .toList(),
          ),
        ),
      ),
    );
  }

  // Warranty Card
  Widget _buildWarrantyCard(Map<String, dynamic> item, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // General Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['device'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("User: ${item['user_name']}"),
                    Text("IMEI 1: ${item['imei1']}"),
                    Text("IMEI 2: ${item['imei2']}"),
                    Text("Manufacturing Year: ${item['year']}"),
                    Text("Purchased For: ${item['purchased_for']}"),
                  ],
                ),
              ),

              // Status Badge
              _buildStatusChip(item['status']),
            ],
          ),

          const SizedBox(height: 20),
          const Divider(),

          // Document Status Row
          Row(
            children: [
              Icon(
                item['document_uploaded']
                    ? Icons.verified
                    : Icons.cancel_outlined,
                color: item['document_uploaded'] ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10),
              Text(
                item['document_uploaded']
                    ? "Documents Uploaded"
                    : "Documents Missing",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Action Buttons (Only Pending)
          if (status == "Pending")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _actionButton("Approve", Colors.green,
                    () => _updateStatus(item['id'], "Approved")),
                const SizedBox(width: 12),
                _actionButton("Reject", AppColors.primary,
                    () => _updateStatus(item['id'], "Rejected")),
              ],
            )
        ],
      ),
    );
  }

  // Status Chip
  Widget _buildStatusChip(String status) {
    Color color = status == "Approved"
        ? Colors.green
        : status == "Pending"
            ? Colors.orange
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Action Buttons
  Widget _actionButton(String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 14, color: Colors.white)),
    );
  }
}
