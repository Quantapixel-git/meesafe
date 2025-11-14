
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class WhyBestSection extends StatelessWidget {
  const WhyBestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why are we the Best in Market?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // 🔹 Card 1
        _infoCard(
          title: 'Easy Doorstep Pickup:',
          description:
              'Enjoy the convenience of our hassle-less doorstep free pickup service. We come to you, saving you time and effort.',
          imagePath: 'assets/images/female.jpeg',
        ),

        const SizedBox(height: 16),

        // 🔹 Card 2
        _infoCard(
          title: 'Assured Best Price:',
          description:
              'Receive the highest value for your gadgets with our guaranteed best-price offers. We ensure you get the maximum worth.',
          imagePath: 'assets/images/male.jpeg',
        ),

        const SizedBox(height: 16),

        // 🔹 Card 3
        _infoCard(
          title: 'Fast Service & Instant Payment:',
          description:
              'Get paid instantly with our swift and secure payment system. No delays, just quick and reliable transactions.',
          imagePath: 'assets/images/female.jpeg',
        ),
      ],
    );
  }

  Widget _infoCard({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 191, 189, 248), Color.fromARGB(255, 2, 36, 88)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
