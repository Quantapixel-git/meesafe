import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/user/user_plan_screen.dart';

class UserEvaluationMobileScreen extends StatefulWidget {
  const UserEvaluationMobileScreen({super.key});

  @override
  State<UserEvaluationMobileScreen> createState() => _UserEvaluationMobileScreenState();
}

class _UserEvaluationMobileScreenState extends State<UserEvaluationMobileScreen> {
  String? selectedAge;

  final List<Map<String, String>> ageOptions = [
    {
      "title": "Purchase date below 3 months",
      "sub": "Valid bill mandatory",
    },
    {
      "title": "Purchase date between 3 to 6 months",
      "sub": "Valid bill mandatory",
    },
    {
      "title": "Purchase date between 6 to 11 months",
      "sub": "Valid bill mandatory",
    },
    {
      "title": "Above 11 months",
      "sub": "",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F7),

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Evaluation",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // MAIN CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let's Evaluate your device",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 20),

                  // Image + Brand Row
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                          image: const DecorationImage(
                            image: AssetImage("assets/images/samsung.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Evaluating",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text("Samsung",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Overall Condition > Physical Condition > Functional & Accessories > Warranty Condition",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Age of the mobile",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  // RADIO OPTIONS
                  for (var opt in ageOptions) ...[
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(opt["title"]!,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      subtitle: opt["sub"]!.isNotEmpty
                          ? Text(opt["sub"]!,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey))
                          : null,
                      value: opt["title"]!,
                      groupValue: selectedAge,
                      onChanged: (value) {
                        setState(() {
                          selectedAge = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                  ],

                  const SizedBox(height: 20),

                  // BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text("Back"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: selectedAge == null ? null : () {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserPlanScreen(),
      ),
    );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedAge == null
                                ? Colors.grey[300]
                                : const Color(0xff111098),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SUMMARY CARD (MOBILE BELOW)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Device Evaluation",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Summary",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6),

                  Text(
                    """
Screening Question :
• Yes, Is the phone in proper working condition?
• Yes, Is the touchscreen on your phone working properly?
• Yes, Is the phone’s display original?
• Yes, Is there a valid warranty for your phone?

Screen :
• No Spot
• No scratch or crack

Body :
• Minor Scratches or less than 2 scratches
• Minor dent or scratches

Functional :
• Yes, Front Camera not working
• Yes, Ear Speaker not working or low

Accessories :
• Yes, Original Charger of Device
                    """,
                    style: TextStyle(fontSize: 13, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
