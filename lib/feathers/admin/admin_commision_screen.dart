import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class Vendor {
  final int id;
  final String name;

  Vendor({required this.id, required this.name});
}

class Commission {
  final Vendor vendor;
  final double percentage;

  Commission({required this.vendor, required this.percentage});
}

class AdminCommissionScreen extends StatefulWidget {
  const AdminCommissionScreen({super.key});

  @override
  State<AdminCommissionScreen> createState() => _AdminCommissionScreenState();
}

class _AdminCommissionScreenState extends State<AdminCommissionScreen> {
  final _formKey = GlobalKey<FormState>();

  Vendor? selectedVendor;
  final TextEditingController commissionController = TextEditingController();

  // Sample vendor list
  final List<Vendor> vendors = [
    Vendor(id: 1, name: "Vendor A"),
    Vendor(id: 2, name: "Vendor B"),
    Vendor(id: 3, name: "Vendor C"),
  ];

  // Existing commissions
  final List<Commission> commissions = [];

  void _saveCommission() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final existingIndex =
            commissions.indexWhere((c) => c.vendor.id == selectedVendor!.id);
        final commissionValue =
            double.tryParse(commissionController.text.trim()) ?? 0.0;

        if (existingIndex >= 0) {
          commissions[existingIndex] =
              Commission(vendor: selectedVendor!, percentage: commissionValue);
        } else {
          commissions.add(
              Commission(vendor: selectedVendor!, percentage: commissionValue));
        }

        commissionController.clear();
        selectedVendor = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Commission saved successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Commission"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Vendor dropdown
                  DropdownButtonFormField<Vendor>(
                    value: selectedVendor,
                    decoration: InputDecoration(
                      labelText: "Select Vendor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    items: vendors
                        .map((v) => DropdownMenuItem(
                              value: v,
                              child: Text(v.name),
                            ))
                        .toList(),
                    validator: (val) =>
                        val == null ? "Please select a vendor" : null,
                    onChanged: (val) {
                      setState(() {
                        selectedVendor = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Commission input
                  TextFormField(
                    controller: commissionController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Commission (%)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter commission";
                      }
                      final number = double.tryParse(val);
                      if (number == null || number < 0 || number > 100) {
                        return "Enter a valid percentage (0-100)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _saveCommission,
                      child: const Text(
                        "Save Commission",
                        style: TextStyle(fontSize: 16,color : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Existing Commissions",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // List of existing commissions
            commissions.isEmpty
                ? const Text("No commissions set yet")
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: commissions.length,
                    itemBuilder: (context, index) {
                      final commission = commissions[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(commission.vendor.name),
                          subtitle:
                              Text("${commission.percentage.toString()}%"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                commissions.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Commission removed")),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
