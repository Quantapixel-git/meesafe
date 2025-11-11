import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/choose_brand_screen.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),

          const Text(
            "Sell Maximum Brand of Mobile on Mee Safe",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              BrandButton(label: 'Apple', icon: Icons.apple),
              BrandButton(label: 'Samsung', icon: Icons.phone_android),
              BrandButton(label: 'OnePlus', icon: Icons.mobile_friendly),
              BrandButton(label: 'Google Pixel', icon: Icons.android),
              BrandButton(label: 'Oppo', icon: Icons.phone_iphone),
              BrandButton(label: 'Vivo', icon: Icons.phone_iphone),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChooseBrandScreen()),
              );
            },
            child: const Text(
              'Sell all brands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),

          const SizedBox(height: 30),

          // You can re-add your WhyBestSection() here if needed
          // const WhyBestSection(),
        ],
      ),
    );
  }
}

class BrandButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const BrandButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 🟢 Navigate to ChooseBrandScreen when any brand is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChooseBrandScreen()),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


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
