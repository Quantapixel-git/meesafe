import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/evaluating_condition_screen.dart';
import 'package:mee_safe/feathers/user/variant_price_questionary_screen.dart';
import 'package:mee_safe/feathers/user/variant_price_screen.dart';

class LocationSelectScreen extends StatefulWidget {
  const LocationSelectScreen({super.key});

  @override
  State<LocationSelectScreen> createState() => _LocationSelectScreenState();
}

class _LocationSelectScreenState extends State<LocationSelectScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLocationBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Please select your location...",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  // ------------------ Bottom Sheet ------------------
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

              // Horizontal scroll of states
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

              // Search Bar
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

  // ------------------ State Card Widget ------------------
  static Widget _stateCard(BuildContext context, String state, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VariantPriceQuestionaryScreen()
          ),
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
