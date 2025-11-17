import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'admin_otp_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: isWeb
              ? null
              : AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: const Text(
                    "Admin Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primary,
                  centerTitle: true,
                ),
          body: Center(
            child: Container(
              width: isWeb ? 420 : double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              margin: EdgeInsets.only(top: isWeb ? 40 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  /// 🔵 LOGO + TITLE
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.admin_panel_settings,
                            size: 90, color: AppColors.primary),
                        const SizedBox(height: 12),
                        Text(
                          "Admin Panel",
                          style: TextStyle(
                            fontSize: isWeb ? 30 : 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Secure admin access only",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// LABEL
                  const Text(
                    "Enter Mobile Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// INPUT FIELD
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "e.g. 9876543210",
                      prefixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminOtpScreen(
                              phoneNumber: _phoneController.text,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Center(
                    child: Text(
                      "You’ll receive an OTP for verification",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
