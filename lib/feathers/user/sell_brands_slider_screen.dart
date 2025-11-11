import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class SellBrandsScreen extends StatelessWidget {
  const SellBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> brands = [
      {'logo': 'assets/images/apple.png', 'name': 'Apple'},
      {'logo': 'assets/images/samsung_logo.png', 'name': 'Samsung'},
      {'logo': 'assets/images/oneplus.png', 'name': 'OnePlus'},
      {'logo': 'assets/images/xiaomi.png', 'name': 'Xiaomi'},
      {'logo': 'assets/images/oppo.png', 'name': 'Oppo'},
      {'logo': 'assets/images/vivo.png', 'name': 'Vivo'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Maximum Brand of Mobile'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: brands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return _brandBox(brand['logo']!, brand['name']!);
          },
        ),
      ),
    );
  }

  Widget _brandBox(String asset, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE9E9E9)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(asset, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
