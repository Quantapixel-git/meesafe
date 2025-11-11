import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

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
      SnackBar(
        content: Text("Company status updated to $newStatus"),
      ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Approvals"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(company['logo']),
                radius: 28,
              ),
              title: Text(
                company['name'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(company['email']),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              onTap: () {
                // Optional: show company details
                _showActionDialog(index);
              },
            ),
          );
        },
      ),
    );
  }

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
              child: const Text(
                "Approve",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                updateStatus(index, "Rejected");
              },
              child: const Text(
                "Reject",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                updateStatus(index, "Pending");
              },
              child: const Text(
                "Pending",
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
