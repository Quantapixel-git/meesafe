import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchCustomer extends StatefulWidget {
  final bool isManager;
  const BranchCustomer({super.key, this.isManager = true});

  @override
  State<BranchCustomer> createState() => _BranchCustomerState();
}

class _BranchCustomerState extends State<BranchCustomer> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> customers = [
    {
      "name": "John Doe",
      "contact": "+91 9876543210",
      "warrantyCount": 3,
      "orderNumber": "ORD-10234"
    },
    {
      "name": "Priya Sharma",
      "contact": "+91 9988776655",
      "warrantyCount": 1,
      "orderNumber": "ORD-10235"
    },
    {
      "name": "Rahul Mehta",
      "contact": "+91 9123456789",
      "warrantyCount": 2,
      "orderNumber": "ORD-10236"
    },
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredCustomers = customers.where((customer) {
      final query = searchQuery.toLowerCase();
      return customer["name"].toLowerCase().contains(query) ||
          customer["contact"].toLowerCase().contains(query) ||
          customer["orderNumber"].toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          'Customers',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,

        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      drawer: BranchDrawerScreen(role: 'Manager'),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search by phone number",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🧾 Customer List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: filteredCustomers.length,
              itemBuilder: (context, index) {
                final customer = filteredCustomers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 26,
                      foregroundColor: AppColors.primary,
                      child: Text(
                        customer["name"].substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: AppColors.primary,),
                      ),
                    ),
                    title: Text(
                      customer["name"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text("📞 ${customer["contact"]}"),
                        Text("🧾 Order: ${customer["orderNumber"]}"),
                        Text("🔧 Warranties: ${customer["warrantyCount"]}"),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to customer details page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.primary,
                        foregroundColor:AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("View"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
