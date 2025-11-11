import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchReportsScreen extends StatefulWidget {
  const BranchReportsScreen({super.key});

  @override
  State<BranchReportsScreen> createState() => _BranchReportsScreenState();
}

class _BranchReportsScreenState extends State<BranchReportsScreen> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  Future<void> _pickDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Example summary data (for UI)
    final int totalWarranties = 45;
    final int claimsApproved = 18;
    final int claimsRejected = 7;
    final int activeCustomers = 62;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          "Reports",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,

        foregroundColor: AppColors.white,
      ),
         drawer: BranchDrawerScreen(role: 'Manager'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📅 Date Filters
            const Text(
              "Filter by Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    label: "From",
                    controller: fromDateController,
                    onTap: () => _pickDate(fromDateController),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDateField(
                    label: "To",
                    controller: toDateController,
                    onTap: () => _pickDate(toDateController),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 📊 Summary Cards
            const Text(
              "Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildSummaryCard(
                  title: "Warranties (This Month)",
                  value: "$totalWarranties",
                  icon: Icons.verified_user,
                  color: Colors.blueAccent,
                ),
                _buildSummaryCard(
                  title: "Claims Approved",
                  value: "$claimsApproved",
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                _buildSummaryCard(
                  title: "Claims Rejected",
                  value: "$claimsRejected",
                  icon: Icons.cancel,
                  color: AppColors.primary,
                ),
                _buildSummaryCard(
                  title: "Active Customers",
                  value: "$activeCustomers",
                  icon: Icons.people,
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 32),

          
            // 🧾 Report Table (Sample Display)
            const Text(
              "Report Overview",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Category")),
                  DataColumn(label: Text("Count")),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text("Warranties Added")),
                    DataCell(Text(totalWarranties.toString())),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text("Claims Approved")),
                    DataCell(Text(claimsApproved.toString())),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text("Claims Rejected")),
                    DataCell(Text(claimsRejected.toString())),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text("Active Customers")),
                    DataCell(Text(activeCustomers.toString())),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧱 Custom Widgets

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 26,
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
