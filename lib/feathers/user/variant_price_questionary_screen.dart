import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/evaluating_condition_screen.dart';

class VariantPriceQuestionaryScreen extends StatefulWidget {
  const VariantPriceQuestionaryScreen({super.key});

  @override
  State<VariantPriceQuestionaryScreen> createState() =>
      _VariantPriceQuestionaryScreenState();
}

class _VariantPriceQuestionaryScreenState
    extends State<VariantPriceQuestionaryScreen> {
  // static dummy data
  final String modelName = "Samsung Galaxy A17 5G";
  final String variant = "8 GB / 128 GB";
  final String imagePath = "assets/images/samsung.jpg";

  // track answers
  final Map<int, bool?> _answers = {
    1: null,
    2: null,
    3: null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Device > Brand > Model > Variant > Price",
          style: TextStyle(color: Colors.black54, fontSize: 13.5),
        ),
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

            // Device Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Row(
                children: [
                  Image.asset(imagePath, height: 80, width: 80, fit: BoxFit.cover),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Evaluating",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "$modelName ($variant)",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: 0.3,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "View Evaluation Summary",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Question 1
            _buildQuestion(
              index: 1,
              title: "Is the phone in proper working condition?",
              subtitle:
                  "Check if the phone powers on and confirm that it is in working condition",
            ),

            // Question 2
            _buildQuestion(
              index: 2,
              title: "Is the touchscreen on your phone working properly?",
              subtitle:
                  "Check the touch screen functionality of your phone",
            ),

            // Question 3
            _buildQuestion(
              index: 3,
              title: "Is the phone’s display original?",
              subtitle:
                  "Select 'Yes' if the screen was never changed or was changed by the Authorized Service Center. Select 'No' if it was changed at a local shop or Unauthorized Service Center.",
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -1))
          ],
        ),
        child: ElevatedButton(
          onPressed: _canProceed() ? () {
             Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EvaluatingConditionScreen()
          ),
        );
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _canProceed() ? AppColors.primary : Colors.grey.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text(
            "Next",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  bool _canProceed() {
    return !_answers.values.contains(null);
  }

  Widget _buildQuestion({
    required int index,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$index. $title",
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _optionButton(index, true, "✓ Yes"),
              const SizedBox(width: 10),
              _optionButton(index, false, "✗ No"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _optionButton(int index, bool value, String label) {
    final selected = _answers[index] == value;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _answers[index] = value;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? AppColors.primary.withOpacity(0.1) : null,
          side: BorderSide(
              color: selected ? AppColors.primary : Colors.grey.shade400,
              width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
