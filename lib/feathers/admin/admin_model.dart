import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminModelScreen extends StatefulWidget {
  const AdminModelScreen({super.key});

  @override
  State<AdminModelScreen> createState() => _AdminModelScreenState();
}

class _AdminModelScreenState extends State<AdminModelScreen> {
  final TextEditingController _nameController = TextEditingController();

  // Example devices and brands
  final List<Map<String, dynamic>> _devices = [
    {"id": 1, "name": "Mobile"},
    {"id": 2, "name": "Laptop"},
    {"id": 3, "name": "Television"},
  ];

  final Map<int, List<Map<String, dynamic>>> _brandsByDevice = {
    1: [
      {"id": 1, "name": "Samsung"},
      {"id": 2, "name": "Apple"},
      {"id": 3, "name": "OnePlus"},
    ],
    2: [
      {"id": 4, "name": "Dell"},
      {"id": 5, "name": "HP"},
      {"id": 6, "name": "Lenovo"},
    ],
    3: [
      {"id": 7, "name": "LG"},
      {"id": 8, "name": "Sony"},
    ],
  };

  // Selected dropdown values
  int? _selectedDeviceId;
  int? _selectedBrandId;

  // Models List
  final List<Map<String, dynamic>> _models = [
    {"id": 1, "name": "Galaxy S23", "deviceId": 1, "brandId": 1},
    {"id": 2, "name": "MacBook Air", "deviceId": 2, "brandId": 2},
    {"id": 3, "name": "Bravia X90", "deviceId": 3, "brandId": 8},
  ];

  // Add or Edit Model
  void _addOrEditModel({Map<String, dynamic>? existing}) {
    if (existing != null) {
      _nameController.text = existing["name"];
      _selectedDeviceId = existing["deviceId"];
      _selectedBrandId = existing["brandId"];
    } else {
      _nameController.clear();
      _selectedDeviceId = null;
      _selectedBrandId = null;
    }

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setInnerState) {
          final selectedBrands =
              _brandsByDevice[_selectedDeviceId] ?? [];

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            title: Text(existing == null ? "Add Model" : "Edit Model"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Device dropdown
                  // Device dropdown
DropdownButtonFormField<int>(
  decoration: const InputDecoration(
    labelText: "Select Device",
    border: OutlineInputBorder(),
  ),
  value: _selectedDeviceId,
  items: _devices
      .map<DropdownMenuItem<int>>((d) => DropdownMenuItem<int>(
            value: d["id"] as int,
            child: Text(d["name"].toString()),
          ))
      .toList(),
  onChanged: (val) {
    setInnerState(() {
      _selectedDeviceId = val;
      _selectedBrandId = null;
    });
  },
),
const SizedBox(height: 12),

// Brand dropdown
DropdownButtonFormField<int>(
  decoration: const InputDecoration(
    labelText: "Select Brand",
    border: OutlineInputBorder(),
  ),
  value: _selectedBrandId,
  items: selectedBrands
      .map<DropdownMenuItem<int>>((b) => DropdownMenuItem<int>(
            value: b["id"] as int,
            child: Text(b["name"].toString()),
          ))
      .toList(),
  onChanged: (val) {
    setInnerState(() => _selectedBrandId = val);
  },
),

                  const SizedBox(height: 12),

                  // Model name
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Model Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  final name = _nameController.text.trim();
                  if (name.isEmpty ||
                      _selectedDeviceId == null ||
                      _selectedBrandId == null) return;

                  setState(() {
                    if (existing == null) {
                      _models.add({
                        "id": _models.isEmpty ? 1 : _models.last["id"] + 1,
                        "name": name,
                        "deviceId": _selectedDeviceId,
                        "brandId": _selectedBrandId,
                      });
                    } else {
                      existing["name"] = name;
                      existing["deviceId"] = _selectedDeviceId;
                      existing["brandId"] = _selectedBrandId;
                    }
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }

  void _deleteModel(Map<String, dynamic> model) {
    setState(() => _models.remove(model));
  }

  String _deviceName(int id) =>
      _devices.firstWhere((d) => d["id"] == id)["name"];

  String _brandName(int id) {
    for (var brandList in _brandsByDevice.values) {
      for (var b in brandList) {
        if (b["id"] == id) return b["name"];
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Models"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Model"),
        onPressed: () => _addOrEditModel(),
      ),
      body: _models.isEmpty
          ? const Center(child: Text("No models found"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _models.length,
              itemBuilder: (_, i) {
                final model = _models[i];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      model["name"],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Device: ${_deviceName(model["deviceId"])}\n"
                      "Brand: ${_brandName(model["brandId"])}",
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: AppColors.primary),
                          onPressed: () =>
                              _addOrEditModel(existing: model),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteModel(model),
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
