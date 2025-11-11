import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/variant_price_screen.dart';

class ChooseVariantScreen extends StatefulWidget {
  final String modelName;
  final String imagePath;

  const ChooseVariantScreen({
    super.key,
    required this.modelName,
    required this.imagePath,
  });

  @override
  State<ChooseVariantScreen> createState() => _ChooseVariantScreenState();
}

class _ChooseVariantScreenState extends State<ChooseVariantScreen> {
  int selectedIndex = -1;

  final List<String> variants = [
    "4 GB/128 GB",
    "8 GB/128 GB",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Device > Brand > Model > Variant",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Variant",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE9E9E9)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    widget.imagePath,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Select your ${widget.modelName} variant",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(variants.length, (index) {
                      final isSelected = selectedIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : Colors.white,
                            side: BorderSide(
                              color: isSelected
                                  ?  AppColors.primary
                                  : Colors.black26,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Text(
                            variants[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Proceed button fixed at bottom
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: selectedIndex == -1
                ? null
                : () {
                   Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VariantPriceScreen(
                modelName: "Samsung Galaxy F17 5G",
                variant: "8 GB/128 GB",
                imagePath: "assets/images/samsung.jpg",
                price: "10,380",
              ),
            ),
          );
                  },
            child: const Text(
              "Proceed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
