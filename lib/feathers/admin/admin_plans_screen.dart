import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_drawer.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
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
    
    return LayoutBuilder(builder: (context, constraints) {
       final isDesktop = constraints.maxWidth >= 900;
      // ------------------ 📱 MOBILE (Original UI — unchanged) -------------------
      if (constraints.maxWidth < 700) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Subscription Plans"),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          body: _mobileUI(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add),
            onPressed: () => _navigateToAddOrEdit(),
          ),
        );
      }

      // ------------------ 🖥 DESKTOP / WEB VERSION -------------------
      return Scaffold(
        body: Row(
          children: [
 if (isDesktop)
                SizedBox(
                  width: 250,
                  child: const AdminDrawer(),
                ),


            Expanded(
              child: Column(
                children: [
                  _desktopHeader(),
                  Expanded(child: _desktopUI()),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
          onPressed: () => _navigateToAddOrEdit(),
        ),
      );
    });
  }

  // ---------------------------------------------------------------------------
  // 📱 MOBILE UI — ORIGINAL CODE (UNCHANGED)
  // ---------------------------------------------------------------------------
  Widget _mobileUI() {
    return ListView.builder(
      itemCount: _plans.length,
      itemBuilder: (context, index) {
        final plan = _plans[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(
              "${plan["name"]} • ${plan["role"]}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
    );
  }

  // ---------------------------------------------------------------------------
  // 🖥 DESKTOP UI — TABLE LAYOUT
  // ---------------------------------------------------------------------------
  Widget _desktopUI() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 6,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.1))
          ],
        ),
        child: DataTable(
          headingRowColor:
              WidgetStateProperty.all(Colors.grey.shade200),
          columns: const [
            DataColumn(label: Text("Plan Name")),
            DataColumn(label: Text("Role")),
            DataColumn(label: Text("Amount")),
            DataColumn(label: Text("Duration")),
            DataColumn(label: Text("Features")),
            DataColumn(label: Text("Actions")),
          ],
          rows: _plans.map((plan) {
            return DataRow(cells: [
              DataCell(Text(plan["name"])),
              DataCell(Text(plan["role"])),
              DataCell(Text("₹${plan["amount"]}")),
              DataCell(Text(plan["duration"])),
              DataCell(Text(plan["features"])),
              DataCell(
                Row(
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
            ]);
          }).toList(),
        ),
      ),
    );
  }

  

  // ---------------------------------------------------------------------------
  // 🖥 DESKTOP HEADER
  // ---------------------------------------------------------------------------
  Widget _desktopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: const Text(
        "Subscription Plans",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
      text: widget.plan?["amount"]?.toString() ?? "",
    );
    _durationController =
        TextEditingController(text: widget.plan?["duration"] ?? "");

    _selectedRole = widget.plan?["role"] ?? _roles.first;

    final existingFeatures =
        widget.plan?["features"]?.toString().split("\n") ?? [];
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
    final features = _featureControllers
        .map((c) => c.text.trim())
        .where((f) => f.isNotEmpty)
        .join("\n");

    Navigator.pop(context, {
      "name": _nameController.text.trim(),
      "role": _selectedRole,
      "amount": double.tryParse(_amountController.text) ?? 0,
      "duration": _durationController.text.trim(),
      "features": features,
    });
  }

  InputDecoration _box(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plan != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        // ----------------------- 📱 MOBILE VERSION (unchanged) -----------------------
        if (constraints.maxWidth < 700) {
          return _mobileUI(isEditing);
        }

        // ----------------------- 🖥 DESKTOP VERSION -----------------------
        return Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? "Edit Plan" : "Add Plan"),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          body: Center(
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: _formContent(isEditing),
            ),
          ),
        );
      },
    );
  }

  // Mobile Original UI wrapper
  Widget _mobileUI(bool isEditing) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Plan" : "Add Plan"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _formContent(isEditing),
      ),
    );
  }

  /// Shared form content for both mobile + desktop
  Widget _formContent(bool isEditing) {
    return ListView(
      children: [
        TextField(
          controller: _nameController,
          decoration: _box("Plan Name"),
        ),
        const SizedBox(height: 16),

        InputDecorator(
          decoration: _box("Select Role"),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              items: _roles
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedRole = value),
            ),
          ),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _amountController,
          decoration: _box("Amount (₹)"),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        TextField(
          controller: _durationController,
          decoration: _box("Duration"),
        ),
        const SizedBox(height: 24),

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
                        decoration: _box("Feature ${i + 1}"),
                      ),
                    ),
                    if (_featureControllers.length > 1)
                      IconButton(
                        icon: const Icon(Icons.remove_circle,
                            color: Colors.red),
                        onPressed: () => _removeFeatureField(i),
                      ),
                  ],
                ),
              ),
            TextButton.icon(
              onPressed: _addFeatureField,
              icon: Icon(Icons.add_circle, color: AppColors.primary),
              label: Text("Add Feature",
                  style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: _savePlan,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.save, color: Colors.white),
          label: Text(
            isEditing ? "Update Plan" : "Add Plan",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
