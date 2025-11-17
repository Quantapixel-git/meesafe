import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/user_warrenty_registration.dart';
import 'package:mee_safe/feathers/user/variant_price_questionary_screen.dart';
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
          //   onPressed: selectedIndex == -1
          //       ? null
          //       : () {
          //          Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const VariantPriceScreen(
          //       modelName: "Samsung Galaxy F17 5G",
          //       variant: "8 GB/128 GB",
          //       imagePath: "assets/images/samsung.jpg",
          //       price: "10,380",
          //     ),
          //   ),
          // );
          //         },
           onPressed: () {
              _showLocationBottomSheet(context);
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

   void _showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Select your location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                "Based on your location, we will service for you",
                style: TextStyle(color: Colors.black54, fontSize: 13.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),

              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _stateCard(context, "Karnataka", Icons.temple_hindu),
                    const SizedBox(width: 12),
                    _stateCard(context, "Andhra Pradesh", Icons.account_balance),
                    const SizedBox(width: 12),
                    _stateCard(context, "Telangana", Icons.fort),
                    const SizedBox(width: 12),
                    _stateCard(context, "Tamil Nadu", Icons.location_city),
                    const SizedBox(width: 12),
                    _stateCard(context, "Kerala", Icons.park),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search your city or pincode",
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
  static Widget _stateCard(BuildContext context, String state, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VariantPriceQuestionaryScreen()),
        );
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              state,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
