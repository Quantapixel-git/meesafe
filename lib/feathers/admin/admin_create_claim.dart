
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminCreateClaimScreen extends StatefulWidget {
  const AdminCreateClaimScreen({super.key});

  @override
  State<AdminCreateClaimScreen> createState() => _AdminCreateClaimScreenState();
}

class _AdminCreateClaimScreenState extends State<AdminCreateClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _contactController = TextEditingController();
  final _productController = TextEditingController();
  final _warrantyController = TextEditingController();
  final _issueController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();

  String _selectedStatus = "Pending";
  DateTime? _purchaseDate;
  DateTime? _claimDate = DateTime.now();

  Future<void> _pickDate(BuildContext context, bool isPurchase) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isPurchase ? DateTime.now() : _claimDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isPurchase) {
          _purchaseDate = pickedDate;
        } else {
          _claimDate = pickedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newClaim = {
        "claimId":
            "CLM-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        "customer": _customerController.text,
        "contact": _contactController.text,
        "product": _productController.text,
        "warrantyNo": _warrantyController.text,
        "issue": _issueController.text,
        "claimAmount": _amountController.text,
        "purchaseDate": _purchaseDate != null
            ? DateFormat('yyyy-MM-dd').format(_purchaseDate!)
            : '',
        "claimDate": _claimDate != null
            ? DateFormat('yyyy-MM-dd').format(_claimDate!)
            : '',
        "remarks": _remarksController.text,
        "status": _selectedStatus,
      };

      Navigator.pop(context, newClaim);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Create New Claim", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: _customerController,
                decoration: const InputDecoration(
                  labelText: "Customer Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter customer name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter contact number";
                  if (value.length < 10) return "Enter valid number";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _productController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter product name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _issueController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Issue Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please describe the issue" : null,
              ),
              const SizedBox(height: 16),

              // Purchase Date
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Purchase Date"),
                subtitle: Text(
                  _purchaseDate != null
                      ? DateFormat('yyyy-MM-dd').format(_purchaseDate!)
                      : "Select date",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, true),
                ),
              ),
              const SizedBox(height: 8),

              // Claim Date
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Claim Date"),
                subtitle: Text(
                  _claimDate != null
                      ? DateFormat('yyyy-MM-dd').format(_claimDate!)
                      : "Select date",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, false),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Claim Amount",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter claim amount" : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Pending", child: Text("Pending")),
                  DropdownMenuItem(value: "Approved", child: Text("Approved")),
                  DropdownMenuItem(value: "Rejected", child: Text("Rejected")),
                ],
                onChanged: (value) => setState(() {
                  _selectedStatus = value!;
                }),
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "Create Claim",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
