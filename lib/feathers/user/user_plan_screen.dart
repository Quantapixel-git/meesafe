import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/bottom_nav.dart';
import 'package:mee_safe/feathers/user/final_sell_screen.dart';

class UserPlanScreen extends StatefulWidget {
  const UserPlanScreen({super.key});

  @override
  State<UserPlanScreen> createState() => _UserPlanScreenState();
}

class _UserPlanScreenState extends State<UserPlanScreen> {
  String? selectedPlan;

  final List<Map<String, dynamic>> plans = [
    {
      "title": "Basic Plan",
      "price": "₹499",
      "features": [
        "Standard processing",
        "Email support",
        "3-day completion",
      ],
    },
    {
      "title": "Premium Plan",
      "price": "₹999",
      "features": [
        "Priority processing",
        "24x7 support",
        "Same-day completion",
      ],
    },
    {
      "title": "Pro Plan",
      "price": "₹1,499",
      "features": [
        "Top priority",
        "Dedicated manager",
        "Instant confirmation",
      ],
    },
  ];

  void _onSelectPlan(String title) {
    setState(() => selectedPlan = title);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Plan Purchased Successfully!")),
      );
     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Choose Your Plan",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Select the plan that best fits your needs",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // Real-time animated cards
          ...plans.map((plan) {
            final bool isSelected = selectedPlan == plan['title'];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.08)
                        : Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.black87,
                        ),
                      ),
                      Text(
                        plan['price'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Features list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (plan['features'] as List<String>)
                        .map(
                          (f) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    f,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),

                  // Select button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? AppColors.primary
                            : AppColors.primary.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _onSelectPlan(plan['title']),
                      child: Text(
                        isSelected ? "Selected" : "Select Plan",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
