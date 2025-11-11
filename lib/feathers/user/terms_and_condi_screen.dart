import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '1. Introduction',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to our mobile electronics app. By using this application, you agree to comply with and be bound by the following terms and conditions.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. User Responsibilities',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Users must provide accurate information and ensure that all devices listed for sale are their own and comply with applicable laws.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. Intellectual Property',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'All content, images, and logos used in this application are owned by the company or used with permission. Users may not copy or distribute any content without authorization.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '4. Limitation of Liability',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We are not responsible for any damages or losses arising from the use of this app, including issues with device sales or purchases.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '5. Changes to Terms',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We may update these terms and conditions from time to time. Users are advised to review this page periodically.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '6. Contact Us',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'If you have any questions regarding these terms, please contact our support team through the app or website.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen or perform accept action
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Accept',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
