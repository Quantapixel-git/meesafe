import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class StoreLocatorScreen extends StatelessWidget {
  const StoreLocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stores = [
      {
        'image': 'assets/images/ad_1.jpeg',
        'title': 'Tambaram, Chennai',
        'address':
            'Shop No: 8.A, 45, Shanmugam Rd, West Tambaram,\nChennai, Tamil Nadu - 600045',
        'timing': 'Sunday–Saturday 10 am–9.30 pm',
      },
      {
        'image': 'assets/images/ad_2.png',
        'title': 'Anna Nagar, Chennai',
        'address':
            'Shop No: 12, 2nd Avenue, Anna Nagar East,\nChennai, Tamil Nadu - 600102',
        'timing': 'Sunday–Saturday 10 am–9.30 pm',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Row(
          children: [
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search mobile phones, laptops...',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
           
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Locate our Store",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: stores.map((store) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Store image
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(14)),
                        child: Image.asset(
                          store['image']!,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store['title']!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              store['address']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              store['timing']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _storeButton(
                                  icon: Icons.near_me_outlined,
                                  label: "Get Direction",
                                  color: AppColors.primary,
                                ),
                                _storeButton(
                                  icon: Icons.phone_outlined,
                                  label: "Call Store",
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storeButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _bottomNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            color: active ? AppColors.primary : Colors.black54, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? AppColors.primary : Colors.black54,
          ),
        ),
      ],
    );
  }
}
