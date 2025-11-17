import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth >= 900;

      return Scaffold(
        drawer: isDesktop ? null : const AdminDrawer(),

        // ------------------------------ APPBAR ------------------------------
        appBar: AppBar(
          elevation: isDesktop ? 5 : 0,
          titleSpacing: isDesktop ? 20 : 0,
          toolbarHeight: isDesktop ? 70 : kToolbarHeight,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: Text(
            "Warranty Approvals",
            style: TextStyle(
              fontSize: isDesktop ? 24 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 30 : 16,
                vertical: 6,
              ),
              alignment: Alignment.centerLeft,
              child: _buildTabBar(isDesktop),
            ),
          ),
        ),

        // ------------------------------ BODY ------------------------------
        body: Row(
          children: [
            if (isDesktop)
              SizedBox(width: 250, child: const AdminDrawer()),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildWarrantyList("Pending", isDesktop),
                  _buildWarrantyList("Approved", isDesktop),
                  _buildWarrantyList("Rejected", isDesktop),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

 // ------------------------------ DESKTOP TAB STYLE ------------------------------
Widget _buildTabBar(bool isDesktop) {
  if (!isDesktop) {
    // MOBILE = unchanged (original TabBar)
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.white,
      tabs: const [
        Tab(text: "Pending"),
        Tab(text: "Approved"),
        Tab(text: "Rejected"),
      ],
    );
  }

  // DESKTOP = centered & premium pills
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: selected ? Colors.white : Colors.white.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: selected ? AppColors.primary : Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
  );
}

  // ------------------------------ WARRANTY LIST ------------------------------
  Widget _buildWarrantyList(String status, bool isDesktop) {
    final filtered =
        warrantyRequests.where((item) => item['status'] == status).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No $status warranties.",
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 45 : 16,
        vertical: 20,
      ),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final item = filtered[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------ TITLE ROW ------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['device'],
                      style: TextStyle(
                        fontSize: isDesktop ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStatusChip(status),
                  ],
                ),
                const SizedBox(height: 12),

                // ------------------ GRID INFO ------------------
                LayoutBuilder(builder: (context, box) {
                  final twoColumn = box.maxWidth > 500;

                  return Column(
                    children: [
                      Row(
                        children: [
                          _info("User", item['user_name'], twoColumn),
                          if (twoColumn) const SizedBox(width: 30),
                          _info("Purchased For", item['purchased_for'], twoColumn),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _info("IMEI 1", item['imei1'], twoColumn),
                          if (twoColumn) const SizedBox(width: 30),
                          _info("IMEI 2", item['imei2'], twoColumn),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _info("Manufacturing Year", item['year'], twoColumn),
                        ],
                      )
                    ],
                  );
                }),

                const Divider(height: 30),

                // ------------------ DOCUMENT INFO ------------------
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
                    const SizedBox(width: 10),
                    Text(
                      item['document_uploaded']
                          ? "Documents uploaded"
                          : "No documents provided",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ------------------ APPROVE | REJECT ------------------
                if (status == "Pending")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            _updateStatus(item['id'], 'Approved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Approve"),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () =>
                            _updateStatus(item['id'], 'Rejected'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Reject"),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ------------------------------ SMALL UI HELPERS ------------------------------
  Widget _info(String label, String value, bool twoColumn) {
    return Expanded(
      flex: twoColumn ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          "$label: $value",
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg, text;

    if (status == "Approved") {
      bg = Colors.green.withOpacity(0.15);
      text = Colors.green[800]!;
    } else if (status == "Rejected") {
      bg = Colors.red.withOpacity(0.15);
      text = Colors.red[800]!;
    } else {
      bg = Colors.orange.withOpacity(0.15);
      text = Colors.orange[800]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
