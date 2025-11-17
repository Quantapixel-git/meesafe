import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/branches/branch_warrenty_list.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/evaluating_condition_screen.dart';
import 'package:mee_safe/feathers/user/user_warrenty_registration.dart';
import 'package:mee_safe/feathers/user/variant_price_questionary_screen.dart';

class VariantPriceScreen extends StatelessWidget {
  final String modelName;
  final String variant;
  final String imagePath;
  final String price;

  const VariantPriceScreen({
    super.key,
    required this.modelName,
    required this.variant,
    required this.imagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APPBAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Device > Brand > Model > Variant > Variant Price",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 13.5,
          ),
        ),
      ),

      // ---------------- BODY ----------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            // Phone Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE9E9E9)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$modelName ($variant)",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Get Upto",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ $price",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "This price is not final it is an approximate value you can get maximum for this device. "
              "The final price will be quoted at the end of this section.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM BUTTON ----------------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              _showLocationBottomSheet(context);
            },
            child: const Text(
              "Check Exact Value",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- SHOW BOTTOM SHEET ----------------
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

  // ---------------- STATE CARD ----------------
  static Widget _stateCard(BuildContext context, String state, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserWarrantyRegistrationScreen()),
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
