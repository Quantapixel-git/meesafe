import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/user/user_plan_screen.dart';
import 'package:mee_safe/feathers/web/web_user_warranty_registration.dart';

class WebWarrantyConditionScreen extends StatefulWidget {
  final String deviceName;
  final String imageUrl;

  const WebWarrantyConditionScreen({
    super.key,
    required this.deviceName,
    required this.imageUrl,
  });

  @override
  State<WebWarrantyConditionScreen> createState() =>
      _WebWarrantyConditionScreenState();
}

class _WebWarrantyConditionScreenState
    extends State<WebWarrantyConditionScreen> {
  final List<Map<String, String>> options = [
    {
      "title": "Purchase date below 3 months",
      "subtitle": "Valid bill mandatory",
    },
    {
      "title": "Purchase date between 3 to 6 months",
      "subtitle": "Valid bill mandatory",
    },
    {
      "title": "Purchase date between 6 to 11 months",
      "subtitle": "Valid bill mandatory",
    },
    {
      "title": "Above 11 months",
      "subtitle": "",
    },
  ];

  int? selectedOption;

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
            // LEFT PANEL
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

                      // Device Info
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

                      // Warranty Options
                      const Text(
                        "Age of the mobile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Column(
                        children: List.generate(options.length, (index) {
                          final option = options[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                });
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Radio<int>(
                                    value: index,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        option["title"]!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (option["subtitle"]!.isNotEmpty)
                                        Text(
                                          option["subtitle"]!,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 42,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.primary),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
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
                              onPressed: selectedOption == null
                                  ? null
                                  : () {
                                     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebUserWarrantyRegistrationWeb()
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

            // RIGHT PANEL (Summary)
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const SingleChildScrollView(
                  child: Column(
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
                        "Screening Question :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "• Yes, Is the phone in proper working condition?\n"
                        "• Yes, Is the touchscreen on your phone working properly?\n"
                        "• Yes, Is the phone’s display original?\n"
                        "• Yes, Is there a valid warranty for your phone?",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Screen :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "• No Spot\n• No scratch or crack",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Body :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "• Minor Scratches or less than 2 scratches\n• Minor dent or scratches",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Functional :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "• Yes, Front Camera not working\n• Yes, Ear Speaker not working or low",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Accessories :",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "• Yes, Original Charger of Device",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
