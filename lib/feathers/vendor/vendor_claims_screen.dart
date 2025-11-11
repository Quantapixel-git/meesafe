import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class VendorClaimsScreen extends StatelessWidget {
  const VendorClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy claim list for UI demonstration
    final claims = [
      {
        "product": "LED Smart TV (VisionX 55)",
        "customer": "Rahul Sharma",
        "status": "Approved",
        "warrantyExpiry": "12 Oct 2026",
        "claimDate": "25 Sep 2025",
      },
      {
        "product": "Washing Machine (WMX-500)",
        "customer": "Priya Patel",
        "status": "Pending",
        "warrantyExpiry": "03 Aug 2026",
        "claimDate": "28 Oct 2025",
      },
      {
        "product": "Air Conditioner (CoolMax A15)",
        "customer": "Arjun Singh",
        "status": "Rejected",
        "warrantyExpiry": "20 May 2026",
        "claimDate": "14 Oct 2025",
      },
    ];

    Color _statusColor(String status) {
      switch (status) {
        case "Approved":
          return Colors.green;
        case "Pending":
          return Colors.orange;
        case "Rejected":
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Warranty Claims "),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: claims.length,
        itemBuilder: (context, index) {
          final claim = claims[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          claim["product"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          color: _statusColor(claim["status"]!).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          claim["status"]!,
                          style: TextStyle(
                            color: _statusColor(claim["status"]!),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Customer details
                  Text(
                    "Customer: ${claim["customer"]}",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Claim Date: ${claim["claimDate"]}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Warranty Expiry: ${claim["warrantyExpiry"]}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon:  Icon(Icons.edit, color: AppColors.primary),
                          label:  Text(
                            "Update Details",
                            style: TextStyle(color: AppColors.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            side:  BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // Navigate to edit warranty details page
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.history),
                          label: const Text("View History"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // Navigate to view history page
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
