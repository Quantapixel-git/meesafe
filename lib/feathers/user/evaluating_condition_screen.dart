import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/accessories_screen.dart';

class EvaluatingConditionScreen extends StatefulWidget {
  const EvaluatingConditionScreen({super.key});

  @override
  State<EvaluatingConditionScreen> createState() => _EvaluatingConditionScreenState();
}

class _EvaluatingConditionScreenState extends State<EvaluatingConditionScreen> {
  int? selectedScreenCondition;
  int? selectedGlassCondition;
  int? selectedBackCondition;
  int? selectedPanelCondition;

  Widget buildOption({
    required int index,
    required String label,
    required int? selectedIndex,
    required VoidCallback onTap,
    required String imagePath,
  }) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primary : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDeviceDetailCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/samsung.jpg',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Evaluating",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Samsung Galaxy A17 5G (8 GB/128 GB)",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey.shade200,
                    color: AppColors.primary,
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "View Evaluation Summary  >",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Device > Brand > Model > Variant > Price > Evaluation",
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Text(
              "Evaluation",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),

            buildDeviceDetailCard(),

            // Screen Condition
            sectionTitle("Screen Condition"),
            Wrap(
              children: [
                buildOption(
                  index: 0,
                  label: "No Spot",
                  selectedIndex: selectedScreenCondition,
                  onTap: () => setState(() => selectedScreenCondition = 0),
                  imagePath: 'assets/images/no_damage.png',
                ),
                buildOption(
                  index: 1,
                  label: "Minor Spot",
                  selectedIndex: selectedScreenCondition,
                  onTap: () => setState(() => selectedScreenCondition = 1),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
                buildOption(
                  index: 2,
                  label: "Major Spot",
                  selectedIndex: selectedScreenCondition,
                  onTap: () => setState(() => selectedScreenCondition = 2),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
              ],
            ),

            // Touch Glass Condition
            sectionTitle("Touch Glass Condition"),
            Wrap(
              children: [
                buildOption(
                  index: 0,
                  label: "No scratch or crack",
                  selectedIndex: selectedGlassCondition,
                  onTap: () => setState(() => selectedGlassCondition = 0),
                  imagePath: 'assets/images/mobile.png',
                ),
                buildOption(
                  index: 1,
                  label: "Minor Scratches or less than 2 scratches",
                  selectedIndex: selectedGlassCondition,
                  onTap: () => setState(() => selectedGlassCondition = 1),
                  imagePath: 'assets/images/broken_mobile_glass.jpeg',
                ),
                buildOption(
                  index: 2,
                  label: "Heavy Scratches",
                  selectedIndex: selectedGlassCondition,
                  onTap: () => setState(() => selectedGlassCondition = 2),
                  imagePath: 'assets/images/broken_mobile_glass.jpeg',
                ),
                buildOption(
                  index: 3,
                  label: "Screen Cracked or Glass Broken",
                  selectedIndex: selectedGlassCondition,
                  onTap: () => setState(() => selectedGlassCondition = 3),
                  imagePath: 'assets/images/broken_mobile_glass.jpeg',
                ),
              ],
            ),

            // Back Panel Condition
            sectionTitle("Back Panel Condition"),
            Wrap(
              children: [
                buildOption(
                  index: 0,
                  label: "No defects on back panel",
                  selectedIndex: selectedBackCondition,
                  onTap: () => setState(() => selectedBackCondition = 0),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
                buildOption(
                  index: 1,
                  label: "Minor Scratches or less than 2 scratches",
                  selectedIndex: selectedBackCondition,
                  onTap: () => setState(() => selectedBackCondition = 1),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
                buildOption(
                  index: 2,
                  label: "Heavy Scratches",
                  selectedIndex: selectedBackCondition,
                  onTap: () => setState(() => selectedBackCondition = 2),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
                buildOption(
                  index: 3,
                  label: "Back Panel broken",
                  selectedIndex: selectedBackCondition,
                  onTap: () => setState(() => selectedBackCondition = 3),
                  imagePath: 'assets/images/back_damaged.jpeg',
                ),
              ],
            ),

            // Center Panel Condition
            sectionTitle("Center or Side Panel Condition"),
            Wrap(
              children: [
                buildOption(
                  index: 0,
                  label: "No defects on center panel",
                  selectedIndex: selectedPanelCondition,
                  onTap: () => setState(() => selectedPanelCondition = 0),
                  imagePath: 'assets/images/side_mobile.jpg',
                ),
                buildOption(
                  index: 1,
                  label: "Minor dent or scratches",
                  selectedIndex: selectedPanelCondition,
                  onTap: () => setState(() => selectedPanelCondition = 1),
                  imagePath: 'assets/images/side_mobile.jpg',
                ),
                buildOption(
                  index: 2,
                  label: "Major dent or heavy scratches",
                  selectedIndex: selectedPanelCondition,
                  onTap: () => setState(() => selectedPanelCondition = 2),
                  imagePath: 'assets/images/side_mobile.jpg',
                ),
                buildOption(
                  index: 3,
                  label:
                      "Center panel cracked or buttons missing or bent panel",
                  selectedIndex: selectedPanelCondition,
                  onTap: () => setState(() => selectedPanelCondition = 3),
                  imagePath:  'assets/images/side_mobile.jpg',
                ),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccessoriesScreen(),
              ),
            );
          },
          child: const Text(
            "Next",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
