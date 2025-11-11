import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> blogs = [
      {
        'image': 'assets/images/female.jpeg',
        'date': '03 Nov 2025',
        'title': "How Battery Health Affects Your Phone's Resale Value?",
        'desc':
            "Have you ever wondered if battery health would be the primary factor that drives the phone's price? If not, it's time to unlearn the older thought about it and get a fresh update."
      },
      {
        'image': 'assets/images/male.jpeg',
        'date': '28 Oct 2025',
        'title': "Top Tips to Increase Your Old Phone’s Value Before Selling",
        'desc':
            "Before you sell your old phone, follow these simple yet powerful tips to boost your resale price instantly."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BLOG HEADER
            Center(
              child: Column(
                children: [
                  Text(
                    "BLOGS",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "The latest writings from our team",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tools and strategies modern teams need to help their companies grow.",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // BLOG CARDS
            Column(
              children: blogs.map((blog) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(14)),
                        child: Image.asset(
                          blog['image']!,
                          height: 180,
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
                              blog['date']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              blog['title']!,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              blog['desc']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                height: 1.4,
                              ),
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

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,
            color: active ? AppColors.primary : Colors.black54, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style:TextStyle(
            fontSize: 12,
            color: active ? AppColors.primary : Colors.black54,
          ),
        ),
      ],
    );
  }
}
