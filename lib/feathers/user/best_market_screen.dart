import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class BestMarketScreen extends StatelessWidget {
  const BestMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: const [
          _FeatureCard(
            title: "Easy Doorstep Pickup:",
            description:
                "Enjoy the convenience of our hassle-less doorstep free pickup service. We come to you, saving you time and effort.",
            imagePath: "assets/images/female.jpeg",
            gradientColor: Color.fromARGB(255, 53, 53, 110),
          ),
          SizedBox(height: 16),
          _FeatureCard(
            title: "Assured Best Price:",
            description:
                "Receive the highest value for your gadgets with our guaranteed best-price offers. We ensure you get the maximum worth.",
            imagePath: "assets/images/female.jpeg",
            gradientColor: Color.fromARGB(255, 53, 53, 110),
          ),
          SizedBox(height: 16),

           _FeatureCard(
            title: "Fast Service & Instant Payment",
              imagePath: "assets/images/female.jpeg",
            description:
                "Get Paid instantly with our swift and secure payment system. No delays, just quick and relaible transcations",
            gradientColor: Color.fromARGB(255, 53, 53, 110)
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color gradientColor;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientColor.withOpacity(0.3), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
