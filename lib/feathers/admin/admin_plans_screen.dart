import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminPlansScreen extends StatefulWidget {
  const AdminPlansScreen({super.key});

  @override
  State<AdminPlansScreen> createState() => _AdminPlansScreenState();
}

class _AdminPlansScreenState extends State<AdminPlansScreen> {
  final List<Map<String, dynamic>> _plans = [
    {
      "id": 1,
      "name": "Basic Plan",
      "role": "Vendor",
      "amount": 199,
      "features": "Access to limited tools",
      "duration": "1 Month",
    },
    {
      "id": 2,
      "name": "Premium Plan",
      "role": "Branch Owner",
      "amount": 499,
      "features": "All tools + Priority Support",
      "duration": "3 Months",
    },
  ];

  Future<void> _navigateToAddOrEdit({Map<String, dynamic>? existingPlan}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditPlanScreen(plan: existingPlan),
      ),
    );

    if (result != null) {
      setState(() {
        if (existingPlan == null) {
          // Add new plan
          _plans.add({
            "id": DateTime.now().millisecondsSinceEpoch,
            ...result,
          });
        } else {
          existingPlan.addAll(result);
        }
      });
    }
  }

  void _deletePlan(int id) {
    setState(() {
      _plans.removeWhere((plan) => plan["id"] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription Plans"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          final plan = _plans[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text("${plan["name"]} • ${plan["role"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹${plan["amount"]} • ${plan["duration"]}"),
                  const SizedBox(height: 4),
                  Text(plan["features"]),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _navigateToAddOrEdit(existingPlan: plan),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePlan(plan["id"]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddOrEdit(),
      ),
    );
  }
}
class AddEditPlanScreen extends StatefulWidget {
  final Map<String, dynamic>? plan;

  const AddEditPlanScreen({super.key, this.plan});

  @override
  State<AddEditPlanScreen> createState() => _AddEditPlanScreenState();
}

class _AddEditPlanScreenState extends State<AddEditPlanScreen> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _durationController;
  final List<TextEditingController> _featureControllers = [];
  String? _selectedRole;

  final List<String> _roles = ["Vendor", "Branch", "User"];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plan?["name"] ?? "");
    _amountController = TextEditingController(
        text: widget.plan?["amount"] != null
            ? widget.plan!["amount"].toString()
            : "");
    _durationController =
        TextEditingController(text: widget.plan?["duration"] ?? "");
    _selectedRole = widget.plan?["role"] ?? _roles.first;

    // Handle feature points (split string by newline or comma)
    final existingFeatures = widget.plan?["features"]?.toString().split("\n") ?? [];
    if (existingFeatures.isNotEmpty) {
      for (var feature in existingFeatures) {
        if (feature.trim().isNotEmpty) {
          _featureControllers.add(TextEditingController(text: feature.trim()));
        }
      }
    }
    if (_featureControllers.isEmpty) {
      _featureControllers.add(TextEditingController());
    }
  }

  void _addFeatureField() {
    setState(() {
      _featureControllers.add(TextEditingController());
    });
  }

  void _removeFeatureField(int index) {
    setState(() {
      _featureControllers.removeAt(index);
    });
  }

  void _savePlan() {
    final featuresList =
        _featureControllers.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();

    final planData = {
      "name": _nameController.text.trim(),
      "role": _selectedRole ?? "Vendor",
      "amount": double.tryParse(_amountController.text) ?? 0,
      "duration": _durationController.text.trim(),
      "features": featuresList.join("\n"),
    };
    Navigator.pop(context, planData);
  }

  InputDecoration _boxDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  BorderSide(color: AppColors.primary, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plan != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Plan" : "Add Plan"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: _boxDecoration("Plan Name"),
            ),
            const SizedBox(height: 16),

            // 🔹 Role Dropdown
            InputDecorator(
              decoration: _boxDecoration("Select Role"),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedRole,
                  isExpanded: true,
                  items: _roles
                      .map((role) =>
                          DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _amountController,
              decoration: _boxDecoration("Amount (₹)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _durationController,
              decoration: _boxDecoration("Duration"),
            ),
            const SizedBox(height: 24),

            // 🔹 Features list
            const Text(
              "Features (point wise)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Column(
              children: [
                for (int i = 0; i < _featureControllers.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _featureControllers[i],
                            decoration:
                                _boxDecoration("Feature ${i + 1}"),
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (_featureControllers.length > 1)
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: AppColors.primary),
                            onPressed: () => _removeFeatureField(i),
                          ),
                      ],
                    ),
                  ),
                TextButton.icon(
                  onPressed: _addFeatureField,
                  icon:  Icon(Icons.add_circle, color: AppColors.primary),
                  label:  Text("Add Feature",
                      style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 🔹 Save Button
            ElevatedButton.icon(
              onPressed: _savePlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.save,color: Colors.white,),
              label: Text(isEditing ? "Update Plan" : "Add Plan",style: TextStyle(color: Colors.white,),),
            ),
          ],
        ),
      ),
    );
  }
}
