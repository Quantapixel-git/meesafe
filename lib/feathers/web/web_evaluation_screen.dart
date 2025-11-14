import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_evaluation_physical_condition_screen.dart';

class WebEvaluationScreen extends StatefulWidget {
  final String deviceName;
  final String imageUrl;

  const WebEvaluationScreen({
    super.key,
    required this.deviceName,
    required this.imageUrl,
  });

  @override
  State<WebEvaluationScreen> createState() => _WebEvaluationScreenState();
}

class _WebEvaluationScreenState extends State<WebEvaluationScreen> {
  // Questions data
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Is the phone in proper working condition?",
      "subtitle":
          "Check if the phone powers on and confirm that it is in working condition"
    },
    {
      "question": "Is the touchscreen on your phone working properly?",
      "subtitle": "Check the touch screen functionality of your phone"
    },
    {
      "question": "Is the phone’s display original?",
      "subtitle":
          "Select 'Yes' if the screen was never changed or changed by an Authorized Service Center. Select 'No' if replaced locally."
    },
    {
      "question": "Is there a valid warranty for your phone?",
      "subtitle":
          "You’ll get a better price if your device has a manufacturer warranty"
    },
  ];

  final Map<int, String> answers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Evaluation",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Row(
            children: const [
              Text("My Orders", style: TextStyle(color: Colors.black)),
              SizedBox(width: 24),
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xfff0f0f0),
                child: Icon(Icons.person, color: Colors.black54),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Let’s Evaluate your device",
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      // Device info card
                      Row(
                        children: [
                          Image.asset(
                           'assets/images/samsung.jpg',
                            width: 60,
                            height: 60,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Evaluating",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.deviceName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                  
                      // Breadcrumb
                      const Text(
                        "Overall Condition > Physical Condition > Functional & Accessories > Warranty Condition",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const Divider(height: 32),
                  
                      // Questions list
                      ...List.generate(questions.length, (index) {
                        final q = questions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}. ${q['question']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                q['subtitle'],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _optionButton(index, "Yes"),
                                  const SizedBox(width: 12),
                                  _optionButton(index, "No"),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 140,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                             Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebEvaluationPhysicalConditionScreen(
                                            deviceName: 'Samsung',
                                            imageUrl: 'assets/images/samsung.jpg',
                                          )
                                    ),
                                  );
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 32),

            // RIGHT SIDE — Summary card
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Device Evaluation",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Summary",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Your answers will appear here as you complete evaluation.",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionButton(int questionIndex, String label) {
    final isSelected = answers[questionIndex] == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            answers[questionIndex] = label;
          });
        },
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
