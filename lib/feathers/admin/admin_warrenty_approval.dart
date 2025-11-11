import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminWarrantyApprovalScreen extends StatefulWidget {
  const AdminWarrantyApprovalScreen({super.key});

  @override
  State<AdminWarrantyApprovalScreen> createState() =>
      _AdminWarrantyApprovalScreenState();
}

class _AdminWarrantyApprovalScreenState
    extends State<AdminWarrantyApprovalScreen>
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

  void _updateStatus(int id, String newStatus) {
    setState(() {
      final item = warrantyRequests.firstWhere((e) => e['id'] == id);
      item['status'] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newStatus == 'Approved'
              ? "✅ Warranty approved successfully!"
              : "❌ Warranty rejected.",
        ),
        backgroundColor:
            newStatus == 'Approved' ? Colors.green : AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warranty Approvals"),
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
          _buildWarrantyList("Pending"),
          _buildWarrantyList("Approved"),
          _buildWarrantyList("Rejected"),
        ],
      ),
    );
  }

  Widget _buildWarrantyList(String status) {
    final filtered = warrantyRequests
        .where((item) => item['status'] == status)
        .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No $status warranties.",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['device'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("User: ${item['user_name']}"),
                Text("IMEI 1: ${item['imei1']}"),
                Text("IMEI 2: ${item['imei2']}"),
                Text("Purchased For: ${item['purchased_for']}"),
                Text("Manufacturing Year: ${item['year']}"),
                const Divider(height: 20),

                Row(
                  children: [
                    Icon(
                      item['document_uploaded']
                          ? Icons.verified
                          : Icons.warning_amber_rounded,
                      color: item['document_uploaded']
                          ? Colors.green
                          : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(item['document_uploaded']
                        ? "Documents uploaded"
                        : "No documents provided"),
                  ],
                ),
                const SizedBox(height: 12),

                if (status == "Pending")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => _updateStatus(item['id'], 'Approved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Approve"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _updateStatus(item['id'], 'Rejected'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Reject"),
                      ),
                    ],
                  )
                else
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: status == "Approved"
                            ? Colors.green.withOpacity(0.15)
                            : Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: status == "Approved"
                              ? Colors.green[800]
                              : Colors.red[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
