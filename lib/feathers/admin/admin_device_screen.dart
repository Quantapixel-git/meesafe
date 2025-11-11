
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/admin/admin_brand_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class Device {
  int id;
  String name;
  Device({required this.id, required this.name});
}

class AdminDeviceScreen extends StatefulWidget {
  const AdminDeviceScreen({super.key});

  @override
  State<AdminDeviceScreen> createState() => _AdminDeviceScreenState();
}

class _AdminDeviceScreenState extends State<AdminDeviceScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Device> _devices = [
    Device(id: 1, name: "Mobile"),
    Device(id: 2, name: "Laptop"),
    Device(id: 3, name: "Television"),
  ];

  void _addOrEditDevice({Device? existing}) {
    if (existing != null) {
      _controller.text = existing.name;
    } else {
      _controller.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(existing == null ? "Add Device" : "Edit Device"),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: "Device Name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
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
                  _devices.add(Device(id: _devices.length + 1, name: name));
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

  void _delete(Device device) {
    setState(() => _devices.remove(device));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Devices"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => _addOrEditDevice(),
        icon: const Icon(Icons.add),
        label: const Text("Add Device"),
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          final device = _devices[i];
          return Card(
            child: ListTile(
              title: Text(device.name),
              trailing: Wrap(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primary),
                    onPressed: () => _addOrEditDevice(existing: device),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.primary),
                    onPressed: () => _delete(device),
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
