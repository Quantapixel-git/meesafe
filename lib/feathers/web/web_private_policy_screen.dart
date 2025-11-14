import 'package:flutter/material.dart';

class WebPrivatePolicyScreen extends StatelessWidget {
  const WebPrivatePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        "title": "1. Introduction",
        "text":
            "Mee Safe values your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our website, app, or related services."
      },
      {
        "title": "2. Information We Collect",
        "text":
            "We may collect personal information such as your name, phone number, email address, device details, location, and transaction data. Information may be gathered when you register, sell a device, schedule a pickup, or contact our support team."
      },
      {
        "title": "3. How We Use Your Information",
        "text":
            "Your data is used to provide and improve our services, process transactions, verify ownership, communicate updates, and comply with legal obligations. We do not sell or rent your personal information to third parties."
      },
      {
        "title": "4. Data Security",
        "text":
            "We implement appropriate security measures, including encryption and secure data storage, to protect your personal information. However, no online system is completely secure, and Mee Safe cannot guarantee absolute data safety."
      },
      {
        "title": "5. Data Sharing and Disclosure",
        "text":
            "Your data may be shared with trusted partners, logistics providers, or payment gateways only as required to fulfill our services. We may also share information if required by law or government authorities."
      },
      {
        "title": "6. Cookies and Tracking",
        "text":
            "Our website may use cookies to enhance your browsing experience, analyze site usage, and personalize content. You can manage or disable cookies through your browser settings."
      },
      {
        "title": "7. User Rights",
        "text":
            "You have the right to access, modify, or delete your personal information stored with us. You may also withdraw consent or request data portability by contacting our support team."
      },
      {
        "title": "8. Data Retention",
        "text":
            "We retain your personal information only as long as necessary to provide services or comply with legal and regulatory obligations. Once no longer needed, the data is securely deleted."
      },
      {
        "title": "9. Third-Party Links",
        "text":
            "Our platform may include links to third-party websites. Mee Safe is not responsible for the content, privacy practices, or policies of external sites. Please review their policies separately."
      },
      {
        "title": "10. Updates to This Policy",
        "text":
            "We may revise this Privacy Policy periodically to reflect changes in our practices or applicable laws. The updated version will be posted on our website with the revised date."
      },
      {
        "title": "11. Contact Us",
        "text":
            "If you have questions or concerns regarding this Privacy Policy, please contact us at privacy@Mee Safe.in or visit our Contact Us page on the website."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                  "Mee Safe - Privacy Policy",
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
