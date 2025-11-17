import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart'; // << ADD YOUR DRAWER HERE

class CompanyApprovalScreen extends StatefulWidget {
  const CompanyApprovalScreen({super.key});

  @override
  State<CompanyApprovalScreen> createState() => _CompanyApprovalScreenState();
}

class _CompanyApprovalScreenState extends State<CompanyApprovalScreen> {
  // --- Static sample company data
  List<Map<String, dynamic>> companies = [
    {
      "name": "QuantaPixel Pvt. Ltd.",
      "email": "info@quantapixel.com",
      "status": "Pending",
      "logo": "https://via.placeholder.com/80x80.png?text=Q"
    },
    {
      "name": "TechNova Solutions",
      "email": "contact@technova.in",
      "status": "Approved",
      "logo": "https://via.placeholder.com/80x80.png?text=T"
    },
    {
      "name": "SmartEdge Systems",
      "email": "support@smartedge.com",
      "status": "Rejected",
      "logo": "https://via.placeholder.com/80x80.png?text=S"
    },
  ];

  void updateStatus(int index, String newStatus) {
    setState(() {
      companies[index]['status'] = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Company status updated to $newStatus")),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Company Approvals"),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            centerTitle: true,
          ),

          // MOBILE → drawer works normally
          // DESKTOP → drawer stays permanently visible
          drawer: isDesktop ? null : const AdminDrawer(),

          body: Row(
            children: [
              // ------------------- DESKTOP DRAWER AS SIDEBAR -------------------
              if (isDesktop)
                SizedBox(
                  width: 250,
                  child: const AdminDrawer(),
                ),

              // ------------------- MAIN CONTENT AREA ---------------------------
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraint2) {
                    if (constraint2.maxWidth < 700) {
                      return _buildMobileUI();
                    }
                    return _buildWebUI();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 📱 MOBILE VERSION (Your original code kept same)
  // ---------------------------------------------------------------------------
  Widget _buildMobileUI() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(company['logo']),
              radius: 28,
            ),
            title: Text(company['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(company['email']),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _statusColor(company['status']).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                company['status'],
                style: TextStyle(
                  color: _statusColor(company['status']),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            onTap: () => _showActionDialog(index),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 🖥 WEB / DESKTOP VERSION (with table layout)
  // ---------------------------------------------------------------------------
  Widget _buildWebUI() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Expanded(flex: 2, child: Text("Company Name", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 120, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: ListView.separated(
              itemCount: companies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final company = companies[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      // Company Name + Logo
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(company['logo']),
                              radius: 26,
                            ),
                            const SizedBox(width: 14),
                            Text(company['name'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),

                      // Email
                      Expanded(flex: 2, child: Text(company['email'])),

                      // Status Tag
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _statusColor(company['status']).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(company['status'],
                              style: TextStyle(
                                  color: _statusColor(company['status']),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),

                      // Action Buttons
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.check_circle, color: Colors.green),
                                onPressed: () => updateStatus(index, "Approved")),
                            IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () => updateStatus(index, "Rejected")),
                            IconButton(
                                icon: const Icon(Icons.pending, color: Colors.orange),
                                onPressed: () => updateStatus(index, "Pending")),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dialog (Mobile + Web)
  // ---------------------------------------------------------------------------
  void _showActionDialog(int index) {
    final company = companies[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(company['name']),
          content: const Text("Select the company approval status:"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateStatus(index, "Approved");
                },
                child: const Text("Approve", style: TextStyle(color: Colors.green))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateStatus(index, "Rejected");
                },
                child: const Text("Reject", style: TextStyle(color: Colors.red))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateStatus(index, "Pending");
                },
                child: const Text("Pending", style: TextStyle(color: Colors.orange))),
          ],
        );
      },
    );
  }
}
