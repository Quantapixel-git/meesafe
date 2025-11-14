import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/inner_sub_cate.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  final List<Map<String, dynamic>> subCategories = const [
    {
      "name": "Oppo",
      "models": ["F10", "F11"]
    },
    {
      "name": "Vivo",
      "models": ["Vivo X1", "Vivo X2"]
    },
    {
      "name": "Samsung",
      "models": ["Samsung S20", "Samsung S21"]
    },
    {
      "name": "iPhone 13",
      "models": ["iPhone 13 Mini", "iPhone 13 Pro"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subcategories"),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: subCategories.length,
        itemBuilder: (_, index) {
          final sub = subCategories[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                sub["name"],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InnerSubCategoryScreen(
                      subCategoryName: sub["name"],
                      models: sub["models"],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
