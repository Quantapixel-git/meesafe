import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_functional_accessories_screen.dart';

class WebEvaluationPhysicalConditionScreen extends StatefulWidget {
  final String deviceName;
  final String imageUrl;

  const WebEvaluationPhysicalConditionScreen({
    super.key,
    required this.deviceName,
    required this.imageUrl,
  });

  @override
  State<WebEvaluationPhysicalConditionScreen> createState() =>
      _WebEvaluationPhysicalConditionScreenState();
}

class _WebEvaluationPhysicalConditionScreenState
    extends State<WebEvaluationPhysicalConditionScreen> {
  // Store selections
  final Map<String, String> selectedOptions = {};

  // Condition categories with options
  final Map<String, List<Map<String, String>>> conditionCategories = {
    "Screen Condition": [
      {"title": "No Spot", "image": 'assets/images/mobile.png'},
      {"title": "Minor Spot", "image": 'assets/images/back_damaged.jpeg'},
      {"title": "Major Spot", "image":'assets/images/back_damaged.jpeg'},
    ],
    "Touch Glass Condition": [
      {"title": "No scratch or crack", "image": 'assets/images/mobile.png'},
      {
        "title": "Minor Scratches or less than 2 scratches",
        "image": 'assets/images/broken_mobile_glass.jpeg'
      },
      {"title": "Heavy Scratches", "image": 'assets/images/broken_mobile_glass.jpeg'},
      {
        "title": "Screen Cracked or Glass Broken",
        "image": "assets/images/broken_mobile_glass.jpeg"
      },
    ],
    "Back Panel Condition": [
      {
        "title": "No defects on back panel",
        "image": 'assets/images/back_damaged.jpeg'
      },
      {
        "title": "Minor Scratches or less than 2 scratches",
        "image":  'assets/images/back_damaged.jpeg'
      },
      {"title": "Heavy Scratches", "image": "assets/images/back_damaged.jpeg"},
      {
        "title": "Back Panel broken",
        "image": "assets/images/back_damaged.jpeg"
      },
    ],
    "Center or Side Panel Condition": [
      {"title": "No defects on center panel", "image": 'assets/images/side_mobile.jpg'},
      {"title": "Minor dent or scratches", "image": 'assets/images/side_mobile.jpg'},
      {"title": "Major dent or heavy scratches", "image": 'assets/images/side_mobile.jpg'},
      {
        "title": "Center panel cracked or buttons missing or bent panel",
        "image": 'assets/images/side_mobile.jpg'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
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
            // LEFT CONTENT
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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Device Header
                      Row(
                        children: [
                          Image.asset(
                            widget.imageUrl,
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

                      const SizedBox(height: 16),
                      const Divider(height: 32),
                      const Text(
                        "Overall Condition > Physical Condition > Functional & Accessories > Warranty Condition",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 32),

                      // Condition Categories
                      ...conditionCategories.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: _buildConditionCategory(
                            entry.key,
                            entry.value,
                          ),
                        );
                      }),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 42,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primary),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Back",
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
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
                                // Navigate to next evaluation step
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebFunctionalAccessoriesScreen(
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 32),

            // RIGHT SIDEBAR
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
                      "Your answers will appear here as you complete the evaluation.",
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

  Widget _buildConditionCategory(String title, List<Map<String, String>> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final opt = options[index];
            final isSelected = selectedOptions[title] == opt["title"];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOptions[title] = opt["title"]!;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(opt["image"]!, width: 60, height: 60),
                    const SizedBox(height: 10),
                    Text(
                      opt["title"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : Colors.black87,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
