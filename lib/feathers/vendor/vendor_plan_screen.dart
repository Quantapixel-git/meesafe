import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/vendor/vendor_dashboard.dart';

class VendorPlanScreen extends StatelessWidget {
  const VendorPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        "name": "Basic",
        "price": "₹499 / month",
        "features": [
          "Up to 10 listings",
          "Email support",
          "Basic analytics",
        ],
        "color": Colors.blueAccent,
      },
      {
        "name": "Standard",
        "price": "₹999 / month",
        "features": [
          "Up to 50 listings",
          "Priority support",
          "Advanced analytics",
        ],
        "color": AppColors.primary,
      },
      {
        "name": "Premium",
        "price": "₹1999 / month",
        "features": [
          "Unlimited listings",
          "24/7 support",
          "Full analytics & insights",
        ],
        "color": Colors.orangeAccent,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Plan"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.workspace_premium,
                            color: plan["color"] as Color, size: 36),
                        const SizedBox(width: 10),
                        Text(
                          plan["name"].toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: plan["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      plan["price"].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (plan["features"] as List<String>)
                          .map((feature) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        feature,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: plan["color"] as Color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("${plan["name"]} Plan Selected ✅"),
                            backgroundColor: plan["color"] as Color,
                          ));
                            Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const VendorDashboardScreen()),
    );
                        },
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
