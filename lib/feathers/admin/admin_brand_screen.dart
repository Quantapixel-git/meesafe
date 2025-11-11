import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_device_screen.dart';
import 'package:mee_safe/feathers/admin/admin_varient_screen.dart' hide Device;
import 'package:mee_safe/feathers/constants/app_colors.dart';

class Brand {
  int id;
  String name;
  int deviceId;

  Brand({required this.id, required this.name, required this.deviceId});
}

class AdminBrandScreen extends StatefulWidget {
  const AdminBrandScreen({super.key});

  @override
  State<AdminBrandScreen> createState() => _AdminBrandScreenState();
}

class _AdminBrandScreenState extends State<AdminBrandScreen> {
  final TextEditingController _controller = TextEditingController();

  // Sample devices (you can later fetch this from backend)
  final List<Device> _devices = [
    Device(id: 1, name: "Mobile"),
    Device(id: 2, name: "Laptop"),
    Device(id: 3, name: "Tablet"),
    Device(id: 4, name: "Smart TV"),
  ];

  // All brands
  final List<Brand> _brands = [];

  Device? _selectedDevice;

  // Filter brands by device
  List<Brand> get _filteredBrands {
    if (_selectedDevice == null) return [];
    return _brands.where((b) => b.deviceId == _selectedDevice!.id).toList();
  }

  // Add or Edit Brand Dialog
  void _addOrEditBrand({Brand? existing}) {
    if (_selectedDevice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a device first.")),
      );
      return;
    }

    if (existing != null) {
      _controller.text = existing.name;
    } else {
      _controller.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(existing == null ? "Add Brand" : "Edit Brand"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Device: ${_selectedDevice?.name ?? "Unknown"}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Brand Name",
                border: OutlineInputBorder(),
              ),
            ),
          ],
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
              final name = _controller.text.trim();
              if (name.isEmpty) return;

              setState(() {
                if (existing == null) {
                  _brands.add(
                    Brand(
                      id: _brands.isEmpty ? 1 : _brands.last.id + 1,
                      name: name,
                      deviceId: _selectedDevice!.id,
                    ),
                  );
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

  void _deleteBrand(Brand brand) {
    setState(() => _brands.remove(brand));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Brands"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Brand"),
        onPressed: () => _addOrEditBrand(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Device selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<Device>(
              decoration: const InputDecoration(
                labelText: "Select Device",
                border: OutlineInputBorder(),
              ),
              value: _selectedDevice,
              items: _devices.map((d) {
                return DropdownMenuItem(
                  value: d,
                  child: Text(d.name),
                );
              }).toList(),
              onChanged: (device) {
                setState(() => _selectedDevice = device);
              },
            ),
          ),

          // ✅ Header
          if (_selectedDevice != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.primary.withOpacity(0.1),
              child: Text(
                "Device: ${_selectedDevice!.name} → Brands",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

          // ✅ Brand List
          Expanded(
            child: _selectedDevice == null
                ? const Center(
                    child: Text("Please select a device to view brands."),
                  )
                : _filteredBrands.isEmpty
                    ? const Center(child: Text("No brands found"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filteredBrands.length,
                        itemBuilder: (_, i) {
                          final brand = _filteredBrands[i];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                brand.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Device: ${_devices.firstWhere((d) => d.id == brand.deviceId).name}",
                                style: const TextStyle(fontSize: 13),
                              ),
                              leading: CircleAvatar(
                                backgroundColor:
                                    AppColors.primary.withOpacity(0.1),
                                child: Text(
                                  brand.name[0].toUpperCase(),
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
                                    onPressed: () =>
                                        _addOrEditBrand(existing: brand),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: AppColors.primary),
                                    onPressed: () => _deleteBrand(brand),
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
    );
  }
}
