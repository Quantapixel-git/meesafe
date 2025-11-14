import 'package:flutter/material.dart';

class WebTermsAndConditionsScreen extends StatelessWidget {
  const WebTermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        "title": "1. Introduction",
        "text":
            "Welcome to Mee Safe! These Terms and Conditions govern your use of our website, mobile app, and services related to buying and selling electronic devices. By accessing or using our platform, you agree to these terms in full."
      },
      {
        "title": "2. Eligibility",
        "text":
            "You must be at least 18 years old to use our services. By agreeing to these terms, you represent that you have the legal authority to enter into a binding agreement."
      },
      {
        "title": "3. Device Evaluation and Pricing",
        "text":
            "All device prices are determined based on the information you provide about your device’s condition and current market value. If the actual condition differs during inspection, Mee Safe reserves the right to revise the final price accordingly."
      },
      {
        "title": "4. Pick-up and Payment",
        "text":
            "Our team will arrange a free pick-up of your device at the scheduled time. Payment will be made instantly or within a few hours after successful verification of the device."
      },
      {
        "title": "5. User Responsibilities",
        "text":
            "You must ensure that all personal data is removed or backed up before handing over your device. Mee Safe will not be responsible for any data loss, security breach, or privacy issue after pickup."
      },
      {
        "title": "6. Ownership Verification",
        "text":
            "You must be the rightful owner of the device you sell. Devices found to be stolen, blacklisted, or reported lost will not be accepted, and Mee Safe reserves the right to report such cases to authorities."
      },
      {
        "title": "7. Warranties and Liability",
        "text":
            "All services are provided on an 'as is' basis. While we strive to ensure smooth operation, Mee Safe will not be liable for any indirect, incidental, or consequential damages arising from the use of our services."
      },
      {
        "title": "8. Refund and Cancellation",
        "text":
            "Once a transaction is completed and payment is made, it cannot be reversed. Pick-up appointments can be rescheduled through the app or by contacting our customer support before the assigned time."
      },
      {
        "title": "9. Privacy and Data Protection",
        "text":
            "Your privacy is important to us. Personal details and device information shared during transactions are used strictly for operational and legal purposes. Refer to our Privacy Policy for more information."
      },
      {
        "title": "10. Changes to Terms",
        "text":
            "Mee Safe may update these Terms and Conditions at any time. Any major updates will be notified through our website or app. Continued use of our services implies acceptance of the revised terms."
      },
      {
        "title": "11. Contact Information",
        "text":
            "For any questions or concerns related to these Terms, please reach us at support@Mee Safe.in or through the Contact Us page on our website."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Mee Safe - Terms and Conditions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Last Updated: November 2025",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 25),
                ...sections.map(
                  (section) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          section["text"]!,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14.5,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 40),
                Center(
                  child: Text(
                    "© 2025 Mee Safe. All rights reserved.",
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
