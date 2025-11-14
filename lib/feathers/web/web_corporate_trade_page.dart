import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:mee_safe/feathers/web/web_footer_secton.dart';
import 'package:mee_safe/feathers/web/web_home_screen.dart';

class WebCorporateTradePage extends StatelessWidget {
  const WebCorporateTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
              const WebHeaderNav(),
          const Divider(height: 1, color: Colors.black12),
            // -------- Main Content --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Left Section ----
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF9F9F9), Color(0xFFFDF3F3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Corporate in trade",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Describe your queries in the form — we’ll get back to you soon.",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 60),
                          const Text(
                            "For business related queries",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.phone, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text("+91-9988112151", style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Icon(Icons.email_outlined, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text("info@dofy.in", style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 60),

                  // ---- Right Section (Form) ----
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField("Name", "Enter your name"),
                          _buildTextField("Email ID", "Enter your Email-id"),
                          _buildTextField("Mobile Number", "Enter your mobile number", prefix: "+91"),
                          Row(
                            children: [
                              Expanded(child: _buildTextField("State", "Enter your State")),
                              const SizedBox(width: 10),
                              Expanded(child: _buildTextField("District", "District")),
                              const SizedBox(width: 10),
                              Expanded(child: _buildTextField("Pincode", "Enter your Pincode")),
                            ],
                          ),
                          _buildTextField("Subject", "Enter your query about"),
                          _buildTextField("Query", "Describe your query in detail..", maxLines: 4),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // -------- Footer Section --------
           FooterSection()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {String? prefix, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 6),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixText: prefix != null ? "$prefix " : null,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
