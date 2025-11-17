import 'package:flutter/material.dart';

class WebFaqsScreen extends StatelessWidget {
  const WebFaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqList = [
      {
        "q": "How to sell my mobile phone in Mee Safe?",
        "a":
            "We made selling your phone very easy on our app/website. The signup process is simple. You can sign up using mobile number and OTP. Once signed up, select your device and its condition, get the value, schedule pickup, and choose payment mode."
      },
      {
        "q": "How do you fix the price for my device?",
        "a":
            "The price is fixed based on your device’s current condition and the market value. We ensure the best and most competitive pricing in the market."
      },
      {"q": "Is there any charge for the pick up?", "a": "No, pickup is free."},
      {
        "q":
            "What if I get a lesser price than the assured price shown during the pick-up schedule?",
        "a":
            "If the device condition doesn’t match the declared condition, the price may be revised accordingly."
      },
      {
        "q": "What to do if my pick up is delayed?",
        "a":
            "You can contact our support team via the app or website to reschedule your pickup."
      },
      {
        "q": "My phone is broken, but under warranty?",
        "a": "Yes, we still accept phones that are under warranty."
      },
      {
        "q": "Whether original invoice is required?",
        "a":
            "Original invoice is not mandatory but helps in getting a better price."
      },
      {
        "q": "What if I lost my invoice but device is still under warranty?",
        "a":
            "You can still registered device. The team will verify warranty status during pickup."
      },
      {
        "q": "What do you do with my old phone?",
        "a":
            "Devices are refurbished or recycled responsibly according to environmental guidelines."
      },
      {
        "q": "Can I sell a device bought using EMI?",
        "a":
            "Yes, as long as there are no outstanding dues or pending payments."
      },
      {
        "q": "How to reach for any query related to placed order and order placement?",
        "a":
            "You can reach us through our website contact form, Mee Safe app, or customer support email."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...faqList.map(
                  (faq) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faq["q"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Text(
                            faq["a"]!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                              height: 1.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "© 2025 MEE SAFE. All rights reserved.",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
