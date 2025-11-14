import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/model_screen.dart';

class InnerSubCategoryScreen extends StatelessWidget {
  final String subCategoryName;
  final List<String> models;

  const InnerSubCategoryScreen({
    super.key,
    required this.subCategoryName,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategoryName),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: models.length,
        itemBuilder: (_, index) {
          final model = models[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                model,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ModelDetailScreen(
                      modelName: "Oppo F10",
                      description:
                          "Oppo F10 is a powerful smartphone with great features.",
                      plans: ["Basic", "Standard", "Premium"],
                      imagePath: 'assets/images/samsang.jpg',
                      price: 50000,
                      rating: 5,
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
