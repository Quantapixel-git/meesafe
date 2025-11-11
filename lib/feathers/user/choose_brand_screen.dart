import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/choose_model_screen.dart';

class ChooseBrandScreen extends StatelessWidget {
  const ChooseBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> brands = [
      {'name': 'Apple', 'logo': 'assets/images/apple.png'},
      {'name': 'Samsung', 'logo': 'assets/images/samsung_logo.png'},
      {'name': 'OnePlus', 'logo': 'assets/images/oneplus.png'},
      {'name': 'Google', 'logo': 'assets/images/google.jpeg'},
      {'name': 'Oppo', 'logo': 'assets/images/apple.png'},
      {'name': 'Vivo', 'logo': 'assets/images/samsung_logo.png'},
      {'name': 'Xiaomi', 'logo': 'assets/images/oneplus.png'},
      {'name': 'Motorola', 'logo': 'assets/images/google.jpeg'},
      {'name': 'Realme', 'logo': 'assets/images/apple.png'},
      {'name': 'Poco', 'logo': 'assets/images/oneplus.png'},
      {'name': 'iQOO', 'logo': 'assets/images/samsung_logo.png'},
      {'name': 'Nothing', 'logo': 'assets/images/google.jpeg'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Device > Brand",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search Your Brand To Sell",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                hintText: 'Search for brand',
                filled: true,
                fillColor: const Color(0xFFF9F9F9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose Brand",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // 🟦 Bigger Brand Grid
            Expanded(
              child: GridView.builder(
                itemCount: brands.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.0, // 🔹 makes boxes taller
                ),
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseModelScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            brand['logo']!,
                            height: 80, // 🔹 Larger logo image
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            brand['name']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
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
