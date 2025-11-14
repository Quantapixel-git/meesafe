import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/bottom_nav.dart';
import 'package:mee_safe/feathers/user/final_sell_screen.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';

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
class WebPlanScreen extends StatefulWidget {
  const WebPlanScreen({super.key});

  @override
  State<WebPlanScreen> createState() => _WebPlanScreenState();
}

class _WebPlanScreenState extends State<WebPlanScreen> {
  String? selectedPlan;
  String? hoveredPlan;

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

  void _onSelectPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Plan Purchased Successfully!")));

    Navigator.push(context, MaterialPageRoute(builder: (c) => WebHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Mee Safe – Choose Your Plan",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Choose the best plan for experience",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),

                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 950 ? 3 : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: plans.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final plan = plans[index];
                        final isSelected = selectedPlan == plan['title'];
                        final isHovered = hoveredPlan == plan['title'];

                        return MouseRegion(
                          onEnter: (_) => setState(() {
                            hoveredPlan = plan['title'];
                          }),
                          onExit: (_) => setState(() {
                            hoveredPlan = null;
                          }),

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isHovered
                                      ? AppColors.primary.withOpacity(0.12)
                                      : Colors.grey.shade300.withOpacity(0.3),
                                  blurRadius: isHovered ? 18 : 10,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plan['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text(
                                  plan['price'],
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black,
                                  ),
                                ),

                                const SizedBox(height: 20),
                                const Divider(),
                                const SizedBox(height: 12),

                                ...plan['features'].map<Widget>(
                                  (f) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            f,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? AppColors.primary
                                          : AppColors.primary.withOpacity(0.9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => _onSelectPlan(plan['title']),
                                    child: Text(
                                      isSelected ? "Selected" : "Choose Plan",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
