import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class SuccessInNumbersScreen extends StatelessWidget {
  const SuccessInNumbersScreen({super.key});

  @override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final bool isWeb = constraints.maxWidth > 700; // 🔹 Detect large screens

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000), // 🔹 Web width limit
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Mee Safe’s Success in Numbers",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    // 🔹 Use responsive grid count
                    GridView.count(
                      crossAxisCount: isWeb ? 4 : 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: isWeb ? 40 : 20,
                      mainAxisSpacing: isWeb ? 30 : 20,
                      children: [
                        _buildStatItem("1M+", "Downloads"),
                        _buildStatItem("₹500M+", "Cash Given"),
                        _buildStatItem("100K+", "Devices Acquired"),
                        _buildStatItem("2,000+", "Areas Covered"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


  Widget _buildStatItem(String number, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
