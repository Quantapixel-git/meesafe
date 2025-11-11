import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How can I sell my old mobile devices?',
      'answer': 'You can sell your old devices by selecting the device type and brand, then following the step-by-step instructions on the app.'
    },
    {
      'question': 'Is there a service fee?',
      'answer': 'No, selling on our platform is completely free. You will receive the full value of your device.'
    },
    {
      'question': 'How do I get paid?',
      'answer': 'Payments are made directly to your bank account or via digital wallets once the transaction is completed.'
    },
    {
      'question': 'Can I sell multiple devices at once?',
      'answer': 'Yes, you can select multiple devices and brands to sell all at once using the "Sell all devices" option.'
    },
    {
      'question': 'Are my data and personal information safe?',
      'answer': 'Absolutely! We ensure all personal data is wiped from devices and handled securely.'
    },
    {
      'question': 'What brands do you accept?',
      'answer': 'We accept all major mobile brands including Apple, Samsung, OnePlus, Oppo, Vivo, Google Pixel, and more.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'FAQs',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ExpansionTile(
              title: Text(
                faq['question']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    faq['answer']!,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
