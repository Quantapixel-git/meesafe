import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';

class CorporateInTradeScreen extends StatelessWidget {
  const CorporateInTradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primary;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              'Mee Safe',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Pink Header Card
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Corporate in trade',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Describe your queries in the form, we'll get back to you soon.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Contact Info Section
            const Text(
              'For business related queries',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.call_outlined, color: primaryColor),
                const SizedBox(width: 8),
                const Text('+91-9988112151', style: TextStyle(fontSize: 15)),
                const SizedBox(width: 16),
                Icon(Icons.email_outlined, color: primaryColor),
                const SizedBox(width: 8),
                const Text('info@dofy.in', style: TextStyle(fontSize: 15)),
              ],
            ),

            const SizedBox(height: 24),

            // 🔹 Form Fields
            _buildTextField(label: 'Name', hint: 'Enter your name'),
            _buildTextField(label: 'Email ID', hint: 'Enter your Email-id'),
            _buildTextField(
              label: 'Mobile Number',
              hint: 'Enter your mobile number',
              prefix: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('+91'),
              ),
            ),
            _buildTextField(label: 'State', hint: 'Enter your State'),
            _buildTextField(label: 'District', hint: 'Enter your District'),
            _buildTextField(label: 'Pincode', hint: 'Enter your Pincode'),
            _buildTextField(label: 'Subject', hint: 'Enter your query about'),
            _buildTextField(
              label: 'Query',
              hint: 'Describe your query in detail..',
              maxLines: 4,
            ),

            const SizedBox(height: 24),

            // 🔹 Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    Widget? prefix,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 6),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: prefix,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
