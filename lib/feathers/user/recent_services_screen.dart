import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class RecentServicesScreen extends StatelessWidget {
  const RecentServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recentServices = [
      {
        'title': 'Samsung Galaxy F17 5G ',
        'date': '05 Nov 2025',
        'image': 'assets/images/samsung.jpg',
      },
      {
        'title': 'iPhone 13 Pro Max',
        'date': '04 Nov 2025',
        'image': 'assets/images/apple.png',
      },
      {
        'title': 'IPhone 17',
        'date': '02 Nov 2025',
        'image': 'assets/images/iphone_17.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor:  AppColors.white,
        elevation: 0.4,
        centerTitle: true,
        title: const Text(
          "Recent Services",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: recentServices.length,
          itemBuilder: (context, index) {
            final service = recentServices[index];


            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset(
                      service['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(
                  service['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    service['date']!,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
