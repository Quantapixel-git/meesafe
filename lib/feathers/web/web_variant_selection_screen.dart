import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';
import 'package:mee_safe/feathers/web/web_varient_price_screen.dart';

class WebVariantSelectionScreen extends StatefulWidget {
  final String modelName;
  final String imagePath;

  const WebVariantSelectionScreen({
    super.key,
    required this.modelName,
    required this.imagePath,
  });

  @override
  State<WebVariantSelectionScreen> createState() =>
      _WebVariantSelectionScreenState();
}

class _WebVariantSelectionScreenState extends State<WebVariantSelectionScreen> {
  String? selectedVariant;

  final List<String> variants = ["4 GB / 128 GB", "8 GB / 128 GB"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WebHeaderNav(),

            // 🔹 Breadcrumb
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
              child: Row(
                children: [
                  _breadcrumbLink(
                    "Device",
                    onTap: () => Navigator.pop(context),
                  ),
                  const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                  _breadcrumbLink("Brand", onTap: () {}),
                  const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                  _breadcrumbLink("Model", onTap: () {}),
                  const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
                  const Text(
                    "Variant",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "Choose Variant",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 Card Section
            Center(
              child: Container(
                width: 700,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 40,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 🔹 Phone Image
                    Container(
                      height: 200,
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                    ),

                    const SizedBox(width: 50),

                    // 🔹 Variant Selection Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select your ${widget.modelName} variant",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 25),

                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: variants.map((v) {
                              final isSelected = selectedVariant == v;
                              return ChoiceChip(
                                label: Text(
                                  v,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (_) =>
                                    setState(() => selectedVariant = v),
                                selectedColor: AppColors.primary,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 30),

                          // 🔹 Proceed Button
                          SizedBox(
                            width: 180,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: selectedVariant == null
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WebVarientPriceScreen(
                                              ),
                                        ),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Selected: $selectedVariant",
                                          ),
                                        ),
                                      );
                                    },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedVariant == null
                                    ? Colors.grey.shade300
                                    : AppColors.primary,
                                foregroundColor: selectedVariant == null
                                    ? Colors.black45
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: selectedVariant == null ? 0 : 2,
                              ),

                              child: const Text(
                                "Proceed",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),

            // 🔹 Footer
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: const Text(
                "© 2025 DOFY. All rights reserved.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _breadcrumbLink(String text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }
}
