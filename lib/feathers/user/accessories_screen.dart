import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/evaluation_summary_screen.dart';
import 'package:mee_safe/feathers/user/user_evaluation_mobile_screen.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  // Selection tracking
  final Map<String, bool> _selectedIssues = {
    "Battery issue": false,
    "Front Camera not working": false,
    "Back Camera not working": false,
    "Camera Glass Broken": false,
  };

  void _toggleSelection(String title) {
    setState(() {
      _selectedIssues[title] = !_selectedIssues[title]!;
    });
  }

  void _goNext() {
    final selected = _selectedIssues.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserEvaluationMobileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Device > Brand > Model > Variant > Price > Evaluation",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Evaluation Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/samsung.jpg',
                        height: 60,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Evaluating",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Samsung Galaxy S25 Edge (12 GB/512 GB)",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            LinearProgressIndicator(
                              value: 0.45,
                              backgroundColor: Colors.grey.shade300,
                              color: AppColors.primary,
                              minHeight: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "View Evaluation Summary ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Select all issues identified in your Phone",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Dynamic Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: _selectedIssues.entries.map((e) {
                return GestureDetector(
                  onTap: () => _toggleSelection(e.key),
                  child: IssueTile(
                    icon: _getIconForIssue(e.key),
                    title: e.key,
                    isSelected: e.value,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: _selectedIssues.containsValue(true) ? _goNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForIssue(String title) {
    switch (title) {
      case "Battery issue":
        return Icons.battery_alert_rounded;
      case "Front Camera not working":
        return Icons.camera_front_rounded;
      case "Back Camera not working":
        return Icons.camera_alt_outlined;
      case "Camera Glass Broken":
        return Icons.camera;
      default:
        return Icons.error_outline;
    }
  }
}

class IssueTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  const IssueTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 40, color: Colors.black87),
              if (isSelected)
                const Positioned(
                  right: -6,
                  top: -6,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.close, size: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
