import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class AdminDeviceScreen extends StatefulWidget {
  const AdminDeviceScreen({super.key});

  @override
  State<AdminDeviceScreen> createState() => _AdminDeviceScreenState();
}

class _AdminDeviceScreenState extends State<AdminDeviceScreen> {
  final TextEditingController _DeviceController = TextEditingController();

  List<String> categories = ["Mobile", "Laptop", "Tablet"];
  int? editingIndex;

  void _addDevice() {
    String name = _DeviceController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      if (editingIndex != null) {
        // Update existing
        categories[editingIndex!] = name;
        editingIndex = null;
      } else {
        // Add new
        categories.add(name);
      }
      _DeviceController.clear();
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Device ${editingIndex != null ? 'updated' : 'added'} successfully")),
    );
  }

  void _editDevice(int index) {
    setState(() {
      editingIndex = index;
      _DeviceController.text = categories[index];
    });
    _showDeviceDialog();
  }

  void _deleteDevice(int index) {
    setState(() {
      categories.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Device deleted successfully")),
    );
  }

  void _showDeviceDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(editingIndex != null ? "Edit Device" : "Add Device"),
        content: TextField(
          controller: _DeviceController,
          decoration: const InputDecoration(
            hintText: "Enter Device name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _DeviceController.clear();
              editingIndex = null;
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _addDevice,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text(
              editingIndex != null ? "Update" : "Add",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Devices"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: categories.isEmpty
          ? const Center(
              child: Text("No Devices found",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final name = categories[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text(
                        name[0].toUpperCase(),
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ),
                    title: Text(name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _editDevice(index),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => _deleteDevice(index),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          editingIndex = null;
          _DeviceController.clear();
          _showDeviceDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Device"),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
