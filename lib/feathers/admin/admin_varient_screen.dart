import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class VariantItem {
  int id;
  String name;
  int modelId;

  VariantItem({required this.id, required this.name, required this.modelId});
}

class Device {
  int id;
  String name;
  Device({required this.id, required this.name});
}

class Brand {
  int id;
  String name;
  int deviceId;
  Brand({required this.id, required this.name, required this.deviceId});
}

class ModelItem {
  int id;
  String name;
  int brandId;
  ModelItem({required this.id, required this.name, required this.brandId});
}

class AdminVariantScreen extends StatefulWidget {
  const AdminVariantScreen({super.key});

  @override
  State<AdminVariantScreen> createState() => _AdminVariantScreenState();
}

class _AdminVariantScreenState extends State<AdminVariantScreen> {
  final TextEditingController _variantController = TextEditingController();

  // Sample data
  final List<Device> _devices = [
    Device(id: 1, name: "Mobile"),
    Device(id: 2, name: "Laptop"),
  ];

  final List<Brand> _brands = [
    Brand(id: 1, name: "Samsung", deviceId: 1),
    Brand(id: 2, name: "Apple", deviceId: 1),
    Brand(id: 3, name: "Dell", deviceId: 2),
    Brand(id: 4, name: "HP", deviceId: 2),
  ];

  final List<ModelItem> _models = [
    ModelItem(id: 1, name: "Samsung S24", brandId: 1),
    ModelItem(id: 2, name: "Samsung A55", brandId: 1),
    ModelItem(id: 3, name: "iPhone 15", brandId: 2),
    ModelItem(id: 4, name: "Dell XPS 15", brandId: 3),
    ModelItem(id: 5, name: "HP Spectre", brandId: 4),
  ];

  final List<VariantItem> _variants = [];

  Device? _selectedDevice;
  Brand? _selectedBrand;
  ModelItem? _selectedModel;

  // Filtered dropdowns
  List<Brand> get _filteredBrands => _brands
      .where((b) => _selectedDevice != null && b.deviceId == _selectedDevice!.id)
      .toList();

  List<ModelItem> get _filteredModels => _models
      .where((m) => _selectedBrand != null && m.brandId == _selectedBrand!.id)
      .toList();

  List<VariantItem> get _filteredVariants => _variants
      .where((v) => _selectedModel != null && v.modelId == _selectedModel!.id)
      .toList();

  // Add/Edit Variant
  void _addOrEditVariant({VariantItem? existing}) {
    if (_selectedDevice == null ||
        _selectedBrand == null ||
        _selectedModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select Device, Brand, and Model first."),
        ),
      );
      return;
    }

    if (existing != null) {
      _variantController.text = existing.name;
    } else {
      _variantController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(existing == null ? "Add Variant" : "Edit Variant"),
        content: TextField(
          controller: _variantController,
          decoration: const InputDecoration(
            labelText: "Variant Name (e.g. 128GB / 8GB)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final name = _variantController.text.trim();
              if (name.isEmpty) return;

              setState(() {
                if (existing == null) {
                  _variants.add(VariantItem(
                    id: _variants.isEmpty ? 1 : _variants.last.id + 1,
                    name: name,
                    modelId: _selectedModel!.id,
                  ));
                } else {
                  existing.name = name;
                }
              });

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // Delete Variant
  void _deleteVariant(VariantItem variant) {
    setState(() => _variants.remove(variant));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Variants"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Variant"),
        onPressed: () => _addOrEditVariant(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Device Dropdown
            DropdownButtonFormField<Device>(
              value: _selectedDevice,
              decoration: const InputDecoration(
                labelText: "Select Device",
                border: OutlineInputBorder(),
              ),
              items: _devices.map((d) {
                return DropdownMenuItem(value: d, child: Text(d.name));
              }).toList(),
              onChanged: (device) {
                setState(() {
                  _selectedDevice = device;
                  _selectedBrand = null;
                  _selectedModel = null;
                });
              },
            ),
            const SizedBox(height: 12),

            // Brand Dropdown
            DropdownButtonFormField<Brand>(
              value: _selectedBrand,
              decoration: const InputDecoration(
                labelText: "Select Brand",
                border: OutlineInputBorder(),
              ),
              items: _filteredBrands.map((b) {
                return DropdownMenuItem(value: b, child: Text(b.name));
              }).toList(),
              onChanged: (brand) {
                setState(() {
                  _selectedBrand = brand;
                  _selectedModel = null;
                });
              },
            ),
            const SizedBox(height: 12),

            // Model Dropdown
            DropdownButtonFormField<ModelItem>(
              value: _selectedModel,
              decoration: const InputDecoration(
                labelText: "Select Model",
                border: OutlineInputBorder(),
              ),
              items: _filteredModels.map((m) {
                return DropdownMenuItem(value: m, child: Text(m.name));
              }).toList(),
              onChanged: (model) {
                setState(() {
                  _selectedModel = model;
                });
              },
            ),
            const SizedBox(height: 16),

            // Variants List
            Expanded(
              child: _selectedModel == null
                  ? const Center(
                      child: Text("Please select a model to view variants."),
                    )
                  : _filteredVariants.isEmpty
                      ? const Center(
                          child: Text("No variants found for this model."),
                        )
                      : ListView.builder(
                          itemCount: _filteredVariants.length,
                          itemBuilder: (_, i) {
                            final variant = _filteredVariants[i];
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  variant.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primary.withOpacity(0.1),
                                  child: Text(
                                    variant.name[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                trailing: Wrap(
                                  spacing: 8,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: AppColors.primary),
                                      onPressed: () => _addOrEditVariant(
                                          existing: variant),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: AppColors.primary),
                                      onPressed: () =>
                                          _deleteVariant(variant),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
