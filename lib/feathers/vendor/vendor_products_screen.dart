import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class VendorProductsScreen extends StatefulWidget {
  const VendorProductsScreen({super.key});

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  String? selectedDevice;
  String? selectedBrand;
  String? selectedModel;
  String? selectedVariant;

  final Map<String, List<String>> deviceBrands = {
    "Mobile": ["Samsung", "Apple", "OnePlus"],
    "Laptop": ["Dell", "HP", "Lenovo"],
  };

  final Map<String, List<String>> brandModels = {
    "Samsung": ["Galaxy S23", "Galaxy A55"],
    "Apple": ["iPhone 14", "iPhone 15 Pro"],
    "Dell": ["Inspiron 15", "XPS 13"],
  };

  final Map<String, List<String>> modelVariants = {
    "Galaxy S23": ["128GB", "256GB"],
    "iPhone 15 Pro": ["128GB", "512GB"],
    "XPS 13": ["8GB RAM", "16GB RAM"],
  };

  List<Map<String, String>> existingProducts = [
    {
      "device": "Mobile",
      "brand": "Samsung",
      "model": "Galaxy S23",
      "variant": "128GB",
    },
    {
      "device": "Laptop",
      "brand": "Dell",
      "model": "XPS 13",
      "variant": "16GB RAM",
    },
  ];

  Widget _buildDropdown<T>(
      String label, T? value, List<T> items, ValueChanged<T?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        value: value,
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString()),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _addProduct() {
    if (selectedDevice != null &&
        selectedBrand != null &&
        selectedModel != null &&
        selectedVariant != null) {
      setState(() {
        existingProducts.add({
          "device": selectedDevice!,
          "brand": selectedBrand!,
          "model": selectedModel!,
          "variant": selectedVariant!,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Product added successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Please select all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final brands = selectedDevice != null ? deviceBrands[selectedDevice]! : [];
    final models = selectedBrand != null ? brandModels[selectedBrand]! : [];
    final variants = selectedModel != null ? modelVariants[selectedModel]! : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Products"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDropdown("Device", selectedDevice, deviceBrands.keys.toList(),
                  (val) {
                setState(() {
                  selectedDevice = val;
                  selectedBrand = null;
                  selectedModel = null;
                  selectedVariant = null;
                });
              }),
              _buildDropdown("Brand", selectedBrand, brands, (val) {
                setState(() {
                  selectedBrand = val;
                  selectedModel = null;
                  selectedVariant = null;
                });
              }),
              _buildDropdown("Model", selectedModel, models, (val) {
                setState(() {
                  selectedModel = val;
                  selectedVariant = null;
                });
              }),
              _buildDropdown("Variant", selectedVariant, variants, (val) {
                setState(() {
                  selectedVariant = val;
                });
              }),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _addProduct,
                icon: const Icon(Icons.add),
                label: const Text("Add Product"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const Text("Existing Products",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ListView.builder(
                itemCount: existingProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = existingProducts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text("${product['brand']} - ${product['model']}"),
                      subtitle: Text(
                          "${product['device']} • ${product['variant']}"),
                      trailing: const Icon(Icons.inventory_2_outlined),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
