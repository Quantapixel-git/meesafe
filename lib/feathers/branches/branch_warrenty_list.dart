import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mee_safe/feathers/branches/brach_drawer_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BranchWarrentyList extends StatefulWidget {
  final bool isManager; // true = Manager, false = Executive
  const BranchWarrentyList({super.key, this.isManager = false});

  @override
  State<BranchWarrentyList> createState() => _BranchWarrentyListState();
}

class _BranchWarrentyListState extends State<BranchWarrentyList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  // Dummy data
  final List<Map<String, dynamic>> warranties = [
    {
      "warrantyNo": "WNT-1001",
      "customer": "John Doe",
      "product": "AC Model X123",
      "order": "ORD-1001",
      "status": "Active"
    },
    {
      "warrantyNo": "WNT-1002",
      "customer": "Priya Sharma",
      "product": "Refrigerator R230",
      "order": "ORD-1002",
      "status": "Expired"
    },
    {
      "warrantyNo": "WNT-1003",
      "customer": "Rahul Mehta",
      "product": "TV Model T900",
      "order": "ORD-1003",
      "status": "Pending"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         drawer: BranchDrawerScreen(role: 'Manager'),
      appBar: AppBar(
        title: const Text(
          "Warranty List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Expired"),
            Tab(text: "Pending Verification"),
          ],
        ),
      ),

      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    "Search by warranty number",
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

          // 📋 Warranty Tabs Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWarrantyList("Active"),
                _buildWarrantyList("Expired"),
                _buildWarrantyList("Pending"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔧 Warranty List Builder
  Widget _buildWarrantyList(String status) {
    final filtered = warranties.where((w) {
      final query = searchQuery.toLowerCase();
      return (w["status"].toLowerCase() == status.toLowerCase()) &&
          (w["warrantyNo"].toLowerCase().contains(query) ||
              w["customer"].toLowerCase().contains(query) ||
              w["product"].toLowerCase().contains(query) ||
              w["order"].toLowerCase().contains(query));
    }).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Text("No warranties found."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final w = filtered[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      w["warrantyNo"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor(w["status"]).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        w["status"],
                        style: TextStyle(
                            color: _statusColor(w["status"]),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("👤 Customer: ${w["customer"]}"),
                Text("📦 Product: ${w["product"]}"),
                Text("🧾 Order: ${w["order"]}"),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // View button (common for both roles)
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Navigate to warranty detail screen
                      },
                      icon: const Icon(Icons.visibility, color: Colors.blueAccent),
                      label: const Text("View",
                          style: TextStyle(color: Colors.blueAccent)),
                    ),

                    // Approve / Reject (Manager only for Pending)
                    if (widget.isManager && w["status"] == "Pending") ...[
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Approve warranty
                        },
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        label: const Text("Approve",
                            style: TextStyle(color: Colors.green)),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Reject warranty
                        },
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        label: const Text("Reject",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🎨 Status color helper
  Color _statusColor(String status) {
    switch (status) {
      case "Active":
        return Colors.green;
      case "Expired":
        return Colors.grey;
      case "Pending":
        return Colors.orangeAccent;
      default:
        return Colors.blueAccent;
    }
  }
}
class AddWarrantyScreen extends StatefulWidget {
  const AddWarrantyScreen({super.key});

  @override
  State<AddWarrantyScreen> createState() => _AddWarrantyScreenState();
}

class _AddWarrantyScreenState extends State<AddWarrantyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController warrantyNoController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();

  String? selectedCustomer;
  String? selectedProduct;
  String? selectedOrder;
  File? selectedImage;

  final picker = ImagePicker();

  // Dummy dropdown data
  final List<String> customers = ["John Doe", "Priya Sharma", "Rahul Mehta"];
  final List<String> products = ["AC Model X123", "Refrigerator R230", "TV Model T900"];
  final List<String> orders = ["ORD-1001", "ORD-1002", "ORD-1003"];

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

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          "Add Warranty",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Warranty Number
              _buildTextField(
                label: "Warranty Number",
                controller: warrantyNoController,
                hint: "Enter warranty number",
              ),
              const SizedBox(height: 16),

              // Customer Dropdown
              _buildDropdown(
                label: "Select Customer",
                value: selectedCustomer,
                items: customers,
                onChanged: (value) => setState(() => selectedCustomer = value),
              ),
              const SizedBox(height: 16),

              // Product Dropdown
              _buildDropdown(
                label: "Select Product",
                value: selectedProduct,
                items: products,
                onChanged: (value) => setState(() => selectedProduct = value),
              ),
              const SizedBox(height: 16),

              // Order Dropdown
              _buildDropdown(
                label: "Select Order Number",
                value: selectedOrder,
                items: orders,
                onChanged: (value) => setState(() => selectedOrder = value),
              ),
              const SizedBox(height: 16),

              // Purchase Date
              _buildDatePickerField(
                label: "Purchase Date",
                controller: purchaseDateController,
                onTap: () => _pickDate(purchaseDateController),
              ),
              const SizedBox(height: 16),

              // Expiry Date
              _buildDatePickerField(
                label: "Expiry Date",
                controller: expiryDateController,
                onTap: () => _pickDate(expiryDateController),
              ),
              const SizedBox(height: 24),

              // Upload Invoice
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upload Invoice / Proof Image",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey[800]),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.upload_file,
                                size: 40, color: Colors.blueAccent),
                            SizedBox(height: 8),
                            Text("Tap to upload image",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Submit logic here
                    }
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text(
                    "Submit Warranty",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🧱 Custom Widgets

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800])),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: (value) =>
              value == null || value.isEmpty ? "Please enter $label" : null,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: const Text("Select"),
              isExpanded: true,
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800])),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          validator: (value) =>
              value == null || value.isEmpty ? "Please select $label" : null,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: "Select date",
            prefixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
