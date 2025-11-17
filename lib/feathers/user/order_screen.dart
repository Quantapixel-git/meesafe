import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/user_evaluation_mobile_screen.dart';
import 'package:mee_safe/feathers/web/web_warranty_condition_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedTab = 1; // 0 = Orders, 1 = Pending

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("Mee Safe"),
      ),

      // 🔥 Responsive LayoutBuilder
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isDesktop = constraints.maxWidth >= 800;

          // 🔥 Center content on desktop like real web dashboard
          double maxWidth = isDesktop ? 700 : double.infinity;

          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // ---------------- Tabs ----------------
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedTab = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selectedTab == 0
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                color: selectedTab == 0
                                    ? AppColors.primary
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: isDesktop ? 16 : 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedTab = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selectedTab == 1
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                              ),
                              color: selectedTab == 1
                                  ? Colors.grey.shade200
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: selectedTab == 1
                                    ? AppColors.primary
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: isDesktop ? 16 : 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ---------------- Order Card ----------------
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(isDesktop ? 20 : 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/samsung.jpg',
                                  height: isDesktop ? 80 : 60,
                                  width: isDesktop ? 80 : 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Samsung Galaxy F17 5G (4 GB/128 GB)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: isDesktop ? 18 : 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '₹ 2,730/-',
                                      style: TextStyle(
                                        fontSize: isDesktop ? 20 : 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          const Divider(height: 26),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ORDER PENDING',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isDesktop ? 18 : 14,
                                ),
                              ),
                              Text(
                                'Order No.: SMO1011250501',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: isDesktop ? 14 : 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: isDesktop ? 18 : 14,
                                ),
                              ),
                              onPressed: () {
  if (kIsWeb) {
    // Web Navigation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebWarrantyConditionScreen(
           deviceName: 'Samsung',
                                            imageUrl: 'assets/images/samsung.jpg',
        ),
      ),
    );
  } else {
    // Mobile Navigation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserEvaluationMobileScreen(),
      ),
    );
  }
},

                              child: Text(
                                'Continue to checkout',
                                style: TextStyle(
                                  fontSize: isDesktop ? 17 : 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label, {bool isActive = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? Colors.black : Colors.grey, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
